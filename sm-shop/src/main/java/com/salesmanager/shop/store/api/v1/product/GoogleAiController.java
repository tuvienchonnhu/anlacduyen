package com.salesmanager.shop.store.api.v1.product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.slugify.Slugify;
import com.salesmanager.core.business.services.system.MerchantConfigurationService;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.system.MerchantConfiguration;
import com.salesmanager.shop.store.controller.store.facade.StoreFacade;
import com.salesmanager.shop.store.api.exception.RestApiException;

/**
 * REST API tao dong bo san pham bang AI (Google Gemini).
 *
 * Workflow:
 * 1. Admin chup/tai anh san pham.
 * 2. Backend dong goi anh (Base64) + danh sach ngon ngu he thong ho tro
 *    (vi, en, fr, zh) trong prompt JSON Schema -> goi Gemini API.
 * 3. Parse JSON tra ve (ObjectMapper) -> ProductAiDTO -> Frontend tu dong
 *    populate vao tung o input/CKEditor theo tung ngon ngu.
 */
@RestController
@RequestMapping("/admin/product/gemini")
public class GoogleAiController {

	private static final Logger LOGGER = LoggerFactory.getLogger(GoogleAiController.class);

	private static final String GEMINI_API_BASE_URL = "https://generativelanguage.googleapis.com/v1beta/models/";

	// co the ghi de bang property googleai.gemini.model trong shopizer-properties.properties
	@Value("${googleai.gemini.model:gemini-3.5-flash}")
	private String geminiModel;

	private static final String GEMINI_API_KEY_CONFIG = "GEMINI_API_KEY";

	/** Danh sach ngon ngu mac dinh he thong ho tro. */
	private static final List<String> DEFAULT_LANGUAGES = List.of("vi", "en", "fr", "zh");

	private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper()
			.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

	private static final Slugify SLUGIFY = Slugify.builder().build();

	@Inject
	private StoreFacade storeFacade;

	@Inject
	private MerchantConfigurationService merchantConfigurationService;

	@Value("${googleai.gemini.apikey:}")
	private String apiKeyFromProperties;

	private RestTemplate restTemplate = new RestTemplate();

	/**
	 * POST /admin/product/gemini/generate
	 * Body: { "imageBase64": "...", "mimeType": "image/jpeg",
	 *         "languages": "vi,en,fr,zh" (optional),
	 *         "skuPrefix": "tui-xach" (optional - ten danh muc tieng Viet khong dau) }
	 *
	 * Returns ProductAiDTO JSON:
	 * { "sku": "SP-12345", "refCode": "REF-98765",
	 *   "languages": { "vi": { name, seUrl, shortDescription, description,
	 *   metaTitle, metaDescription }, "en": {...}, ... } }
	 */
	@PostMapping("/generate")
	public ProductAiDTO generateProduct(@RequestBody Map<String, String> body, HttpServletRequest request) {

		MerchantStore store = storeFacade.getByCode(request);
		if (store == null) {
			throw new RestApiException("Merchant store not found");
	}

		String apiKey = resolveApiKey(store);
		if (StringUtils.isBlank(apiKey)) {
			LOGGER.warn("Gemini API key is not configured (config " + GEMINI_API_KEY_CONFIG
					+ " or property googleai.gemini.apikey)");
			throw new RestApiException(
					"Chưa cấu hình Gemini API key. Vào Admin > Configuration thêm cấu hình GEMINI_API_KEY hoặc đặt googleai.gemini.apikey trong shopizer-properties.properties");
	}

		String imageBase64 = body.get("imageBase64");
		if (StringUtils.isBlank(imageBase64)) {
			throw new RestApiException("Thiếu ảnh (imageBase64)");
	}

		String mimeType = StringUtils.defaultIfBlank(body.get("mimeType"), "image/jpeg");

	// strip data url prefix if present (data:image/jpeg;base64,...)
	if (imageBase64.startsWith("data:")) {
	int commaIndex = imageBase64.indexOf(',');
	if (commaIndex < 0) {
	throw new RestApiException("Định dạng ảnh data URL không hợp lệ");
	}
	String meta = imageBase64.substring(0, commaIndex);
	int semi = meta.indexOf(';');
	if (semi > 0) {
	mimeType = meta.substring(5, semi); // image/jpeg
	}
	imageBase64 = imageBase64.substring(commaIndex + 1);
	}

	// validate base64
		try {
			Base64.getDecoder().decode(imageBase64);
	} catch (IllegalArgumentException e) {
			throw new RestApiException("Ảnh không hợp lệ (Base64 decode failed)");
	}

			// danh sach ngon ngu Admin chon ("vi,en,fr,zh"), mac dinh theo he thong
			List<String> languages = parseLanguages(body.get("languages"));

			// tien to SKU theo danh muc (ten danh muc tieng Viet khong dau,vd: tui-xach)
			String skuPrefix = StringUtils.trimToEmpty(body.get("skuPrefix"));

			String prompt = buildPrompt(skuPrefix, languages);

			try {
				String generatedText = callGemini(apiKey, mimeType, imageBase64, prompt);
				if (StringUtils.isBlank(generatedText)) {
					throw new RestApiException("Gemini không trả về dữ liệu");
				}
				// Parse JSON tu Gemini -> DTO de frontend fill vao form Admin
				ProductAiDTO dto = OBJECT_MAPPER.readValue(generatedText, ProductAiDTO.class);

				// Chuan hoa seUrl (slug) tranh ky tu dac biet gay loi duong dan
				sanitizeSlugs(dto);

				return dto;
			} catch (RestApiException e) {
				throw e;
			} catch (Exception e) {
				LOGGER.error("Error calling Gemini API or parsing response", e);
				throw new RestApiException("Lỗi khi gọi Gemini API: " + e.getMessage());
			}
		}

