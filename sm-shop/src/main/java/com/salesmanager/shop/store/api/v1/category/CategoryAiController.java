package com.salesmanager.shop.store.api.v1.category;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.salesmanager.core.model.reference.language.Language;
import com.salesmanager.shop.constants.Constants;

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
 * REST API tao dong bo du lieu danh muc san pham bang AI.
 *
 * Workflow:
 * 1. Admin nhap Ten danh muc (bat ky ngon ngu nao) tren form "Tao danh muc".
 * 2. Frontend goi POST /api/v1/category/ai/generate kem category_name va
 * danh sach supported_languages.
 * 3. Backend dung System Prompt (JSON Schema) -> goi mo hinh AI da cau hinh
 * trong Admin > Configuration > AI Configuration.
 * 4. Parse JSON tra ve -> CategoryAiDTO -> Frontend tu dong dien vao cac o
 * input / CKEditor theo tung ngon ngu. Nguoi dung VAN xem lai va chinh sua
 * truoc khi bam Luu.
 *
 * Nha cung cap AI (Gemini / OpenAI / Groq / Cerebras) va API key do
 * {@link AiChatModelFactory} quyet dinh dua tren cau hinh trong Admin, nen
 * controller nay khong phu thuoc vao mot nha cung cap cu the.
 */
