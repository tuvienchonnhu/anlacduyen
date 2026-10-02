package com.salesmanager.shop.store.api.v1.product.sapo;

import java.math.BigDecimal;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * Du lieu gui LEN Sapo khi Shopizer day nguoc (POST/PUT
 * /admin/products(.json)).
 *
 * Sapo la he thong kieu Shopify nen body phai boc trong {"product": {...}}
 * (xem {@link SapoProductSyncService#updateProductOnSapo}).
 *
 * Chi cac truong khac null moi duoc ghi vao JSON (@JsonInclude NON_NULL) de
 * tranh vo tinh xoa du lieu tren Sapo khi chi muon cap nhat mot vai truong.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SapoProductPushRequest {

	private String name;
	private String alias;
	private String content;
	@JsonProperty("product_type")
	private String productType;
	@JsonProperty("published")
	private Boolean published;

	@JsonProperty("variants")
	private List<SapoVariantPushRequest> variants;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public Boolean getPublished() {
		return published;
	}

	public void setPublished(Boolean published) {
		this.published = published;
	}

	public List<SapoVariantPushRequest> getVariants() {
		return variants;
	}

	public void setVariants(List<SapoVariantPushRequest> variants) {
		this.variants = variants;
	}

	/** Bien the gui len Sapo */
	@JsonIgnoreProperties(ignoreUnknown = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SapoVariantPushRequest {

		private Long id;
		private String sku;
		private BigDecimal price;
		@JsonProperty("compare_at_price")
		private BigDecimal compareAtPrice;
		@JsonProperty("inventory_quantity")
		private Integer inventoryQuantity;

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public String getSku() {
			return sku;
		}

		public void setSku(String sku) {
			this.sku = sku;
		}

		public BigDecimal getPrice() {
			return price;
		}

		public void setPrice(BigDecimal price) {
			this.price = price;
		}

		public BigDecimal getCompareAtPrice() {
			return compareAtPrice;
		}

		public void setCompareAtPrice(BigDecimal compareAtPrice) {
			this.compareAtPrice = compareAtPrice;
		}

		public Integer getInventoryQuantity() {
			return inventoryQuantity;
		}

		public void setInventoryQuantity(Integer inventoryQuantity) {
			this.inventoryQuantity = inventoryQuantity;
		}
	}
}
