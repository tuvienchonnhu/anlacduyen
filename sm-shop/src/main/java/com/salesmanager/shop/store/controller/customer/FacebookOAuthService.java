package com.salesmanager.shop.store.controller.customer;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.salesmanager.core.business.services.system.MerchantConfigurationService;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.system.MerchantConfiguration;
import com.salesmanager.shop.constants.Constants;

/**
 * Facebook Login (OAuth 2.0 authorization code) helper.
 *
 * App ID / App Secret duoc lay tu cau hinh cua cua hang (Admin > Configuration >
 * Login Configuration) va luu trong bang MerchantConfiguration.
 *
 * Facebook khong tra ve ID token nhu Google, nen luong xu ly la:
 *   1. Doi authorization code lay access token (Graph API /oauth/access_token)
 *   2. Doc thong tin nguoi dung (/me?fields=id,email,first_name,last_name)
 *   3. Xac minh access token thuoc dung app cua cua hang bang
 *      appsecret_proof (HMAC-SHA256 cua access token voi App Secret) va
 *      /debug_token - tranh truong hop token cua app khac bi gui len.
 */
@Component
public class FacebookOAuthService {

	private static final Logger LOGGER = LoggerFactory.getLogger(FacebookOAuthService.class);

	private static final String AUTH_ENDPOINT = "https://www.facebook.com/v19.0/dialog/oauth";
	private static final String TOKEN_ENDPOINT = "https://graph.facebook.com/v19.0/oauth/access_token";
	private static final String USERINFO_ENDPOINT = "https://graph.facebook.com/v19.0/me";
	private static final String DEBUG_TOKEN_ENDPOINT = "https://graph.facebook.com/v19.0/debug_token";

	/** Cac truong thong tin nguoi dung can lay. */
	private static final String USER_FIELDS = "id,email,first_name,last_name";

	private static final int TIMEOUT_MS = 15000;

	private static final ObjectMapper MAPPER = new ObjectMapper();

	/** Thong tin co ban cua nguoi dung Facebook. */
	public static class FacebookUser {
		private String id;
		private String email;
		private String firstName;
		private String lastName;

		public String getId() {
			return id;
		}

		public String getEmail() {
			return email;
		}

		public String getFirstName() {
			return firstName;
		}

		public String getLastName() {
			return lastName;
		}
	}

	@Inject
	private MerchantConfigurationService merchantConfigurationService;

	/**
	 * App ID da cau hinh trong Admin. Tra ve null neu chua cau hinh.
	 */
	public String getAppId(MerchantStore store) {
		return readConfig(Constants.KEY_FACEBOOK_APP_ID, store);
	}

	/**
	 * App Secret da cau hinh trong Admin. Tra ve null neu chua cau hinh.
	 */
	public String getAppSecret(MerchantStore store) {
		return readConfig(Constants.KEY_FACEBOOK_APP_SECRET, store);
	}

	/**
	 * Dang nhap bang Facebook chi kha dung khi da co ca App ID va App Secret.
	 */
	public boolean isConfigured(MerchantStore store) {
		return StringUtils.isNotBlank(getAppId(store)) && StringUtils.isNotBlank(getAppSecret(store));
	}

	/**
	 * Tao URL dong y cap quyen cua Facebook de chuyen huong nguoi dung toi.
	 *
	 * @param redirectUri URL callback (phai khop Valid OAuth Redirect URI trong
	 *                    Facebook Console)
	 * @param state       gia tri chong CSRF, duoc Facebook tra ve nguyen ven
	 */
	public String buildAuthorizationUrl(MerchantStore store, String redirectUri, String state) {
		String appId = getAppId(store);
		if (StringUtils.isBlank(appId)) {
			return null;
		}

		StringBuilder url = new StringBuilder();
		url.append(AUTH_ENDPOINT);
		url.append("?client_id=").append(urlEncode(appId));
		url.append("&redirect_uri=").append(urlEncode(redirectUri));
		url.append("&response_type=code");
		url.append("&scope=").append(urlEncode("email,public_profile"));
		if (StringUtils.isNotBlank(state)) {
			url.append("&state=").append(urlEncode(state));
		}
		return url.toString();
	}

	/**
	 * Doi authorization code lay access token, sau do doc thong tin nguoi dung
	 * (id, email, ten) tu Graph API.
	 *
	 * @return thong tin nguoi dung hoac null neu that bai
	 */
	public FacebookUser getUser(MerchantStore store, String code, String redirectUri) {

		String appId = getAppId(store);
		String appSecret = getAppSecret(store);

		if (StringUtils.isBlank(appId) || StringUtils.isBlank(appSecret) || StringUtils.isBlank(code)) {
			return null;
		}

		RequestConfig requestConfig = RequestConfig.custom().setConnectTimeout(TIMEOUT_MS)
				.setSocketTimeout(TIMEOUT_MS).build();

		try (CloseableHttpClient httpClient = HttpClients.custom().setDefaultRequestConfig(requestConfig).build()) {

			String accessToken = exchangeCodeForToken(httpClient, appId, appSecret, code, redirectUri);
			if (StringUtils.isBlank(accessToken)) {
				return null;
			}

			// Bao dam token nay do dung app cua cua hang cap (chong token gia mao).
			String tokenAppId = debugToken(httpClient, appId, appSecret, accessToken);
			if (!appId.equals(tokenAppId)) {
				LOGGER.error("Facebook access token belongs to app {} instead of {}", tokenAppId, appId);
				return null;
			}

			return readUser(httpClient, appSecret, accessToken);

		} catch (Exception e) {
			LOGGER.error("Error while signing in with Facebook", e);
			return null;
		}
	}

