package com.salesmanager.shop.store.controller.catalog.product;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.salesmanager.core.business.services.catalog.product.ProductService;
import com.salesmanager.core.business.services.catalog.product.PricingService;
import com.salesmanager.core.model.catalog.product.Product;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.reference.language.Language;
import com.salesmanager.shop.constants.Constants;
import com.salesmanager.shop.model.catalog.product.ReadableProduct;
import com.salesmanager.shop.populator.catalog.ReadableProductPopulator;
import com.salesmanager.shop.store.api.exception.ServiceRuntimeException;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatModel;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatModelFactory;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatRequest;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatResponse;
import com.salesmanager.shop.store.api.v1.product.ai.AiException;
import com.salesmanager.shop.utils.ImageFilePath;

/**
 * Tim san pham trong catalogue bang cach chup anh.
 *
 * Workflow (tat ca trong MOT request, khong luu anh len server):
 * 1. Trinh duyet chup anh (getUserMedia) -> gui len dang Base64.
 * 2. AI (Gemini / OpenAI - tuy cau hinh Admin) phan tich anh tra ve JSON gom
 *    ten san pham, tu khoa tim kiem, mau sac / chat lieu / loai.
 * 3. Backend chay cac tu khoa nay qua ProductService.listByStore de tim san
 *    pham khop trong catalogue cua cua hang.
 * 4. Chi tra ve cac san pham THAT SU co trong catalogue (de them vao gio duoc).
 *
 * Anh chi ton tai trong bo nho cua request, KHONG duoc ghi xuong dia.
 */
