package com.salesmanager.shop.store.api.v1.product.sapo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * DTO nhan du lieu lien ket san pham <-> danh muc (collect) tu API Sapo.
 *
 * Sapo dung cung mo hinh API voi Shopify nen quan he giua san pham va danh muc
 * nam o endpoint:
 * - GET /admin/collects.json -> { "collects": [ {...} ] }
 * - GET /admin/collects.json?product_id={id} -> cac danh muc cua mot san pham
 *
 * Moi collect lien ket mot product_id voi mot collection_id.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class SapoCollectDto {

	private Long id;
	@JsonProperty("collection_id")
	private Long collectionId;
	@JsonProperty("product_id")
	private Long productId;
	@JsonProperty("featured")
	private Boolean featured;
	@JsonProperty("position")
	private Integer position;
	@JsonProperty("sort_value")
	private String sortValue;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getCollectionId() {
		return collectionId;
	}

	public void setCollectionId(Long collectionId) {
		this.collectionId = collectionId;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Boolean getFeatured() {
		return featured;
	}

	public void setFeatured(Boolean featured) {
		this.featured = featured;
	}

	public Integer getPosition() {
		return position;
	}

	public void setPosition(Integer position) {
		this.position = position;
	}

	public String getSortValue() {
		return sortValue;
	}

	public void setSortValue(String sortValue) {
		this.sortValue = sortValue;
	}
}
