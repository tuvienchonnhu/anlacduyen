<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>
<div class="tabbable">
   <jsp:include page="/common/adminTabs.jsp" />
	<div class="tab-content">
		<div class="tab-pane active" id="catalogue-section">
           <div class="sm-ui-component">
           
           
           			<c:if test="${product.id!=null && product.id>0}">
						<c:set value="${product.id}" var="productId" scope="request"/>
						<jsp:include page="/pages/admin/products/product-menu.jsp" />
					</c:if>	
           
           
				<h3>
					<s:message code="label.product.category.association" text="Associate to categories" />
				</h3>
				
				
			
			<c:url var="addCategory" value="/admin/products/addProductToCategories.html" />
			<c:set var="categoryLanguage" value="${LANGUAGE.code}" />
			<form:form method="POST" enctype="multipart/form-data" modelAttribute="product" action="${addCategory}">
			<form:errors path="*" cssClass="alert alert-error" element="div" />
			<div id="store.success" class="alert alert-success"	style="<c:choose><c:when test="${success!=null}">display:block;</c:when><c:otherwise>display:none;</c:otherwise></c:choose>">
					<s:message code="message.success" text="Request successfull" />
			</div>
			<c:if test="${not empty errorMessage}">
				<div class="alert alert-error"><c:out value="${errorMessage}"/></div>
			</c:if>
			<br/>
			<strong><c:out value="${product.sku}"/></strong>
			<br/><br/>
			
			<div class="control-group">
				<label><s:message code="label.productedit.categoryname" text="Category"/></label>
			  	<div class="controls">
								<!-- Khong bind vao product.id: neu bind vao "id" thi Spring se ghi de
								     product.id bang gia tri category, lam request param "id"
								     (chinh la categoryId) bi sai -> them danh muc that bai.
								     Dung doi tuong roi de form chi gui len tham so categoryId. -->
								<select name="categoryId" id="categoryId" class="form-control">
									<c:forEach items="${categoryLabels}" var="categoryLabel">
										<option value="<c:out value='${categoryLabel.id}'/>"><c:out value="${categoryLabel.name}"/></option>
									</c:forEach>
								</select>
								<c:if test="${categoryLabels==null || empty categoryLabels}">
									<span class="help-inline"><s:message code="label.product.category.nocategories" text="No category available"/></span>
								</c:if>
				</div>
			</div>
			

			<input type="hidden" name="productId" value="${product.id}">
			<div class="form-actions">
                  		<div class="pull-right">
                  			<button type="submit" class="btn btn-success"><s:message code="label.generic.add" text="Add"/></button>
                  		</div>
            	 </div>
			
		  </form:form>
				
				
				
				<br />
				<!-- Listing grid include -->
				<c:set value="/admin/product-categories/paging.html?productId=${product.id}" var="pagingUrl" scope="request" />
				<c:set value="/admin/product-categories/remove.html?productId=${product.id}" var="removeUrl" scope="request" />
				<c:set value="/admin/products/displayProductToCategories.html?id=${product.id}" var="refreshUrl" scope="request" />
				<c:set var="entityId" value="categoryId" scope="request"/>
				<c:set var="componentTitleKey" value="label.categories.title" scope="request" />
				<c:set var="canRemoveEntry" value="true" scope="request" />
				<c:set var="gridHeader" value="/pages/admin/products/product-categories-gridHeader.jsp" scope="request"/>
				<jsp:include page="/pages/admin/components/list.jsp"></jsp:include>
				<!-- End listing grid include -->
			

		</div>
	   </div>
	</div>
</div>	