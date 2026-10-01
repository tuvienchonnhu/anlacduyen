package com.salesmanager.shop.store.api.v1.product.sapo;

import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import com.salesmanager.core.business.exception.ServiceException;
import com.salesmanager.core.business.services.catalog.product.ProductService;
import com.salesmanager.core.business.services.reference.language.LanguageService;
import com.salesmanager.core.business.services.system.MerchantConfigurationService;
import com.salesmanager.core.model.catalog.product.Product;
import com.salesmanager.core.model.catalog.product.availability.ProductAvailability;
import com.salesmanager.core.model.catalog.product.description.ProductDescription;
import com.salesmanager.core.model.catalog.product.price.ProductPrice;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.reference.language.Language;
import com.salesmanager.core.model.system.MerchantConfiguration;
import com.salesmanager.shop.constants.Constants;

/**
 * Dong bo san pham theo thoi gian thuc tu Sapo.
 *
 * Xac thuc bang Key API + Secret API (Sapo Private App), luu trong
 * Admin > Configuration > Accounts configuration:
 * - SAPO_API_KEY / SAPO_API_SECRET
 * Header: Authorization: Basic base64(key:secret)
 *
 * CRUD: GET / POST / PUT / DELETE /admin/products(.json)
 * Real-time: webhook product/create, product/update, product/delete.
 */
@Service
public class SapoProductSyncService {

	private static final Logger LOGGER = LoggerFactory.getLogger(SapoProductSyncService.class);

	private static final String SAPO_REF_PREFIX = "SAPO-";

	private static final String SAPO_PRODUCTS_PATH = "/admin/products.json";
	private static final String SAPO_PRODUCT_PATH = "/admin/products/%s.json";

	@Inject
	private MerchantConfigurationService merchantConfigurationService;

	@Inject
	private ProductService productService;

	@Inject
	private LanguageService languageService;

	@Value("${sapo.api.key:}")
	private String sapoApiKeyFromProperties;

	@Value("${sapo.api.secret:}")
	private String sapoApiSecretFromProperties;

	private final RestTemplate restTemplate = new RestTemplate();
	private final ObjectMapper objectMapper = new ObjectMapper();

	/**
	 * Goi API Sapo lay mot san pham theo id va cap nhat vao DB local.
	 */
	public void syncProductFromSapo(MerchantStore store, String sapoProductId) throws Exception {
		String url = buildProductsUrl(store, String.format(SAPO_PRODUCT_PATH, sapoProductId));
		SapoProductResponse response = callSapo(store, url, HttpMethod.GET, null, SapoProductResponse.class);
		if (response != null && response.getProduct() != null) {
			saveOrUpdateLocalProduct(store, response.getProduct());
		}
	}

	/**
	 * Doc du lieu 1 san pham Sapo (khong ghi vao DB), tra ve DTO.
	 */
	public SapoProductDto readProduct(MerchantStore store, String sapoProductId) throws Exception {
		String url = buildProductsUrl(store, String.format(SAPO_PRODUCT_PATH, sapoProductId));
		SapoProductResponse response = callSapo(store, url, HttpMethod.GET, null, SapoProductResponse.class);
		return response == null ? null : response.getProduct();
	}

	/**
	 * Doc du lieu danh sach san pham Sapo (khong ghi vao DB).
	 */
	public List<SapoProductDto> readProducts(MerchantStore store) throws Exception {
		String url = buildProductsUrl(store, SAPO_PRODUCTS_PATH);
		SapoProductResponse response = callSapo(store, url, HttpMethod.GET, null, SapoProductResponse.class);
		return response == null || response.getProducts() == null ? java.util.Collections.emptyList()
				: response.getProducts();
	}

	/**
	 * Tao san pham moi tren Sapo (POST /admin/products.json).
	 *
	 * @return san pham Sapo vua tao
	 */
	public SapoProductDto createProductOnSapo(MerchantStore store, SapoProductDto newProduct) throws Exception {
		String url = buildProductsUrl(store, SAPO_PRODUCTS_PATH);
		String body = objectMapper.writeValueAsString(
				java.util.Collections.singletonMap("product", newProduct));
		SapoProductResponse response = callSapo(store, url, HttpMethod.POST, body, SapoProductResponse.class);
		return response == null ? null : response.getProduct();
	}

