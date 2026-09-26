package com.salesmanager.shop.store.controller.customer;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salesmanager.core.business.services.shoppingcart.ShoppingCartService;
import com.salesmanager.core.model.customer.Customer;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.reference.language.Language;
import com.salesmanager.core.model.shoppingcart.ShoppingCart;
import com.salesmanager.shop.admin.model.userpassword.UserReset;
import com.salesmanager.shop.constants.Constants;
import com.salesmanager.shop.model.customer.SecuredShopPersistableCustomer;
import com.salesmanager.shop.model.customer.address.Address;
import com.salesmanager.shop.store.controller.AbstractController;
import com.salesmanager.shop.store.controller.customer.facade.CustomerFacade;
import com.salesmanager.shop.store.controller.customer.GoogleOAuthService.GoogleUser;
import com.salesmanager.shop.utils.LabelUtils;

/**
 * Dang nhap / dang ky bang tai khoan Google (OAuth 2.0 authorization code).
 *
 * Client ID va Client Secret duoc cau hinh trong Admin > Configuration > Login
 * Configuration. Authorized redirect URI can khai bao trong Google Console la:
 * {context}/shop/customer/google/callback.html
 */
@Controller
@RequestMapping("/shop/customer")
public class GoogleOAuthController extends AbstractController {

	private static final Logger LOGGER = LoggerFactory.getLogger(GoogleOAuthController.class);

	/** Ten attribute luu state chong CSRF trong session. */
	private static final String SESSION_OAUTH_STATE = "GOOGLE_OAUTH_STATE";

	private static final int COOKIE_MAX_AGE = 60 * 24 * 3600;

	@Inject
	private GoogleOAuthService googleOAuthService;

	/**
	 * Dua cau hinh Google (Client ID + ma ngon ngu) vao model de fragment
	 * googleSignIn.jsp hien thi nut dang nhap bang GIS SDK.
	 */
	public void setGoogleLoginAttributes(Model model, MerchantStore store) {
		model.addAttribute("googleLoginEnabled", googleOAuthService.isConfigured(store));
		model.addAttribute("googleClientId", googleOAuthService.getClientId(store));
		model.addAttribute("googleLocale", resolveGoogleLocale());
	}

	/**
	 * Lay ma ngon ngu 2 ky tu cua request hien tai de GIS SDK hien thi nut dung
	 * ngon ngu. Mac dinh la "en" neu chua xac dinh duoc.
	 */
	private String resolveGoogleLocale() {
		try {
			Locale locale = LocaleContextHolder.getLocale();
			if (locale != null && StringUtils.isNotBlank(locale.getLanguage())) {
				return locale.getLanguage();
			}
		} catch (Exception e) {
			LOGGER.debug("Cannot resolve locale for Google sign-in button", e);
		}
		return "en";
	}

	@Inject
	private CustomerFacade customerFacade;

	@Inject
	private ShoppingCartService shoppingCartService;

	@Inject
	private LabelUtils messages;

