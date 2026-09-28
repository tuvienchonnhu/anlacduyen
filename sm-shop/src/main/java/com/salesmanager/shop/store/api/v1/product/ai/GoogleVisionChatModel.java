package com.salesmanager.shop.store.api.v1.product.ai;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

/**
 * Implementation {@link AiChatModel} cho Google Cloud Vision API.
 *
 * Khac voi cac nha cung cap khac (Gemini / OpenAI / Groq / Cerebras la mo hinh
 * hoi thoai da phuong thuc), Google Vision KHONG phai la chat model: API nay
 * phan tich anh va tra ve danh sach nhan (label) kem diem tin cay, khong sinh
 * ra van ban tu do. Vi vay lop nay:
 *
 * 1. Goi endpoint "images:annotate" voi 3 tinh nang:
 * - LABEL_DETECTION: nhan dien loai san pham (tui xach, giay, ao...)
 * - OBJECT_LOCALIZATION: phat hien TUNG vat the rieng biet trong khung hinh
 * -> tuong ung voi tinh nang "nhieu san pham trong mot anh"
 * - TEXT_DETECTION: doc chu tren bao bi/nhan hang de lam tu khoa.
 *
 * 2. Chuyen ket qua sang JSON dung dinh dang ma
 * {@code ProductImageSearchController.parseDetectedProducts} doc duoc:
 * {"products":[{"name":..., "category":..., "keywords":[...], ...}]}
 *
 * Nho vay, khong can sua bat ky code nghiep vu nao khac khi doi sang Google
 * Vision.
 *
 * Xac thuc:
 * - Neu co API key (AI_GOOGLE_VISION_API_KEY) -> gui qua query param "key".
 * - Neu khong co key -> KHONG gui key, de Google Cloud SDK tu lay thong tin
 * xac thuc tu bien moi truong GOOGLE_APPLICATION_CREDENTIALS.
 */
public class GoogleVisionChatModel implements AiChatModel {

	private static final Logger LOGGER = LoggerFactory.getLogger(GoogleVisionChatModel.class);

	private static final String VISION_API_URL = "https://vision.googleapis.com/v1/images:annotate";

	/** Chi giu cac nhan co diem tin cay tu muc nay tro len de tranh nhieu. */
	private static final double MIN_LABEL_SCORE = 0.5d;

	/** So tu khoa toi da cho mot san pham (giong cac provider khac: 6-10). */
	private static final int MAX_KEYWORDS = 10;

	private final String apiKey;
	private final RestTemplate restTemplate;

	public GoogleVisionChatModel(String apiKey, String model, RestTemplate restTemplate) {
		// Google Vision khong co khai niem "model" chon truoc nhu Gemini/OpenAI,
		// tham so model duoc giu de dong nhat chu ky constructor voi cac provider.
		this.apiKey = apiKey;
		this.restTemplate = (restTemplate != null) ? restTemplate : new RestTemplate();
	}

	@Override
	public String getProvider() {
		return "googlevision";
	}

	@Override
	public AiChatResponse call(AiChatRequest request) throws AiException {

		if (request == null || !request.hasImage()) {
			throw new AiException("Google Vision chi ho tro tim kiem bang hinh anh.");
		}

		Map<String, Object> image = Map.of("content", request.getImageBase64());

		Map<String, Object> features = Map.of(
				"type", "LABEL_DETECTION",
				"maxResults", 20);

		List<Map<String, Object>> requestList = new ArrayList<>();
		Map<String, Object> annotateRequest = new java.util.LinkedHashMap<>();
		annotateRequest.put("image", image);
		// Thu tu tinh nang: vat the rieng biet -> nhan chung -> chu tren bao bi
		annotateRequest.put("features", List.of(
				Map.of("type", "OBJECT_LOCALIZATION", "maxResults", 20),
				features,
				Map.of("type", "TEXT_DETECTION", "maxResults", 5)));
		requestList.add(annotateRequest);

		Map<String, Object> payload = Map.of("requests", requestList);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(payload, headers);

		String url = StringUtils.isNotBlank(apiKey) ? (VISION_API_URL + "?key=" + apiKey) : VISION_API_URL;

		// Retry khi Google tra ve 429 (het quota) hoac 503 (qua tai)
		int maxAttempts = 3;
		HttpStatusCodeException lastError = null;
		for (int attempt = 1; attempt <= maxAttempts; attempt++) {
			try {
				ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
				if (!response.getStatusCode().is2xxSuccessful() || response.getBody() == null) {
					throw new AiException("Google Vision API tra ve status " + response.getStatusCodeValue());
				}
				String json = buildProductsJson(response.getBody());
				return new AiChatResponse(json, getProvider());
			} catch (HttpStatusCodeException e) {
				lastError = e;
				int status = e.getStatusCode().value();
				if ((status == 429 || status == 503) && attempt < maxAttempts) {
					long waitMillis = attempt * 3000L;
					LOGGER.warn("Google Vision API {} (attempt {}/{}), retrying in {} ms", status, attempt, maxAttempts,
							waitMillis);
					try {
						Thread.sleep(waitMillis);
					} catch (InterruptedException ie) {
						Thread.currentThread().interrupt();
						throw new AiException("Bi ngat trong khi cho retry Google Vision API", ie);
					}
					continue;
				}
				String apiMessage = e.getResponseBodyAsString();
				LOGGER.error("Google Vision API HTTP error {} : {}", e.getStatusCode(), apiMessage);
				if (status == 401 || status == 403) {
					throw new AiException(
							"Google Vision API tu choi (kiem tra API key / quyen cua service account): " + apiMessage);
				}
				throw new AiException("Google Vision API tra ve " + e.getStatusCode() + ": " + apiMessage);
			}
		}
		String apiMessage = lastError != null ? lastError.getResponseBodyAsString() : "unknown";
		throw new AiException("Google Vision API qua tai sau " + maxAttempts + " lan thu: " + apiMessage);
	}

