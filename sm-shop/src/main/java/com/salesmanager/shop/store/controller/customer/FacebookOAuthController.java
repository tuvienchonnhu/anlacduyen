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
import com.salesmanager.shop.store.controller.customer.FacebookOAuthService.FacebookUser;
import com.salesmanager.shop.store.controller.customer.facade.CustomerFacade;
import com.salesmanager.shop.utils.LabelUtils;

/**
 * Dang nhap / dang ky bang tai khoan Facebook (OAuth 2.0 authorization code).
 *
 * App ID va App Secret duoc cau hinh trong Admin > Configuration > Login
 * Configuration. Valid OAuth Redirect URI can khai bao trong Facebook Console
 * la:
 * {context}/shop/customer/facebook/callback.html
 */
@Controller
@RequestMapping("/shop/customer")
public class FacebookOAuthController extends AbstractController {

	private static final Logger LOGGER = LoggerFactory.getLogger(FacebookOAuthController.class);

	/** Ten attribute luu state chong CSRF trong session. */
	private static final String SESSION_OAUTH_STATE = "FACEBOOK_OAUTH_STATE";

	private static final int COOKIE_MAX_AGE = 60 * 24 * 3600;

	@Inject
	private FacebookOAuthService facebookOAuthService;

	@Inject
	private CustomerFacade customerFacade;

	@Inject
	private ShoppingCartService shoppingCartService;

	@Inject
	private LabelUtils messages;

	/**
	 * Dua cau hinh Facebook (App ID + ma ngon ngu) vao model de fragment
	 * facebookSignIn.jsp hien thi nut dang nhap.
	 */
	public void setFacebookLoginAttributes(Model model, MerchantStore store) {
		model.addAttribute("facebookLoginEnabled", facebookOAuthService.isConfigured(store));
		model.addAttribute("facebookAppId", facebookOAuthService.getAppId(store));
		model.addAttribute("facebookLocale", resolveFacebookLocale());
	}

	/**
	 * Lay ma ngon ngu cua Facebook (dang "vi_VN", "fr_FR") tu locale hien tai.
	 * Mac dinh la "en_US" neu chua xac dinh duoc.
	 */
	private String resolveFacebookLocale() {
		try {
			Locale locale = LocaleContextHolder.getLocale();
			if (locale != null && StringUtils.isNotBlank(locale.getLanguage())) {
				String language = locale.getLanguage();
				String country = StringUtils.isNotBlank(locale.getCountry()) ? locale.getCountry()
						: language.toUpperCase(Locale.ROOT);
				return language + "_" + country;
			}
		} catch (Exception e) {
			LOGGER.debug("Cannot resolve locale for Facebook sign-in button", e);
		}
		return "en_US";
	}

	/**
	 * Bat dau dang nhap bang Facebook: tao state va chuyen huong sang trang dong y
	 * cap quyen cua Facebook.
	 */
	@RequestMapping(value = "/facebook/login.html", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response) throws Exception {

		MerchantStore store = (MerchantStore) request.getAttribute(Constants.MERCHANT_STORE);

		if (store == null || !facebookOAuthService.isConfigured(store)) {
			LOGGER.debug("Facebook sign-in is not configured for this store");
			return "redirect:/shop/customer/logon.html?facebook_error=notconfigured";
		}

		String state = UUID.randomUUID().toString();
		request.getSession().setAttribute(SESSION_OAUTH_STATE, state);

		String authorizationUrl = facebookOAuthService.buildAuthorizationUrl(store, callbackUrl(request), state);
		if (authorizationUrl == null) {
			return "redirect:/shop/customer/logon.html?facebook_error=notconfigured";
		}

		return "redirect:" + authorizationUrl;
	}

	/**
	 * Facebook tra ket qua ve day. Neu khach hang da ton tai thi dang nhap luon,
	 * neu chua thi tao tai khoan moi (khong co mat khau) roi dang nhap.
	 */
	@RequestMapping(value = "/facebook/callback.html", method = RequestMethod.GET)
	public String callback(@RequestParam(value = "code", required = false) String code,
			@RequestParam(value = "state", required = false) String state,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "error_reason", required = false) String errorReason, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		MerchantStore store = (MerchantStore) request.getAttribute(Constants.MERCHANT_STORE);
		Language language = super.getLanguage(request);

