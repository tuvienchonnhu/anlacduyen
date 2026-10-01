package com.salesmanager.shop.store.api.v1.product.sapo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Bao (envelope) JSON tra ve tu API Sapo:
 * 
 * <pre>
 * { "products": [ {...}, {...} ] }
 * </pre>
 * 
 * voi endpoint GET /admin/products.json
 * hoac
 * 
 * <pre>
 * { "product": {...} }
 * </pre>
 * 
 * voi endpoint GET /admin/products/{id}.json va webhook product update.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class SapoProductResponse {

	private List<SapoProductDto> products;
	private SapoProductDto product;

	public List<SapoProductDto> getProducts() {
		return products;
	}

	public void setProducts(List<SapoProductDto> products) {
		this.products = products;
	}

	public SapoProductDto getProduct() {
		return product;
	}

	public void setProduct(SapoProductDto product) {
		this.product = product;
	}
}