	/**
	 * Google Identity Services (GIS) SDK tra ve ID token (credential) qua
	 * callback JavaScript o phia client. Ham nay xac minh ID token roi thuc hien
	 * dang nhap / dang ky tai khoan, tra ket qua duoi dang JSON de phia client
	 * chuyen huong hoac hien thi thong bao loi da ban dia hoa.
	 */
	@RequestMapping(value = "/google/token.html", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> googleToken(
			@RequestParam(value = "credential", required = false) String credential, HttpServletRequest request,
			HttpServletResponse response, final Locale locale) {

		MerchantStore store = (MerchantStore) request.getAttribute(Constants.MERCHANT_STORE);
		Language language = super.getLanguage(request);

		if (store == null || !googleOAuthService.isConfigured(store)) {
			return errorResult("label.customer.google.error.notconfigured", locale);
		}

		if (StringUtils.isBlank(credential)) {
			LOGGER.debug("Google sign-in was called without a credential");
			return errorResult("label.customer.google.error.invalid", locale);
		}

		GoogleUser googleUser = googleOAuthService.verifyIdToken(store, credential);
		if (googleUser == null || StringUtils.isBlank(googleUser.getEmail())) {
			return errorResult("label.customer.google.error.failed", locale);
		}

		try {
			LoginOutcome outcome = this.loginOrRegister(googleUser, store, language, request, response);
			if (outcome.errorCode != null) {
				return errorResult(outcome.errorCode, locale);
			}

			Map<String, Object> result = new HashMap<String, Object>();
			result.put("success", Boolean.TRUE);
			result.put("redirect", request.getContextPath() + "/shop/customer/dashboard.html");
			return result;

		} catch (Exception e) {
			LOGGER.error("Error while signing in with Google", e);
			return errorResult("label.customer.google.error.failed", locale);
		}
	}

	/** Ket qua xu ly dang nhap, errorCode != null nghia la that bai. */
	private static class LoginOutcome {
		private final String errorCode;

		private LoginOutcome(String errorCode) {
			this.errorCode = errorCode;
		}

		private static LoginOutcome success() {
			return new LoginOutcome(null);
		}

		private static LoginOutcome failure(String errorCode) {
			return new LoginOutcome(errorCode);
		}
	}

	/**
	 * Dung chung cho ca hai luong: nguoi dung da ton tai thi dang nhap, chua co
	 * thi tao tai khoan moi (khong mat khau) roi dang nhap.
	 */
	private LoginOutcome loginOrRegister(GoogleUser googleUser, MerchantStore store, Language language,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String email = googleUser.getEmail().trim().toLowerCase(Locale.ROOT);

		Customer customer = customerFacade.getCustomerByUserName(email, store);

		if (customer == null) {
			customer = this.registerGoogleCustomer(googleUser, email, store, language);
			if (customer == null) {
				return LoginOutcome.failure("label.customer.google.error.failed");
			}
		}

		// dang nhap vao phien hien tai
		customerFacade.authenticateWithoutPassword(customer);
		super.setSessionAttribute(Constants.CUSTOMER, customer, request);
		response.addCookie(buildUserCookie(store, customer));
		this.mergeShoppingCart(customer, store, language, request, response);

		return LoginOutcome.success();
	}

	/**
	 * Tra ve thong bao loi da ban dia hoa theo ngon ngu cua nguoi dung de phia
	 * client hien thi.
	 */
	private Map<String, Object> errorResult(String messageCode, Locale locale) {
		String message = messages.getMessage(messageCode, locale);

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", Boolean.FALSE);
		result.put("message", message);
		return result;
	}

	/**
	 * Bat dau dang nhap bang Google: tao state va chuyen huong sang trang dong y
	 * cua Google.
	 */
	@RequestMapping(value = "/google/login.html", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response) throws Exception {

		MerchantStore store = (MerchantStore) request.getAttribute(Constants.MERCHANT_STORE);

		if (store == null || !googleOAuthService.isConfigured(store)) {
			LOGGER.debug("Google sign-in is not configured for this store");
			return "redirect:/shop/customer/logon.html?google_error=notconfigured";
		}

		String state = UUID.randomUUID().toString();
		request.getSession().setAttribute(SESSION_OAUTH_STATE, state);

		String authorizationUrl = googleOAuthService.buildAuthorizationUrl(store, callbackUrl(request), state);
		if (authorizationUrl == null) {
			return "redirect:/shop/customer/logon.html?google_error=notconfigured";
		}

		return "redirect:" + authorizationUrl;
	}

	/**
	 * Google tra ket qua ve day. Neu khach hang da ton tai thi dang nhap luon, neu
	 * chua thi tao tai khoan moi (khong co mat khau) roi dang nhap.
	 */
	@RequestMapping(value = "/google/callback.html", method = RequestMethod.GET)
	public String callback(@RequestParam(value = "code", required = false) String code,
			@RequestParam(value = "state", required = false) String state,
			@RequestParam(value = "error", required = false) String error, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		MerchantStore store = (MerchantStore) request.getAttribute(Constants.MERCHANT_STORE);
		Language language = super.getLanguage(request);

		if (StringUtils.isNotBlank(error)) {
			LOGGER.debug("Google sign-in was denied : {}", error);
			return "redirect:/shop/customer/logon.html?google_error=denied";
		}

		String sessionState = (String) request.getSession().getAttribute(SESSION_OAUTH_STATE);
		request.getSession().removeAttribute(SESSION_OAUTH_STATE);

		if (StringUtils.isBlank(code) || StringUtils.isBlank(state) || !state.equals(sessionState)) {
			LOGGER.debug("Invalid Google sign-in state or missing authorization code");
			return "redirect:/shop/customer/logon.html?google_error=invalid";
		}

		GoogleUser googleUser = googleOAuthService.getUser(store, code, callbackUrl(request));
		if (googleUser == null || StringUtils.isBlank(googleUser.getEmail())) {
			return "redirect:/shop/customer/logon.html?google_error=failed";
		}

		try {
			LoginOutcome outcome = this.loginOrRegister(googleUser, store, language, request, response);
			if (outcome.errorCode != null) {
				return "redirect:/shop/customer/logon.html?google_error=failed";
			}

			return "redirect:/shop/customer/dashboard.html";

		} catch (Exception e) {
			LOGGER.error("Error while signing in with Google", e);
			return "redirect:/shop/customer/logon.html?google_error=failed";
		}
	}

	/**
	 * Ma quoc gia mac dinh dung cho khach hang dang ky bang Google. Uu tien
	 * quoc gia cua cua hang, sau do toi quoc gia mac dinh cua he thong.
	 *
	 * Google khong tra ve dia chi, trong khi cot BILLING_COUNTRY_ID trong DB la
	 * NOT NULL, nen buoc nay la bat buoc de tao duoc khach hang.
	 */
	private String resolveDefaultCountryCode(MerchantStore store) {

		if (store != null && store.getCountry() != null && StringUtils.isNotBlank(store.getCountry().getIsoCode())) {
			return store.getCountry().getIsoCode();
		}

		return com.salesmanager.core.business.constants.Constants.DEFAULT_COUNTRY;
	}

	/**
	 * Tao tai khoan moi tu thong tin Google (khong co mat khau, dang nhap bang
	 * Google ma thoi).
	 */
	private Customer registerGoogleCustomer(GoogleUser googleUser, String email, MerchantStore store, Language language)
			throws Exception {
		SecuredShopPersistableCustomer newCustomer = new SecuredShopPersistableCustomer();
		newCustomer.setEmailAddress(email);
		newCustomer.setUserName(email);

		String firstName = googleUser.getFirstName();
		String lastName = googleUser.getLastName();
		if (StringUtils.isBlank(firstName)) {
			firstName = StringUtils.substringBefore(email, "@");
		}
		if (StringUtils.isBlank(lastName)) {
			lastName = firstName;
		}

		Address billing = new Address();
		billing.setFirstName(firstName);
		billing.setLastName(lastName);
		billing.setCountry(resolveDefaultCountryCode(store));
		newCustomer.setBilling(billing);
		newCustomer.setProvider("google");

		// Khach hang Google dang nhap bang Google, khong co mat khau that. Tuy
		// nhien CustomerPopulator chi set nick (dinh danh duoc getByNick dung de
		// dang nhap) khi co password. Neu de password trong, nick se la null va
		// khach hang khong the duoc tim thay sau khi dang ky.
		//
		// Vi vay sinh mot mat khau ngau nhien ma KHONG AI BIET va khong hien thi
		// o dau ca. Mat khau nay chi de thoa dieu kien cua populator; nguoi dung
		// khong the dang nhap bang form vi khong co cach nao biet duoc gia tri.
		newCustomer.setPassword(UserReset.generateRandomString());

		customerFacade.registerCustomer(newCustomer, store, language);

		Customer customer = customerFacade.getCustomerByUserName(email, store);
		if (customer == null) {
			LOGGER.error("Unable to load customer {} after Google registration", email);
		}
		return customer;
	}

	private void mergeShoppingCart(Customer customer, MerchantStore store, Language language,
			HttpServletRequest request, HttpServletResponse response) {

		try {
			String sessionShoppingCartCode = (String) request.getSession().getAttribute(Constants.SHOPPING_CART);
			if (StringUtils.isBlank(sessionShoppingCartCode)) {
				ShoppingCart cart = shoppingCartService.getShoppingCart(customer);
				if (cart != null) {
					request.getSession().setAttribute(Constants.SHOPPING_CART, cart.getShoppingCartCode());
				}
				return;
			}

			ShoppingCart shoppingCart = customerFacade.mergeCart(customer, sessionShoppingCartCode, store, language);
			if (shoppingCart != null) {
				request.getSession().setAttribute(Constants.SHOPPING_CART, shoppingCart.getShoppingCartCode());

				Cookie cartCookie = new Cookie(Constants.COOKIE_NAME_CART, shoppingCart.getShoppingCartCode());
				cartCookie.setMaxAge(COOKIE_MAX_AGE);
				cartCookie.setPath(Constants.SLASH);
				response.addCookie(cartCookie);
			}
		} catch (Exception e) {
			LOGGER.error("Cannot merge shopping cart for Google customer", e);
		}
	}

	private Cookie buildUserCookie(MerchantStore store, Customer customer) {
		StringBuilder cookieValue = new StringBuilder();
		cookieValue.append(store.getCode()).append("_").append(customer.getNick());

		Cookie cookie = new Cookie(Constants.COOKIE_NAME_USER, cookieValue.toString());
		cookie.setMaxAge(COOKIE_MAX_AGE);
		cookie.setPath(Constants.SLASH);
		return cookie;
	}

	private String callbackUrl(HttpServletRequest request) {
		return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ request.getContextPath() + "/shop/customer/google/callback.html";
	}
}