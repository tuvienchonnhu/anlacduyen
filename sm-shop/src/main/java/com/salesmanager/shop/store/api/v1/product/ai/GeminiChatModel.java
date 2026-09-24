package com.salesmanager.shop.store.api.v1.product.ai;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
 * Implementation {@link AiChatModel} cho Google Gemini.
 *
 * Giu nguyen logic goi REST API Gemini (bao gom retry khi 503/429) truoc day
 * nam trong GoogleAiController, nhung duoc dong goi lai phia sau lop truu
 * tuong.
 */
public class GeminiChatModel implements AiChatModel {

	private static final Logger LOGGER = LoggerFactory.getLogger(GeminiChatModel.class);

	private static final String GEMINI_API_BASE_URL = "https://generativelanguage.googleapis.com/v1beta/models/";

	private final String apiKey;
	private final String model;
	private final RestTemplate restTemplate;

	public GeminiChatModel(String apiKey, String model, RestTemplate restTemplate) {
		this.apiKey = apiKey;
		this.model = StringUtils.defaultIfBlank(model, "gemini-3.5-flash");
		this.restTemplate = (restTemplate != null) ? restTemplate : new RestTemplate();
	}

	@Override
	public String getProvider() {
		return "gemini";
	}

	@Override
	public AiChatResponse call(AiChatRequest request) throws AiException {

		if (StringUtils.isBlank(apiKey)) {
			throw new AiException(
					"Chua cau hinh Gemini API key. Vao Admin > Configuration > AI Configuration de nhap API key.");
		}
		if (request == null || StringUtils.isBlank(request.getPrompt())) {
			throw new AiException("Thieu noi dung (prompt) gui toi Gemini.");
		}

		Map<String, Object> generationConfig = Map.of(
				// bat buoc Gemini tra ve JSON - tranh markdown/ky tu la
				"responseMimeType", "application/json",
				// cang de nhiet do thap ket qua cang on dinh, it suy dien tu do
				"temperature", 0.4);

		List<Map<String, Object>> parts = new ArrayList<>();
		parts.add(Map.of("text", request.getPrompt()));
		if (request.hasImage()) {
			parts.add(Map.of("inline_data", Map.of(
					"mime_type", StringUtils.defaultIfBlank(request.getImageMimeType(), "image/jpeg"),
					"data", request.getImageBase64())));
		}

		Map<String, Object> payload = Map.of(
				"contents", List.of(Map.of("parts", parts)),
				"generationConfig", generationConfig);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(payload, headers);

		String url = GEMINI_API_BASE_URL + model + ":generateContent?key=" + apiKey;

		// Retry khi Gemini qua tai (503 SERVICE_UNAVAILABLE) hoac bi gioi han (429)
		int maxAttempts = 3;
		HttpStatusCodeException lastError = null;
		for (int attempt = 1; attempt <= maxAttempts; attempt++) {
			try {
				ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
				if (!response.getStatusCode().is2xxSuccessful() || response.getBody() == null) {
					throw new AiException("Gemini API tra ve status " + response.getStatusCodeValue());
				}
				String text = extractText(response.getBody());
				return new AiChatResponse(text, getProvider());
			} catch (HttpStatusCodeException e) {
				lastError = e;
				int status = e.getStatusCode().value();
				if ((status == 503 || status == 429) && attempt < maxAttempts) {
					long waitMillis = attempt * 3000L; // 3s, 6s
					LOGGER.warn("Gemini API {} (attempt {}/{}), retrying in {} ms", status, attempt, maxAttempts,
							waitMillis);
					try {
						Thread.sleep(waitMillis);
					} catch (InterruptedException ie) {
						Thread.currentThread().interrupt();
						throw new AiException("Bi ngat trong khi cho retry Gemini API", ie);
					}
					continue;
				}
					String apiMessage = e.getResponseBodyAsString();
				LOGGER.error("Gemini API HTTP error {} : {}", e.getStatusCode(), apiMessage);
				throw new AiException("Gemini API tra ve " + e.getStatusCode() + ": " + apiMessage);
				}
				}
		String apiMessage = lastError != null ? lastError.getResponseBodyAsString() : "unknown";
		throw new AiException("Gemini API qua tai (503) sau " + maxAttempts + " lan thu: " + apiMessage);
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
}