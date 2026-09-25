package com.salesmanager.shop.store.api.v1.product;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.slugify.Slugify;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.shop.store.api.exception.RestApiException;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatModel;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatModelFactory;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatRequest;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatResponse;
import com.salesmanager.shop.store.api.v1.product.ai.AiException;
import com.salesmanager.shop.store.controller.store.facade.StoreFacade;

/**
 * REST API tao dong bo san pham bang AI.
 *
 * Workflow:
 * 1. Admin chup/tai anh san pham.
 * 2. Backend dong goi anh (Base64) + danh sach ngon ngu he thong he tro
 *    (vi, en, fr, zh) trong prompt JSON Schema -> goi mo hinh AI.
 * 3. Parse JSON tra ve (ObjectMapper) -> ProductAiDTO -> Frontend tu dong
 *    populate vao tung o input/CKEditor theo tung ngon ngu.
 *
 * Nha cung cap AI (Gemini / OpenAI) va API key duoc quyet dinh boi
 * {@link AiChatModelFactory} dua tren cau hinh trong Admin, nen controller
 * nay khong phu thuoc vao mot nha cung cap cu the.
 */
@RestController
@RequestMapping("/admin/product/gemini")
public class GoogleAiController {

	private static final Logger LOGGER = LoggerFactory.getLogger(GoogleAiController.class);

	/**
	 * Danh sach ngon ngu ma cua hang dang ho tro, doc dong tu
	 * MerchantStore.getLanguages() - lay tu cau hinh that su thay vi thiet lap cung.
	 * Khong con dung danh sach ngon ngu hardcode.
	 */
	private List<String> storeLanguages(MerchantStore store) {
		List<String> codes = new ArrayList<>();
		try {
			if (store != null && store.getLanguages() != null) {
				for (com.salesmanager.core.model.reference.language.Language language : store.getLanguages()) {
					if (language != null && StringUtils.isNotBlank(language.getCode())) {
						String code = language.getCode().trim().toLowerCase(Locale.ROOT);
						if (!codes.contains(code)) {
							codes.add(code);
						}
					}
				}
			}
		} catch (Exception e) {
			LOGGER.error("Cannot read store supported languages", e);
		}
		return codes;
	}

	private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper()
			.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

	private static final Slugify SLUGIFY = Slugify.builder().build();

	@Inject
	private StoreFacade storeFacade;

	@Inject
	private AiChatModelFactory aiChatModelFactory;

	/**
	 * POST /admin/product/gemini/translate
	 * Body: { "sourceLanguage": "vi",
	 *         "languages": "en,fr,zh" (optional - cac ngon ngu dich, khong gom ngon ngu nguon),
	 *         "name": "...", "seUrl": "...", "shortDescription": "...",
	 *         "description": "...", "metaTitle": "...", "metaDescription": "...", "sku": "..." }
	 *
	 * Dich toan bo thong tin san pham dang nhap o tab ngon ngu nguon (mac dinh tieng Viet)
	 * sang cac ngon ngu con lai cua cua hang.
	 *
	 * Returns ProductAiDTO JSON voi "languages" chi chua cac ngon ngu dich.
	 */
	@PostMapping("/translate")
	public ProductAiDTO translateProduct(@RequestBody Map<String, String> body, HttpServletRequest request) {

	MerchantStore store = storeFacade.getByCode(request);
	if (store == null) {
	throw new RestApiException("Merchant store not found");
	}

		AiChatModel chatModel = null;
		try {
	// Chon nha cung cap AI theo cau hinh trong Admin (Gemini / OpenAI)
	chatModel = aiChatModelFactory.getChatModel(store);
	} catch (AiException e) {
	LOGGER.warn("AI provider is not configured: {}", e.getMessage());
	throw new RestApiException(e.getMessage());
	}

	// Ngong ngu nguon (mac dinh tieng Viet)
	String sourceLanguage = StringUtils.defaultIfBlank(body.get("sourceLanguage"), "vi")
	.trim().toLowerCase(Locale.ROOT);

	// Tap hop cac truong can dich tu nguon
	ProductAiDTO.ProductAiLanguage source = new ProductAiDTO.ProductAiLanguage();
		source.setName(StringUtils.trimToEmpty(body.get("name")));
		source.setSeUrl(StringUtils.trimToEmpty(body.get("seUrl")));
		source.setShortDescription(StringUtils.trimToEmpty(body.get("shortDescription")));
		source.setDescription(StringUtils.trimToEmpty(body.get("description")));
		source.setMetaTitle(StringUtils.trimToEmpty(body.get("metaTitle")));
		source.setMetaDescription(StringUtils.trimToEmpty(body.get("metaDescription")));

	if (StringUtils.isBlank(source.getName())
	&& StringUtils.isBlank(source.getShortDescription())
	&& StringUtils.isBlank(source.getDescription())
	&& StringUtils.isBlank(source.getMetaTitle())
	&& StringUtils.isBlank(source.getMetaDescription())) {
	throw new RestApiException(
	"Không có nội dung để dịch. Vui lòng nhập tên hoặc mô tả sản phẩm ở tab ngôn ngữ nguồn trước.");
	}

	// Danh sach ngon ngu dich: lay tu cau hinh cua cua hang, uu tien tham so, loai bo ngon ngu nguon
	List<String> languages = new ArrayList<>(parseLanguages(body.get("languages"), storeLanguages(store)));
	languages.remove(sourceLanguage);
	if (languages.isEmpty()) {
		throw new RestApiException("Không xác định được ngôn ngữ đích để dịch.");
	}

		String prompt = buildTranslatePrompt(sourceLanguage, source, languages);

		try {
	String generatedText = callModel(chatModel, AiChatRequest.text(prompt));
	if (StringUtils.isBlank(generatedText)) {
	throw new RestApiException("AI không trả về dữ liệu");
	}
	ProductAiDTO dto = OBJECT_MAPPER.readValue(generatedText, ProductAiDTO.class);
	// Giu nguyen SKU / refCode nguon neu co (dich khong nen doi SKU)
		dto.setSku(StringUtils.trimToNull(body.get("sku")));
		sanitizeSlugs(dto);
	return dto;
	} catch (RestApiException e) {
	throw e;
	} catch (Exception e) {
	LOGGER.error("Error calling AI API or parsing translation response", e);
	throw new RestApiException("Lỗi khi gọi AI API dịch: " + e.getMessage());
	}
	}