	/**
	 * Cap nhat san pham tren Sapo (PUT /admin/products/{id}.json).
	 */
	public SapoProductDto updateProductOnSapo(MerchantStore store, String sapoProductId,
			SapoProductDto changes) throws Exception {
		String url = buildProductsUrl(store, String.format(SAPO_PRODUCT_PATH, sapoProductId));
		String body = objectMapper.writeValueAsString(
				java.util.Collections.singletonMap("product", changes));
		SapoProductResponse response = callSapo(store, url, HttpMethod.PUT, body, SapoProductResponse.class);
		return response == null ? null : response.getProduct();
	}

	/**
	 * Xoa san pham tren Sapo (DELETE /admin/products/{id}.json).
	 */
	public void deleteProductOnSapo(MerchantStore store, String sapoProductId) throws Exception {
		String url = buildProductsUrl(store, String.format(SAPO_PRODUCT_PATH, sapoProductId));
		callSapo(store, url, HttpMethod.DELETE, null, String.class);
	}

	/**
	 * Lay toan bo danh sach san pham tu Sapo va upsert vao DB local.
	 *
	 * @return so san pham da dong bo
	 */
	public int syncAllProducts(MerchantStore store) throws Exception {
		String url = buildProductsUrl(store, SAPO_PRODUCTS_PATH);
		SapoProductResponse response = callSapo(store, url, HttpMethod.GET, null, SapoProductResponse.class);
		int count = 0;
		if (response != null && response.getProducts() != null) {
			for (SapoProductDto sapoProduct : response.getProducts()) {
				try {
					saveOrUpdateLocalProduct(store, sapoProduct);
					count++;
				} catch (Exception e) {
					LOGGER.error("Error syncing Sapo product " + sapoProduct.getId(), e);
				}
			}
		}
		return count;
	}

	/**
	 * Xoa san pham local da dong bo tu Sapo (theo REF_SKU SAPO-{id}).
	 *
	 * @return true neu da xoa, false neu khong tim thay
	 */
	public boolean deleteLocalProduct(MerchantStore store, String sapoProductId) {
		try {
			Product product = findLocalProduct(store, sapoProductId);
			if (product == null) {
				// Co the webhook gui id thay vi sku
				if (StringUtils.isNotBlank(sapoProductId)) {
					List<Product> products = productService.listByStore(store);
					if (products != null) {
						for (Product candidate : products) {
							if (candidate.getRefSku() != null && candidate.getRefSku()
									.equalsIgnoreCase(SAPO_REF_PREFIX + sapoProductId)) {
								product = candidate;
								break;
							}
						}
					}
				}
			}
			if (product == null) {
				return false;
			}
			productService.delete(product);
			LOGGER.info("Deleted local product {} synced from Sapo {}", product.getId(), sapoProductId);
			return true;
		} catch (Exception e) {
			LOGGER.error("Error deleting local product for Sapo id " + sapoProductId, e);
			return false;
		}
	}

