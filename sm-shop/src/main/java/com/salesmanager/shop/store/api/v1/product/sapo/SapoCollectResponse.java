package com.salesmanager.shop.store.api.v1.product.sapo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Bao (envelope) JSON tra ve tu API lien ket san pham - danh muc cua Sapo.
 *
 * <pre>
 * GET /admin/collects.json -> { "collects": [ {...} ] }
 * </pre>
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class SapoCollectResponse {

	private List<SapoCollectDto> collects;

	public List<SapoCollectDto> getCollects() {
		return collects;
	}

	public void setCollects(List<SapoCollectDto> collects) {
		this.collects = collects;
	}
}
