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
					<s:message code="label.product.searchkeywords" text="Search keywords" />
				</h3>
				
								<%--
					Nut sinh tu khoa bang AI.

					AI doc TEN va MO TA san pham (theo ngon ngu dang chon o o Language ben
					duoi), roi sinh tu khoa tim kiem phu hop cho TAT CA ngon ngu ma cua hang
					dang ho tro. Ket qua duoc dien san vao o Keyword theo tung ngon ngu de
					Admin xem lai, bam "Them" moi luu - AI khong tu ghi vao co so du lieu.

					Cac nhan duoc truyen qua data-* thay vi nhung truc tiep vao JS, de ban
					dich co dau nhay don (vd tieng Phap "n'est") khong lam vo cu phap.
				--%>
				<div class="control-group">
					<div class="controls">
						<button type="button" id="generate-keywords-ai" class="btn"
							data-product-id="<c:out value="${product.id}" />"
							data-url="<c:url value="/admin/products/product/generateKeywords.html" />"
							data-msg-working="<s:message code='label.product.keyword.ai.working' text='AI is reading the product name and description, please wait 10-30 seconds...' />"
							data-msg-success="<s:message code='label.product.keyword.ai.success' text='Keywords have been filled in for each language. Please review then press Add.' />"
							data-msg-failed="<s:message code='label.product.keyword.ai.failed' text='Unable to generate keywords. Please try again.' />"
							data-msg-nolang="<s:message code='label.product.keyword.ai.noLanguages' text='No supported language found for this store.' />">
							<i class="fa fa-magic"></i>
							<s:message code="button.label.generate_product_keywords_with_AI"
								text="Add search keywords with AI" />
						</button>
						<span class="help-inline">
							<s:message code="button.label.AI_Keywords_Description"
								text="AI reads the product name and description and suggests search keywords for every supported language." />
						</span>
						<div id="keyword-ai-status" class="alert" style="display:none;margin-top:10px;"></div>
					</div>
				</div>


			
			<c:url var="addKeyword" value="/admin/products/product/addKeyword.html" />
			<form:form method="POST" enctype="multipart/form-data" modelAttribute="productKeyword" action="${addKeyword}">
				<form:errors path="*" cssClass="alert alert-error" element="div" />
				<div id="store.success" class="alert alert-success"	style="<c:choose><c:when test="${success!=null}">display:block;</c:when><c:otherwise>display:none;</c:otherwise></c:choose>">
					<s:message code="message.success" text="Request successfull" />
				</div>
				<br/>
				<strong><c:out value="${product.sku}"/></strong>
				<br/><br/>
			
				<div class="control-group">
					<label><s:message code="label.generic.language" text="Language"/></label>
			  		<div class="controls">
	                        		<form:select path="languageCode">
					  					<form:options items="${store.languages}" itemValue="code" itemLabel="code"/>
				       				</form:select>
	                                <span class="help-inline"><form:errors path="languageCode" cssClass="error" /></span>
					</div>
				</div>
			
				<div class="control-group">
                        <label><s:message code="label.generic.keyword" text="Keyword"/></label>
                        <div class="controls">
                                    <form:input id="keyword" cssClass="highlight" path="keyword"/>
                                    <span class="help-inline"><form:errors path="keyword" cssClass="error" /></span>
                        </div>
                  </div>
			

				<input type="hidden" name="productId" value="${product.id}">
				<div class="form-actions">
                  		<div class="pull-right">
                  			<button type="submit" class="btn btn-success"><s:message code="label.generic.add" text="Add"/></button>
                  		</div>
            	 </div>
			
		  </form:form>
				
				
				 <br/>
				 <!-- Listing grid include -->
				 
				 <c:set value="/admin/products/product/keywords/paging.html?id=${product.id}" var="pagingUrl" scope="request"/>
				 <c:set value="/admin/products/product/removeKeyword.html?id=${product.id}" var="removeUrl" scope="request"/>
				 <c:set value="/admin/products/product/keywords.html?id=${product.id}" var="afterRemoveUrl" scope="request"/>
				 <c:set var="entityId" value="code" scope="request"/>
				 <c:set var="componentTitleKey" value="label.product.searchkeywords" scope="request"/>
				 <c:set var="groupByEntity" value="language" scope="request" />
				 <c:set var="gridHeader" value="/pages/admin/products/keywords-gridHeader.jsp" scope="request"/>
				 <c:set var="canRemoveEntry" value="true" scope="request"/>
				 <c:set var="canEdit" value="false" scope="request"/>

            	 <jsp:include page="/pages/admin/components/list.jsp"></jsp:include> 
				 <!-- End listing grid include -->
			
				<script src="<c:url value="/resources/js/admin-product-keywords-ai.js" />" type="text/javascript"></script>

		</div>
	   </div>
	</div>
</div>		      			     