		if (StringUtils.isNotBlank(error) || StringUtils.isNotBlank(errorReason)) {
			LOGGER.debug("Facebook sign-in was denied : {} / {}", error, errorReason);
			return "redirect:/shop/customer/logon.html?facebook_error=denied";
		}

		String sessionState = (String) request.getSession().getAttribute(SESSION_OAUTH_STATE);
		request.getSession().removeAttribute(SESSION_OAUTH_STATE);

		if (StringUtils.isBlank(code) || StringUtils.isBlank(state) || !state.equals(sessionState)) {
			LOGGER.debug("Invalid Facebook sign-in state or missing authorization code");
			return "redirect:/shop/customer/logon.html?facebook_error=invalid";
		}

		FacebookUser facebookUser = facebookOAuthService.getUser(store, code, callbackUrl(request));
		if (facebookUser == null || StringUtils.isBlank(facebookUser.getEmail())) {
			// Facebook chi tra ve email khi nguoi dung da xac minh va cap quyen email.
			LOGGER.debug("Facebook sign-in did not return an email address");
			return "redirect:/shop/customer/logon.html?facebook_error=failed";
		}

		try {
			LoginOutcome outcome = this.loginOrRegister(facebookUser, store, language, request, response);
			if (outcome.errorCode != null) {
				return "redirect:/shop/customer/logon.html?facebook_error=failed";
			}

			return "redirect:/shop/customer/dashboard.html";

		} catch (Exception e) {
			LOGGER.error("Error while signing in with Facebook", e);
			return "redirect:/shop/customer/logon.html?facebook_error=failed";
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
	private LoginOutcome loginOrRegister(FacebookUser facebookUser, MerchantStore store, Language language,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String email = facebookUser.getEmail().trim().toLowerCase(Locale.ROOT);

		Customer customer = customerFacade.getCustomerByUserName(email, store);

		if (customer == null) {
			customer = this.registerFacebookCustomer(facebookUser, email, store, language);
			if (customer == null) {
				return LoginOutcome.failure("label.customer.facebook.error.failed");
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
	 * Ma quoc gia mac dinh dung cho khach hang dang ky bang Facebook. Uu tien
	 * quoc gia cua cua hang, sau do toi quoc gia mac dinh cua he thong.
	 *
	 * Facebook khong tra ve dia chi, trong khi cot BILLING_COUNTRY_ID trong DB la
	 * NOT NULL, nen buoc nay la bat buoc de tao duoc khach hang.
	 */
	private String resolveDefaultCountryCode(MerchantStore store) {

		if (store != null && store.getCountry() != null && StringUtils.isNotBlank(store.getCountry().getIsoCode())) {
			return store.getCountry().getIsoCode();
		}

		return com.salesmanager.core.business.constants.Constants.DEFAULT_COUNTRY;
	}

	/**
	 * Tao tai khoan moi tu thong tin Facebook (khong co mat khau, dang nhap bang
	 * Facebook ma thoi).
	 */
	private Customer registerFacebookCustomer(FacebookUser facebookUser, String email, MerchantStore store,
			Language language) throws Exception {

		SecuredShopPersistableCustomer newCustomer = new SecuredShopPersistableCustomer();
		newCustomer.setEmailAddress(email);
		newCustomer.setUserName(email);

		String firstName = facebookUser.getFirstName();
		String lastName = facebookUser.getLastName();
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
		newCustomer.setProvider("facebook");

		// Khach hang Facebook dang nhap bang Facebook, khong co mat khau that. Tuy
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
			LOGGER.error("Unable to load customer {} after Facebook registration", email);
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
			LOGGER.error("Cannot merge shopping cart for Facebook customer", e);
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
				+ request.getContextPath() + "/shop/customer/facebook/callback.html";
	}
}