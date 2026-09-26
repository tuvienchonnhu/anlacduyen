package com.salesmanager.shop.store.controller.customer;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.Signature;
import java.security.spec.RSAPublicKeySpec;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
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
 * Google OAuth 2.0 (authorization code) helper.
 *
 * Client ID / Client Secret duoc lay tu cau hinh cua cua hang (Admin >
 * Configuration > Login Configuration) va luu trong bang MerchantConfiguration.
 */
@Component
public class GoogleOAuthService {

	private static final Logger LOGGER = LoggerFactory.getLogger(GoogleOAuthService.class);

	private static final String AUTH_ENDPOINT = "https://accounts.google.com/o/oauth2/v2/auth";
	private static final String TOKEN_ENDPOINT = "https://oauth2.googleapis.com/token";
	private static final String USERINFO_ENDPOINT = "https://www.googleapis.com/oauth2/v3/userinfo";

	/** Tap khoa cong khai (JWKS) cua Google de xac minh chu ky ID token. */
	private static final String GOOGLE_CERTS_ENDPOINT = "https://www.googleapis.com/oauth2/v3/certs";

	/** Cac issuer hop le cua Google Identity Services. */
	private static final Set<String> VALID_ISSUERS = new HashSet<String>(
			Arrays.asList("accounts.google.com", "https://accounts.google.com"));

	/** Thuat toan chu ky duoc Google su dung cho ID token. */
	private static final String SIGNATURE_ALGORITHM = "SHA256withRSA";

	private static final int TIMEOUT_MS = 15000;

	private static final ObjectMapper MAPPER = new ObjectMapper();

	/** Thong tin co ban cua nguoi dung Google tra ve tu userinfo endpoint. */
	public static class GoogleUser {
		private String email;
		private String firstName;
		private String lastName;
		private boolean emailVerified;

		public String getEmail() {
			return email;
		}

		public String getFirstName() {
			return firstName;
		}

		public String getLastName() {
			return lastName;
		}

		public boolean isEmailVerified() {
			return emailVerified;
		}
	}

	@Inject
	private MerchantConfigurationService merchantConfigurationService;

	/**
	 * Client ID da cau hinh trong Admin. Tra ve null neu chua cau hinh.
	 */
	public String getClientId(MerchantStore store) {
		return readConfig(Constants.KEY_GOOGLE_CLIENT_ID, store);
	}

	/**
	 * Client Secret da cau hinh trong Admin. Tra ve null neu chua cau hinh.
	 */
	public String getClientSecret(MerchantStore store) {
		return readConfig(Constants.KEY_GOOGLE_CLIENT_SECRET, store);
	}

	/**
	 * Dang nhap bang Google chi kha dung khi da co ca Client ID va Client Secret.
	 */
	public boolean isConfigured(MerchantStore store) {
		return StringUtils.isNotBlank(getClientId(store)) && StringUtils.isNotBlank(getClientSecret(store));
	}

	/**
	 * Tao URL dong y cap quyen cua Google de hien thi nut "Dang nhap bang Google".
	 *
	 * @param redirectUri URL callback (phai khop Authorized redirect URI trong
	 *                    Google Console)
	 * @param state       gia tri chong CSRF, duoc Google tra ve nguyen ven
	 */
	public String buildAuthorizationUrl(MerchantStore store, String redirectUri, String state) {
		String clientId = getClientId(store);
		if (StringUtils.isBlank(clientId)) {
			return null;
		}

		StringBuilder url = new StringBuilder();
		url.append(AUTH_ENDPOINT);
		url.append("?client_id=").append(urlEncode(clientId));
		url.append("&redirect_uri=").append(urlEncode(redirectUri));
		url.append("&response_type=code");
		url.append("&scope=").append(urlEncode("openid email profile"));
		url.append("&access_type=online");
		url.append("&prompt=select_account");
		if (StringUtils.isNotBlank(state)) {
			url.append("&state=").append(urlEncode(state));
		}
		return url.toString();
	}

