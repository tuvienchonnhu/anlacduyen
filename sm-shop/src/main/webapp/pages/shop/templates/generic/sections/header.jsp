<%
response.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm" %>
<%@ taglib uri="/WEB-INF/shopizer-functions.tld" prefix="display" %> 
 
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<script src="<c:url value="/resources/js/hogan.js" />"></script>
<script src="<c:url value="/resources/templates/generic/js/bloodhound.min.js" />"></script>
<script src="<c:url value="/resources/templates/generic/js/typeahead.bundle.min.js" />"></script>


<!-- Customer account menu logged in customer will display in customerAccount placeholder -->
<script type="text/html" id="customerLoggedInAccountTemplate">
			<ul>
				<li class="click_menu"><a href="#"><s:message code="label.generic.welcome" text="Welcome" /> <span>{{firstName}}</span><i class="fa fa-angle-down"></i></a>
					<ul class="click_menu_show">
						<li><a href="#" onClick="javascript:location.href='<c:url value="/shop/customer/dashboard.html" />';" href="#"><s:message code="label.customer.myaccount" text="My account"/></a></li>
						<li><a href="#" onClick="javascript:location.href='<c:url value="/shop/customer/logout" />';" href="#"><s:message code="button.label.logout" text="Logout"/></a></li>
					</ul>
				</li>
			</ul>
			<script type="text/javascript">
                (function($) {
    			$(".click_menu").on('click', function() {
        			$(".click_menu_show").slideToggle(400)
    			});
                })(jQuery);
			</script>
</script>

<!-- Customer account menu not logged in customer will display in customerAccount placeholder -->
<script type="text/html" id="customerNotLoggedInAccountTemplate">
			<ul>
				<li class="click_menu"><a href="#"><s:message code="label.customer.myaccount" text="My Account"/><i class="fa fa-angle-down"></i></a>
					<ul class="click_menu_show">
						<li><a href="#" id="registerLink" onClick="javascript:location.href='<c:url value="/shop/customer/registration.html" />';"><s:message code="label.generic.register" text="Register" /></a></li>
						<li><a href="#" id="registerLink" onClick="javascript:location.href='<c:url value="/shop/customer/customLogon.html" />';"><s:message code="button.label.signin" text="Signin" /></a></li>
					</ul>
				</li>
			</ul>
			<script type="text/javascript">
                (function($) {
    			$(".click_menu").on('click', function() {
        			$(".click_menu_show").slideToggle(400)
    			});
                })(jQuery);
			</script>
</script>