	/**
	 * POST /admin/product/gemini/generate
	 * Body: { "imageBase64": "...", "mimeType": "image/jpeg",
	 *         "languages": "vi,en,fr,zh" (optional),
	 *         "skuPrefix": "tui-xach" (optional - ten danh muc tieng Viet khong dau) }
	 *
	 * Returns ProductAiDTO JSON:
	 * { "sku": "SP-12345", "refCode": "REF-98765",
	 *   "languages": { "vi": { name, seUrl, shortDescription, description,
	 *   metaTitle, metaDescription }, "en": {...}, ... } }
	 */
	@PostMapping("/generate")
	public ProductAiDTO generateProduct(@RequestBody Map<String, String> body, HttpServletRequest request) {

		MerchantStore store = storeFacade.getByCode(request);
		if (store == null) {
			throw new RestApiException("Merchant store not found");
	}

			AiChatModel chatModel = null;
			try {
		// Chon nha cung cap AI theo cau hinh trong Admin (Gemini / OpenAI)
		chatModel = aiChatModelFactory.getChatModel(store);
		} catch (AiException e) {
		LOGGER.warn("AI provider is not configured: {}", e.getMessage());
		throw new RestApiException(e.getMessage());
		}

		String imageBase64 = body.get("imageBase64");
		if (StringUtils.isBlank(imageBase64)) {
			throw new RestApiException("Thiếu ảnh (imageBase64)");
	}

		String mimeType = StringUtils.defaultIfBlank(body.get("mimeType"), "image/jpeg");

	// strip data url prefix if present (data:image/jpeg;base64,...)
	if (imageBase64.startsWith("data:")) {
	int commaIndex = imageBase64.indexOf(',');
	if (commaIndex < 0) {
	throw new RestApiException("Định dạng ảnh data URL không hợp lệ");
	}
	String meta = imageBase64.substring(0, commaIndex);
	int semi = meta.indexOf(';');
	if (semi > 0) {
	mimeType = meta.substring(5, semi); // image/jpeg
	}
	imageBase64 = imageBase64.substring(commaIndex + 1);
	}

	// validate base64
		try {
			Base64.getDecoder().decode(imageBase64);
	} catch (IllegalArgumentException e) {
			throw new RestApiException("Ảnh không hợp lệ (Base64 decode failed)");
	}

			// danh sach ngon ngu Admin chon ("vi,en,fr,zh"), lay tu cau hinh cua hang
			List<String> languages = parseLanguages(body.get("languages"), storeLanguages(store));

			// tien to SKU theo danh muc (ten danh muc tieng Viet khong dau,vd: tui-xach)
			String skuPrefix = StringUtils.trimToEmpty(body.get("skuPrefix"));

			String prompt = buildPrompt(skuPrefix, languages);

						try {
					String generatedText = callModel(chatModel,
					AiChatRequest.textAndImage(prompt, mimeType, imageBase64));
			if (StringUtils.isBlank(generatedText)) {
			throw new RestApiException("AI không trả về dữ liệu");
			}
			// Parse JSON tu AI -> DTO de frontend fill vao form Admin
			ProductAiDTO dto = OBJECT_MAPPER.readValue(generatedText, ProductAiDTO.class);

			// Chuan hoa seUrl (slug) tranh ky tu dac biet gay loi duong dan
				sanitizeSlugs(dto);

			return dto;
			} catch (RestApiException e) {
			throw e;
			} catch (Exception e) {
			LOGGER.error("Error calling AI API or parsing response", e);
			throw new RestApiException("Lỗi khi gọi AI API: " + e.getMessage());
			}
			}