	/**
	 * Doi authorization code lay access token, sau do doc thong tin nguoi dung
	 * (email, ten) tu Google.
	 *
	 * @return thong tin nguoi dung hoac null neu that bai
	 */
	public GoogleUser getUser(MerchantStore store, String code, String redirectUri) {

		String clientId = getClientId(store);
		String clientSecret = getClientSecret(store);

		if (StringUtils.isBlank(clientId) || StringUtils.isBlank(clientSecret) || StringUtils.isBlank(code)) {
			return null;
		}

		RequestConfig requestConfig = RequestConfig.custom().setConnectTimeout(TIMEOUT_MS)
				.setSocketTimeout(TIMEOUT_MS).build();

		try (CloseableHttpClient httpClient = HttpClients.custom().setDefaultRequestConfig(requestConfig).build()) {

			List<NameValuePair> params = new ArrayList<NameValuePair>();
			params.add(new BasicNameValuePair("code", code));
			params.add(new BasicNameValuePair("client_id", clientId));
			params.add(new BasicNameValuePair("client_secret", clientSecret));
			params.add(new BasicNameValuePair("redirect_uri", redirectUri));
			params.add(new BasicNameValuePair("grant_type", "authorization_code"));

			HttpPost post = new HttpPost(TOKEN_ENDPOINT);
			post.setEntity(new UrlEncodedFormEntity(params, "UTF-8"));
			post.setHeader("Accept", "application/json");

			String tokenResponse = null;
			try (CloseableHttpResponse response = httpClient.execute(post)) {
				HttpEntity entity = response.getEntity();
				if (entity == null) {
					LOGGER.error("Empty response from Google token endpoint");
					return null;
				}
				tokenResponse = EntityUtils.toString(entity, "UTF-8");
				if (response.getStatusLine().getStatusCode() != 200) {
					LOGGER.error("Google token endpoint returned {} : {}", response.getStatusLine().getStatusCode(),
							tokenResponse);
					return null;
				}
			}

			JsonNode tokenJson = MAPPER.readTree(tokenResponse);
			JsonNode accessTokenNode = tokenJson.get("access_token");
			if (accessTokenNode == null || StringUtils.isBlank(accessTokenNode.asText())) {
				LOGGER.error("No access_token in Google response");
				return null;
			}
			String accessToken = accessTokenNode.asText();

			HttpGet get = new HttpGet(USERINFO_ENDPOINT);
			get.setHeader("Authorization", "Bearer " + accessToken);

			try (CloseableHttpResponse response = httpClient.execute(get)) {
				HttpEntity entity = response.getEntity();
				if (entity == null) {
					LOGGER.error("Empty response from Google userinfo endpoint");
					return null;
				}
				String userInfoResponse = EntityUtils.toString(entity, "UTF-8");
				if (response.getStatusLine().getStatusCode() != 200) {
					LOGGER.error("Google userinfo endpoint returned {} : {}", response.getStatusLine().getStatusCode(),
							userInfoResponse);
					return null;
				}

				JsonNode userJson = MAPPER.readTree(userInfoResponse);

				GoogleUser user = new GoogleUser();
				user.email = text(userJson, "email");
				user.firstName = text(userJson, "given_name");
				user.lastName = text(userJson, "family_name");
				user.emailVerified = userJson.has("email_verified") && userJson.get("email_verified").asBoolean();

				if (StringUtils.isBlank(user.email)) {
					LOGGER.error("Google account does not expose an email address");
					return null;
				}
				return user;
			}

		} catch (Exception e) {
			LOGGER.error("Error while authenticating with Google", e);
			return null;
		}
	}

	private String text(JsonNode node, String field) {
		JsonNode value = node.get(field);
		return value == null || value.isNull() ? null : value.asText();
	}