	/**
	 * Goi boi SapoProductWebhookController khi nhan webhook product update.
	 * Khong goi API Sapo lai, dung truc tiep payload Sapo gui sang.
	 */
	public void saveOrUpdateLocalProduct(MerchantStore store, SapoProductDto sapoProduct) throws ServiceException {
		if (store == null || sapoProduct == null) {
			return;
		}

		String sapoSku = resolveSku(sapoProduct);
		Product product = findLocalProduct(store, sapoSku);

		if (product == null) {
			product = new Product();
			product.setMerchantStore(store);
			product.setAvailable(true);
			product.setDateAvailable(new Date());
			product.setRefSku(SAPO_REF_PREFIX + sapoSku);
		}
		product.setSku(sapoSku);

		// Ten + mo ta cho moi ngon ngu ho tro cua cua hang
		String title = StringUtils.defaultIfBlank(sapoProduct.getName(), sapoProduct.getTitle());
		Set<Language> storeLanguages = null;
		if (product.getMerchantStore() != null && product.getMerchantStore().getLanguages() != null) {
			storeLanguages = new HashSet<>(product.getMerchantStore().getLanguages());
		}
		if (storeLanguages == null || storeLanguages.isEmpty()) {
			storeLanguages = new HashSet<>();
			try {
				storeLanguages.add(
						languageService.getByCode(com.salesmanager.core.business.constants.Constants.DEFAULT_LANGUAGE));
			} catch (Exception e) {
				LOGGER.error("Cannot load default language", e);
			}
		}
		for (Language language : storeLanguages) {
			ProductDescription description = null;
			for (ProductDescription existing : product.getDescriptions()) {
				if (existing.getLanguage() != null && language != null
						&& existing.getLanguage().getId().equals(language.getId())) {
					description = existing;
					break;
				}
			}
			if (description == null) {
				description = new ProductDescription();
				description.setProduct(product);
				description.setLanguage(language);
				product.getDescriptions().add(description);
			}
			description.setName(StringUtils.defaultIfBlank(title, sapoSku));
			description.setDescription(StringUtils.defaultString(
					StringUtils.defaultIfBlank(sapoProduct.getDescription(), sapoProduct.getContent())));
		}

		// Gia va ton kho dua tren bien the dau tien cua Sapo
		SapoProductDto.SapoVariantDto variant = firstVariant(sapoProduct);
		if (variant != null) {
			ProductAvailability availability = null;
			if (product.getAvailabilities() != null) {
				for (ProductAvailability existing : product.getAvailabilities()) {
					availability = existing;
					break;
				}
			}
			if (availability == null) {
				availability = new ProductAvailability(product, store);
				product.getAvailabilities().add(availability);
			}
			availability.setRegion(com.salesmanager.core.business.constants.Constants.ALL_REGIONS);
			if (StringUtils.isNotBlank(variant.getSku())) {
				availability.setSku(variant.getSku());
			}
			availability.setProductQuantity(
					variant.getInventoryQuantity() == null ? Integer.valueOf(0) : variant.getInventoryQuantity());

			ProductPrice price = availability.defaultPrice();
			if (price != null) {
				price.setProductAvailability(availability);
				price.setDefaultPrice(true);
				price.setCode(ProductPrice.DEFAULT_PRICE_CODE);
				if (variant.getPrice() != null) {
					price.setProductPriceAmount(variant.getPrice());
				}
				if (variant.getCompareAtPrice() != null
						&& variant.getCompareAtPrice().compareTo(BigDecimal.ZERO) > 0
						&& variant.getPrice() != null
						&& variant.getCompareAtPrice().compareTo(variant.getPrice()) > 0) {
					price.setProductPriceSpecialAmount(variant.getPrice());
				}
			}
			availability.getPrices().add(price);
		}

		// Trang thai: san pham Sapo khong cong bo thi an di
		if (Boolean.FALSE.equals(sapoProduct.getPublished())) {
			product.setAvailable(false);
		}

		productService.save(product);
		LOGGER.info("Synced Sapo product {} as local product {}", sapoProduct.getId(), product.getId());
	}

	/**
	 * Goi API Sapo voi header Authorization: Basic base64(key:secret).
	 */
	private <T> T callSapo(MerchantStore store, String url, HttpMethod method, String body,
			Class<T> responseType) throws Exception {
		HttpHeaders headers = new HttpHeaders();
		headers.set(HttpHeaders.AUTHORIZATION, buildBasicAuthHeader(store));
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setAccept(java.util.Collections.singletonList(MediaType.APPLICATION_JSON));

		HttpEntity<String> entity = new HttpEntity<>(body, headers);
		ResponseEntity<T> response = restTemplate.exchange(url, method, entity, responseType);
		if (!response.getStatusCode().is2xxSuccessful()) {
			throw new ServiceException("Sapo API returned HTTP " + response.getStatusCode());
		}
		return response.getBody();
	}

	/**
	 * Tao header Basic Auth tu Key API + Secret API trong cau hinh.
	 */
	private String buildBasicAuthHeader(MerchantStore store) throws ServiceException {
		String credentials = resolveApiKey(store) + ":" + resolveApiSecret(store);
		return "Basic " + Base64.getEncoder().encodeToString(credentials.getBytes(StandardCharsets.UTF_8));
	}

	private String buildProductsUrl(MerchantStore store, String path) throws ServiceException {
		String domain = resolveStoreDomain(store);
		return "https://" + domain + path;
	}