@RestController
@RequestMapping("/api/v1/category/ai")
public class CategoryAiController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CategoryAiController.class);

	/** Cac ngon ngu he thong ho tro san cho du lieu danh muc. */
	private static final List<String> DEFAULT_LANGUAGES = List.of("vi", "en", "fr", "zh");

	private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper()
			.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

	private static final Slugify SLUGIFY = Slugify.builder().build();

	/**
	 * Locale mac dinh cho thong bao khi khong xac dinh duoc ngon ngu cua nguoi dung.
	 * Giu dung tieng Viet lam phuong an du phong de khong bao gio hien thi key tho.
	 */
	private static final Locale DEFAULT_LOCALE = new Locale("vi", "VN");

	@Inject
	private StoreFacade storeFacade;

	@Inject
	private AiChatModelFactory aiChatModelFactory;

	@Inject
	private MessageSource messageSource;

	/**
	 * POST /api/v1/category/ai/generate
	 *
	 * Body (JSON):
	 * { "category_name": "Laptop & Máy tính bảng",
	 * "supported_languages": ["vi", "en", "fr", "zh"] }
	 *
	 * Ho tro them cac ten truong camelCase (categoryName, languages) de tien
	 * cho client moi.
	 *
	 * Returns CategoryAiDTO JSON:
	 * { "categoryCode": "LAPTOP_COMPUTERS",
	 * "languages": { "vi": { name, seUrl, shortDescription, description,
	 * metaTitle, metaKeywords, metaDescription }, "en": {...}, ... } }
	 */
	@PostMapping("/generate")
	public CategoryAiDTO generateCategory(@RequestBody Map<String, Object> body, HttpServletRequest request) {

		Locale locale = resolveLocale(request);

		MerchantStore store = storeFacade.getByCode(request);
		if (store == null) {
			throw new RestApiException("Merchant store not found");
		}

		AiChatModel chatModel = null;
		try {
			// Chon nha cung cap AI theo cau hinh trong Admin (Gemini / OpenAI / Groq /
			// Cerebras)
			chatModel = aiChatModelFactory.getChatModel(store);
		} catch (AiException e) {
			LOGGER.warn("AI provider is not configured: {}", e.getMessage());
			throw new RestApiException(e.getMessage());
		}

		String categoryName = firstNonBlank(body.get("category_name"), body.get("categoryName"), body.get("name"));
		if (StringUtils.isBlank(categoryName)) {
			throw new RestApiException(msg("category.ai.need.name", locale));
		}

		List<String> languages = parseLanguages(body.get("supported_languages"), body.get("languages"));

		String prompt = buildSystemPrompt(categoryName, languages);

		try {
			String generatedText = callModel(chatModel, AiChatRequest.text(prompt), locale);
			if (StringUtils.isBlank(generatedText)) {
				throw new RestApiException(msg("category.ai.no.data", locale));
			}
			CategoryAiDTO dto = OBJECT_MAPPER.readValue(stripCodeFence(generatedText), CategoryAiDTO.class);

			// category_code luon phai dung dinh dang UPPER_SNAKE_CASE khong dau
			dto.setCategoryCode(sanitizeCategoryCode(dto.getCategoryCode(), categoryName));

			// seUrl luon phai la slug sach, tranh ky tu dac biet gay loi duong dan
			sanitizeSlugs(dto);

			return dto;
		} catch (RestApiException e) {
			throw e;
		} catch (Exception e) {
			LOGGER.error("Error calling AI API or parsing category response", e);
			throw new RestApiException(msg("category.ai.error", locale) + e.getMessage());
		}
	}

	/**
	 * System Prompt gui den AI.
	 *
	 * Yeu cau AI tra ve DUNG JSON Schema (khong them chu nao khac) de backend
	 * parse truc tiep bang ObjectMapper.
	 */
	private String buildSystemPrompt(String categoryName, List<String> languages) {
		String langCsv = String.join(", ", languages);
		StringBuilder sb = new StringBuilder();

		sb.append(
				"Bạn là một chuyên gia E-commerce và SEO Content. Nhiệm vụ của bạn là nhận vào Tên Danh Mục ở bất kỳ ngôn ngữ nào và tự động sinh ra đầy đủ dữ liệu quản lý danh mục cho các ngôn ngữ: [")
				.append(langCsv).append("].\n\n");

		sb.append("TÊN DANH MỤC ĐẦU VÀO: ").append(categoryName).append("\n\n");

		sb.append("Quy tắc tạo dữ liệu:\n");
		sb.append("- categoryCode: Dạng UPPER_SNAKE_CASE không dấu (VD: LAPTOP_COMPUTERS).\n");
		sb.append("- name: Tên danh mục, dịch lại cho từng ngôn ngữ được hỗ trợ.\n");
		sb.append(
				"- seUrl: Dạng kebab-case thân thiện SEO phù hợp với từng ngôn ngữ (với tiếng Trung dùng Pinyin không dấu).\n");
		sb.append("- shortDescription: 1 câu tóm tắt ngắn gọn (dưới 150 ký tự).\n");
		sb.append("- description: Đoạn văn bản HTML chuẩn (<p>, <strong>) giới thiệu danh mục.\n");
		sb.append("- metaTitle: Chuẩn SEO, độ dài 50-60 ký tự.\n");
		sb.append("- metaKeywords: 4-6 từ khóa tìm kiếm phổ biến, phân cách bằng dấu phẩy.\n");
		sb.append("- metaDescription: Đoạn mô tả hấp dẫn kích thích click, độ dài 130-160 ký tự.\n\n");

		sb.append("Trả về kết quả ĐÚNG định dạng JSON với cấu trúc sau:\n");
		sb.append("{\n");
		sb.append("  \"categoryCode\": \"UPPER_SNAKE_CASE_KHONG_DAU\",\n");
		sb.append("  \"languages\": {\n");
		for (int i = 0; i < languages.size(); i++) {
			String lang = languages.get(i);
			sb.append("    \"").append(lang).append("\": {\n");
			sb.append("      \"name\": \"Tên danh mục\",\n");
			sb.append("      \"seUrl\": \"duong-dan-than-thien-seo\",\n");
			sb.append("      \"shortDescription\": \"Mô tả ngắn 1 câu dưới 150 ký tự\",\n");
			sb.append("      \"description\": \"Đoạn HTML giới thiệu danh mục với thẻ <p> và <strong>\",\n");
			sb.append("      \"metaTitle\": \"Tiêu đề SEO 50-60 ký tự\",\n");
			sb.append("      \"metaKeywords\": \"từ khóa 1, từ khóa 2, từ khóa 3, từ khóa 4\",\n");
			sb.append("      \"metaDescription\": \"Mô tả meta hấp dẫn 130-160 ký tự\"\n");
			sb.append("    }");
			if (i < languages.size() - 1) {
				sb.append(",");
			}
			sb.append("\n");
		}
		sb.append("  }\n");
		sb.append("}\n\n");

		sb.append("Lưu ý bắt buộc:\n");
		sb.append("- Chỉ trả về JSON thuần, KHÔNG thêm bất kỳ chữ nào khác, KHÔNG bọc trong markdown code fence.\n");
		sb.append("- Chỉ dùng đúng các mã ngôn ngữ sau cho khóa trong \"languages\": ").append(langCsv).append(".\n");
		sb.append("- description phải dùng thẻ HTML chuẩn (<p>, <strong>) để hiển thị đẹp trong CKEditor.\n");
		sb.append("- seUrl chỉ gồm chữ thường, số và dấu '-', không dấu, không ký tự đặc biệt.\n");
		sb.append("- categoryCode không dấu, không khoảng trắng, chỉ gồm A-Z, 0-9 và dấu '_'.\n");
		return sb.toString();
	}

	/**
	 * Nhan supported_languages tu Frontend: chap nhan ca List (JSON array)
	 * lan chuoi phan cach bang dau phay ("vi,en,fr,zh").
	 */
	private List<String> parseLanguages(Object raw, Object fallbackRaw) {
		List<String> result = new ArrayList<>();
		addLanguages(result, raw);
		if (result.isEmpty()) {
			addLanguages(result, fallbackRaw);
		}
		return result.isEmpty() ? DEFAULT_LANGUAGES : result;
	}

	@SuppressWarnings("unchecked")
	private void addLanguages(List<String> result, Object raw) {
		if (raw == null) {
			return;
		}
		if (raw instanceof Iterable) {
			for (Object item : (Iterable<Object>) raw) {
				addLanguage(result, item == null ? null : String.valueOf(item));
			}
			return;
		}
		if (raw instanceof String) {
			for (String part : ((String) raw).split(",")) {
				addLanguage(result, part);
			}
		}
	}

	private void addLanguage(List<String> result, String raw) {
		if (StringUtils.isBlank(raw)) {
			return;
		}
		String code = raw.trim().toLowerCase(Locale.ROOT);
		if (DEFAULT_LANGUAGES.contains(code) && !result.contains(code)) {
			result.add(code);
		}
	}

	/**
	 * Mot so mo hinh AI van boc JSON trong markdown code fence (```json ... ```)
	 * du da yeu cau khong lam vay - loai bo truoc khi parse.
	 */
	private String stripCodeFence(String text) {
		String value = text.trim();
		if (!value.startsWith("```")) {
			return value;
		}
		int firstLineBreak = value.indexOf('\n');
		if (firstLineBreak < 0) {
			return value;
		}
		value = value.substring(firstLineBreak + 1);
		int closing = value.lastIndexOf("```");
		if (closing >= 0) {
			value = value.substring(0, closing);
		}
		return value.trim();
	}

	/**
	 * Dam bao category_code dung UPPER_SNAKE_CASE khong dau. Neu AI tra ve
	 * rong hoac sai dinh dang thi sinh tu Ten danh muc lam phuong an du phong.
	 */
	private String sanitizeCategoryCode(String code, String fallbackName) {
		String normalized = toUpperSnakeCase(code);
		if (StringUtils.isBlank(normalized)) {
			normalized = toUpperSnakeCase(fallbackName);
		}
		if (normalized.length() > 100) {
			normalized = normalized.substring(0, 100);
		}
		return normalized;
	}

	private String toUpperSnakeCase(String value) {
		if (StringUtils.isBlank(value)) {
			return null;
		}
		String slug = SLUGIFY.slugify(value.trim());
		if (StringUtils.isBlank(slug)) {
			return null;
		}
		return slug.replace('-', '_').toUpperCase(Locale.ROOT);
	}

	/**
	 * Chuan hoa seUrl bang Slugify - dam bao khong co ky tu dac biet gay loi
	 * duong dan SEO (vd "điện-thoại" -> "dien-thoai").
	 */
	private void sanitizeSlugs(CategoryAiDTO dto) {
		if (dto == null || dto.getLanguages() == null) {
			return;
		}
		for (Map.Entry<String, CategoryAiDTO.CategoryAiLanguage> entry : dto.getLanguages().entrySet()) {
			CategoryAiDTO.CategoryAiLanguage lang = entry.getValue();
			if (lang != null && StringUtils.isNotBlank(lang.getSeUrl())) {
				lang.setSeUrl(SLUGIFY.slugify(lang.getSeUrl()));
			}
		}
	}

	/**
	 * Goi mo hinh AI da duoc chon trong cau hinh Admin va tra ve noi dung van ban.
	 *
	 * Controller khong biet cu the dang goi Gemini hay OpenAI - viec do nam o
	 * {@link AiChatModelFactory}. Nho vay khi doi nha cung cap chi can doi cau
	 * hinh.
	 */
	private String callModel(AiChatModel chatModel, AiChatRequest request, Locale locale) throws AiException {
		if (chatModel == null) {
			throw new AiException(msg("category.ai.no.provider", locale));
		}
		AiChatResponse response = chatModel.call(request);
		if (response == null) {
			return null;
		}
		LOGGER.debug("AI response from provider {}", response.getProvider());
		return response.getText();
	}

	/**
	 * Xac dinh Locale de lay thong bao da ngon ngu.
	 *
	 * Uu tien ngon ngu ma AdminFilter/StoreFilter da gan vao request
	 * (request attribute Constants.LANGUAGE) vi do la ngon ngu giao dien Admin
	 * dang hien thi. Neu khong co thi fallback ve request.getLocale() va cuoi
	 * cung la tieng Viet.
	 */
	private Locale resolveLocale(HttpServletRequest request) {
		if (request != null) {
			Language language = (Language) request.getAttribute(Constants.LANGUAGE);
			if (language != null && StringUtils.isNotBlank(language.getCode())) {
				return new Locale(language.getCode());
			}
			try {
				Locale requestLocale = request.getLocale();
				if (requestLocale != null && StringUtils.isNotBlank(requestLocale.getLanguage())) {
					return requestLocale;
				}
			} catch (Exception ignore) {
				// bo qua, dung locale mac dinh ben duoi
			}
		}
		return DEFAULT_LOCALE;
	}

	/**
	 * Lay thong bao da ngon ngu theo key trong bundles/messages_*.properties.
	 * Fallback ve chinh key neu khong tim thay ban dich nao.
	 */
	private String msg(String key, Locale locale) {
		try {
			return messageSource.getMessage(key, null, locale);
		} catch (Exception e) {
			LOGGER.warn("Missing i18n message for key {} and locale {}", key, locale);
			return key;
		}
	}

	private String firstNonBlank(Object... values) {
		for (Object value : values) {
			if (value != null && StringUtils.isNotBlank(String.valueOf(value))) {
				return String.valueOf(value).trim();
			}
		}
		return null;
	}
}