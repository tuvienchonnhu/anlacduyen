<% response.setCharacterEncoding("UTF-8"); response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache"); response.setDateHeader ("Expires", -1); %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
			<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
				<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
					<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm" %>

						<%@page contentType="text/html" %>
							<%@page pageEncoding="UTF-8" %>

								<%-- Trang dang nhap danh rieng (customer logon) cho cac template khong co ban rieng:
									bootstrap, exoticamobilia. Truoc day tiles dinh nghia "customerLogon.*" tro toi
									/pages/shop/common/customer/logon.jsp nhung file nay KHONG TON TAI, nen truy cap
									/shop/customer/customLogon.html tra ve loi 500 "JSP file [...] not found" va toan bo
									trang (ke ca header) bi trang. Template nao co ban rieng (generic, december) se duoc
									tiles override bang dinh nghia "customerLogon.<template>" .
									Nut "Dang nhap bang Google" duoc nhung qua fragment googleSignIn.jsp cua tung
									template; fragment nay doc cau hinh tu requestScope.CONFIGS['GOOGLE_CLIENT_ID'] nen
									hoat dong ca khi doi ngon ngu. --%>

									<div class="container" style="padding-top: 30px; padding-bottom: 50px;">
										<div class="row">

											<!-- Khach hang da dang ky -->
											<div class="span6 col-md-6 col-sm-6 col-xs-12">
												<h3>
													<s:message code="label.customer.registered"
														text="Registered customer" />
												</h3>
												<p>
													<s:message code="label.customer.registered.signinemail"
														text="If you have an account, sign in with your email address" />
													.
												</p>

												<div id="login-form" class="login-form">
													<form id="login" method="post" accept-charset="UTF-8">
														<div id="loginError" class="alert alert-error"
															style="display:none;"></div>

														<div class="control-group">
															<label for="signin_userName">
																<s:message code="label.generic.username"
																	text="User name" />
															</label>
															<div class="controls">
																<input class="form-control" id="signin_userName"
																	type="text" name="userName" size="30" />
															</div>
														</div>

														<div class="control-group">
															<label for="signin_password">
																<s:message code="label.generic.password"
																	text="Password" />
															</label>
															<div class="controls">
																<input class="form-control" id="signin_password"
																	type="password" name="password" size="30" />
															</div>
														</div>

														<input id="signin_storeCode" name="storeCode" type="hidden"
															value="<c:out value="
															${requestScope.MERCHANT_STORE.code}" />"/>

														<button id="login-button" type="submit" class="btn btn-large">
															<s:message code="button.label.login" text="Login" />
														</button>
													</form>

													<!-- Nut dang nhap bang Google: fragment rieng cua tung template -->
													<c:set var="googleSignInFragment"
														value="/pages/shop/templates/${requestScope.MERCHANT_STORE.storeTemplate}/pages/googleSignIn.jsp" />
													<c:choose>
														<c:when
															test="${requestScope.MERCHANT_STORE.storeTemplate == 'bootstrap'}">
															<jsp:include
																page="/pages/shop/templates/bootstrap/pages/googleSignIn.jsp" />
														</c:when>
														<c:when
															test="${requestScope.MERCHANT_STORE.storeTemplate == 'exoticamobilia'}">
															<jsp:include
																page="/pages/shop/templates/exoticamobilia/pages/googleSignIn.jsp" />
														</c:when>
														<c:when
															test="${requestScope.MERCHANT_STORE.storeTemplate == 'december'}">
															<jsp:include
																page="/pages/shop/templates/december/pages/googleSignIn.jsp" />
														</c:when>
														<c:otherwise>
															<jsp:include
																page="/pages/shop/templates/generic/pages/googleSignIn.jsp" />
														</c:otherwise>
													</c:choose>

													<p style="margin-top: 15px;">
														<a id="registerLink" href="<c:url value="
															/shop/customer/registration.html" />">
														<s:message code="label.register.notyetregistered"
															text="Not yet registered ?" />
														</a>
													</p>
												</div>
											</div>

											<!-- Khach hang moi -->
											<div class="span5 col-md-5 col-sm-5 col-xs-12">
												<h3>
													<s:message code="label.customer.new" text="New customer" />
												</h3>
												<p>
													<s:message code="label.customer.faster"
														text="Creating an account has many benefits: check out faster, keep more than one address, track orders and more." />
												</p>
												<a class="btn btn-large" href="<c:url value="
													/shop/customer/registration.html" />">
												<s:message code="button.label.register" text="Register" />
												</a>
											</div>

										</div>
									</div>