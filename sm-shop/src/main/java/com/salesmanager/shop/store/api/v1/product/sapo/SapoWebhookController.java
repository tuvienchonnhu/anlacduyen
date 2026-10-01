package com.salesmanager.shop.store.api.v1.product.sapo;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.system.MerchantConfiguration;
import com.salesmanager.core.business.services.merchant.MerchantStoreService;
import com.salesmanager.core.business.services.system.MerchantConfigurationService;
import com.salesmanager.shop.constants.Constants;

import io.swagger.annotations.ApiOperation;

/**
 * Nhan webhook realtime tu Sapo khi san pham duoc tao / cap nhat.
 *
 * Cau hinh webhook tai Sapo:
 * URL : https://{your_domain}/api/v1/sapo/webhooks/product
 * Topic : product/update (hoac product/create)
 *
 * Neu cau hinh SAPO_WEBHOOK_SECRET (Admin > Configuration > Accounts
 * configuration) ton tai, chu ky HMAC-SHA256 trong header
 * "X-Sapo-Hmac-SHA256" se duoc kiem tra truoc khi xu ly.
 */
@RestController
@RequestMapping("/api/v1/sapo/webhooks")
public class SapoWebhookController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SapoWebhookController.class);

	public static final String KEY_SAPO_WEBHOOK_SECRET = "SAPO_WEBHOOK_SECRET";
	public static final String SAPO_HMAC_HEADER = "X-Sapo-Hmac-SHA256";

	@Inject
	private SapoProductSyncService sapoProductSyncService;

	@Inject
	private MerchantStoreService merchantStoreService;

	@Inject
	private MerchantConfigurationService merchantConfigurationService;

	private final ObjectMapper objectMapper = new ObjectMapper();

	@ApiOperation(value = "Nhan webhook product tu Sapo (create/update/delete)", notes = "Cap nhat san pham theo thoi gian thuc")
	@PostMapping("/product")
	public ResponseEntity<String> handleProductWebhook(HttpServletRequest request,
			@RequestBody String rawPayload) {

		try {
			MerchantStore store = merchantStoreService
					.getByCode(com.salesmanager.core.business.constants.Constants.DEFAULT_STORE);

			if (!verifySignature(store, request, rawPayload)) {
				LOGGER.warn("Rejected Sapo webhook, invalid signature");
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid signature");
			}

			String topic = request.getHeader("X-Sapo-Topic");
			LOGGER.info("Received Sapo webhook topic={}", topic);

			com.fasterxml.jackson.databind.JsonNode root = objectMapper.readTree(rawPayload);
			// Payload webhook co the la {"product": {...}} hoac san pham truc tiep
			com.fasterxml.jackson.databind.JsonNode productNode = root.has("product") ? root.get("product") : root;

			if (productNode == null || productNode.isNull() || !productNode.hasNonNull("id")) {
				LOGGER.warn("Sapo webhook payload has no product object");
				return ResponseEntity.badRequest().body("No product in payload");
			}

			SapoProductDto sapoProduct = objectMapper.treeToValue(productNode, SapoProductDto.class);
			String sapoProductId = String.valueOf(productNode.get("id").asLong());

			if (topic != null && topic.toLowerCase().contains("delete")) {
				// Xoa san pham local khi Sapo xoa
				sapoProductSyncService.deleteLocalProduct(store, sapoProductId);
			} else {
				// product/create va product/update -> upsert ngay lap tuc
				sapoProductSyncService.saveOrUpdateLocalProduct(store, sapoProduct);
			}

			return ResponseEntity.ok("SUCCESS");

		} catch (Exception e) {
			LOGGER.error("Error handling Sapo webhook", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error");
		}
	}

	/**
	 * Kiem tra chu ky HMAC-SHA256 (base64) neu da cau hinh webhook secret.
	 */
	private boolean verifySignature(MerchantStore store, HttpServletRequest request, String payload) {
		try {
			MerchantConfiguration config = merchantConfigurationService
					.getMerchantConfiguration(KEY_SAPO_WEBHOOK_SECRET, store);
			if (config == null || StringUtils.isBlank(config.getValue())) {
				// Chua cau hinh secret => bo qua xac thuc
				return true;
			}
			String header = request.getHeader(SAPO_HMAC_HEADER);
			if (StringUtils.isBlank(header)) {
				return false;
			}
			javax.crypto.Mac mac = javax.crypto.Mac.getInstance("HmacSHA256");
			mac.init(new javax.crypto.spec.SecretKeySpec(
					config.getValue().getBytes(java.nio.charset.StandardCharsets.UTF_8), "HmacSHA256"));
			byte[] raw = mac.doFinal(payload.getBytes(java.nio.charset.StandardCharsets.UTF_8));
			String computed = java.util.Base64.getEncoder().encodeToString(raw);
			return computed.equals(header.trim());
		} catch (Exception e) {
			LOGGER.error("Error verifying Sapo webhook signature", e);
			return false;
		}
	}
}
