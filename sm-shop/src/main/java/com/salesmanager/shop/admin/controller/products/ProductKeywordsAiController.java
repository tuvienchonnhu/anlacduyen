package com.salesmanager.shop.admin.controller.products;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.salesmanager.core.business.services.catalog.product.ProductService;
import com.salesmanager.core.model.catalog.product.Product;
import com.salesmanager.core.model.catalog.product.description.ProductDescription;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.reference.language.Language;
import com.salesmanager.shop.constants.Constants;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatModel;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatModelFactory;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatRequest;
import com.salesmanager.shop.store.api.v1.product.ai.AiChatResponse;
import com.salesmanager.shop.store.api.v1.product.ai.AiException;
import com.salesmanager.shop.utils.LabelUtils;

/**
 * Sinh tu khoa tim kiem cho san pham bang AI.
 *
 * Duoc goi tu nut "Them tu khoa bang AI" o trang
 * /admin/products/product/keywords.html.
 *
 * AI doc ten san pham va mo ta (theo ngon ngu goc), sau do sinh tu khoa tim
 * kiem
 * phu hop cho TAT CA ngon ngu ma cua hang dang ho tro. Ket qua duoc tra ve dang
 * JSON de Admin them hang loat vao ProductDescription.metatagKeywords.
 *
 * Luu y: AI chi tra ve du lieu, KHONG tu ghi vao co so du lieu. Viec luu do
 * ProductKeywordsController dam nhiem khi nguoi dung bam "Them" - nho vay Admin
 * luon xem duoc tu khoa truoc khi chap nhan.
 */
