package com.salesmanager.shop.filter;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.salesmanager.core.business.services.merchant.MerchantStoreService;
import com.salesmanager.core.business.services.reference.language.LanguageService;
import com.salesmanager.core.business.services.user.UserService;
import com.salesmanager.core.business.utils.CacheUtils;
import com.salesmanager.core.model.merchant.MerchantStore;
import com.salesmanager.core.model.reference.language.Language;
import com.salesmanager.core.model.user.User;
import com.salesmanager.shop.admin.model.web.Menu;
import com.salesmanager.shop.constants.Constants;
import com.salesmanager.shop.utils.LanguageUtils;


public class AdminFilter extends HandlerInterceptorAdapter {
	

	private static final Logger LOGGER = LoggerFactory.getLogger(AdminFilter.class);
	
	@Inject
	private MerchantStoreService merchantService;
	
	@Inject
	private UserService userService;

	@Inject
	private CacheUtils cache;
	
	@Inject
	private LanguageUtils languageUtils;
	
	public boolean preHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		@SuppressWarnings("unchecked")
		Map<String,Menu> menus = (Map<String,Menu>) cache.getFromCache("MENUMAP");
		
			HttpSession session = request.getSession();
		User user = (User)session.getAttribute(Constants.ADMIN_USER);
		MerchantStore store = (MerchantStore)session.getAttribute(Constants.ADMIN_STORE);
		String userName = request.getRemoteUser();
		String storeCode = MerchantStore.DEFAULT_STORE;

		if(userName==null) {//** IMPORTANT FOR SPRING SECURITY **//
		// Spring Security handles the unauthenticated request.
		} else {
		// Never trust a user cached in the session when the authenticated
		// username is different. This can happen after logging in with a
		// second admin account in the same browser session and previously
		// caused ADMIN_CATALOGUE to be displayed as ADMIN.
		if(user==null || !userName.equals(user.getAdminName())) {
		user = userService.getByUserName(userName);
		if(user==null) {
		LOGGER.warn("User name not found " + userName);
		response.sendRedirect(request.getContextPath() + "/admin/unauthorized.html");
		return true;
		}
			session.setAttribute(Constants.ADMIN_USER, user);
		store = null;
		}

		if(user.getMerchantStore()!=null) {
		storeCode = user.getMerchantStore().getCode();
		}
		}

		if(store==null || (user!=null && user.getMerchantStore()!=null
		&& !user.getMerchantStore().getCode().equals(store.getCode()))) {
				store = merchantService.getByCode(storeCode);
				session.setAttribute(Constants.ADMIN_STORE, store);
		}
		request.setAttribute(Constants.ADMIN_STORE, store);
		
		
		Language language = languageUtils.getRequestLanguage(request, response);

		if(language==null) {
			
			//TODO get the Locale from Spring API, is it simply request.getLocale() ???
			//if so then based on the Locale language locale.getLanguage() get the appropriate Language
			//object as represented below
			if(user!=null) {
				language = user.getDefaultLanguage();
				if(language==null) {
					language = store.getDefaultLanguage();
				}
			} else {
				language = store.getDefaultLanguage();
			}

			request.getSession().setAttribute("LANGUAGE", language);

		}
		

		request.setAttribute(Constants.LANGUAGE, language);
		

		if(menus==null) {
			InputStream in = null;
			ObjectMapper mapper = new ObjectMapper(); // can reuse, share globally
			try {
				in =
					(InputStream) this.getClass().getClassLoader().getResourceAsStream("admin/menu.json");

				Map<String,Object> data = mapper.readValue(in, Map.class);

				Menu currentMenu = null;
				
				menus = new LinkedHashMap<String,Menu>();
				List objects = (List)data.get("menus");
				for(Object object : objects) {
					Menu m = getMenu(object);
					menus.put(m.getCode(),m);
				}

				cache.putInCache(menus,"MENUMAP");

			} catch (JsonParseException e) {
				LOGGER.error("Error while creating menu", e);
			} catch (JsonMappingException e) {
				LOGGER.error("Error while creating menu", e);
			} catch (IOException e) {
				LOGGER.error("Error while creating menu", e);
			} finally {
				if(in !=null) {
					try {
						in.close();
					} catch (Exception ignore) {
						// TODO: handle exception
					}
				}
			}
		
		} 
		
		
		List<Menu> list = new ArrayList<Menu>(menus.values());

		request.setAttribute("MENULIST", list);

		request.setAttribute("MENUMAP", menus);
		response.setCharacterEncoding("UTF-8");
		
		return true;
	}
	
	
	private Menu getMenu(Object object) {
		
		Map o = (Map)object;
		Map menu = (Map)o.get("menu");
		
		Menu m = new Menu();
		m.setCode((String)menu.get("code"));
		
		
		m.setUrl((String)menu.get("url"));
		m.setIcon((String)menu.get("icon"));
		m.setRole((String)menu.get("role"));
		
		List menus = (List)menu.get("menus");
		if(menus!=null) {
			for(Object oo : menus) {
				
				Menu mm = getMenu(oo);
				m.getMenus().add(mm);
			}
			
		}
		
		return m;
		
	}

}
