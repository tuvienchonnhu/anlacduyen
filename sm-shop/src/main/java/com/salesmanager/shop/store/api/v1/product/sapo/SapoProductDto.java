package com.salesmanager.shop.store.api.v1.product.sapo;

import java.math.BigDecimal;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * DTO nhan du lieu san pham tu API Sapo (products.json).
 * Dung Jackson de anh xa JSON tra ve tu
 * GET https://{store_domain}/admin/products.json
 * va webhook product update cua Sapo.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class SapoProductDto {

	private Long id;
	private String name;
	private String title;
	private String handle;
	/** SKU cua san pham goc trong Sapo */
	private String sku;
	/** Ma san pham tham chieu (product code tren he thong Sapo) */
	private String code;
	private String description;
	private String content;
	private String status;
	@JsonProperty("published")
	private Boolean published;
	@JsonProperty("variants")
	private List<SapoVariantDto> variants;
	@JsonProperty("images")
	private List<SapoImageDto> images;
	private String category;
	@JsonProperty("product_type")
	private String productType;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Boolean getPublished() {
		return published;
	}

	public void setPublished(Boolean published) {
		this.published = published;
	}

	public List<SapoVariantDto> getVariants() {
		return variants;
	}

	public void setVariants(List<SapoVariantDto> variants) {
		this.variants = variants;
	}

	public List<SapoImageDto> getImages() {
		return images;
	}

	public void setImages(List<SapoImageDto> images) {
		this.images = images;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	/** Gia tri bien the (variant) cua san pham Sapo */
	@JsonIgnoreProperties(ignoreUnknown = true)
	public static class SapoVariantDto {

		private Long id;
		private String sku;
		private String title;
		private BigDecimal price;
		@JsonProperty("compare_at_price")
		private BigDecimal compareAtPrice;
		@JsonProperty("inventory_quantity")
		private Integer inventoryQuantity;
		@JsonProperty("inventory_management")
		private String inventoryManagement;

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

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
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

		public String getInventoryManagement() {
			return inventoryManagement;
		}

		public void setInventoryManagement(String inventoryManagement) {
			this.inventoryManagement = inventoryManagement;
		}
	}

	/** Anh san pham Sapo */
	@JsonIgnoreProperties(ignoreUnknown = true)
	public static class SapoImageDto {

		private Long id;
		private String src;
		/** Vi tri sap xep anh (position), anh co vi tri 1 la anh dai dien */
		private Integer position;

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public String getSrc() {
			return src;
		}

		public void setSrc(String src) {
			this.src = src;
		}

		public Integer getPosition() {
			return position;
		}

		public void setPosition(Integer position) {
			this.position = position;
		}
	}
}
