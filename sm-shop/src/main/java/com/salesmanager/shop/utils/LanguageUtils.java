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
      // Dong bo ngon ngu phien voi ngon ngu dang duoc yeu cau.
      //
      // Chi doi khi thuc su tim thay Language tuong ung trong DB. Neu khong tim
      // thay (vi du ma ngon ngu chua co trong bang Language) thi GIU NGUYEN ngon
      // ngu dang co trong session, khong duoc de roi vao fallback mac dinh.
      //
      // Truoc day ham nay luon goi toLanguage() va nhan ve fallback "en" khi
      // khong khop, khien ngon ngu phien bi doi am tham -> StoreFilter nap sai
      // noi dung va khung dang nhap (displayCustomerSection) bien mat.
      //
      if (!isSameLanguage(language.getCode(), localeFromContext.getLanguage())) {
        Language fromContext = languageService.toLanguage(localeFromContext);
        if (fromContext != null && StringUtils.isNotBlank(fromContext.getCode())
            && languageExists(fromContext.getCode())) {
          language = fromContext;
        } else {
          // Khong tim thay ngon ngu phu hop -> giu nguyen session va dong bo
          // LocaleContextHolder theo ngon ngu dang dung de cac bundle van dung.
          Locale sessionLocale = languageService.toLocale(language, store);
          if (sessionLocale != null) {
            LocaleContextHolder.setLocale(sessionLocale);
          }
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
   * Kiem tra mot ma ngon ngu co ton tai trong bang Language cua DB khong.
   * Tra ve false neu khong doc duoc DB (de khong lam hong luong xu ly).
   */
  private boolean languageExists(String code) {
    try {
      return languageService.getByCode(code) != null;
    } catch (Exception e) {
      logger.warn("Cannot verify language " + code, e);
      return false;
    }
  }

  /**
   * So sanh hai ma ngon ngu co cung chi mot ngon ngu khong (khong phan biet hoa/thuong).
   */
  private boolean isSameLanguage(String languageCode, String localeCode) {
    if (StringUtils.isBlank(languageCode) || StringUtils.isBlank(localeCode)) {
      return false;
    }
    return languageCode.trim().equalsIgnoreCase(localeCode.trim());
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
