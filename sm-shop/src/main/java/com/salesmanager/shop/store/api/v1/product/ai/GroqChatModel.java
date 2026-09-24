package com.salesmanager.shop.store.api.v1.product.ai;

import java.util.ArrayList;
import java.util.HashMap;
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
 * Implementation {@link AiChatModel} cho Groq.
 *
 * Groq cung cap API tuong thich OpenAI (OpenAI-compatible), nen endpoint va
 * dinh dang payload/message giong het OpenAI, chi khac base URL
 * (https://api.groq.com/openai/v1/chat/completions) va danh sach model
 * (vi du: llama-3.3-70b-versatile).
 *
 * Ho tro ca van ban va anh (vision) qua message content dang mang (array of
 * parts) voi "image_url" chua data URL (voi cac model vision cua Groq).
 */
public class GroqChatModel implements AiChatModel {

	private static final Logger LOGGER = LoggerFactory.getLogger(GroqChatModel.class);

	private static final String GROQ_API_BASE_URL = "https://api.groq.com/openai/v1/chat/completions";

	private final String apiKey;
	private final String model;
	private final RestTemplate restTemplate;

	public GroqChatModel(String apiKey, String model, RestTemplate restTemplate) {
		this.apiKey = apiKey;
		this.model = StringUtils.defaultIfBlank(model, "llama-3.3-70b-versatile");
		this.restTemplate = (restTemplate != null) ? restTemplate : new RestTemplate();
	}

	@Override
	public String getProvider() {
		return "groq";
	}

	@Override
	public AiChatResponse call(AiChatRequest request) throws AiException {

		if (StringUtils.isBlank(apiKey)) {
			throw new AiException(
					"Chua cau hinh Groq API key. Vao Admin > Configuration > AI Configuration de nhap API key.");
		}
		if (request == null || StringUtils.isBlank(request.getPrompt())) {
			throw new AiException("Thieu noi dung (prompt) gui toi Groq.");
		}

		// content: neu co anh -> mang cac part (text + image_url), nguoc lai la chuoi
		// text
		Object content;
		if (request.hasImage()) {
			List<Map<String, Object>> parts = new ArrayList<>();
			parts.add(Map.of("type", "text", "text", request.getPrompt()));
			String mime = StringUtils.defaultIfBlank(request.getImageMimeType(), "image/jpeg");
			String dataUrl = "data:" + mime + ";base64," + request.getImageBase64();
			parts.add(Map.of("type", "image_url", "image_url", Map.of("url", dataUrl)));
			content = parts;
		} else {
			content = request.getPrompt();
		}

		Map<String, Object> message = new HashMap<>();
		message.put("role", "user");
		message.put("content", content);

		Map<String, Object> payload = new HashMap<>();
		payload.put("model", model);
		payload.put("messages", List.of(message));
		// bat buoc Groq tra ve JSON thuan (giong OpenAI)
		payload.put("response_format", Map.of("type", "json_object"));
		payload.put("temperature", 0.4);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setBearerAuth(apiKey);

		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(payload, headers);

		// Retry khi Groq qua tai (429 rate limit / 503)
		int maxAttempts = 3;
		HttpStatusCodeException lastError = null;
		for (int attempt = 1; attempt <= maxAttempts; attempt++) {
			try {
				ResponseEntity<Map> response = restTemplate.postForEntity(GROQ_API_BASE_URL, entity, Map.class);
				if (!response.getStatusCode().is2xxSuccessful() || response.getBody() == null) {
					throw new AiException("Groq API tra ve status " + response.getStatusCodeValue());
				}
				String text = extractText(response.getBody());
				return new AiChatResponse(text, getProvider());
			} catch (HttpStatusCodeException e) {
				lastError = e;
				int status = e.getStatusCode().value();
				if ((status == 429 || status == 503) && attempt < maxAttempts) {
					long waitMillis = attempt * 3000L;
					LOGGER.warn("Groq API {} (attempt {}/{}), retrying in {} ms", status, attempt, maxAttempts,
							waitMillis);
					try {
						Thread.sleep(waitMillis);
					} catch (InterruptedException ie) {
						Thread.currentThread().interrupt();
						throw new AiException("Bi ngat trong khi cho retry Groq API", ie);
					}
					continue;
				}
				String apiMessage = e.getResponseBodyAsString();
				LOGGER.error("Groq API HTTP error {} : {}", e.getStatusCode(), apiMessage);
				throw new AiException("Groq API tra ve " + e.getStatusCode() + ": " + apiMessage);
			}
		}
		String apiMessage = lastError != null ? lastError.getResponseBodyAsString() : "unknown";
		throw new AiException("Groq API qua tai sau " + maxAttempts + " lan thu: " + apiMessage);
	}

	@SuppressWarnings("unchecked")
	private String extractText(Map<String, Object> body) {
		try {
			List<Map<String, Object>> choices = (List<Map<String, Object>>) body.get("choices");
			if (choices == null || choices.isEmpty()) {
				return null;
			}
			Map<String, Object> message = (Map<String, Object>) choices.get(0).get("message");
			if (message == null) {
				return null;
			}
			Object content = message.get("content");
			return content != null ? content.toString() : null;
		} catch (Exception e) {
			LOGGER.error("Cannot parse Groq response", e);
			return null;
		}
	}
}