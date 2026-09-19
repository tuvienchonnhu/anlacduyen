package com.salesmanager.shop.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;


@Component
@Order(0)
public class XssFilter implements Filter {

	 /**
	  * Description: Log
	  */
	 private static final Logger LOGGER = LoggerFactory.getLogger(XssFilter.class);

	 @Override
	 public void init(FilterConfig filterConfig) throws ServletException {
	  LOGGER.debug("(XssFilter) initialize");
	 }

	 
	 @Override
	 public void doFilter(ServletRequest srequest, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {

	 		// This filter reads request parameters through XssHttpServletRequestWrapper.
	 		// Force UTF-8 before the first parameter is parsed; otherwise a container
	 		// using its default ISO-8859-1/Cp1252 encoding permanently turns Vietnamese
	 		// characters into '?'.
	 		srequest.setCharacterEncoding("UTF-8");
	 		response.setCharacterEncoding("UTF-8");

	 		HttpServletRequest request = (HttpServletRequest) srequest;
	 		filterChain.doFilter(new XssHttpServletRequestWrapper(request) {}, response);

	 }



	 @Override
	 public void destroy() {
	  LOGGER.debug("(XssFilter) destroy");
	 }

}
