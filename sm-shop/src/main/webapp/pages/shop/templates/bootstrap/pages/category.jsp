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
 
 <script src="<c:url value="/resources/js/jquery.easing.1.3.js" />"></script>
 <script src="<c:url value="/resources/js/jquery.quicksand.js" />"></script>
 <script src="<c:url value="/resources/js/jquery-sort-filter-plugin.js" />"></script>


 
 <script>
 
 var START_COUNT_PRODUCTS = 0;
 var MAX_PRODUCTS = 16;
 var filter = null;
 var filterValue = null;
 // danh muc dang duoc chon (mac dinh la danh muc cua trang)
 var currentCategory = '<c:out value="${category.description.friendlyUrl}"/>';
 var currentCategoryName = '<c:out value="${category.description.name}"/>';

 $(function(){
	
	$('#filter').on('change', function() {
	    var orderBy = getOrderBy();
	    orderProducts(orderBy);
	});
	 
	loadCategoryProducts();

 });
 
 
	<jsp:include page="/pages/shop/templates/bootstrap/sections/shop-listing.jsp" />
	 
	  
	function orderProducts(attribute) {
		
		
		  if(attribute=='item-order') {
			  return;
		  }
		
		  // get the first collection
		  var $prods = $('#productsContainer');

		  // clone applications to get a second collection
		  var $data = $prods.clone();
		  
		  var $filteredData = $data.find('li');
	      var $sortedData = $filteredData.sorted({
		        by: function(v) {
		        	if(attribute=='item-price') {
		        		return parseFloat($(v).attr(attribute));
		        	} else {
		        		return $(v).attr(attribute);
		        	}
		        }
		  });

		  // finally, call quicksand
		  $prods.quicksand($sortedData, {
		      duration: 800,
		      easing: 'easeInOutQuad'
		  });
		
		
	}
 
 	function loadCategoryProducts() {
 		var url = '<%=request.getContextPath()%>/services/public/products/page/' + START_COUNT_PRODUCTS + '/' + MAX_PRODUCTS + '/<c:out value="${requestScope.MERCHANT_STORE.code}"/>/<c:out value="${requestScope.LANGUAGE.code}"/>/' + currentCategory;

 		if(filter!=null) {
 			url = url + '/filter=' + filter + '/filter-value=' + filterValue +'';
 		}
 		loadProducts(url,'#productsContainer');
 	}

 	// Nguoi dung bam chon mot danh muc o cot ben trai:
 	// thay vi tai lai toan bo trang, chi tai lai danh sach san pham vao cot ben phai.
 	function selectCategory(friendlyUrl, name, categoryId) {
 		// bo qua neu dang o dung danh muc do
 		if(friendlyUrl == currentCategory) {
 			return false;
 		}

 		// dat lai trang thai de tai danh muc moi
 		currentCategory = friendlyUrl;
 		currentCategoryName = name;
 		filter = null;
 		filterValue = null;
 		START_COUNT_PRODUCTS = 0;

 		$('#productsContainer').html('');
 		$('#button_nav').hide();

 		// cap nhat tieu de danh muc dang xem o cot ben phai
 		$('#categoryName').html(name);

 		// danh dau danh muc dang duoc chon trong danh sach ben trai
 		$('.category-item').removeClass('active');
 		$('.category-item[data-friendly-url="' + friendlyUrl + '"]').addClass('active');

 		// tai san pham cua danh muc vua chon vao cot ben phai
 		loadCategoryProducts();

 		return false;
 	}
 	
 	function filterCategory(filterType,filterVal) {
	 		//reset product section
	 		$('#productsContainer').html('');
	 		START_COUNT_PRODUCTS = 0;
	 		filter = filterType;
	 		filterValue = filterVal;
	 		loadCategoryProducts();
 	}
 
	function callBackLoadProducts(productList) {
			totalCount = productList.productCount;
			START_COUNT_PRODUCTS = START_COUNT_PRODUCTS + MAX_PRODUCTS;
			if(START_COUNT_PRODUCTS < totalCount) {
					$("#button_nav").show();
			} else {
					$("#button_nav").hide();
			}
			hideSMLoading('#productsContainer');
			
			//check option
			var orderBy = getOrderBy();
			orderProducts(orderBy);
			
			var productQty = productList.productCount + ' <s:message code="label.search.items.found" text="item(s) found" />';
			$('#products-qty').html(productQty);

	}
	
	function getOrderBy() {
		var orderBy = $("#filter").val();
		return orderBy;
	}
 
 
 
 