		/**
		 * Xay dung prompt JSON Schema theo yeu cau Structured Output.
		 * Cua hang co quy tac dat SKU: ten danh muc tieng Viet khong dau, cac chu
		 * cach nhau bang dau '-', ket thuc bang so (vi du: tui-xach-da-bo-12345).
		 */
		private String buildPrompt(String skuPrefix, List<String> languages) {
			String langCsv = String.join(", ", languages);
			StringBuilder sb = new StringBuilder();
			sb.append("Phân tích hình ảnh sản phẩm này và tạo thông tin chi tiết cho hệ thống e-commerce bằng các ngôn ngữ: [")
					.append(langCsv).append("]\n");
			sb.append("Trả về kết quả đúng định dạng JSON với cấu trúc sau:\n");
			sb.append("{\n");
			sb.append("  \"sku\": \"Mã SKU tự sinh dạng CHỮ_IN_HOA_SỐ");
			if (StringUtils.isNotBlank(skuPrefix)) {
				sb.append(" (ví dụ: ").append(skuPrefix.toUpperCase(Locale.ROOT)).append("-12345)");
			} else {
				sb.append(" (ví dụ: SP-12345)");
			}
			sb.append(",\n");
			sb.append("  \"refCode\": \"Mã tham chiếu hệ thống (ví dụ: REF-98765)\",\n");
			sb.append("  \"languages\": {\n");
			for (int i = 0; i < languages.size(); i++) {
				String lang = languages.get(i);
				sb.append("    \"").append(lang).append("\": {\n");
				sb.append("      \"name\": \"Tên sản phẩm\",\n");
				sb.append("      \"seUrl\": \"duong-dan-than-thien-seo\",\n");
				sb.append("      \"shortDescription\": \"Mô tả ngắn 1-2 câu\",\n");
				sb.append("      \"description\": \"Mô tả chi tiết sản phẩm (định dạng HTML chuẩn với thẻ <p>, <ul>, <li>, <strong>)\",\n");
				sb.append("      \"metaTitle\": \"Tiêu đề SEO (dưới 60 ký tự)\",\n");
				sb.append("      \"metaDescription\": \"Mô tả Meta SEO (dưới 160 ký tự)\"\n");
				sb.append("    }");
				if (i < languages.size() - 1) {
					sb.append(",");
				}
				sb.append("\n");
			}
			sb.append("  }\n");
			sb.append("}\n");
			sb.append("Lưu ý: chỉ trả về JSON thuần, không thêm bất kỳ chữ nào khác.\n");
			sb.append("- Với mọi ngôn ngữ: seUrl là đường dẫn thân thiện SEO, chỉ chữ thường, số và dấu '-', không ký tự đặc biệt.\n");
			sb.append("- description phải dùng thẻ HTML chuẩn (<p>, <ul>, <li>, <strong>) để hiển thị đẹp trong CKEditor.\n");
			if (StringUtils.isNotBlank(skuPrefix)) {
				sb.append("- sku theo quy tắc của cửa hàng: tiền tố \"").append(skuPrefix.toUpperCase(Locale.ROOT))
						.append("\" + '-' + số ngẫu nhiên 5 chữ số (ví dụ: ").append(skuPrefix.toUpperCase(Locale.ROOT))
						.append("-12345).\n");
			} else {
				sb.append("- sku tự sinh ngẫu nhiên hợp lý dạng CHỮ_IN_HOA + '-' + số.\n");
			}
			return sb.toString();
		}

		/**
		 * Nhan danh sach ngon ngu tu Admin (dang "vi,en,fr,zh"), chi giu ngon ngu
		 * he thong ho tro, mac dinh la vi,en,fr,zh.
		 */
		private List<String> parseLanguages(String languagesRaw) {
			List<String> result = new ArrayList<>();
			if (StringUtils.isNotBlank(languagesRaw)) {
				for (String lang : languagesRaw.split(",")) {
					String code = lang.trim().toLowerCase(Locale.ROOT);
					if (!code.isEmpty() && DEFAULT_LANGUAGES.contains(code) && !result.contains(code)) {
						result.add(code);
					}
				}
			}
			return result.isEmpty() ? DEFAULT_LANGUAGES : result;
		}