		/**
		 * Xay dung prompt JSON Schema theo yeu cau Structured Output.
		 * Cua hang co quy tac dat SKU: ten danh muc tieng Viet khong dau, cac chu
		 * cach nhau bang dau '-', ket thuc bang so (vi du: tui-xach-da-bo-12345).
		 */
		private String buildPrompt(String skuPrefix, List<String> languages) {
			String langCsv = String.join(", ", languages);
			StringBuilder sb = new StringBuilder();
			sb.append("Phân tích hình ảnh sản phẩm này và tạo thông tin chi tiết cho hệ thống e-commerce bằng các ngôn ngữ: [")
					.append(langCsv).append("]\n");
			sb.append("Trả về kết quả đúng định dạng JSON với cấu trúc sau:\n");
			sb.append("{\n");
			sb.append("  \"sku\": \"Mã SKU tự sinh dạng CHỮ_IN_HOA_SỐ");
			if (StringUtils.isNotBlank(skuPrefix)) {
				sb.append(" (ví dụ: ").append(skuPrefix.toUpperCase(Locale.ROOT)).append("-12345)");
			} else {
				sb.append(" (ví dụ: SP-12345)");
			}
			sb.append(",\n");
			sb.append("  \"refCode\": \"Mã tham chiếu hệ thống (ví dụ: REF-98765)\",\n");
			sb.append("  \"languages\": {\n");
			for (int i = 0; i < languages.size(); i++) {
				String lang = languages.get(i);
				sb.append("    \"").append(lang).append("\": {\n");
				sb.append("      \"name\": \"Tên sản phẩm\",\n");
				sb.append("      \"seUrl\": \"duong-dan-than-thien-seo\",\n");
				sb.append("      \"shortDescription\": \"Mô tả ngắn 1-2 câu\",\n");
				sb.append("      \"description\": \"Mô tả chi tiết sản phẩm (định dạng HTML chuẩn với thẻ <p>, <ul>, <li>, <strong>)\",\n");
				sb.append("      \"metaTitle\": \"Tiêu đề SEO (dưới 60 ký tự)\",\n");
				sb.append("      \"metaDescription\": \"Mô tả Meta SEO (dưới 160 ký tự)\"\n");
				sb.append("    }");
				if (i < languages.size() - 1) {
					sb.append(",");
				}
				sb.append("\n");
			}
			sb.append("  }\n");
			sb.append("}\n");
			sb.append("Lưu ý: chỉ trả về JSON thuần, không thêm bất kỳ chữ nào khác.\n");
			sb.append("- Với mọi ngôn ngữ: seUrl là đường dẫn thân thiện SEO, chỉ chữ thường, số và dấu '-', không ký tự đặc biệt.\n");
			sb.append("- description phải dùng thẻ HTML chuẩn (<p>, <ul>, <li>, <strong>) để hiển thị đẹp trong CKEditor.\n");
			if (StringUtils.isNotBlank(skuPrefix)) {
				sb.append("- sku theo quy tắc của cửa hàng: tiền tố \"").append(skuPrefix.toUpperCase(Locale.ROOT))
						.append("\" + '-' + số ngẫu nhiên 5 chữ số (ví dụ: ").append(skuPrefix.toUpperCase(Locale.ROOT))
						.append("-12345).\n");
			} else {
				sb.append("- sku tự sinh ngẫu nhiên hợp lý dạng CHỮ_IN_HOA + '-' + số.\n");
			}
				return sb.toString();
			}