</script>

       <jsp:include page="/pages/shop/templates/bootstrap/sections/breadcrumb.jsp" />
 
	   <c:if test="${not empty category.description.description}">
	   		<!-- category description -->
		   	<div class="row-fluid category-description">
		   		<c:out value="${category.description.description}" escapeXml="false"/>
		   	</div>
	   
	   </c:if>

	<div class="row-fluid">
	
	
	   <div class="span12">
	   
	   <%-- Chi hien thi cot ben trai khi danh muc co danh muc con hoac co thuong hieu --%>
	   <c:set var="hasSidebar" value="${not empty subCategories or fn:length(manufacturers) > 0}" />



      	<c:if test="${hasSidebar}">
      	<!-- left column -->
        <div class="span3">
          <div class="sidebar-nav">


            <br/>

            <ul class="nav nav-list">
              <c:if test="${parent!=null}">
              	<li class="nav-header"><c:out value="${parent.description.name}" /></li>
              </c:if>
              <c:forEach items="${subCategories}" var="subCategory">
              	<li class="category-item" data-friendly-url="${subCategory.description.friendlyUrl}">
              		<a href="javascript:void(0)" onclick="return selectCategory('${subCategory.description.friendlyUrl}', '<c:out value="${fn:escapeXml(subCategory.description.name)}"/>', '${subCategory.id}');"><c:out value="${subCategory.description.name}" />
              			<c:if test="${subCategory.productCount>0}">&nbsp;<span class="countItems">(<c:out value="${subCategory.productCount}" />)</span></c:if></a></li>
              </c:forEach>
            </ul>
          </div>

          <c:if test="${fn:length(manufacturers) > 0}">
          <br/>
          <div class="sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header"><s:message code="label.manufacturer.brand" text="Brands" /></li>
              <c:forEach items="${manufacturers}" var="manufacturer">
              	<li>
              		<a href="javascript:filterCategory('BRAND','${manufacturer.id}')"><c:out value="${manufacturer.description.name}" /></a></li>
              </c:forEach>
            </ul>
          </div>
          </c:if>


        </div><!--/span-->
        </c:if>

        <!-- right column: neu khong co cot ben trai thi san pham chiem toan bo chieu rong -->
        <c:choose>
        	<c:when test="${hasSidebar}">
        	<div class="span9">
        	</c:when>
        	<c:otherwise>
        	<div class="span12">
        	</c:otherwise>
        </c:choose>
        <p class="lead" id="categoryName"><c:out value="${category.description.name}" /></p>
        <div class="products-title row-fluid">
    		<div class="span6">
        		<p><div id="products-qty"></div></p>
    		</div>
		    <div class="span6">
		        <div class="pull-right">
		            <p>
		            <ul class="nav nav-list">
	            		<li class="widget-header"><s:message code="label.generic.sortby" text="Sort by" />:
						<select id="filter">
							<option value="item-order"><s:message code="label.generic.default" text="Default" /></option>
							<option value="item-name"><s:message code="label.generic.name" text="Name" /></option>
							<option value="item-price"><s:message code="label.generic.price" text="Price" /></option>
						</select>
						</li>
					</ul>
		            </p>
		        </div>
		    </div>
		 </div>
        
        
			<!-- just copy that block for havimg products displayed -->
          	<!-- products are loaded by ajax -->
        	<ul id="productsContainer" class="thumbnails product-list"></ul>
			
			<nav id="button_nav" style="text-align:center;display:none;">
				<button class="btn btn-large" style="width:400px;" onClick="loadCategoryProducts();"><s:message code="label.product.moreitems" text="Display more items" />...</button>
			</nav>
			<span id="end_nav" style="display:none;"><s:message code="label.product.nomoreitems" text="No more items to be displayed" /></span>
          	<!-- end block -->
          
        </div><!--/span-->
        
        </div><!-- 12 -->
        
      </div><!-- row fluid -->