package com.salesmanager.shop.store.api.v1.product.sapo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * DTO nhan du lieu danh muc (collection) tu API Sapo.
 *
 * Sapo tra ve danh muc qua endpoint:
 * - GET /admin/custom_collections.json  -> { "custom_collections": [ {...} ] }
 * - GET /admin/smart_collections.json   -> { "smart_collections":  [ {...} ] }
 *
 * LUU Y ve ten truong: API Sapo KHONG dung "title"/"handle" nhu Shopify ma dung:
 * - "name"  -> ten danh muc hien thi
 * - "alias" -> ma/duong dan danh muc (slug)
 *
 * JsonProperty duoc khai bao tuong minh de viec anh xa khong phu thuoc vao
 * ten field trong Java (tranh truong hop ten Java la "name" trung voi
 * keyword hoac bi doi ten sau nay).
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class SapoCollectionDto {

	private Long id;
	/** Ten danh muc hien thi tren Sapo (truong "name" trong JSON) */
	@JsonProperty("name")
	private String title;
	/** Ma danh muc / duong dan danh muc tren Sapo (truong "alias" trong JSON) */
	@JsonProperty("alias")
	private String handle;
	@JsonProperty("description")
	private String bodyHtml;
	@JsonProperty("products_count")
	private Integer productsCount;
	@JsonProperty("published_on")
	private String publishedAt;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getHandle() {
		return handle;
	}

	public void setHandle(String handle) {
		this.handle = handle;
	}

	public String getBodyHtml() {
		return bodyHtml;
	}

	public void setBodyHtml(String bodyHtml) {
		this.bodyHtml = bodyHtml;
	}

	public Integer getProductsCount() {
		return productsCount;
	}

	public void setProductsCount(Integer productsCount) {
		this.productsCount = productsCount;
	}

	public String getPublishedAt() {
		return publishedAt;
	}

	public void setPublishedAt(String publishedAt) {
		this.publishedAt = publishedAt;
	}
}