	private String resolveStoreDomain(MerchantStore store) throws ServiceException {
		String domain = readConfig("SAPO_STORE_DOMAIN", store);
		if (StringUtils.isBlank(domain)) {
			throw new ServiceException(
					"Sapo store domain is not configured. Go to Admin > Configuration > Accounts configuration.");
		}
		return domain.trim().replaceFirst("^https?://", "");
	}

	private String resolveApiKey(MerchantStore store) throws ServiceException {
		String key = readConfig(Constants.KEY_SAPO_API_KEY, store);
		if (StringUtils.isBlank(key)) {
			key = sapoApiKeyFromProperties;
		}
		if (StringUtils.isBlank(key)) {
			throw new ServiceException(
					"Sapo API key is not configured. Go to Admin > Configuration > Accounts configuration.");
		}
		return key.trim();
	}

	private String resolveApiSecret(MerchantStore store) throws ServiceException {
		String secret = readConfig(Constants.KEY_SAPO_API_SECRET, store);
		if (StringUtils.isBlank(secret)) {
			secret = sapoApiSecretFromProperties;
		}
		if (StringUtils.isBlank(secret)) {
			throw new ServiceException(
					"Sapo API secret is not configured. Go to Admin > Configuration > Accounts configuration.");
		}
		return secret.trim();
	}

	private String readConfig(String key, MerchantStore store) {
		if (store == null || StringUtils.isBlank(key)) {
			return null;
		}
		try {
			MerchantConfiguration config = merchantConfigurationService.getMerchantConfiguration(key, store);
			if (config != null && StringUtils.isNotBlank(config.getValue())) {
				return config.getValue();
			}
		} catch (Exception e) {
			LOGGER.error("Error reading Sapo configuration " + key, e);
		}
		return null;
	}

	/**
	 * Tim san pham local da dong bo tu Sapo. Doi chieu theo REF_SKU
	 * (SAPO-{sku}) hoac theo SKU chinh cua san pham.
	 */
	private Product findLocalProduct(MerchantStore store, String sapoSku) {
		try {
			Product byRefSku = null;
			// Uu tien tim theo REF_SKU (SAPO-xxx) de tranh nham voi san pham thu cong
			List<Product> products = productService.listByStore(store);
			if (products != null) {
				for (Product candidate : products) {
					if (candidate.getRefSku() != null
							&& candidate.getRefSku().equalsIgnoreCase(SAPO_REF_PREFIX + sapoSku)) {
						byRefSku = candidate;
						break;
					}
					if (byRefSku == null && sapoSku != null && sapoSku.equalsIgnoreCase(candidate.getSku())) {
						byRefSku = candidate;
					}
				}
			}
			return byRefSku;
		} catch (Exception e) {
			LOGGER.error("Error finding local product for Sapo sku " + sapoSku, e);
			return null;
		}
	}

	/**
	 * Chon SKU cua san pham Sapo: uu tien variant dau tien, sau do den
	 * sku/code cua san pham.
	 */
	private String resolveSku(SapoProductDto sapoProduct) {
		String sku = null;
		if (sapoProduct.getVariants() != null) {
			for (SapoProductDto.SapoVariantDto variant : sapoProduct.getVariants()) {
				if (StringUtils.isNotBlank(variant.getSku())) {
					sku = variant.getSku();
					break;
				}
			}
		}
		if (StringUtils.isBlank(sku)) {
			sku = sapoProduct.getSku();
		}
		if (StringUtils.isBlank(sku)) {
			sku = sapoProduct.getCode();
		}
		if (StringUtils.isBlank(sku) && sapoProduct.getId() != null) {
			sku = "sapo-" + sapoProduct.getId();
		}
		// SKU trong Shopizer chi cho phep chu, so va gach duoi
		return sku == null ? "sapo-unknown" : sku.replaceAll("[^a-zA-Z0-9_]", "_");
	}

	private SapoProductDto.SapoVariantDto firstVariant(SapoProductDto sapoProduct) {
		if (sapoProduct.getVariants() != null && !sapoProduct.getVariants().isEmpty()) {
			return sapoProduct.getVariants().get(0);
		}
		return null;
	}
}
