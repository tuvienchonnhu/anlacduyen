package com.salesmanager.shop.utils;

import java.util.Locale;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;
import com.salesmanager.core.business.exception.ServiceException;
import com.salesmanager.core.business.services.reference.language.LanguageService;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.reference.language.Language;
import com.salesmanager.shop.constants.Constants;
import com.salesmanager.shop.store.api.exception.ServiceRuntimeException;

@Component
public class LanguageUtils {

  protected final Log logger = LogFactory.getLog(getClass());

  private static final String ALL_LANGUALES = "_all";

  @Inject
  LanguageService languageService;

  public Language getServiceLanguage(String lang) {
    Language l = null;
    if (!StringUtils.isBlank(lang)) {
      try {
        l = languageService.getByCode(lang);
      } catch (ServiceException e) {
        logger.error("Cannot retrieve language " + lang, e);
      }
    }

    if (l == null) {
      l = languageService.defaultLanguage();
    }

    return l;
  }

  /**
   * Determines request language based on store rules
   * 
   * @param request
   * @return
   */
  public Language getRequestLanguage(HttpServletRequest request, HttpServletResponse response) {

    Locale locale = null;

    Language language = (Language) request.getSession().getAttribute(Constants.LANGUAGE);
    MerchantStore store =
        (MerchantStore) request.getSession().getAttribute(Constants.MERCHANT_STORE);
    


    if (language == null) {
      try {

        locale = LocaleContextHolder.getLocale();// should be browser locale



        if (store != null) {
          language = store.getDefaultLanguage();
          if (language != null) {
            locale = languageService.toLocale(language, store);
            if (locale != null) {
              LocaleContextHolder.setLocale(locale);
            }
            request.getSession().setAttribute(Constants.LANGUAGE, language);
          }

          if (language == null) {
            language = languageService.toLanguage(locale);
            request.getSession().setAttribute(Constants.LANGUAGE, language);
          }

        }

      } catch (Exception e) {
        if (language == null) {
          try {
            language = languageService.getByCode(Constants.DEFAULT_LANGUAGE);
          } catch (Exception ignore) {
          }
        }
      }
    } else {


      Locale localeFromContext = LocaleContextHolder.getLocale();// should be browser locale
      //
      // So sanh theo NGON NGU (khong phan biet hoa/thuong) va co xu ly ma cu.
      //
      // Trong DB, tieng Viet duoc luu voi ma cu "vn", trong khi java.util.Locale
      // dung ma ISO-639 "vi" (Locale("vi","VN").getLanguage() tra ve "vi").
      // Neu so sanh truc tiep "vn".equals("vi") thi LUON sai -> moi request deu goi
      // toLanguage("vi"), tra cuu getLanguagesMap() theo key "vi" khong thay
      // (map duoc danh key theo ma DB "vn") nen roi vao fallback DEFAULT_LANGUAGE
      // ("en"). Ket qua: ngon ngu phien bi doi am tham sang "en" moi lan tai trang,
      // lam StoreFilter nap sai noi dung va khung dang nhap bien mat.
      //
      if (!isSameLanguage(language.getCode(), localeFromContext.getLanguage())) {
        // get locale context
        Language fromContext = languageService.toLanguage(localeFromContext);
        if (fromContext != null) {
          language = fromContext;
        }
      }

    }

    if (language != null) {
      locale = languageService.toLocale(language, store);
    } else {
      language = languageService.toLanguage(locale);
    }

    LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
    if (localeResolver != null) {
      localeResolver.setLocale(request, response, locale);
    }
    response.setLocale(locale);
    request.getSession().setAttribute(Constants.LANGUAGE, language);

    return language;
  }

  /**
   * So sanh hai ma ngon ngu co cung chi mot ngon ngu khong.
   *
   * Xu ly truong hop dac biet cua tieng Viet: DB dung ma cu "vn" con
   * java.util.Locale dung ma ISO-639 "vi". Neu khong quy ve cung mot dang thi
   * phep so sanh luon sai va ngon ngu phien bi reset ve mac dinh moi request.
   */
  private boolean isSameLanguage(String languageCode, String localeCode) {
    if (StringUtils.isBlank(languageCode) || StringUtils.isBlank(localeCode)) {
      return false;
    }
    return normalizeLanguageCode(languageCode).equalsIgnoreCase(normalizeLanguageCode(localeCode));
  }

  /** Quy cac ma ngon ngu tieng Viet (vn / vie) ve cung mot dang "vi". */
  private String normalizeLanguageCode(String code) {
    String normalized = code.trim();
    if ("vn".equalsIgnoreCase(normalized) || "vie".equalsIgnoreCase(normalized)) {
      return "vi";
    }
    return normalized;
  }

  /**
   * Should be used by rest web services
   * 
   * @param request
   * @param store
   * @return
   * @throws Exception
   */
  public Language getRESTLanguage(HttpServletRequest request) {

    Validate.notNull(request, "HttpServletRequest must not be null");

    try {
      Language language = null;

      String lang = request.getParameter(Constants.LANG);

      if (StringUtils.isBlank(lang)) {
        if (language == null) {
          language = languageService.defaultLanguage();
        }
      } else {
        if(!ALL_LANGUALES.equals(lang)) {
          language = languageService.getByCode(lang);
          if (language == null) {
            language = languageService.defaultLanguage();
          }
        }
      }
      
      //if language is null then underlying facade must load all languages
      return language;

    } catch (ServiceException e) {
      throw new ServiceRuntimeException(e);
    }
  }

}
