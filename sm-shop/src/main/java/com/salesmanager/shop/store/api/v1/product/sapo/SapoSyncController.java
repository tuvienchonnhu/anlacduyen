package com.salesmanager.shop.store.api.v1.product.sapo;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.shop.constants.Constants;

import io.swagger.annotations.ApiOperation;

/**
 * API dong bo san pham theo thoi gian thuc tu Sapo.
 *
 * Admin goi tu man hinh quan tri (hoac bat ky client nao co quyen AUTH):
 * POST /api/v1/sapo/sync -> dong bo toan bo danh sach san pham
 */
@RestController
@RequestMapping("/api/v1/sapo")
public class SapoSyncController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SapoSyncController.class);

	@Inject
	private SapoProductSyncService sapoProductSyncService;

	@ApiOperation(value = "Dong bo san pham tu Sapo", notes = "Lay danh sach san pham tu /admin/products.json va cap nhat vao he thong")
	@PostMapping("/sync")
	public ResponseEntity<String> sync(HttpServletRequest request) {

		// Endpoint nay duoc goi bang fetch() tu trang quan tri da dang nhap
		// (/admin/configuration/accounts.html). Request khong di qua /admin/**
		// nen AdminFilter khong chay => khong the lay ADMIN_STORE tu request attribute.
		// Vi vay doc truc tiep tu session admin giong nhu cac controller admin khac.
		MerchantStore store = (MerchantStore) request.getSession().getAttribute(Constants.ADMIN_STORE);
		if (store == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Store not resolved");
		}
		try {
			int count = sapoProductSyncService.syncAllProducts(store);
			return ResponseEntity.ok("SUCCESS " + count);
		} catch (Exception e) {
			LOGGER.error("Error syncing products from Sapo", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
		}
	}
}