	/**
	 * Chuyen phan "responses" cua Google Vision thanh JSON dang
	 * {"products":[...]} de controller tai su dung nguyen logic tim kiem.
	 *
	 * Voi moi vat the duoc dinh vi (localizedObjectAnnotations) tao mot san pham;
	 * cac nhan con lai (labelAnnotations) gop thanh mot san pham chung. Neu ca
	 * hai deu rong thi tra ve mang rong - controller se bao khong nhan dien duoc
	 * va ghi log ro rang de chan doan.
	 */
	@SuppressWarnings("unchecked")
	private String buildProductsJson(Map<String, Object> body) throws AiException {

		List<Map<String, Object>> products = new ArrayList<>();

		try {
			List<Map<String, Object>> responses = (List<Map<String, Object>>) body.get("responses");
			if (responses == null || responses.isEmpty()) {
				return "{\"products\":[]}";
			}

			Map<String, Object> first = responses.get(0);
			if (first == null) {
				return "{\"products\":[]}";
			}

			// Google tra loi kem truong "error" khi API chua duoc bat, sai key,
			// het quota... Neu bo qua thi nguoi dung chi thay "khong nhan dien duoc"
			// ma khong biet nguyen nhan that. Vi vay doc va bao ro rang.
			Object responseError = first.get("error");
			if (responseError instanceof Map) {
				Map<?, ?> errorMap = (Map<?, ?>) responseError;
				Object errorMessage = errorMap.get("message");
				LOGGER.error("Google Vision returned error: {}", errorMessage);
				throw new AiException("Google Vision bao loi: " + errorMessage);
			}

			// Ghi lai ket qua tho de chan doan khi cau hinh/anh khong phu hop.
			// Dung info de nguoi quan tri thay duoc trong log khi can go loi.
			LOGGER.info("Google Vision response keys: {}", first.keySet());

			// 1. Vat the duoc dinh vi -> moi vat the la mot san pham rieng biet
			List<Map<String, Object>> localizedObjects = (List<Map<String, Object>>) first
					.get("localizedObjectAnnotations");
			if (localizedObjects != null) {
				for (Map<String, Object> object : localizedObjects) {
					Object name = object.get("name");
					if (name == null || StringUtils.isBlank(name.toString())) {
						continue;
					}
					Number score = (Number) object.get("score");
					double confidence = score != null ? score.doubleValue() : 0d;
					if (confidence < MIN_LABEL_SCORE) {
						continue;
					}
					products.add(buildDetectedProduct(name.toString(), confidence));
				}
			}

			// 2. Nhan chung (label) -> gop thanh mot san pham "tong hop"
			List<Map<String, Object>> labels = (List<Map<String, Object>>) first.get("labelAnnotations");
			Set<String> labelNames = new LinkedHashSet<>();
			double bestLabelScore = 0d;
			if (labels != null) {
				for (Map<String, Object> label : labels) {
					Object description = label.get("description");
					if (description == null || StringUtils.isBlank(description.toString())) {
						continue;
					}
					Number score = (Number) label.get("score");
					double confidence = score != null ? score.doubleValue() : 0d;
					if (confidence < MIN_LABEL_SCORE) {
						continue;
					}
					labelNames.add(description.toString());
					if (confidence > bestLabelScore) {
						bestLabelScore = confidence;
					}
				}

				// Khong co nhan nao dat nguong: van lay nhan co diem cao nhat thay vi
				// tra ve rong. Anh chup trong dieu kien thieu sang / san pham la thuong
				// gap diem thap nhung van la thong tin tot nhat co duoc.
				if (labelNames.isEmpty()) {
					for (Map<String, Object> label : labels) {
						Object description = label.get("description");
						if (description == null || StringUtils.isBlank(description.toString())) {
							continue;
						}
						Number score = (Number) label.get("score");
						double confidence = score != null ? score.doubleValue() : 0d;
						if (confidence >= 0.35d) {
							labelNames.add(description.toString());
							if (confidence > bestLabelScore) {
								bestLabelScore = confidence;
							}
						}
					}
					if (!labelNames.isEmpty()) {
						LOGGER.debug("No label above threshold, using fallback labels: {}", labelNames);
					}
			}
			}

			if (!labelNames.isEmpty()) {
				Map<String, Object> product = new java.util.LinkedHashMap<>();
				// Nhan chi tiet nhat (dau tien trong danh sach cua Google) lam ten san pham
				String name = labelNames.iterator().next();
				product.put("name", name);
				product.put("category", name);
				product.put("confidence", toConfidenceLabel(bestLabelScore));
				product.put("keywords", new ArrayList<>(labelNames));
				products.add(product);
			}

			// 3. Chu doc duoc tren bao bi -> bo sung tu khoa cho san pham dau tien
			List<Map<String, Object>> texts = (List<Map<String, Object>>) first.get("textAnnotations");
			if (texts != null && !texts.isEmpty() && !products.isEmpty()) {
				Object fullText = texts.get(0).get("description");
				if (fullText != null && StringUtils.isNotBlank(fullText.toString())) {
					@SuppressWarnings("unchecked")
					List<String> keywords = (List<String>) products.get(0).get("keywords");
					if (keywords == null) {
						keywords = new ArrayList<>();
						products.get(0).put("keywords", keywords);
					}
					// Tach chu tren bao bi thanh tung tu khoa ngan, toi da MAX_KEYWORDS
					for (String token : StringUtils.defaultString(fullText.toString()).split("\\s+")) {
						if (keywords.size() >= MAX_KEYWORDS) {
							break;
						}
						String cleaned = token.replaceAll("[^\\p{L}\\p{N}]", "");
						if (cleaned.length() >= 2) {
							keywords.add(cleaned);
						}
					}
				}
			}

		} catch (ClassCastException | NullPointerException e) {
			LOGGER.error("Cannot parse Google Vision response", e);
			throw new AiException("Google Vision tra ve du lieu khong doc duoc.");
		}

		// Gioi han keywords cua moi san pham cho gon
		for (Map<String, Object> product : products) {
			Object keywords = product.get("keywords");
			if (keywords instanceof List) {
				@SuppressWarnings("unchecked")
				List<String> list = (List<String>) keywords;
				if (list.size() > MAX_KEYWORDS) {
					product.put("keywords", new ArrayList<>(list.subList(0, MAX_KEYWORDS)));
				}
			}
		}

		if (products.isEmpty()) {
			// Khong co vat the lan nhan nao dat nguong -> ghi log ro rang de chan doan
			// (thuong gap khi anh qua mo / thieu sang, hoac Cloud Vision chua bat).
			LOGGER.warn("Google Vision khong tra ve vat the/nhan nao dat nguong cho anh nay.");
		}

		return toJson(products);
	}

	private Map<String, Object> buildDetectedProduct(String name, double confidence) {
		Map<String, Object> product = new java.util.LinkedHashMap<>();
		product.put("name", name);
		product.put("category", name);
		product.put("confidence", toConfidenceLabel(confidence));
		List<String> keywords = new ArrayList<>();
		keywords.add(name);
		keywords.add(name.toLowerCase(Locale.ROOT));
		product.put("keywords", keywords);
		return product;
	}

	/** Doi diem tin cay so (0..1) thanh nhan high/medium/low cho dong nhat. */
	private String toConfidenceLabel(double confidence) {
		if (confidence >= 0.85d) {
			return "high";
		}
		if (confidence >= 0.7d) {
			return "medium";
		}
		return "low";
	}

	/** Serialize danh sach san pham thanh JSON bang ObjectMapper cua Jackson. */
	private String toJson(List<Map<String, Object>> products) throws AiException {
		try {
			com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
			Map<String, Object> root = new java.util.LinkedHashMap<>();
			root.put("products", products);
			return mapper.writeValueAsString(root);
		} catch (Exception e) {
			LOGGER.error("Cannot serialize Google Vision result", e);
			throw new AiException("Khong tao duoc ket qua tu Google Vision.");
		}
	}
}