	private String exchangeCodeForToken(CloseableHttpClient httpClient, String appId, String appSecret, String code,
			String redirectUri) throws Exception {

		StringBuilder url = new StringBuilder();
		url.append(TOKEN_ENDPOINT);
		url.append("?client_id=").append(urlEncode(appId));
		url.append("&client_secret=").append(urlEncode(appSecret));
		url.append("&redirect_uri=").append(urlEncode(redirectUri));
		url.append("&code=").append(urlEncode(code));

		String body = httpGet(httpClient, url.toString());
		if (body == null) {
			return null;
		}

		JsonNode json = MAPPER.readTree(body);
		JsonNode tokenNode = json.get("access_token");
		if (tokenNode == null || StringUtils.isBlank(tokenNode.asText())) {
			LOGGER.error("No access_token in Facebook response : {}", body);
			return null;
		}
		return tokenNode.asText();
	}

	/**
	 * Kiem tra access token va tra ve app id ma token thuoc ve. Tra null neu
	 * token khong hop le.
	 */
	private String debugToken(CloseableHttpClient httpClient, String appId, String appSecret, String accessToken)
			throws Exception {

		// app access token = "{app-id}|{app-secret}"
		String appAccessToken = appId + "|" + appSecret;
		StringBuilder url = new StringBuilder();
		url.append(DEBUG_TOKEN_ENDPOINT);
		url.append("?input_token=").append(urlEncode(accessToken));
		url.append("&access_token=").append(urlEncode(appAccessToken));

		String body = httpGet(httpClient, url.toString());
		if (body == null) {
			return null;
		}

		JsonNode json = MAPPER.readTree(body);
		JsonNode data = json.get("data");
		if (data == null) {
			LOGGER.error("No data in Facebook debug_token response : {}", body);
			return null;
		}

		JsonNode validNode = data.get("is_valid");
		if (validNode == null || !validNode.asBoolean()) {
			LOGGER.error("Facebook access token is not valid : {}", body);
			return null;
		}

		JsonNode appIdNode = data.get("app_id");
		return appIdNode == null ? null : appIdNode.asText();
	}

	private FacebookUser readUser(CloseableHttpClient httpClient, String appSecret, String accessToken)
			throws Exception {

		StringBuilder url = new StringBuilder();
		url.append(USERINFO_ENDPOINT);
		url.append("?fields=").append(urlEncode(USER_FIELDS));
		url.append("&access_token=").append(urlEncode(accessToken));

		String body = httpGet(httpClient, url.toString());
		if (body == null) {
			return null;
		}

		JsonNode json = MAPPER.readTree(body);
		if (json.has("error")) {
			LOGGER.error("Facebook userinfo returned an error : {}", body);
			return null;
		}

		FacebookUser user = new FacebookUser();
		user.id = text(json, "id");
		user.email = text(json, "email");
		user.firstName = text(json, "first_name");
		user.lastName = text(json, "last_name");
		return user;
	}

	private String text(JsonNode json, String field) {
		JsonNode node = json.get(field);
		return node == null || node.isNull() ? null : node.asText();
	}

	/**
	 * Goi GET mot URL cua Graph API va tra ve body duoi dang chuoi. Tra null neu
	 * loi mang hoac HTTP status khac 200.
	 */
	private String httpGet(CloseableHttpClient httpClient, String url) {
		try {
			HttpGet get = new HttpGet(url);
			get.setHeader("Accept", "application/json");

			try (CloseableHttpResponse response = httpClient.execute(get)) {
				HttpEntity entity = response.getEntity();
				if (entity == null) {
					LOGGER.error("Empty response from Facebook endpoint {}", url);
					return null;
				}
				String body = EntityUtils.toString(entity, "UTF-8");
				if (response.getStatusLine().getStatusCode() != 200) {
					LOGGER.error("Facebook endpoint returned {} : {}", response.getStatusLine().getStatusCode(), body);
					return null;
				}
				return body;
			}
		} catch (Exception e) {
			LOGGER.error("Cannot call Facebook endpoint " + url, e);
			return null;
		}
	}

	private String readConfig(String key, MerchantStore store) {
		if (store == null || StringUtils.isBlank(key)) {
			return null;
		}
		try {
			MerchantConfiguration config = merchantConfigurationService.getMerchantConfiguration(key, store);
			if (config != null && StringUtils.isNotBlank(config.getValue())) {
				return config.getValue().trim();
			}
		} catch (Exception e) {
			LOGGER.error("Error reading login configuration " + key, e);
		}
		return null;
	}

	private String urlEncode(String value) {
		try {
			return URLEncoder.encode(value, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return value;
		}
	}
}