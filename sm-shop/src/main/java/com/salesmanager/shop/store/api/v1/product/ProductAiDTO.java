package com.salesmanager.shop.store.api.v1.product;

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * DTO chua du lieu AI sinh ra tu Gemini cho form Admin tao san pham moi.
 *
 * Cau truc JSON mong doi tu Gemini:
 * {
 *   "sku": "SP-12345",
 *   "refCode": "REF-98765",
 *   "languages": {
 *     "vi": { "name": "...", "seUrl": "...", "shortDescription": "...",
 *             "description": "...", "metaTitle": "...", "metaDescription": "..." },
 *     "en": { ... }
 *   }
 * }
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class ProductAiDTO {

	@JsonProperty("sku")
	private String sku;

	@JsonProperty("refCode")
	private String refCode;

	@JsonProperty("languages")
	private Map<String, ProductAiLanguage> languages;

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getRefCode() {
		return refCode;
	}

	public void setRefCode(String refCode) {
		this.refCode = refCode;
	}

	public Map<String, ProductAiLanguage> getLanguages() {
		return languages;
	}

	public void setLanguages(Map<String, ProductAiLanguage> languages) {
		this.languages = languages;
	}

	@JsonIgnoreProperties(ignoreUnknown = true)
	public static class ProductAiLanguage {

		@JsonProperty("name")
		private String name;

		@JsonProperty("seUrl")
		private String seUrl;

		@JsonProperty("shortDescription")
		private String shortDescription;

		@JsonProperty("description")
		private String description;

		@JsonProperty("metaTitle")
		private String metaTitle;

		@JsonProperty("metaDescription")
		private String metaDescription;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getSeUrl() {
			return seUrl;
		}

		public void setSeUrl(String seUrl) {
			this.seUrl = seUrl;
		}

		public String getShortDescription() {
			return shortDescription;
		}

		public void setShortDescription(String shortDescription) {
			this.shortDescription = shortDescription;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public String getMetaTitle() {
			return metaTitle;
		}

		public void setMetaTitle(String metaTitle) {
			this.metaTitle = metaTitle;
		}

		public String getMetaDescription() {
			return metaDescription;
		}

		public void setMetaDescription(String metaDescription) {
			this.metaDescription = metaDescription;
		}
	}
}
