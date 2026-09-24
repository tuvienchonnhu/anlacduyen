package com.salesmanager.shop.store.api.v1.product.ai;

/**
 * Ket qua tra ve tu mo hinh AI (tuong duong ChatResponse cua Spring AI).
 */
public class AiChatResponse {

	private final String text;
	private final String provider;

	public AiChatResponse(String text, String provider) {
		this.text = text;
		this.provider = provider;
	}

	public String getText() {
		return text;
	}

	public String getProvider() {
		return provider;
	}
}