package com.salesmanager.shop.store.api.v1.product.sapo;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.salesmanager.core.business.services.merchant.MerchantStoreService;
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

	@Inject
	private MerchantStoreService merchantStoreService;

	/**
	 * Xac dinh cua hang dang quan tri.
	 *
	 * Request fetch() tu trang admin khong di qua /admin/** nen AdminFilter
	 * khong chay, vi vay ADMIN_STORE khong co tren request attribute. Ta thu
	 * lan luot:
	 * 1) request attribute (truong hop request co di qua AdminFilter)
	 * 2) session admin (AdminFilter da luu khi tai trang admin truoc do)
	 * 3) cua hang mac dinh (truong hop session khong duoc gui kem)
	 */
	private MerchantStore resolveStore(HttpServletRequest request) {
		MerchantStore store = (MerchantStore) request.getAttribute(Constants.ADMIN_STORE);
		if (store != null) {
			return store;
		}
		if (request.getSession(false) != null) {
			store = (MerchantStore) request.getSession(false).getAttribute(Constants.ADMIN_STORE);
			if (store != null) {
				return store;
			}
		}
		try {
			store = merchantStoreService
					.getByCode(com.salesmanager.core.business.constants.Constants.DEFAULT_STORE);
			LOGGER.warn("ADMIN_STORE not found on request/session, falling back to default store");
			return store;
		} catch (Exception e) {
			LOGGER.error("Cannot resolve merchant store", e);
			return null;
		}
	}

	@ApiOperation(value = "Dong bo san pham tu Sapo", notes = "Lay danh sach san pham tu /admin/products.json va cap nhat vao he thong")
	@PostMapping("/sync")
	public ResponseEntity<String> sync(HttpServletRequest request) {

		MerchantStore store = resolveStore(request);
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

	@ApiOperation(value = "Dong bo danh muc tu Sapo", notes = "Lay danh sach danh muc (collections) tu Sapo va cap nhat ten + ma danh muc vao he thong")
	@PostMapping("/sync-categories")
	public ResponseEntity<String> syncCategories(HttpServletRequest request) {

		MerchantStore store = resolveStore(request);
		if (store == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Store not resolved");
		}
		try {
			int count = sapoProductSyncService.syncCategories(store);
			return ResponseEntity.ok("SUCCESS " + count);
		} catch (Exception e) {
			LOGGER.error("Error syncing categories from Sapo", e);
			// Tra ve 500 de phia JS hien thi loi thay vi bao thanh cong
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
		}
	}

	@ApiOperation(value = "Dong bo danh muc tu Sapo (chi tiet)", notes = "Nhu /sync-categories nhung tra ve chi tiet tung danh muc de chan doan")
	@PostMapping("/sync-categories-verbose")
	public ResponseEntity<String> syncCategoriesVerbose(HttpServletRequest request) {

		MerchantStore store = resolveStore(request);
		if (store == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Store not resolved");
		}
		try {
			return ResponseEntity.ok(sapoProductSyncService.syncCategoriesVerbose(store));
		} catch (Exception e) {
			LOGGER.error("Error syncing categories verbose", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
		}
	}

	@ApiOperation(value = "Day tat ca san pham da dong bo len Sapo", notes = "Chi day cac san pham co sapo_product_id; day ten/gia/ton kho va danh muc")
	@PostMapping("/push-all")
	public ResponseEntity<String> pushAll(HttpServletRequest request) {

		MerchantStore store = resolveStore(request);
		if (store == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Store not resolved");
		}
		try {
			int count = 			sapoProductSyncService.pushAllProductsToSapo(store);
						return ResponseEntity.ok("SUCCESS " + count);
					} catch (Exception e) {
						LOGGER.error("Error pushing products to Sapo", e);
						return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
					}
				}

				/**
				 * CHAN DOAN: cho biet app dang cau hinh Sapo nhu the nao va doc duoc gi tu
				 * Sapo. Dung de tim loi khi dong bo tra ve 0.
				 */
				@ApiOperation(value = "Chan doan ket noi Sapo", notes = "Kiem tra cau hinh va so luong danh muc doc duoc tu Sapo")
				@GetMapping("/diagnose")
				public ResponseEntity<String> diagnose(HttpServletRequest request) {
					MerchantStore store = resolveStore(request);
					if (store == null) {
						return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Store not resolved");
					}
					try {
						StringBuilder sb = new StringBuilder();
						sb.append("store=" + store.getCode() + " (id=" + store.getId() + ")\n");
						sb.append(sapoProductSyncService.diagnose(store));
						return ResponseEntity.ok(sb.toString());
					} catch (Exception e) {
						LOGGER.error("Error diagnosing Sapo connection", e);
						return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
					}
				}
			}