@Controller
@RequestMapping(Constants.SHOP_URI + "/product")
public class ProductImageSearchController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ProductImageSearchController.class);

	private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper()
			.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

	/** Gioi han so san pham tra ve cho trinh duyet. */
	private static final int MAX_RESULTS = 8;

	/** Gioi han so san pham quet tu catalogue de tranh qua tai. */
	private static final int CATALOGUE_SCAN_LIMIT = 500;

	@Inject
	private ProductService productService;

	@Inject
	private AiChatModelFactory aiChatModelFactory;

	/**
	 * Bat buoc phai co: ReadableProductPopulator.validate() nem loi neu pricingService null,
	 * khien moi ket qua tim duoc deu bi bo di.
	 */
	@Inject
	private PricingService pricingService;

	@Inject
	@org.springframework.beans.factory.annotation.Qualifier("img")
	private ImageFilePath imageUtils;

	/**
	 * POST /shop/product/imageSearch.html
	 * Body: { "imageBase64": "data:image/jpeg;base64,..." }
	 *
	 * Tra ve danh sach san pham khop trong catalogue:
	 * { "success": true, "detected": {...}, "products": [ {...} ] }
	 */
	@RequestMapping(value = "/imageSearch.html", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> imageSearch(@RequestBody Map<String, String> body,
			HttpServletRequest request, Locale locale, HttpServletResponse response) {

		MerchantStore store = (MerchantStore) request.getAttribute(Constants.MERCHANT_STORE);
		Language language = (Language) request.getAttribute(Constants.LANGUAGE);

		if (store == null) {
			return error(response, "MerchantStore not found");
		}
		if (language == null) {
			language = store.getDefaultLanguage();
		}

		String imageBase64 = body.get("imageBase64");
		if (StringUtils.isBlank(imageBase64)) {
			return error(response, "Thiếu ảnh. Vui lòng chụp lại.");
		}

		String mimeType = "image/jpeg";
		if (imageBase64.startsWith("data:")) {
			int commaIndex = imageBase64.indexOf(',');
			if (commaIndex < 0) {
				return error(response, "Định dạng ảnh không hợp lệ.");
			}
			String meta = imageBase64.substring(0, commaIndex);
			int semi = meta.indexOf(';');
			if (semi > 0) {
				mimeType = meta.substring(5, semi);
			}
			imageBase64 = imageBase64.substring(commaIndex + 1);
		}

		try {
			Base64.getDecoder().decode(imageBase64);
		} catch (IllegalArgumentException e) {
			return error(response, "Ảnh không hợp lệ.");
		}

		// 1. AI phan tich anh -> tu khoa tim kiem
		DetectedProduct detected;
		try {
			detected = detectFromImage(store, language, mimeType, imageBase64);
		} catch (ServiceRuntimeException e) {
			// Tra JSON loi de giao dien hien thi thong bao than thien thay vi trang 500
			LOGGER.warn("Product image search failed: {}", e.getMessage());
			String message = StringUtils.defaultIfBlank(e.getMessage(),
					"Không nhận diện được sản phẩm. Vui lòng thử lại.");
			return error(response, message);
		}

		// 2. Tim trong catalogue cua cua hang
		try {
			List<ReadableProduct> matches = findMatchingProducts(store, language, locale, detected);

			Map<String, Object> result = new java.util.LinkedHashMap<>();
			result.put("success", true);
			result.put("detected", detected);
			result.put("products", matches);
			return result;
		} catch (Exception e) {
			LOGGER.error("Cannot match products for image search", e);
			return error(response, "Lỗi khi tìm sản phẩm trong cửa hàng.");
		}
	}

	/** Tra ve JSON loi thong nhat de giao dien doc truong "message". */
	private Map<String, Object> error(HttpServletResponse response, String message) {
		response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		Map<String, Object> result = new java.util.LinkedHashMap<>();
		result.put("success", false);
		result.put("message", message);
		return result;
	}

	/** Thong tin AI nhan dien duoc tu anh. */
	public static class DetectedProduct {
		private String name;
		private String category;
		private List<String> keywords = new ArrayList<>();
		private String color;
		private String material;
		private String confidence;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}

		public List<String> getKeywords() {
			return keywords;
		}

		public void setKeywords(List<String> keywords) {
			this.keywords = keywords;
		}

		public String getColor() {
			return color;
		}

		public void setColor(String color) {
			this.color = color;
		}

		public String getMaterial() {
			return material;
		}

		public void setMaterial(String material) {
			this.material = material;
		}

		public String getConfidence() {
			return confidence;
		}

		public void setConfidence(String confidence) {
			this.confidence = confidence;
		}
	}

	/**
	 * Goi AI phan tich anh va tra ve thong tin san pham nhan dien duoc.
	 * Neu AI loi thi tra ve DetectedProduct rong de frontend bao nguoi dung.
	 */
	private DetectedProduct detectFromImage(MerchantStore store, Language language, String mimeType,
			String imageBase64) {

		try {
			AiChatModel chatModel = aiChatModelFactory.getChatModel(store);
			String prompt = buildDetectionPrompt(language);
			AiChatResponse response = chatModel.call(AiChatRequest.textAndImage(prompt, mimeType, imageBase64));

			if (response == null || StringUtils.isBlank(response.getText())) {
				throw new ServiceRuntimeException("AI không nhận diện được ảnh. Vui lòng thử lại.");
			}

			return OBJECT_MAPPER.readValue(response.getText(), DetectedProduct.class);

		} catch (AiException e) {
			LOGGER.warn("AI provider not configured for image search: {}", e.getMessage());
			throw new ServiceRuntimeException(
					"Chưa cấu hình AI. Vào Admin > Configuration > AI Configuration để bật tính năng chụp ảnh.");
		} catch (ServiceRuntimeException e) {
			// Da la thong bao than thien (vi du AI khong tra ve du lieu) -> giu nguyen
			throw e;
		} catch (Exception e) {
			LOGGER.error("Cannot analyse product image", e);
			// Ghi lai nguyen nhan that trong log, con nguoi dung thay thong bao de hieu
			throw new ServiceRuntimeException(
					"Không phân tích được ảnh bằng AI. Vui lòng kiểm tra lại API key trong Admin > Configuration > AI Configuration.");
		}
	}

	/** Prompt yeu cau AI tra ve JSON thuan de tim kiem trong catalogue. */
	private String buildDetectionPrompt(Language language) {
		String langCode = (language != null && StringUtils.isNotBlank(language.getCode()))
				? language.getCode()
				: "vi";

		StringBuilder sb = new StringBuilder();
		sb.append("Bạn là hệ thống nhận diện sản phẩm cho một cửa hàng trực tuyến.\n");
		sb.append("Hãy quan sát kỹ HÌNH ẢNH và cho biết đây là sản phẩm gì.\n\n");
		sb.append("Trả về DUY NHẤT một JSON theo cấu trúc sau, không thêm chữ nào khác:\n");
		sb.append("{\n");
		sb.append("  \"name\": \"Tên sản phẩm bằng ngôn ngữ '").append(langCode).append("'\",\n");
		sb.append("  \"category\": \"Nhóm sản phẩm, ví dụ: túi xách, giày, áo, đồng hồ\",\n");
		sb.append("  \"color\": \"Màu sắc chính của sản phẩm\",\n");
		sb.append("  \"material\": \"Chất liệu nếu nhìn thấy được (da, vải, gỗ, kim loại...)\",\n");
		sb.append("  \"confidence\": \"high | medium | low\",\n");
		sb.append("  \"keywords\": [\"6-10 từ khoá ngắn bằng ngôn ngữ '").append(langCode)
				.append("' để tìm sản phẩm này trong catalogue\"]\n");
		sb.append("}\n\n");
		sb.append("Lưu ý:\n");
		sb.append("- keywords phải là các từ đơn giản, phổ biến, dùng để so khớp tên sản phẩm trong catalogue.\n");
		sb.append("- Đưa cả từ khoá chung (ví dụ: \"túi xách\") và từ khoá cụ thể (ví dụ: \"túi da màu nâu\").\n");
		sb.append("- Nếu ảnh không phải sản phẩm, đặt confidence = \"low\" và keywords rỗng.\n");
		sb.append("- Chỉ trả về JSON thuần.");
		return sb.toString();
	}

	/**
	 * Tim san pham trong catalogue khop voi tu khoa AI tra ve.
	 *
	 * Cach lam: quet san pham cua cua hang mot lan, cham diem theo so tu khoa
	 * xuat hien trong ten/mo ta san pham, roi lay cac san pham diem cao nhat.
	 * Cach nay khong phu thuoc vao Elasticsearch nen hoat dong ca khi cua hang
	 * chua bat search service.
	 */
	private List<ReadableProduct> findMatchingProducts(MerchantStore store, Language language, Locale locale,
			DetectedProduct detected) {

		List<ReadableProduct> results = new ArrayList<>();
		if (detected == null || detected.getKeywords() == null || detected.getKeywords().isEmpty()) {
			return results;
		}

		try {
			// Tap tu khoa da chuan hoa (chu thuong, bo dau)
			List<String> keywords = new ArrayList<>();
			for (String keyword : detected.getKeywords()) {
				String normalized = normalize(keyword);
				if (normalized.length() >= 2 && !keywords.contains(normalized)) {
					keywords.add(normalized);
				}
			}
			String category = normalize(detected.getCategory());
			String color = normalize(detected.getColor());

			if (keywords.isEmpty() && category.isEmpty() && color.isEmpty()) {
				return results;
			}

			List<Product> products = productService.listByStore(store);
			if (products == null || products.isEmpty()) {
				return results;
			}

			ReadableProductPopulator populator = new ReadableProductPopulator();
			populator.setPricingService(pricingService);
			populator.setimageUtils(imageUtils);

			// Cham diem tung san pham
			List<ScoredProduct> scored = new ArrayList<>();
			int scanned = 0;
			for (Product product : products) {
				if (scanned++ >= CATALOGUE_SCAN_LIMIT) {
					break;
				}
				if (product == null || !product.isAvailable()) {
					continue;
				}

				String haystack = buildSearchText(product);
				if (StringUtils.isBlank(haystack)) {
					continue;
				}

				int score = 0;
				for (String keyword : keywords) {
					if (haystack.contains(keyword)) {
						// tu khoa cang dai thi cang dang tin
						score += Math.min(keyword.length(), 10);
					}
				}
				if (!category.isEmpty() && haystack.contains(category)) {
					score += 5;
				}
				if (!color.isEmpty() && haystack.contains(color)) {
					score += 3;
				}

				if (score > 0) {
					scored.add(new ScoredProduct(product, score));
				}
			}

			// Diem cao truoc, gioi han so luong tra ve
			scored.sort((a, b) -> Integer.compare(b.score, a.score));

			for (ScoredProduct entry : scored) {
				if (results.size() >= MAX_RESULTS) {
					break;
				}
				try {
					ReadableProduct readable = populator.populate(entry.product, new ReadableProduct(), store,
							language);
					results.add(readable);
				} catch (Exception e) {
					LOGGER.warn("Cannot populate product {} for image search", entry.product.getId(), e);
				}
			}

		} catch (Exception e) {
			LOGGER.error("Error while matching products for image search", e);
			throw new ServiceRuntimeException("Lỗi khi tìm sản phẩm trong cửa hàng.");
		}

		return results;
	}

	private static class ScoredProduct {
		private final Product product;
		private final int score;

		ScoredProduct(Product product, int score) {
			this.product = product;
			this.score = score;
		}
	}

	/** Gop ten + mo ta + thuong hieu cua san pham thanh mot chuoi de tim kiem. */
	private String buildSearchText(Product product) {
		StringBuilder sb = new StringBuilder();
		try {
			if (product.getDescriptions() != null) {
				product.getDescriptions().forEach(description -> {
					if (description == null) {
						return;
					}
					String name = description.getName();
					if (StringUtils.isNotBlank(name)) {
						sb.append(name).append(' ');
					}
					String metaTitle = description.getMetatagTitle();
					if (StringUtils.isNotBlank(metaTitle)) {
						sb.append(metaTitle).append(' ');
					}
					String desc = description.getDescription();
					if (StringUtils.isNotBlank(desc)) {
						sb.append(stripHtml(desc)).append(' ');
					}
					String highlight = description.getProductHighlight();
					if (StringUtils.isNotBlank(highlight)) {
						sb.append(stripHtml(highlight)).append(' ');
					}
				});
			}
			if (product.getManufacturer() != null && product.getManufacturer().getDescriptions() != null) {
				product.getManufacturer().getDescriptions().forEach(md -> {
					if (md != null && StringUtils.isNotBlank(md.getName())) {
						sb.append(md.getName()).append(' ');
					}
				});
			}
			// SKU / ma san pham cung co the la tu khoa nguoi dung tim
			if (StringUtils.isNotBlank(product.getSku())) {
				sb.append(product.getSku()).append(' ');
			}
		} catch (Exception e) {
			LOGGER.debug("Cannot build search text for product {}", product.getId(), e);
		}
		return normalize(sb.toString());
	}

	/** Bo the HTML khoi mo ta san pham truoc khi tim kiem. */
	private String stripHtml(String html) {
		return html == null ? "" : html.replaceAll("<[^>]*>", " ");
	}

	/**
	 * Chuan hoa chuoi de so khop: chu thuong, bo dau tieng Viet.
	 * Nho vay "Túi Xách" va "tui xach" duoc coi la giong nhau.
	 */
	private String normalize(String value) {
		if (StringUtils.isBlank(value)) {
			return "";
		}
		String lower = value.toLowerCase(Locale.ROOT).trim();
		// Bo dau tieng Viet (NFC -> NFD roi xoa cac dau thanh)
		String decomposed = java.text.Normalizer.normalize(lower, java.text.Normalizer.Form.NFD);
		String noAccent = decomposed.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
		// 'đ' khong nam trong khoi dau thanh nen phai xu ly rieng
		noAccent = noAccent.replace('đ', 'd');
		// Bo ky tu khong phai chu/số, gop khoang trang
		return noAccent.replaceAll("[^a-z0-9\\s]", " ").replaceAll("\\s+", " ").trim();
	}
}