			/**
			 * Xay dung prompt dich toan bo thong tin san pham tu ngon ngu nguon sang
			 * cac ngon ngu dich. Giu nguyen dinh dang HTML cua mo ta chi tiet.
			 */
			private String buildTranslatePrompt(String sourceLanguage, ProductAiDTO.ProductAiLanguage source,
			List<String> languages) {
			String langCsv = String.join(", ", languages);
			StringBuilder sb = new StringBuilder();
				sb.append("Bạn là chuyên gia dịch thuật thương mại điện tử.");
				sb.append("Dịch toàn bộ thông tin sản phẩm sau từ ngôn ngữ \"").append(sourceLanguage)
			.append("\" sang các ngôn ngữ: [").append(langCsv).append("].\n\n");
				sb.append("NỘI DUNG NGUỒN:\n");
				sb.append("- name: ").append(source.getName()).append("\n");
				sb.append("- shortDescription: ").append(source.getShortDescription()).append("\n");
				sb.append("- description (HTML): ").append(source.getDescription()).append("\n");
				sb.append("- metaTitle: ").append(source.getMetaTitle()).append("\n");
				sb.append("- metaDescription: ").append(source.getMetaDescription()).append("\n\n");
				sb.append("Trả về kết quả đúng định dạng JSON với cấu trúc sau:\n");
				sb.append("{\n");
				sb.append("  \"languages\": {\n");
			for (int i = 0; i < languages.size(); i++) {
			String lang = languages.get(i);
				sb.append("    \"").append(lang).append("\": {\n");
				sb.append("      \"name\": \"Ten san pham da dich\",\n");
				sb.append("      \"seUrl\": \"duong-dan-than-thien-seo\",\n");
				sb.append("      \"shortDescription\": \"Mo ta ngan da dich\",\n");
				sb.append("      \"description\": \"Mo ta chi tiet da dich (HTML)\",\n");
				sb.append("      \"metaTitle\": \"Tieu de SEO da dich\",\n");
				sb.append("      \"metaDescription\": \"Mo ta Meta SEO da dich\"\n");
				sb.append("    }");
			if (i < languages.size() - 1) {
				sb.append(",");
			}
				sb.append("\n");
			}
				sb.append("  }\n");
				sb.append("}\n");
				sb.append("Lưu ý: chỉ trả về JSON thuần, không thêm bất kỳ chữ nào khác.\n");
				sb.append("- Dịch sát nghĩa, tự nhiên, phù hợp văn phong bán hàng của ngôn ngữ đích.\n");
				sb.append("- Với mọi ngôn ngữ: seUrl là đường dẫn thân thiện SEO, chỉ chữ thường, số và dấu '-', không dấu, không ký tự đặc biệt.\n");
				sb.append("- description phải giữ nguyên cấu trúc thẻ HTML (<p>, <ul>, <li>, <strong>) như bản gốc, chỉ dịch phần văn bản bên trong.\n");
				sb.append("- Không dịch tên thương hiệu riêng, SKU, hoặc mã sản phẩm nếu có trong nội dung.\n");
			return sb.toString();
			}

			/**
			 * Nhan danh sach ngon ngu tu Admin (dang "vi,en,fr,zh"), chi giu ngon ngu
			 * ma cua hang dang ho tro (supportedLanguages lay tu cau hinh cua cua hang).
			 * Neu tham so rong thi dung luon danh sach ngon ngu cua cua hang.
			 */
		private List<String> parseLanguages(String languagesRaw, List<String> supportedLanguages) {
			List<String> result = new ArrayList<>();
			if (StringUtils.isNotBlank(languagesRaw)) {
				for (String lang : languagesRaw.split(",")) {
					String code = lang.trim().toLowerCase(Locale.ROOT);
					if (!code.isEmpty() && supportedLanguages.contains(code) && !result.contains(code)) {
						result.add(code);
					}
				}
			}
			return result.isEmpty() ? new ArrayList<>(supportedLanguages) : result;
		}

		/**
		 * Chuan hoa seUrl bang Slugify - dam bao khong co ky tu dac biet gay loi
		 * duong dan SEO (vd tieng Viet co dau "điện-thoại" -> "dien-thoai").
		 */
		private void sanitizeSlugs(ProductAiDTO dto) {
			if (dto == null || dto.getLanguages() == null) {
				return;
			}
			for (Map.Entry<String, ProductAiDTO.ProductAiLanguage> entry : dto.getLanguages().entrySet()) {
				ProductAiDTO.ProductAiLanguage lang = entry.getValue();
				if (lang != null && StringUtils.isNotBlank(lang.getSeUrl())) {
					lang.setSeUrl(SLUGIFY.slugify(lang.getSeUrl()));
				}
			}
		}

			/**
			 * Goi mo hinh AI da duoc chon trong cau hinh Admin va tra ve noi dung van ban.
			 *
			 * Controller khong biet cu the dang goi Gemini hay OpenAI - viec do nam o
			 * {@link AiChatModelFactory}. Nho vay khi doi nha cung cap chi can doi cau hinh.
			 */
			private String callModel(AiChatModel chatModel, AiChatRequest request) throws AiException {
			if (chatModel == null) {
			throw new AiException(
			"Chưa cấu hình nhà cung cấp AI. Vào Admin > Configuration > AI Configuration để chọn Gemini, OpenAI, Groq hoặc Cerebras.");
			}
			AiChatResponse response = chatModel.call(request);
			if (response == null) {
			return null;
			}
			LOGGER.debug("AI response from provider {}", response.getProvider());
			return response.getText();
			}
		}
