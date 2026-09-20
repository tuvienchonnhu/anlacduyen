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

	<div id="shop" class="row-fluid">

	       		<!-- Categories: keep this column first so it appears at the upper-left. -->
	       		<div class="span3">
	       		<div class="sidebar-nav">
	<h3 id="categoryLabel"><s:message code="label.categories.title" text="Categories"/></h3>
	<ul id="categoriesFacets" class="nav nav-list">
	<c:forEach items="${requestScope.categoryFacets}" var="facet">
	<c:if test="${facet.visible}">
	<li><a href="<c:url value="/shop/category/${facet.description.friendlyUrl}.html"/><sm:breadcrumbParam categoryId="${facet.id}"/>"><c:out value="${facet.description.name}"/> <c:if test="${facet.productCount > 0}">(<c:out value="${facet.productCount}"/>)</c:if></a></li>
	</c:if>
	</c:forEach>
	</ul>
	</div>
	       		</div><!-- /span3 -->

	       		<div class="span9">

	<div class="row-fluid top-shop-option">
	<div class="span9">
	<strong><div id="products-qty">${fn:length(requestScope.products)} <s:message code="label.search.items.found" text="item(s) found" /></div></strong>
	</div>
	</div>

	<div class="row-fluid product-list">

	<!-- server side rendered products using productBox.jsp -->
	<c:if test="${not empty requestScope.products}">
	<c:set var="ITEMS" value="${requestScope.products}" scope="request" />
	<c:remove var="FEATURED" scope="request" />
	<jsp:include page="/pages/shop/templates/bootstrap/sections/productBox.jsp" />
	</c:if>
	<c:if test="${empty requestScope.products}">
	<p><s:message code="label.search.noresults" text="No results found" /></p>
	</c:if>

	</div>
	</div><!-- /span9 -->

	       </div><!-- row-fluid -->

	     </div><!-- container -->
