package com.salesmanager.shop.store.api.v1.product.sapo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Bao (envelope) JSON tra ve tu API danh muc Sapo.
 *
 * <pre>
 * GET /admin/custom_collections.json -> { "custom_collections": [ {...} ] }
 * GET /admin/smart_collections.json  -> { "smart_collections":  [ {...} ] }
 * </pre>
 *
 * LUU Y: JSON cua Sapo dung snake_case (custom_collections), khong phai
 * camelCase nhu ten field Java, nen BAT BUOC phai co @JsonProperty. Neu thieu,
 * Jackson se bo qua va tra ve null (day chinh la loi khien dong bo danh muc
 * tra ve 0).
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class SapoCollectionResponse {

	@JsonProperty("custom_collections")
	private List<SapoCollectionDto> customCollections;

	@JsonProperty("smart_collections")
	private List<SapoCollectionDto> smartCollections;

	public List<SapoCollectionDto> getCustomCollections() {
		return customCollections;
	}

	public void setCustomCollections(List<SapoCollectionDto> customCollections) {
		this.customCollections = customCollections;
	}

	public List<SapoCollectionDto> getSmartCollections() {
		return smartCollections;
	}

	public void setSmartCollections(List<SapoCollectionDto> smartCollections) {
		this.smartCollections = smartCollections;
	}
}
