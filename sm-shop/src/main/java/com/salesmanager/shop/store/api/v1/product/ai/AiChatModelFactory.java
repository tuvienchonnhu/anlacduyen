package com.salesmanager.shop.store.api.v1.product.ai;

import java.util.Locale;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.salesmanager.core.business.services.system.MerchantConfigurationService;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.system.MerchantConfiguration;
import com.salesmanager.shop.constants.Constants;

/**
 * Nha may tao {@link AiChatModel} dua tren cau hinh trong Admin.
 *
 * Toan bo thong tin (API key, model, nha cung cap dang chon) duoc doc tu bang
 * MerchantConfiguration - chinh la du lieu nguoi dung nhap trong
 * Admin > Configuration > AI Configuration. Vi vay, khi doi AI chi can doi cau
 * hinh, KHONG can sua code Java.
 *
 * Thu tu uu tien cau hinh:
 * 1. MerchantConfiguration (Admin > Configuration > AI Configuration)
 * 2. Property trong application.properties (mac dinh, dung khi chua cau hinh DB)
 */
@Component
public class AiChatModelFactory {

	private static final Logger LOGGER = LoggerFactory.getLogger(AiChatModelFactory.class);

	@Inject
	private MerchantConfigurationService merchantConfigurationService;

	// Gia tri mac dinh trong application.properties (co the bo qua neu cau hinh DB)
	@Value("${googleai.gemini.apikey:}")
	private String geminiApiKeyFromProperties;

	@Value("${googleai.gemini.model:gemini-3.5-flash}")
	private String geminiModelFromProperties;

	@Value("${openai.apikey:}")
	private String openAiApiKeyFromProperties;

	@Value("${openai.model:gpt-4o-mini}")
	private String openAiModelFromProperties;

	@Value("${groq.apikey:}")
	private String groqApiKeyFromProperties;

	@Value("${groq.model:llama-3.3-70b-versatile}")
	private String groqModelFromProperties;

	@Value("${cerebras.apikey:}")
	private String cerebrasApiKeyFromProperties;

	@Value("${cerebras.model:llama3.1-8b}")
	private String cerebrasModelFromProperties;

	@Value("${ai.provider:" + Constants.AI_PROVIDER_GEMINI + "}")
	private String defaultProvider;

	/**
	 * Tra ve {@link AiChatModel} tuong ung voi nha cung cap dang duoc chon trong
	 * cau hinh AI. Mac dinh la Gemini neu chua cau hinh.
	 *
	 * @throws AiException neu nha cung cap duoc chon chua co API key
	 */
	public AiChatModel getChatModel(MerchantStore store) throws AiException {

		String provider = StringUtils.defaultIfBlank(readConfig(Constants.KEY_AI_PROVIDER, store), defaultProvider)
				.trim().toLowerCase(Locale.ROOT);

		if (Constants.AI_PROVIDER_OPENAI.equals(provider)) {
			String apiKey = StringUtils.defaultIfBlank(readConfig(Constants.KEY_AI_OPENAI_API_KEY, store),
					openAiApiKeyFromProperties);
			String model = StringUtils.defaultIfBlank(readConfig(Constants.KEY_AI_OPENAI_MODEL, store),
					openAiModelFromProperties);
			LOGGER.debug("Using OpenAI chat model : {}", model);
			return new OpenAiChatModel(apiKey, model, null);
	}

		if (Constants.AI_PROVIDER_GROQ.equals(provider)) {
			String apiKey = StringUtils.defaultIfBlank(readConfig(Constants.KEY_AI_GROQ_API_KEY, store),
					groqApiKeyFromProperties);
			String model = StringUtils.defaultIfBlank(readConfig(Constants.KEY_AI_GROQ_MODEL, store),
					groqModelFromProperties);
			LOGGER.debug("Using Groq chat model : {}", model);
			return new GroqChatModel(apiKey, model, null);
	}

		if (Constants.AI_PROVIDER_CEREBRAS.equals(provider)) {
			String apiKey = StringUtils.defaultIfBlank(readConfig(Constants.KEY_AI_CEREBRAS_API_KEY, store),
					cerebrasApiKeyFromProperties);
			String model = StringUtils.defaultIfBlank(readConfig(Constants.KEY_AI_CEREBRAS_MODEL, store),
					cerebrasModelFromProperties);
			LOGGER.debug("Using Cerebras chat model : {}", model);
			return new CerebrasChatModel(apiKey, model, null);
	}

	// Mac dinh Gemini
		String apiKey = StringUtils.defaultIfBlank(readConfig(Constants.KEY_GEMINI_API_KEY, store),
				geminiApiKeyFromProperties);
		String model = StringUtils.defaultIfBlank(readConfig(Constants.KEY_AI_GEMINI_MODEL, store),
				geminiModelFromProperties);
	LOGGER.debug("Using Gemini chat model : {}", model);
		return new GeminiChatModel(apiKey, model, null);
	}

	/**
	 * Doc mot gia tri cau hinh AI tu MerchantConfiguration cua cua hang.
	 * Uu tien cau hinh theo AI Configuration roi toi cac key cu (GEMINI_API_KEY).
	 */
	private String readConfig(String key, MerchantStore store) {
		if (store == null || StringUtils.isBlank(key)) {
			return null;
	}
		try {
			MerchantConfiguration config = merchantConfigurationService.getMerchantConfiguration(key, store);
			if (config != null && StringUtils.isNotBlank(config.getValue())) {
				return config.getValue();
			}
	} catch (Exception e) {
			LOGGER.error("Error reading AI configuration " + key, e);
	}
		return null;
	}
}