<!-- Mini shopping cart JS template -->
<script type="text/html" id="miniCartTemplate">
                          {{#code}}
                          {{#shoppingCartItems}}
                          <li>
									<div class="cart-img">
											{{#image}}
												<img src="<c:out value="${pageContext.servletContext.contextPath}" />{{image}}">
											{{/image}}
											{{^image}}
												&nbsp;
											{{/image}}
									</div>	
									<div class="cart-content">
											<h4><a href="#">{{quantity}} x {{name}}</a></h4>
											<span class="cart-price">{{price}}</span>
									</div>
									<div class="cart-del">
											<button productid="{{productId}}" class="close removeProductIcon" onclick="removeItemFromMinicart('{{id}}')"><i class="fa fa-times-circle"></i></a>
									</div>			
							</li>
                            {{/shoppingCartItems}}
                            <li>&nbsp;</li>
							<li class="total-price"><s:message code="label.order.total" text="Total" />&nbsp;{{total}}</li>
							<li class="checkout-bg">
									<a href="#" onclick="viewShoppingCartPage();"><s:message code="label.checkout" text="Checkout"/><i class="fa fa-angle-right"></i></a>
							</li>
                            {{/code}}
							{{^code}}
							<h4 style="text-align: center;color:#666666;margin-top:10px;margin-bottom:10px;"><s:message code="label.emptycart" text="Your Shopping cart is empty" /></h4>
						    {{/code}}

</script>

<!-- mini cart label button template -->
<script type="text/html" id="miniCartSummaryTemplate">
		<!-- empty cart and full summary subTotal & quantity -->
		{{^code}}
		<a href="#"><span class="lnr lnr-cart"></span><s:message code="label.cart" text="Shopping cart"/> (0)</a>
		{{/code}}
		{{#code}}
		<a href="#"><span class="lnr lnr-cart"></span><s:message code="label.cart" text="Shopping cart"/> <font color="red"><strong>({{quantity}})</strong></font></a>
		{{/code}}
</script>


<!-- header-start -->
		<header>
			<div class="header-top-area ptb-10 hidden-xs">
				<div class="container">
					<div class="row">
						<div class="col-lg-9 col-md-8 col-sm-8">
						    <c:if test="${fn:length(requestScope.MERCHANT_STORE.languages) > 1}">
							<!-- switch language -->
							<div class="btn-group dropdown">
								<!-- For this template only french and english supported, if required build a dropdown list with all languages -->
								<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
									<i class="fa fa-gear no-desktop">
									</i>
									<span class="no-responsive"><s:message code="label.generic.language" text="Language"/>
									</span>
								</button>
								<ul class="dropdown-menu dropdown-menu-right dropdown-animation">
									<c:forEach items="${requestScope.MERCHANT_STORE.languages}" var="language">
									<li><a href="<c:url value="/shop?locale=${language.code}"/>"><s:message code="lang.${language.code}" text="${language.code}" /></a></li>
									</c:forEach>
								</ul>
							</div> 
							</c:if>
							<c:if test="${requestScope.CONFIGS['displayCustomerSection'] == true}">
							<!-- placeholder for customer account -->
							<div class="header-top-left" id="customerAccount" style="margin-left:20px;"></div>
							</c:if>
							<c:if test="${requestScope.CONFIGS['displayContactUs']==true}">
							<button class="btn btn-default header-left-menu type="button" onClick="javascript:location.href='<c:url value="/shop/store/contactus.html"/>';" aria-haspopup="true" aria-expanded="true">
								<a href="<c:url value="/shop/store/contactus.html"/>"><s:message code="label.customer.contactus" text="Contact us"/></a>
							</button>
							</c:if>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-4">
							<div class="header-top-right">
							<!-- Empty placeholder -->
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="header-bottom-area ptb-10">
				<div class="container">
					<div class="row">
						<div class="col-lg-4 col-md-2 col-sm-3 col-xs-12">
						    <!-- logo -->
							<div class="logo">
								<c:choose>
									<c:when test="${requestScope.CONTENT['logo']!=null}">
										<!-- A content logo exist -->
										<sm:pageContent contentCode="logo"/>
									</c:when>
									<c:otherwise>
										<c:choose>
						                		<c:when test="${not empty requestScope.MERCHANT_STORE.storeLogo}">
						                			<!--  use merchant store logo -->
						                			<a class="grey store-name" href="<c:url value="/shop/"/>">
						                			<img class="logoImage" src="<sm:storeLogo/>"/>
						                			</a>
						                		</c:when>
						                		<c:otherwise>
						                			<!-- Use store name -->
						                			<h1>
						                			<a class="grey store-name" href="<c:url value="/shop/"/>">
						                				<c:out value="${requestScope.MERCHANT_STORE.storename}"/>
						                			</a>  
						                			</h1>
						                		</c:otherwise>
						                </c:choose>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="col-lg-4 col-md-5 hidden-sm hidden-xs">
						
							<c:if test="${requestScope.CONTENT['headerMessage']!=null}">
									<!-- A content logo exist -->
									<sm:pageContent contentCode="headerMessage"/>
							</c:if>
						
							<!--
							<div class="single-header-bottom-info">
								<div class="header-bottom-icon">
									<span class="lnr lnr-rocket"></span>
								</div>
								<div class="header-bottom-text">
								</div>
							</div>
							-->
						</div>
						<div class="col-lg-4 col-md-4 col-sm-9 col-xs-12">
						    <!-- search box -->
		                    <c:if test="${requestScope.CONFIGS['displaySearchBox'] == true}">

							<div class="input-group menu-search-box">
								<input type="text" class="form-control typeahead" type="search" name="q" id="searchField" placeholder="<s:message code="label.generic.search" text="Search"/>" value="" />
								<span class="input-group-btn">
									<button class="btn btn-default" id="searchButton" type="button" onclick="submitSearch()"><s:message code="label.generic.search" text="Search"/></button>
								</span>
								<!-- important for submitting search -->
								<form id="hiddenSearchForm" method="post" action="<c:url value="/shop/search/search.html"/>">
									<input type="hidden" id="hiddenQuery" name="q">
								</form>
							</div>

							<!-- ThÃªm Script xá»­ lÃ½ sá»± kiá»‡n Enter vÃ  Click -->
							<script type="text/javascript">
								function submitSearch() {
									var query = $('#searchField').val();
									if (query && query.trim() !== '') {
										$('#hiddenQuery').val(query.trim());
										$('#hiddenSearchForm').submit();
									}
								}

								$(document).ready(function() {
									$('#searchField').on('keypress', function(e) {
										// Kiá»ƒm tra náº¿u phÃ­m báº¥m lÃ  Enter (mÃ£ phÃ­m 13)
										if (e.which === 13 || e.keyCode === 13) {
											e.preventDefault(); // NgÄƒn hÃ nh vi submit form máº·c Ä‘á»‹nh (náº¿u cÃ³)
											submitSearch();
										}
									});
								});
							</script>

							</c:if>
						    <!-- Shopping cart -->
						    <c:if test="${requestScope.CONFIGS['allowPurchaseItems'] == true}">						    						
								<div class="header-bottom-right">
									<div class="shop-cart" id="miniCartSummary"></div>
									<div class="shop-cart-hover fix">
									<ul id="miniCartDetails"></ul>
									</div>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</header>
		<!-- header-end -->