package com.salesmanager.shop.store.api.v1.product.ai;

/**
 * Loi chung cua tang AI (thieu cau hinh, loi API, loi parse...).
 */
public class AiException extends Exception {

	private static final long serialVersionUID = 1L;

	public AiException(String message) {
		super(message);
	}

	public AiException(String message, Throwable cause) {
		super(message, cause);
	}
}