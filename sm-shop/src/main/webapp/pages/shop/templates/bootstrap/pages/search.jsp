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
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm" %> 
 
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

 <script>
 	//server side rendered, bindings only
 	$(function(){
  	initBindings();
 	});
 </script>


	<div id="mainContent" class="container">

		<div id="shop" class="row">



        			<div class="col-md-9">

							<div class="row top-shop-option">
								<div class="col-sm-9 col-md-9">
									<strong><div id="products-qty">${fn:length(requestScope.products)} <s:message code="label.search.items.found" text="item(s) found" /></div></strong>
								</div>
							</div>


							<div class="row product-list">

							<!-- server side rendered products using productBox.jsp (same as exoticamobilia) -->
							<c:if test="${not empty requestScope.products}">
							<c:set var="ITEMS" value="${requestScope.products}" scope="request" />
							<c:remove var="FEATURED" scope="request" />
							<jsp:include page="/pages/shop/templates/bootstrap/sections/productBox.jsp" />
							</c:if>
							<c:if test="${empty requestScope.products}">
							<p><s:message code="label.search.noresults" text="No results found" /></p>
							</c:if>

							</div>

					</div><!-- /col-md-9 -->
        
        			<sidebar class="col-md-3">
        						<h3 id="categoryLabel"><s:message code="label.categories.title" text="Categories"/></h3>
        			            <ul id="categoriesFacets" class="nav nav-list"></ul>
        			</sidebar>
        

        
        </div><!-- row -->
        
      </div><!-- container -->
