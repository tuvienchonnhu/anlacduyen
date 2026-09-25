package com.salesmanager.shop.store.api.v1.category;

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * DTO chua du lieu AI sinh ra cho form Admin tao danh muc moi.
 *
 * Cau truc JSON mong doi tu AI (dung lam JSON Schema trong System Prompt):
 * {
 * "categoryCode": "LAPTOP_COMPUTERS",
 * "languages": {
 * "vi": { "name": "...", "seUrl": "...", "shortDescription": "...",
 * "description": "...", "metaTitle": "...", "metaKeywords": "...",
 * "metaDescription": "..." },
 * "en": { ... },
 * "fr": { ... },
 * "zh": { ... }
 * }
 * }
 *
 * Ten truong duoc dat trung voi ten truong tren form Admin de frontend chi
 * viec gan truc tiep gia tri vao cac o input tuong ung.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CategoryAiDTO {

	@JsonProperty("categoryCode")
	private String categoryCode;

	@JsonProperty("languages")
	private Map<String, CategoryAiLanguage> languages;

	public String getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}

	public Map<String, CategoryAiLanguage> getLanguages() {
		return languages;
	}

	public void setLanguages(Map<String, CategoryAiLanguage> languages) {
		this.languages = languages;
	}

	@JsonIgnoreProperties(ignoreUnknown = true)
	public static class CategoryAiLanguage {

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

		@JsonProperty("metaKeywords")
		private String metaKeywords;

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

		public String getMetaKeywords() {
			return metaKeywords;
		}

		public void setMetaKeywords(String metaKeywords) {
			this.metaKeywords = metaKeywords;
		}

		public String getMetaDescription() {
			return metaDescription;
		}

		public void setMetaDescription(String metaDescription) {
			this.metaDescription = metaDescription;
		}
	}
}