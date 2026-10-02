package com.salesmanager.shop.store.api.v1.product.sapo;

import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
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
import com.salesmanager.core.business.services.catalog.category.CategoryService;
import com.salesmanager.core.business.services.catalog.product.ProductService;
import com.salesmanager.core.business.services.reference.language.LanguageService;
import com.salesmanager.core.business.services.system.MerchantConfigurationService;
import com.salesmanager.core.model.catalog.category.Category;
import com.salesmanager.core.model.catalog.category.CategoryDescription;
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

	// Sapo dung mo hinh API giong Shopify: danh muc nam trong collections.
	private static final String SAPO_CUSTOM_COLLECTIONS_PATH = "/admin/custom_collections.json";
	private static final String SAPO_SMART_COLLECTIONS_PATH = "/admin/smart_collections.json";
	// Lien ket san pham <-> danh muc (product <-> collection)
	private static final String SAPO_COLLECTS_PATH = "/admin/collects.json";

	// Danh muc dong bo tu Sapo duoc danh dau tien to nay trong CODE de
	// phan biet voi danh muc tao tay va de tim lai khi cap nhat.
	private static final String SAPO_CATEGORY_PREFIX = "SAPO-CAT-";

	@Inject
	private MerchantConfigurationService merchantConfigurationService;

	@Inject
	private ProductService productService;

	@Inject
	private CategoryService categoryService;

	@Inject
	private LanguageService languageService;

	@Value("${sapo.api.key:}")
	private String sapoApiKeyFromProperties;

	@Value("${sapo.api.secret:}")
	private String sapoApiSecretFromProperties;

	private final RestTemplate restTemplate = new RestTemplate();
	private final ObjectMapper objectMapper = new ObjectMapper();

	/**
	 * CHONG VONG LAP dong bo hai chieu.
	 *
	 * Khi Shopizer day mot san pham len Sapo, Sapo se ban webhook product/update
	 * tro lai. Neu khong nhan biet, webhook do lai ghi de du lieu local roi lai
	 * day len Sapo... tao thanh vong lap vo tan.
	 *
	 * Map duoi day luu moc thoi gian Shopizer vua day tung sapo_product_id len
	 * Sapo. Khi webhook ve trong khoang thoi gian cho phep, ta bo qua.
	 */
	private static final long SYNC_ECHO_WINDOW_MS = 30_000L;

	private final Map<Long, Long> recentlyPushedToSapo = new java.util.concurrent.ConcurrentHashMap<>();

	/**
	 * Ghi nho vua day san pham nay len Sapo (dung cho chong vong lap webhook).
	 */
	private void markPushedToSapo(Long sapoProductId) {
		if (sapoProductId != null) {
			recentlyPushedToSapo.put(sapoProductId, System.currentTimeMillis());
		}
	}

	/**
	 * Webhook nay co phai la ket qua cua lan Shopizer vua day len Sapo khong?
	 *
	 * @return true neu nen bo qua webhook de tranh vong lap
	 */
	public boolean isSelfOriginatedWebhook(String sapoProductId) {
		if (StringUtils.isBlank(sapoProductId)) {
			return false;
		}
		try {
			Long id = Long.parseLong(sapoProductId.trim());
			Long pushedAt = recentlyPushedToSapo.get(id);
			if (pushedAt == null) {
				return false;
			}
			if (System.currentTimeMillis() - pushedAt > SYNC_ECHO_WINDOW_MS) {
				// Da qua khoang thoi gian echo => webhook nay la thay doi that tu Sapo
				recentlyPushedToSapo.remove(id);
				return false;
			}
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

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
		List<SapoProductDto> result = new ArrayList<>();
		int page = 1;
		while (true) {
			String url = buildProductsUrl(store, SAPO_PRODUCTS_PATH) + "?limit=" + SAPO_PAGE_LIMIT + "&page=" + page;
			SapoProductResponse response = callSapo(store, url, HttpMethod.GET, null, SapoProductResponse.class);
			List<SapoProductDto> products = response == null ? null : response.getProducts();
			if (products == null || products.isEmpty()) {
				break;
			}
			result.addAll(products);
			if (products.size() < SAPO_PAGE_LIMIT) {
				break;
			}
			page++;
		}
		return result;
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
	 * Dong thoi dong bo danh muc va gan moi san pham vao dung danh muc
	 * giong nhu tren Sapo (thong qua collects.json).
	 *
	 * @return so san pham da dong bo
	 */
	public int syncAllProducts(MerchantStore store) throws Exception {
		// Buoc 1: dong bo danh muc truoc de co san cac Category local
		List<SapoCollectionDto> collections = null;
		try {
			collections = readCollections(store);
			for (SapoCollectionDto collection : collections) {
				try {
					saveOrUpdateLocalCategory(store, collection);
				} catch (Exception e) {
					LOGGER.error("Error syncing Sapo collection " + collection.getId(), e);
				}
			}
		} catch (Exception e) {
			LOGGER.error("Error reading Sapo collections", e);
		}

		// Buoc 2: upsert san pham (phan trang de lay TAT CA san pham,
		// khong chi 50-60 san pham cua trang dau tien)
		List<SapoProductDto> allProducts = readProducts(store);
		int count = 0;
		Map<Long, SapoProductDto> productsById = new java.util.HashMap<>();
		for (SapoProductDto sapoProduct : allProducts) {
			try {
				if (sapoProduct.getId() != null) {
					productsById.put(sapoProduct.getId(), sapoProduct);
				}
				saveOrUpdateLocalProduct(store, sapoProduct);
				count++;
			} catch (Exception e) {
				LOGGER.error("Error syncing Sapo product " + sapoProduct.getId(), e);
			}
		}

		// Buoc 3: gan san pham vao danh muc tuong ung giong tren Sapo
		try {
			Map<Long, Set<Long>> collectionByProduct = readProductCollections(store);
			assignProductsToCategories(store, collectionByProduct, collections, productsById);
		} catch (Exception e) {
			LOGGER.error("Error assigning Sapo products to categories", e);
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
		// Uu tien doi chieu bang sapo_product_id (on dinh, khong phu thuoc SKU)
		Product product = findLocalProductBySapoId(store, sapoProduct.getId());
		if (product == null) {
			product = findLocalProduct(store, sapoSku);
		}

		Long sapoProductId = sapoProduct.getId();
		if (product == null) {
			product = new Product();
			product.setMerchantStore(store);
			product.setAvailable(true);
			product.setDateAvailable(new Date());
			product.setRefSku(SAPO_REF_PREFIX + sapoSku);
		}
		product.setSku(sapoSku);
		// Luu id san pham Sapo lam khoa doi chieu on dinh cho chieu Shopizer -> Sapo
		if (sapoProductId != null) {
			product.setSapoProductId(sapoProductId);
		}

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
				// Gia so sanh (compare_at_price) cua Sapo, khi lon hon gia ban, la gia
				// goc/niem yet => luu vao gia dac biet cua Shopizer de hien thi gach ngang.
				if (variant.getCompareAtPrice() != null
						&& variant.getCompareAtPrice().compareTo(BigDecimal.ZERO) > 0
						&& (variant.getPrice() == null
								|| variant.getCompareAtPrice().compareTo(variant.getPrice()) > 0)) {
					price.setProductPriceSpecialAmount(variant.getCompareAtPrice());
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
	 * Gioi han ban ghi moi trang khi goi API Sapo (toi da Sapo cho phep: 250).
	 */
	private static final int SAPO_PAGE_LIMIT = 250;

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
	 * Tim san pham local theo id san pham Sapo (sapo_product_id).
	 * Day la khoa doi chieu on dinh, khong phu thuoc SKU cua Sapo.
	 */
	private Product findLocalProductBySapoId(MerchantStore store, Long sapoProductId) {
		if (sapoProductId == null) {
			return null;
		}
		try {
			List<Product> products = productService.listByStore(store);
			if (products != null) {
				for (Product candidate : products) {
					if (sapoProductId.equals(candidate.getSapoProductId())) {
						return candidate;
					}
				}
			}
		} catch (Exception e) {
			LOGGER.error("Error finding local product by Sapo id " + sapoProductId, e);
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

	/**
	 * Dong bo danh muc san pham tu Sapo (collections) vao he thong.
	 *
	 * Sapo tra ve danh muc qua:
	 * - GET /admin/custom_collections.json -> { "custom_collections": [...] }
	 * - GET /admin/smart_collections.json  -> { "smart_collections": [...] }
	 *
	 * Voi moi collection, cap nhat ten danh muc (title) va ma danh muc (handle)
	 * vao bang CATEGORY / CATEGORY_DESCRIPTION cua Shopizer.
	 *
	 * @return so danh muc da dong bo
	 */
	public int syncCategories(MerchantStore store) throws Exception {
		if (store == null) {
			return 0;
		}

		List<SapoCollectionDto> collections = readCollections(store);
		LOGGER.info("Sapo returned {} collections for store {}", collections.size(), store.getCode());
		int count = 0;
		for (SapoCollectionDto collection : collections) {
			try {
				if (saveOrUpdateLocalCategory(store, collection)) {
					count++;
				}
			} catch (Exception e) {
				LOGGER.error("Error syncing Sapo collection " + collection.getId(), e);
			}
		}
		LOGGER.info("Synced {} of {} Sapo collections into local categories", count, collections.size());
		return count;
	}

	/**
	 * Dong bo danh muc va TRA VE CHI TIET tung danh muc (dung cho chan doan).
	 * Khac voi syncCategories, ham nay khong nuot loi ma ghi ro loi tung item.
	 */
	public String syncCategoriesVerbose(MerchantStore store) {
		StringBuilder sb = new StringBuilder();
		if (store == null) {
			return "store is null";
		}
		try {
			List<SapoCollectionDto> collections = readCollections(store);
			sb.append("read " + collections.size() + " collections\n");
			int count = 0;
			for (SapoCollectionDto collection : collections) {
				try {
					boolean ok = saveOrUpdateLocalCategory(store, collection);
					if (ok) {
						count++;
					}
					sb.append("id=" + collection.getId() + " alias=" + collection.getHandle() + " -> "
							+ (ok ? "OK" : "SKIPPED (code null)") + "\n");
				} catch (Exception e) {
					sb.append("id=" + collection.getId() + " -> EXCEPTION " + e.getClass().getName() + ": "
							+ e.getMessage() + "\n");
					LOGGER.error("Error syncing Sapo collection " + collection.getId(), e);
				}
			}
			sb.append("TOTAL synced=" + count);
		} catch (Exception e) {
			sb.append("FATAL " + e.getClass().getName() + ": " + e.getMessage());
		}
		return sb.toString();
	}

	/**
	 * CHAN DOAN: tra ve tinh trang cau hinh + ket qua goi API Sapo.
	 * Dung de tim nguyen nhan khi dong bo tra ve 0.
	 */
	public String diagnose(MerchantStore store) {
		StringBuilder sb = new StringBuilder();
		try {
			sb.append("SAPO_STORE_DOMAIN=" + readConfig("SAPO_STORE_DOMAIN", store) + "\n");
		} catch (Exception e) {
			sb.append("SAPO_STORE_DOMAIN=<error: " + e.getMessage() + ">\n");
		}
		try {
			sb.append("SAPO_API_KEY=" + (StringUtils.isBlank(readConfig(Constants.KEY_SAPO_API_KEY, store))
					? "<empty>" : "<set>") + "\n");
			sb.append("SAPO_API_SECRET=" + (StringUtils.isBlank(readConfig(Constants.KEY_SAPO_API_SECRET, store))
					? "<empty>" : "<set>") + "\n");
		} catch (Exception e) {
			sb.append("credentials=<error: " + e.getMessage() + ">\n");
		}

		// Thu goi rieng tung endpoint de biet endpoint nao loi
		for (String path : new String[] { SAPO_CUSTOM_COLLECTIONS_PATH, SAPO_SMART_COLLECTIONS_PATH }) {
			try {
				String url = buildProductsUrl(store, path) + "?limit=" + SAPO_PAGE_LIMIT + "&page=1";
				sb.append(path + " URL=" + url + "\n");
				SapoCollectionResponse response = callSapo(store, url, HttpMethod.GET, null,
						SapoCollectionResponse.class);
				if (response == null) {
					sb.append("  -> response=null\n");
				} else {
					List<SapoCollectionDto> list = path.equals(SAPO_CUSTOM_COLLECTIONS_PATH)
							? response.getCustomCollections()
							: response.getSmartCollections();
					sb.append("  -> " + (list == null ? "null" : String.valueOf(list.size())) + " collections\n");
					if (list != null) {
						for (SapoCollectionDto c : list) {
							sb.append("     id=" + c.getId() + " name=" + c.getTitle() + " alias=" + c.getHandle()
									+ " code=" + buildCategoryCode(c) + "\n");
						}
					}
				}
			} catch (Exception e) {
				sb.append("  -> EXCEPTION " + e.getClass().getSimpleName() + ": " + e.getMessage() + "\n");
			}
		}
		return sb.toString();
	}

	/**
	 * Doc danh muc tu ca custom_collections va smart_collections cua Sapo.
	 */
	public List<SapoCollectionDto> readCollections(MerchantStore store) throws Exception {
		List<SapoCollectionDto> result = new ArrayList<>();
		Set<Long> seenIds = new HashSet<>();

		for (String path : new String[] { SAPO_CUSTOM_COLLECTIONS_PATH, SAPO_SMART_COLLECTIONS_PATH }) {
			int page = 1;
			while (true) {
				String url = buildProductsUrl(store, path) + "?limit=" + SAPO_PAGE_LIMIT + "&page=" + page;
				SapoCollectionResponse response = callSapo(store, url, HttpMethod.GET, null,
						SapoCollectionResponse.class);
				List<SapoCollectionDto> pageCollections = response == null ? null
						: (path.equals(SAPO_CUSTOM_COLLECTIONS_PATH) ? response.getCustomCollections()
								: response.getSmartCollections());
				if (pageCollections == null || pageCollections.isEmpty()) {
					break;
				}
				for (SapoCollectionDto collection : pageCollections) {
					// Tranh trung lap neu cung id xuat hien o ca hai endpoint
					if (collection.getId() != null && seenIds.add(collection.getId())) {
						result.add(collection);
					}
				}
				if (pageCollections.size() < SAPO_PAGE_LIMIT) {
					break;
				}
				page++;
			}
		}

		return result;
	}

	/**
	 * Upsert mot collection Sapo thanh Category trong Shopizer.
	 * Cap nhat ten (title) va ma (handle) danh muc theo du lieu Sapo.
	 *
	 * @return true neu da xu ly (tao moi hoac cap nhat)
	 */
	private boolean saveOrUpdateLocalCategory(MerchantStore store, SapoCollectionDto collection)
			throws ServiceException {
		if (collection == null || store == null) {
			return false;
		}

		String title = StringUtils.trimToNull(collection.getTitle());
		Long sapoCategoryId = collection.getId();

		// Doi chieu danh muc local bang sapo_category_id truoc (khong phu thuoc
		// ten/alias cua Sapo, vi alias co the doi ma code Shopizer giu nguyen).
		Category category = findCategoryBySapoId(store, sapoCategoryId);

		// Ma danh muc local: chi dung khi tao moi. Neu da co danh muc (tim theo
		// sapo_category_id) thi GIU NGUYEN code cua Shopizer.
		String categoryCode = category != null ? category.getCode() : buildCategoryCode(collection);
		if (categoryCode == null) {
			// Khong xac dinh duoc ma danh muc => bo qua
			return false;
		}

		if (category == null) {
			category = categoryService.getByCode(store, categoryCode);
		}
		if (category == null) {
			category = new Category(store);
			// QUAN TRONG: constructor Category(store) dat id = 0L (khong phai null).
			// Spring Data JPA coi id != null la entity DA TON TAI nen dung merge()
			// thay vi persist(). Hau qua: CategoryServiceImpl.create() goi save()
			// (merge) roi update() (merge lan 2) -> INSERT 2 lan cung mot CODE ->
			// vi pham unique constraint CATEGORY(MERCHANT_ID, CODE).
			// Dat id = null de Hibernate dung persist() nhu mot entity moi that su.
			category.setId(null);
			category.setMerchantStore(store);
			category.setCode(categoryCode);
			category.setVisible(true);
			category.setCategoryStatus(true);
			category.setDepth(0);
			category.setSortOrder(0);
		}

		// Luu id danh muc Sapo lam khoa doi chieu cho cac lan dong bo sau
		category.setSapoCategoryId(sapoCategoryId);

		// Ten danh muc cho tat ca ngon ngu cua cua hang
		String name = StringUtils.defaultIfBlank(title, categoryCode);
		Set<Language> languages = resolveStoreLanguages(store);
		for (Language language : languages) {
			CategoryDescription description = null;
			for (CategoryDescription existing : category.getDescriptions()) {
				if (existing.getLanguage() != null && language != null
						&& existing.getLanguage().getId() != null
						&& existing.getLanguage().getId().equals(language.getId())) {
					description = existing;
					break;
				}
			}
			if (description == null) {
				description = new CategoryDescription();
				description.setCategory(category);
				description.setLanguage(language);
				category.getDescriptions().add(description);
			}
			description.setName(name);
			if (StringUtils.isBlank(description.getSeUrl())) {
				description.setSeUrl(StringUtils.defaultIfBlank(collection.getHandle(), categoryCode));
			}
		}

		categoryService.saveOrUpdate(category);
		LOGGER.info("Synced Sapo collection {} as local category {} ({})", collection.getId(),
				category.getId(), categoryCode);
		return true;
	}

	/**
	 * Tim Category local theo id danh muc Sapo (sapo_category_id).
	 * Day la khoa doi chieu on dinh, khong phu thuoc ten hay alias cua Sapo.
	 */
	private Category findCategoryBySapoId(MerchantStore store, Long sapoCategoryId) {
		if (sapoCategoryId == null) {
			return null;
		}
		try {
			List<Category> categories = categoryService.listByStore(store);
			if (categories != null) {
				for (Category candidate : categories) {
					if (sapoCategoryId.equals(candidate.getSapoCategoryId())) {
						return candidate;
					}
				}
			}
		} catch (Exception e) {
			LOGGER.error("Error finding local category by Sapo id " + sapoCategoryId, e);
		}
		return null;
	}

	/**
	 * Lay danh sach ngon ngu cua cua hang, fallback ve ngon ngu mac dinh.
	 */
	private Set<Language> resolveStoreLanguages(MerchantStore store) {
		Set<Language> storeLanguages = null;
		if (store != null && store.getLanguages() != null) {
			storeLanguages = new HashSet<>(store.getLanguages());
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
		return storeLanguages;
	}

	/**
	 * Chuan hoa ma danh muc: Shopizer chi cho phep chu, so, gach ngang va gach duoi.
	 */
	private String sanitizeCode(String code) {
		if (StringUtils.isBlank(code)) {
			return "";
		}
		return code.trim().replaceAll("[^a-zA-Z0-9_-]", "-");
	}

	/**
	 * Tao ma danh muc local cho mot collection Sapo: SAPO-CAT-{alias}.
	 *
	 * Sapo tra ve ma danh muc o truong "alias" (khong phai "handle").
	 * Neu alias rong thi fallback ve id cua collection.
	 *
	 * @return ma danh muc, hoac null neu khong xac dinh duoc
	 */
	private String buildCategoryCode(SapoCollectionDto collection) {
		if (collection == null) {
			return null;
		}
		String handle = StringUtils.trimToNull(collection.getHandle());
		if (handle == null && collection.getId() == null) {
			return null;
		}
		String code = SAPO_CATEGORY_PREFIX
				+ sanitizeCode(handle != null ? handle : String.valueOf(collection.getId()));
		return code.equals(SAPO_CATEGORY_PREFIX) ? null : code;
	}

	/**
	 * Doc toan bo lien ket san pham - danh muc (collects) tu Sapo.
	 *
	 * Khong truyen product_id de lay het trong mot lan goi, sau do gom nhom
	 * theo product_id -> tap collection_id. Cach nay nhanh hon goi tung san pham.
	 *
	 * @return map: productId (Sapo) -> tap collectionId (Sapo)
	 */
	public Map<Long, Set<Long>> readProductCollections(MerchantStore store) throws Exception {
		Map<Long, Set<Long>> result = new java.util.HashMap<>();

		int page = 1;
		while (true) {
			String url = buildProductsUrl(store, SAPO_COLLECTS_PATH) + "?limit=" + SAPO_PAGE_LIMIT + "&page=" + page;
			SapoCollectResponse response = callSapo(store, url, HttpMethod.GET, null, SapoCollectResponse.class);
			List<SapoCollectDto> collects = response == null ? null : response.getCollects();
			if (collects == null || collects.isEmpty()) {
				break;
			}
			for (SapoCollectDto collect : collects) {
				if (collect.getProductId() == null || collect.getCollectionId() == null) {
					continue;
				}
				result.computeIfAbsent(collect.getProductId(), k -> new HashSet<>())
						.add(collect.getCollectionId());
			}
			if (collects.size() < SAPO_PAGE_LIMIT) {
				break;
			}
			page++;
		}
		return result;
	}

	/**
	 * Gan san pham vao dung danh muc giong tren Sapo.
	 *
	 * Voi moi san pham Sapo, tim cac collection ma no thuoc ve (qua collects.json),
	 * sau do doi chieu collection_id sang Category local (code SAPO-CAT-{alias})
	 * va cap nhat danh sach categories cua san pham.
	 *
	 * @param store               cua hang dang dong bo
	 * @param collectionByProduct map productId -> tap collectionId (co the null, khi do se doc tu Sapo)
	 * @param collections         danh sach collection cua Sapo (de doi collectionId -> alias)
	 * @param productsById        map Sapo productId -> SapoProductDto (co the null, khi do se doc tu Sapo)
	 * @return so san pham da duoc gan danh muc
	 */
	public int assignProductsToCategories(MerchantStore store, Map<Long, Set<Long>> collectionByProduct,
			List<SapoCollectionDto> collections, Map<Long, SapoProductDto> productsById) throws Exception {
		if (store == null) {
			return 0;
		}

		if (collections == null) {
			collections = readCollections(store);
		}
		// Doi chieu collectionId -> Category local bang sapo_category_id
		// (fallback ve theo code SAPO-CAT-{alias} cho danh muc dong bo truoc khi co cot moi)
		Map<Long, Category> categoryByCollectionId = new java.util.HashMap<>();
		Map<Long, String> categoryCodeByCollectionId = new java.util.HashMap<>();
		List<Category> storeCategories = categoryService.listByStore(store);
		if (storeCategories != null) {
			for (Category candidate : storeCategories) {
				if (candidate.getSapoCategoryId() != null) {
					categoryByCollectionId.put(candidate.getSapoCategoryId(), candidate);
				}
			}
		}
		for (SapoCollectionDto collection : collections) {
			if (collection.getId() == null) {
				continue;
			}
			Category bySapoId = categoryByCollectionId.get(collection.getId());
			if (bySapoId == null) {
				// Fallback: danh muc da dong bo lan truoc nhua chua co sapo_category_id
				String code = buildCategoryCode(collection);
				if (StringUtils.isNotBlank(code)) {
					categoryCodeByCollectionId.put(collection.getId(), code);
				}
			}
		}

		if (collectionByProduct == null) {
			collectionByProduct = readProductCollections(store);
		}

		int count = 0;
		for (Map.Entry<Long, Set<Long>> entry : collectionByProduct.entrySet()) {
			Long sapoProductId = entry.getKey();
			Set<Long> collectionIds = entry.getValue();
			if (sapoProductId == null || collectionIds == null || collectionIds.isEmpty()) {
				continue;
			}
			try {
				String sapoSku = resolveSapoProductSku(store, sapoProductId, productsById);
				if (StringUtils.isBlank(sapoSku)) {
					continue;
				}
				if (assignProductToCategories(store, sapoProductId, sapoSku, collectionIds,
						categoryByCollectionId, categoryCodeByCollectionId)) {
					count++;
				}
			} catch (Exception e) {
				LOGGER.error("Error assigning Sapo product " + sapoProductId + " to categories", e);
			}
		}
		return count;
	}

	/**
	 * Xac dinh SKU local cua mot san pham Sapo: uu tien lay tu danh sach san pham
	 * da tai san (productsById) de khong goi API cho tung san pham.
	 */
	private String resolveSapoProductSku(MerchantStore store, Long sapoProductId,
			Map<Long, SapoProductDto> productsById) {
		if (productsById != null) {
			SapoProductDto cached = productsById.get(sapoProductId);
			if (cached != null) {
				return resolveSku(cached);
			}
		}
		// Khong co trong danh sach da tai (vi du webhook) => goi API mot lan
		try {
			SapoProductDto sapoProduct = readProduct(store, String.valueOf(sapoProductId));
			return sapoProduct == null ? null : resolveSku(sapoProduct);
		} catch (Exception e) {
			LOGGER.error("Error reading Sapo product " + sapoProductId, e);
			return null;
		}
	}

	/**
	 * Gan mot san pham (theo SKU local) vao cac danh muc local tuong ung.
	 *
	 * @return true neu tim thay san pham local va cap nhat
	 */
	private boolean assignProductToCategories(MerchantStore store, Long sapoProductId, String sapoSku,
			Set<Long> collectionIds, Map<Long, Category> categoryByCollectionId,
			Map<Long, String> categoryCodeByCollectionId) throws ServiceException {

		Product product = findLocalProduct(store, sapoSku);
		if (product == null) {
			return false;
		}

		Set<Category> categories = new HashSet<>();
		for (Long collectionId : collectionIds) {
			// Uu tien doi chieu bang sapo_category_id, fallback ve theo code
			Category category = categoryByCollectionId.get(collectionId);
			if (category == null) {
				String code = categoryCodeByCollectionId.get(collectionId);
				if (StringUtils.isNotBlank(code)) {
					try {
						category = categoryService.getByCode(store, code);
					} catch (Exception e) {
						LOGGER.error("Error finding local category by code " + code, e);
					}
				}
			}
			if (category != null) {
				categories.add(category);
			}
		}

		if (categories.isEmpty()) {
			return false;
		}

		if (product.getCategories() == null) {
			product.setCategories(new HashSet<Category>());
		}
		product.getCategories().clear();
		product.getCategories().addAll(categories);
		// Dung update() (khong phai save()) de Hibernate merge quan he
		// ManyToMany PRODUCT_CATEGORY cua product da co id.
		productService.update(product);
		LOGGER.info("Assigned Sapo product {} ({}) to {} local categories", sapoProductId, sapoSku,
				categories.size());
		return true;
	}

	/**
	 * Lay bien the (variant) dau tien cua san pham Sapo.
	 */
	private SapoProductDto.SapoVariantDto firstVariant(SapoProductDto sapoProduct) {
		if (sapoProduct.getVariants() != null && !sapoProduct.getVariants().isEmpty()) {
			return sapoProduct.getVariants().get(0);
		}
		return null;
	}

	// =====================================================================
	// CHIEU NGUOC: SHOPIZER -> SAPO
	//
	// Chi nhung san pham/danh muc da duoc dong bo tu Sapo (co sapo_product_id /
	// sapo_category_id) moi duoc day nguoc de tranh tao ban ghi rac tren Sapo.
	// Moi ham deu boc try/catch: loi Sapo KHONG duoc phep lam hong thao tac luu
	// cua Admin trong Shopizer.
	// =====================================================================

	/**
	 * Day san pham Shopizer len Sapo: cap nhat thong tin co ban (ten, SKU, gia,
	 * ton kho, trang thai) cua san pham Sapo tuong ung qua
	 * PUT /admin/products/{sapoProductId}.json
	 *
	 * @return true neu da day thanh cong, false neu bo qua hoac loi
	 */
	public boolean pushProductToSapo(MerchantStore store, Product product) {
		Long sapoProductId = product == null ? null : product.getSapoProductId();
		if (store == null || product == null || sapoProductId == null) {
			// San pham khong den tu Sapo => khong tao moi tu dong
			return false;
		}
		try {
			SapoProductPushRequest request = new SapoProductPushRequest();
			String name = resolveProductName(product);
			if (StringUtils.isNotBlank(name)) {
				request.setName(name);
			}
			request.setPublished(product.isAvailable());

			SapoProductPushRequest.SapoVariantPushRequest variant = new SapoProductPushRequest.SapoVariantPushRequest();
			boolean hasVariant = false;
			if (StringUtils.isNotBlank(product.getSku())) {
				variant.setSku(product.getSku());
				hasVariant = true;
			}
			ProductAvailability availability = firstAvailability(product);
			if (availability != null) {
				if (availability.getProductQuantity() != null) {
					variant.setInventoryQuantity(availability.getProductQuantity());
					hasVariant = true;
				}
				ProductPrice price = availability.defaultPrice();
				if (price != null && price.getProductPriceAmount() != null) {
					variant.setPrice(price.getProductPriceAmount());
					hasVariant = true;
				}
			}
			if (hasVariant) {
				request.setVariants(java.util.Collections.singletonList(variant));
			}

			SapoProductDto result = updateProductOnSapo(store, String.valueOf(sapoProductId), request);
			// Danh dau de webhook product/update tu Sapo khong ghi de nguoc lai
			markPushedToSapo(sapoProductId);
			LOGGER.info("Pushed Shopizer product {} to Sapo product {}", product.getId(), sapoProductId);
			return result != null;
		} catch (Exception e) {
			LOGGER.error("Error pushing Shopizer product " + product.getId() + " to Sapo " + sapoProductId, e);
			return false;
		}
	}

	/**
	 * Cap nhat san pham Sapo tu request day nguoc cua Shopizer.
	 */
	public SapoProductDto updateProductOnSapo(MerchantStore store, String sapoProductId,
			SapoProductPushRequest changes) throws Exception {
		String url = buildProductsUrl(store, String.format(SAPO_PRODUCT_PATH, sapoProductId));
		String body = objectMapper.writeValueAsString(
				java.util.Collections.singletonMap("product", changes));
		SapoProductResponse response = callSapo(store, url, HttpMethod.PUT, body, SapoProductResponse.class);
		return response == null ? null : response.getProduct();
	}

	/**
	 * Dong bo lien ket danh muc cua mot san pham len Sapo.
	 *
	 * So sanh danh muc hien co tren Shopizer voi cac collect hien co tren Sapo
	 * (theo sapo_category_id) va:
	 * - them collect cho danh muc moi duoc gan
	 * - xoa collect cua danh muc da bi bo
	 *
	 * Sapo tao collect bang POST /admin/collects.json voi body
	 * {"collect": {"product_id":..,"collection_id":..}}; xoa bang
	 * DELETE /admin/collects/{id}.json
	 */
	public void pushProductCategoriesToSapo(MerchantStore store, Product product) {
		Long sapoProductId = product == null ? null : product.getSapoProductId();
		if (store == null || product == null || sapoProductId == null) {
			return;
		}
		try {
			// Tap collection Sapo mong muon, lay tu danh muc Shopizer cua san pham
			Set<Long> desiredCollectionIds = new HashSet<>();
			if (product.getCategories() != null) {
				for (Category category : product.getCategories()) {
					if (category != null && category.getSapoCategoryId() != null) {
						desiredCollectionIds.add(category.getSapoCategoryId());
					}
				}
			}

			// Tap collection Sapo hien co cua san pham (kem id collect de xoa)
			Map<Long, Long> existingCollectIdByCollection = readCollectIdsOfProduct(store, sapoProductId);

			// Xoa cac collect khong con trong Shopizer
			for (Map.Entry<Long, Long> entry : existingCollectIdByCollection.entrySet()) {
				if (!desiredCollectionIds.contains(entry.getKey())) {
					deleteCollectOnSapo(store, entry.getValue());
					LOGGER.info("Removed Sapo collect {} (collection {}) from product {}", entry.getValue(),
							entry.getKey(), sapoProductId);
				}
			}

			// Them cac collect con thieu
			for (Long collectionId : desiredCollectionIds) {
				if (!existingCollectIdByCollection.containsKey(collectionId)) {
					createCollectOnSapo(store, sapoProductId, collectionId);
					LOGGER.info("Added Sapo collect product {} -> collection {}", sapoProductId, collectionId);
				}
			}
		} catch (Exception e) {
			LOGGER.error("Error syncing categories of product " + product.getId() + " to Sapo", e);
		}
	}

	/**
	 * Day ten/danh muc Shopizer cua mot Category len collection Sapo tuong ung
	 * qua PUT /admin/custom_collections/{id}.json
	 *
	 * @return true neu da day thanh cong hoac bo qua (khong den tu Sapo)
	 */
	public boolean pushCategoryToSapo(MerchantStore store, Category category) {
		if (store == null || category == null || category.getSapoCategoryId() == null) {
			// Danh muc khong den tu Sapo => khong tao moi tu dong
			return false;
		}
		try {
			String name = null;
			if (category.getDescriptions() != null) {
				for (CategoryDescription description : category.getDescriptions()) {
					if (StringUtils.isNotBlank(description.getName())) {
						name = description.getName();
						break;
					}
				}
			}
			if (StringUtils.isBlank(name)) {
				name = category.getCode();
			}
			java.util.Map<String, Object> collection = new java.util.HashMap<>();
			collection.put("name", name);
			java.util.Map<String, Object> body = java.util.Collections.singletonMap("custom_collection", collection);
			updateCustomCollectionOnSapo(store, category.getSapoCategoryId(),
					objectMapper.writeValueAsString(body));
			LOGGER.info("Pushed Shopizer category {} to Sapo collection {}", category.getId(),
					category.getSapoCategoryId());
			return true;
		} catch (Exception e) {
			LOGGER.error("Error pushing Shopizer category " + category.getId() + " to Sapo", e);
			return false;
		}
	}

	/**
	 * Day tat ca san pham local da den tu Sapo len Sapo (Shopizer -> Sapo).
	 * Chi xu ly san pham co sapo_product_id; bo qua san pham tao tay trong Shopizer
	 * de tranh tao ban ghi rac tren Sapo.
	 *
	 * @return so san pham da day thanh cong
	 */
	public int pushAllProductsToSapo(MerchantStore store) {
		if (store == null) {
			return 0;
		}
		int count = 0;
		try {
			List<Product> products = productService.listByStore(store);
			if (products == null) {
				return 0;
			}
			for (Product product : products) {
				if (product.getSapoProductId() == null) {
					// San pham khong den tu Sapo -> bo qua
					continue;
				}
				try {
					if (pushProductToSapo(store, product)) {
						pushProductCategoriesToSapo(store, product);
						count++;
					}
				} catch (Exception e) {
					LOGGER.error("Error pushing local product " + product.getId() + " to Sapo", e);
				}
			}
		} catch (Exception e) {
			LOGGER.error("Error listing products to push to Sapo", e);
		}
		return count;
	}

	/**
	 * Doc cac collect cua MOT san pham Sapo, tra ve map collectionId -> collectId
	 * de biet can xoa collect nao khi danh muc bi bo khoi san pham.
	 */
	private Map<Long, Long> readCollectIdsOfProduct(MerchantStore store, Long sapoProductId) throws Exception {
		Map<Long, Long> result = new java.util.HashMap<>();
		int page = 1;
		while (true) {
			String url = buildProductsUrl(store, SAPO_COLLECTS_PATH) + "?product_id=" + sapoProductId
					+ "&limit=" + SAPO_PAGE_LIMIT + "&page=" + page;
			SapoCollectResponse response = callSapo(store, url, HttpMethod.GET, null, SapoCollectResponse.class);
			List<SapoCollectDto> collects = response == null ? null : response.getCollects();
			if (collects == null || collects.isEmpty()) {
				break;
			}
			for (SapoCollectDto collect : collects) {
				if (collect.getCollectionId() != null && collect.getId() != null) {
					result.put(collect.getCollectionId(), collect.getId());
				}
			}
			if (collects.size() < SAPO_PAGE_LIMIT) {
				break;
			}
			page++;
		}
		return result;
	}

	/**
	 * Tao lien ket product <-> collection tren Sapo (POST /admin/collects.json).
	 */
	private void createCollectOnSapo(MerchantStore store, Long sapoProductId, Long sapoCollectionId) throws Exception {
		java.util.Map<String, Object> collect = new java.util.HashMap<>();
		collect.put("product_id", sapoProductId);
		collect.put("collection_id", sapoCollectionId);
		String body = objectMapper.writeValueAsString(java.util.Collections.singletonMap("collect", collect));
		String url = buildProductsUrl(store, SAPO_COLLECTS_PATH);
		callSapo(store, url, HttpMethod.POST, body, SapoCollectResponse.class);
	}

	/**
	 * Xoa lien ket product <-> collection tren Sapo (DELETE /admin/collects/{id}.json).
	 */
	private void deleteCollectOnSapo(MerchantStore store, Long sapoCollectId) throws Exception {
		String url = buildProductsUrl(store, "/admin/collects/" + sapoCollectId + ".json");
		callSapo(store, url, HttpMethod.DELETE, null, String.class);
	}

	/**
	 * Cap nhat collection Sapo (PUT /admin/custom_collections/{id}.json).
	 */
	private void updateCustomCollectionOnSapo(MerchantStore store, Long sapoCollectionId, String body)
			throws Exception {
		String url = buildProductsUrl(store, "/admin/custom_collections/" + sapoCollectionId + ".json");
		callSapo(store, url, HttpMethod.PUT, body, SapoCollectionResponse.class);
	}

	/**
	 * Lay ten hien thi cua san pham Shopizer theo ngon ngu mac dinh, fallback ve SKU.
	 */
	private String resolveProductName(Product product) {
		if (product.getDescriptions() != null) {
			for (ProductDescription description : product.getDescriptions()) {
				if (StringUtils.isNotBlank(description.getName())) {
					return description.getName();
				}
			}
		}
		return product.getSku();
	}

	/**
	 * Lay availability (kho) dau tien cua san pham Shopizer.
	 */
	private ProductAvailability firstAvailability(Product product) {
		if (product.getAvailabilities() != null && !product.getAvailabilities().isEmpty()) {
			return product.getAvailabilities().iterator().next();
		}
		return null;
	}
}