	/**
	 * Xac minh ID token (JWT) ma Google Identity Services SDK tra ve o phia
	 * client.
	 *
	 * Kiem tra: dinh dang JWT, chu ky RS256 bang khoa cong khai cua Google,
	 * issuer, audience (clientId) va thoi gian het han, sau do doc email / ten
	 * nguoi dung tu payload.
	 *
	 * @return thong tin nguoi dung hoac null neu token khong hop le
	 */
	public GoogleUser verifyIdToken(MerchantStore store, String idToken) {

		String clientId = getClientId(store);
		if (StringUtils.isBlank(clientId) || StringUtils.isBlank(idToken)) {
			return null;
		}

		try {
			String[] parts = idToken.split("\\.");
			if (parts.length != 3) {
				LOGGER.error("Google ID token does not have the expected JWT format");
				return null;
			}

			JsonNode header = MAPPER.readTree(decodeBase64Url(parts[0]));
			String algorithm = text(header, "alg");
			String keyId = text(header, "kid");

			if (!"RS256".equals(algorithm) || StringUtils.isBlank(keyId)) {
				LOGGER.error("Unsupported Google ID token algorithm : {}", algorithm);
				return null;
			}

			PublicKey publicKey = getGooglePublicKey(keyId);
			if (publicKey == null) {
				LOGGER.error("No Google public key found for kid {}", keyId);
				return null;
			}

			Signature signature = Signature.getInstance(SIGNATURE_ALGORITHM);
			signature.initVerify(publicKey);
			signature.update((parts[0] + "." + parts[1]).getBytes(StandardCharsets.UTF_8));

			if (!signature.verify(Base64.getUrlDecoder().decode(parts[2]))) {
				LOGGER.error("Google ID token signature verification failed");
				return null;
			}

			JsonNode payload = MAPPER.readTree(decodeBase64Url(parts[1]));

			// token phai duoc cap cho dung cua hang nay
			String audience = text(payload, "aud");
			if (!clientId.equals(audience)) {
				LOGGER.error("Google ID token audience does not match the configured client id");
				return null;
			}

			// token phai do Google phat hanh
			String issuer = text(payload, "iss");
			if (!VALID_ISSUERS.contains(issuer)) {
				LOGGER.error("Unexpected Google ID token issuer : {}", issuer);
				return null;
			}

			// token chua het han
			JsonNode expNode = payload.get("exp");
			if (expNode == null || expNode.asLong() * 1000L < System.currentTimeMillis()) {
				LOGGER.error("Google ID token has expired");
				return null;
			}

			GoogleUser user = new GoogleUser();
			user.email = text(payload, "email");
			user.firstName = text(payload, "given_name");
			user.lastName = text(payload, "family_name");
			user.emailVerified = payload.has("email_verified") && payload.get("email_verified").asBoolean();

			if (StringUtils.isBlank(user.email)) {
				LOGGER.error("Google ID token does not contain an email address");
				return null;
			}

			return user;

		} catch (Exception e) {
			LOGGER.error("Error while verifying Google ID token", e);
			return null;
		}
	}

	/**
	 * Lay khoa cong khai RSA cua Google theo kid tu bo khoa JWKS.
	 */
	private PublicKey getGooglePublicKey(String keyId) {

		RequestConfig requestConfig = RequestConfig.custom().setConnectTimeout(TIMEOUT_MS)
				.setSocketTimeout(TIMEOUT_MS).build();

		try (CloseableHttpClient httpClient = HttpClients.custom().setDefaultRequestConfig(requestConfig).build()) {

			HttpGet get = new HttpGet(GOOGLE_CERTS_ENDPOINT);
			get.setHeader("Accept", "application/json");

			try (CloseableHttpResponse response = httpClient.execute(get)) {
				HttpEntity entity = response.getEntity();
				if (entity == null) {
					LOGGER.error("Empty response from Google certs endpoint");
					return null;
				}

				String certsResponse = EntityUtils.toString(entity, "UTF-8");
				if (response.getStatusLine().getStatusCode() != 200) {
					LOGGER.error("Google certs endpoint returned {} : {}", response.getStatusLine().getStatusCode(),
							certsResponse);
					return null;
				}

				JsonNode keys = MAPPER.readTree(certsResponse).get("keys");
				if (keys == null || !keys.isArray()) {
					return null;
				}

				for (JsonNode key : keys) {
					if (!keyId.equals(text(key, "kid"))) {
						continue;
					}

					BigInteger modulus = new BigInteger(1, Base64.getUrlDecoder().decode(text(key, "n")));
					BigInteger exponent = new BigInteger(1, Base64.getUrlDecoder().decode(text(key, "e")));

					return KeyFactory.getInstance("RSA").generatePublic(new RSAPublicKeySpec(modulus, exponent));
				}

				LOGGER.error("Google did not publish a key for kid {}", keyId);
				return null;
			}

		} catch (Exception e) {
			LOGGER.error("Error while fetching Google public keys", e);
			return null;
		}
	}

	/**
	 * Giai ma mot doan Base64URL (khong padding) cua JWT.
	 */
	private byte[] decodeBase64Url(String value) {
		return Base64.getUrlDecoder().decode(value);
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