		/**
		 * Chuan hoa seUrl bang Slugify - dam bao khong co ky tu dac biet gay loi
		 * duong dan SEO (vd tieng Viet co dau "điện-thoại" -> "dien-thoai").
		 */
		private void sanitizeSlugs(ProductAiDTO dto) {
			if (dto == null || dto.getLanguages() == null) {
				return;
			}
			for (Map.Entry<String, ProductAiDTO.ProductAiLanguage> entry : dto.getLanguages().entrySet()) {
				ProductAiDTO.ProductAiLanguage lang = entry.getValue();
				if (lang != null && StringUtils.isNotBlank(lang.getSeUrl())) {
					lang.setSeUrl(SLUGIFY.slugify(lang.getSeUrl()));
				}
			}
		}

	private String callGemini(String apiKey, String mimeType, String imageBase64, String prompt) throws IOException {

		Map<String, Object> generationConfig = Map.of(
				// bat buoc Gemini tra ve JSON - tranh markdown/ky tu la
				"responseMimeType", "application/json",
				// cang de nhiet do thap ket qua cang on dinh, it suy dien tu do
				"temperature", 0.4);

			Map<String, Object> payload = Map.of(
					"contents", List.of(Map.of(
							"parts", List.of(
									Map.of("text", prompt),
									Map.of("inline_data", Map.of(
											"mime_type", mimeType,
											"data", imageBase64))))),
					"generationConfig", generationConfig);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(payload, headers);

		String url = GEMINI_API_BASE_URL + geminiModel + ":generateContent?key=" + apiKey;

		// Retry khi Gemini qua tai (503 SERVICE_UNAVAILABLE) hoac bi gioi han (429)
		int maxAttempts = 3;
		HttpStatusCodeException lastError = null;
		for (int attempt = 1; attempt <= maxAttempts; attempt++) {
			try {
				ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
				if (!response.getStatusCode().is2xxSuccessful() || response.getBody() == null) {
					throw new IOException("Gemini API returned status " + response.getStatusCodeValue());
				}
				return extractText(response.getBody());
			} catch (HttpStatusCodeException e) {
				lastError = e;
				int status = e.getStatusCode().value();
				if ((status == 503 || status == 429) && attempt < maxAttempts) {
					long waitMillis = attempt * 3000L; // 3s, 6s
					LOGGER.warn("Gemini API {} (attempt {}/{}), retrying in {} ms", status, attempt, maxAttempts, waitMillis);
					try {
						Thread.sleep(waitMillis);
					} catch (InterruptedException ie) {
						Thread.currentThread().interrupt();
						throw new IOException("Interrupted while waiting to retry Gemini API", ie);
					}
					continue;
				}
				// doc body loi cua Gemini de bao cao ro hon (404/400/403...)
				String apiMessage = e.getResponseBodyAsString();
				LOGGER.error("Gemini API HTTP error {} : {}", e.getStatusCode(), apiMessage);
				throw new IOException("Gemini API tra ve " + e.getStatusCode() + ": " + apiMessage);
			}
		}
		// het so lan retry van loi 503/429
		String apiMessage = lastError != null ? lastError.getResponseBodyAsString() : "unknown";
		throw new IOException("Gemini API qua tai (503) sau " + maxAttempts + " lan thu: " + apiMessage);
	}

	@SuppressWarnings("unchecked")
	private String extractText(Map<String, Object> body) {
		try {
			List<Map<String, Object>> candidates = (List<Map<String, Object>>) body.get("candidates");
			if (candidates == null || candidates.isEmpty()) {
				return null;
			}
			Map<String, Object> content = (Map<String, Object>) candidates.get(0).get("content");
			if (content == null) {
				return null;
			}
			List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");
			if (parts == null || parts.isEmpty()) {
				return null;
			}
			StringBuilder sb = new StringBuilder();
			for (Map<String, Object> part : parts) {
				Object text = part.get("text");
				if (text != null) {
					sb.append(text.toString());
				}
			}
			return sb.length() > 0 ? sb.toString() : null;
	} catch (Exception e) {
			LOGGER.error("Cannot parse Gemini response", e);
			return null;
	}
	}

	/**
	 * API key priority:
	 * 1. Merchant configuration (Admin > Configuration) with key GEMINI_API_KEY
	 * 2. Property googleai.gemini.apikey in shopizer-properties.properties
	 */
	private String resolveApiKey(MerchantStore store) {
		try {
			MerchantConfiguration config = merchantConfigurationService
					.getMerchantConfiguration(GEMINI_API_KEY_CONFIG, store);
			if (config != null && StringUtils.isNotBlank(config.getValue())) {
				return config.getValue();
			}
	} catch (Exception e) {
			LOGGER.error("Error reading GEMINI_API_KEY configuration", e);
	}
		return apiKeyFromProperties;
	}
}