@Controller
@RequestMapping("/admin/products/product")
public class ProductKeywordsAiController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ProductKeywordsAiController.class);

	private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper()
			.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

	/**
	 * So tu khoa toi da sinh cho moi ngon ngu, tranh nhoi qua nhieu vao meta
	 * keywords.
	 */
	private static final int MAX_KEYWORDS_PER_LANGUAGE = 15;

	@Inject
	private ProductService productService;

	@Inject
	private AiChatModelFactory aiChatModelFactory;

	@Inject
	private MessageSource messageSource;

	@Inject
	private LabelUtils messages;

	/**
	 * POST /admin/products/product/generateKeywords.html
	 *
	 * Tham so:
	 * id - id san pham
	 * languageCode - (tuy chon) ngon ngu cua ten/mo ta nguon; mac dinh la ngon
	 * ngu dau tien co mo ta, neu khong co thi lay ngon ngu mac
	 * dinh cua cua hang
	 *
	 * Tra ve JSON:
	 * { "success": true,
	 * "sourceLanguage": "vi",
	 * "languages": { "vi": ["tu khoa 1", "tu khoa 2"], "en": [...] } }
	 */
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value = "/generateKeywords.html", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> generateKeywords(@RequestParam("id") long productId,
			@RequestParam(value = "languageCode", required = false) String languageCode, HttpServletRequest request) {

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		Locale locale = resolveLocale(request);
		MerchantStore store = (MerchantStore) request.getAttribute(Constants.ADMIN_STORE);

		try {
			Product product = productService.getById(productId);
			if (product == null || store == null
					|| product.getMerchantStore().getId().intValue() != store.getId().intValue()) {
				return jsonError(headers, message("label.product.camera.searchFailed", locale));
			}

			// Ngon ngu cua cua hang - lay dong tu cau hinh that su.
			List<String> storeLanguages = storeLanguages(store);
			if (storeLanguages.isEmpty()) {
				return jsonError(headers, message("label.product.keyword.ai.noLanguages", locale));
			}

			// Ngon ngu nguon: uu tien tham so, sau do la ngon ngu co ten san pham.
			String sourceLanguage = resolveSourceLanguage(product, languageCode, storeLanguages);
			if (sourceLanguage == null) {
				return jsonError(headers, message("label.product.keyword.ai.noDescription", locale));
			}

			ProductDescription source = description(product, sourceLanguage);
			String productName = source == null ? null : source.getName();
			String productDescription = source == null ? null : source.getDescription();

			if (StringUtils.isBlank(productName) && StringUtils.isBlank(productDescription)) {
				return jsonError(headers, message("label.product.keyword.ai.noDescription", locale));
			}

			AiChatModel chatModel;
			try {
				chatModel = aiChatModelFactory.getChatModel(store);
			} catch (AiException e) {
				LOGGER.warn("AI provider is not configured: {}", e.getMessage());
				return jsonError(headers, message("label.product.keyword.ai.notConfigured", locale));
			}

			String prompt = buildKeywordPrompt(productName, productDescription, sourceLanguage, storeLanguages);
			String generatedText = callModel(chatModel, prompt, locale);
			if (StringUtils.isBlank(generatedText)) {
				return jsonError(headers, message("label.product.keyword.ai.failed", locale));
			}

			Map<String, List<String>> keywords = parseKeywords(generatedText, storeLanguages);
			if (keywords.isEmpty()) {
				return jsonError(headers, message("label.product.keyword.ai.failed", locale));
			}

			Map<String, Object> result = new LinkedHashMap<String, Object>();
			result.put("success", Boolean.TRUE);
			result.put("sourceLanguage", sourceLanguage);
			result.put("languages", keywords);

			return new ResponseEntity<String>(OBJECT_MAPPER.writeValueAsString(result), headers, HttpStatus.OK);

		} catch (Exception e) {
			LOGGER.error("Error while generating product keywords with AI", e);
			return jsonError(headers, message("label.product.keyword.ai.failed", locale));
		}
	}

	/**
	 * System prompt: yeu cau AI tra ve DUY NHAT mot JSON gom tu khoa cho tung
	 * ngon ngu, de backend parse truc tiep.
	 */
	private String buildKeywordPrompt(String productName, String productDescription, String sourceLanguage,
			List<String> languages) {

		String langCsv = String.join(", ", languages);
		StringBuilder sb = new StringBuilder();

		sb.append("Bạn là chuyên gia SEO E-commerce. Nhiệm vụ: đọc TÊN và MÔ TẢ sản phẩm ")
				.append("(ngôn ngữ nguồn: ").append(sourceLanguage).append(") rồi sinh ra các TỪ KHÓA TÌM KIẾM ")
				.append("phù hợp cho từng ngôn ngữ sau: [").append(langCsv).append("].\n\n");

		sb.append("TÊN SẢN PHẨM: ").append(StringUtils.defaultString(productName)).append("\n\n");

		String plain = stripHtml(productDescription);
		// Gioi han do dai mo ta gui len AI de tranh ton token va tranh lam loang thong
		// tin.
		if (plain.length() > 2000) {
			plain = plain.substring(0, 2000);
		}
		sb.append("MÔ TẢ SẢN PHẨM: ").append(plain).append("\n\n");

		sb.append("Quy tắc sinh từ khóa:\n");
		sb.append("- Mỗi ngôn ngữ sinh 8-").append(MAX_KEYWORDS_PER_LANGUAGE)
				.append(" từ khóa, DỊCH và BẢN ĐỊA HÓA theo đúng ngôn ngữ đó (không giữ nguyên tiếng nguồn).\n");
		sb.append("- Từ khóa phải là cụm từ người mua thật sự tìm kiếm, ngắn gọn 1-4 từ.\n");
		sb.append("- Bao gồm: tên gọi chung, chất liệu, công dụng, đối tượng dùng, từ khóa thương mại ")
				.append("(mua, giá, chính hãng...).\n");
		sb.append("- KHÔNG trùng lặp trong cùng một ngôn ngữ, KHÔNG dùng dấu phẩy bên trong từ khóa.\n");
		sb.append("- Với tiếng Trung: dùng chữ Hán giản thể thông dụng cho tìm kiếm.\n\n");

		sb.append("Trả về ĐÚNG định dạng JSON sau, không thêm gì khác:\n");
		sb.append("{\n  \"languages\": {\n");
		for (int i = 0; i < languages.size(); i++) {
			String lang = languages.get(i);
			sb.append("    \"").append(lang).append("\": [\"từ khóa 1\", \"từ khóa 2\", \"từ khóa 3\"]");
			if (i < languages.size() - 1) {
				sb.append(",");
			}
			sb.append("\n");
		}
		sb.append("  }\n}\n\n");

		sb.append("Lưu ý bắt buộc:\n");
		sb.append("- Chỉ trả về JSON thuần, KHÔNG bọc trong markdown code fence.\n");
		sb.append("- Chỉ dùng đúng các mã ngôn ngữ sau làm khóa: ").append(langCsv).append(".\n");
		sb.append("- Mỗi giá trị là một MẢNG chuỗi từ khóa.\n");

		return sb.toString();
	}

	/**
	 * Doc JSON AI tra ve thanh Map<ngon ngu, danh sach tu khoa>.
	 *
	 * Ho tro ca hai dang: {"languages": {...}} va {...} (phang), dong thoi chap
	 * nhan mang hoac chuoi phan cach bang dau phay.
	 */
	private Map<String, List<String>> parseKeywords(String generatedText, List<String> storeLanguages) {

		Map<String, List<String>> result = new LinkedHashMap<String, List<String>>();

		try {
			JsonNode root = OBJECT_MAPPER.readTree(stripCodeFence(generatedText));
			JsonNode languagesNode = root.get("languages");
			if (languagesNode == null || !languagesNode.isObject()) {
				languagesNode = root;
			}

			for (String code : storeLanguages) {
				JsonNode node = languagesNode.get(code);
				if (node == null) {
					continue;
				}
				List<String> keywords = readKeywordArray(node);
				if (!keywords.isEmpty()) {
					result.put(code, keywords);
				}
			}
		} catch (Exception e) {
			LOGGER.error("Cannot parse AI keyword response", e);
		}

		return result;
	}

	private List<String> readKeywordArray(JsonNode node) {

		List<String> keywords = new ArrayList<String>();
		Set<String> seen = new HashSet<String>();

		if (node.isArray()) {
			for (JsonNode item : node) {
				addKeyword(keywords, seen, item == null ? null : item.asText());
			}
		} else if (node.isTextual()) {
			// Truong hop AI tra ve chuoi "a, b, c" thay vi mang.
			for (String part : node.asText().split(",")) {
				addKeyword(keywords, seen, part);
			}
		}

		return keywords;
	}

	private void addKeyword(List<String> keywords, Set<String> seen, String raw) {

		if (StringUtils.isBlank(raw)) {
			return;
		}

		String keyword = raw.trim();
		// Bo dau ngoac kep va gach dau dong neu AI lo tra ve.
		keyword = keyword.replace("\"", "").replace("'", "").replace("- ", "").trim();
		if (keyword.isEmpty()) {
			return;
		}

		String key = keyword.toLowerCase(Locale.ROOT);
		if (seen.contains(key)) {
			return;
		}

		seen.add(key);
		if (keywords.size() < MAX_KEYWORDS_PER_LANGUAGE) {
			keywords.add(keyword);
		}
	}

	/**
	 * Xac dinh ngon ngu nguon (ngon ngu cua ten/mo ta dua cho AI).
	 *
	 * Uu tien: tham so nguoi dung chon -> ngon ngu dau tien co mo ta -> ngon ngu
	 * mac dinh cua cua hang -> null neu khong co mo ta nao.
	 */
	private String resolveSourceLanguage(Product product, String requested, List<String> storeLanguages) {

		if (StringUtils.isNotBlank(requested)) {
			String code = requested.trim().toLowerCase(Locale.ROOT);
			if (storeLanguages.contains(code) && description(product, code) != null) {
				return code;
			}
		}

		for (String code : storeLanguages) {
			ProductDescription description = description(product, code);
			if (description != null && StringUtils.isNotBlank(description.getName())) {
				return code;
			}
		}

		return null;
	}

	private ProductDescription description(Product product, String languageCode) {

		if (product == null || product.getDescriptions() == null || StringUtils.isBlank(languageCode)) {
			return null;
		}

		for (ProductDescription description : product.getDescriptions()) {
			if (description != null && description.getLanguage() != null
					&& languageCode.equalsIgnoreCase(description.getLanguage().getCode())) {
				return description;
			}
		}

		return null;
	}

	private List<String> storeLanguages(MerchantStore store) {

		List<String> codes = new ArrayList<String>();
		try {
			if (store != null && store.getLanguages() != null) {
				for (Language language : store.getLanguages()) {
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

	private String callModel(AiChatModel chatModel, String prompt, Locale locale) throws AiException {

		if (chatModel == null) {
			throw new AiException(message("label.product.keyword.ai.notConfigured", locale));
		}
		AiChatResponse response = chatModel.call(AiChatRequest.text(prompt));
		if (response == null) {
			return null;
		}
		LOGGER.debug("AI keyword response from provider {}", response.getProvider());
		return response.getText();
	}

	/** Loai bo the HTML de gui mo ta gon gang cho AI. */
	private String stripHtml(String html) {

		if (StringUtils.isBlank(html)) {
			return "";
		}
		String text = html.replaceAll("<[^>]*>", " ");
		text = text.replace("&nbsp;", " ").replace("&amp;", "&").replace("&quot;", "\"");
		return text.replaceAll("\\s+", " ").trim();
	}

	/**
	 * Mot so mo hinh AI van boc JSON trong markdown code fence du da yeu cau khong
	 * lam vay - loai bo truoc khi parse.
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

	private Locale resolveLocale(HttpServletRequest request) {

		try {
			Language language = (Language) request.getAttribute(Constants.LANGUAGE);
			if (language != null && StringUtils.isNotBlank(language.getCode())) {
				return new Locale(language.getCode());
			}
		} catch (Exception e) {
			LOGGER.debug("Cannot resolve admin request locale", e);
		}

		Locale locale = request.getLocale();
		return locale == null ? new Locale("vi") : locale;
	}

	private String message(String code, Locale locale) {

		try {
			return messages.getMessage(code, locale);
		} catch (Exception e) {
			return messages.getMessage(code, new Locale("vi"));
		}
	}

	private ResponseEntity<String> jsonError(HttpHeaders headers, String message) {

		Map<String, Object> body = new HashMap<String, Object>();
		body.put("success", Boolean.FALSE);
		body.put("message", message);

		try {
			return new ResponseEntity<String>(OBJECT_MAPPER.writeValueAsString(body), headers, HttpStatus.OK);
		} catch (Exception e) {
			LOGGER.error("Cannot serialize error response", e);
			return new ResponseEntity<String>("{\"success\":false}", headers, HttpStatus.OK);
		}
	}
}