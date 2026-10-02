<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm" %>   

<%@ page session="false"%>



<script type="text/javascript">
	
	function removeImage(){
			$("#store.error").show();
			$.ajax({
			  type: 'POST',
			  url: '<c:url value="/admin/store/removeImage.html"/>',
			  dataType: 'json',
			  success: function(response){
		
					var status = isc.XMLTools.selectObjects(response, "/response/status");
					if(status==0 || status ==9999) {
						
						//remove delete
						$("#imageControlRemove").html('');
						//add field
						$("#imageControl").html('<input class=\"input-file\" id=\"file\" name=\"file\" type=\"file\">');
						$(".alert-success").show();
						
					} else {
						
						//display message
						$(".alert-error").show();
					}
		
			  
			  },
			  error: function(xhr, textStatus, errorThrown) {
			  	alert('error ' + errorThrown);
			  }
			  
			});
	}
	
	function sapoSyncProducts() {
		var btn = document.getElementById('sapoSyncProductsButton');
		btn.disabled = true;
		document.getElementById('sapoSyncProductsSuccess').style.display = 'none';
		document.getElementById('sapoSyncProductsError').style.display = 'none';
		fetch('<c:url value="/api/v1/sapo/sync"/>', {method: 'POST', credentials: 'same-origin'})
		.then(function(response) {
			if (response.ok) {
				document.getElementById('sapoSyncProductsSuccess').style.display = 'block';
			} else {
				document.getElementById('sapoSyncProductsError').style.display = 'block';
			}
			btn.disabled = false;
		})
		.catch(function() {
			document.getElementById('sapoSyncProductsError').style.display = 'block';
			btn.disabled = false;
		});
	}

	function sapoSyncCategories() {
		var btn = document.getElementById('sapoSyncCategoriesButton');
		btn.disabled = true;
		document.getElementById('sapoSyncCategoriesSuccess').style.display = 'none';
		document.getElementById('sapoSyncCategoriesError').style.display = 'none';
		fetch('<c:url value="/api/v1/sapo/sync-categories"/>', {method: 'POST', credentials: 'same-origin'})
		.then(function(response) {
			if (response.ok) {
				document.getElementById('sapoSyncCategoriesSuccess').style.display = 'block';
			} else {
				document.getElementById('sapoSyncCategoriesError').style.display = 'block';
			}
			btn.disabled = false;
		})
		.catch(function() {
			document.getElementById('sapoSyncCategoriesError').style.display = 'block';
			btn.disabled = false;
		});
	}

</script>


<div class="tabbable">


	<jsp:include page="/common/adminTabs.jsp" />

	<div class="tab-content">

		<div class="tab-pane active" id="catalogue-section">

				<c:url var="saveBrandingImage" value="/admin/store/saveBranding.html" />
				<form:form method="POST" enctype="multipart/form-data" action="${saveBrandingImage}">

					<form:errors path="*" cssClass="alert alert-error" element="div" />
					<div id="store.success" class="alert alert-success"
						style="<c:choose><c:when test="${success!=null}">display:block;</c:when><c:otherwise>display:none;</c:otherwise></c:choose>">
						<s:message code="message.success" text="Request successfull" />
					</div>



					<!-- hidden when creating the product -->
					<div class="control-group">
						<label><s:message code="label.storelogo" text="Store logo"/>&nbsp;<c:if test="${store.storeLogo!=null}"><span id="imageControlRemove"> - <a href="#" onClick="removeImage('${store.id}')"><s:message code="label.generic.remove" text="Remove"/></a></span></c:if></label>
						<div class="controls" id="imageControl">

									   <c:choose>
				                        		<c:when test="${empty store.storeLogo}">
				                                    <input class="input-file" name="file" type="file"><br/>
				                                </c:when>
				                                <c:otherwise>
				                                	<img src="<c:url value=""/><sm:contentImage imageName="${store.storeLogo}" imageType="LOGO"/>">
				                                </c:otherwise>
			                            </c:choose>






						</div>
					</div>
					<div class="form-actions">
						<div class="pull-right">
							<button type="submit" class="btn btn-success">
								<s:message code="button.label.submit2" text="Submit" />
							</button>
						</div>
					</div>
				</form:form>

				<br/>
				<br/>
				<c:url var="saveTemplate" value="/admin/store/saveTemplate.html" />
				<form:form method="POST" enctype="multipart/form-data" modelAttribute="store" action="${saveTemplate}">



					<!-- hidden when creating the product -->
					<div class="control-group">
						<label><s:message code="label.store.template" text="Theme"/></label>
						<div class="controls">
								<%-- Uu tien hien nhan than thien (Generic, December...); neu bean templateOptions
									khong san sang thi quay ve danh sach ma template. --%>
								<c:choose>
									<c:when test="${not empty templateOptions}">
										<form:select items="${templateOptions}" path="storeTemplate" />
									</c:when>
									<c:otherwise>
										<form:select items="${templates}" path="storeTemplate" />
									</c:otherwise>
								</c:choose>
	                                <span class="help-inline"></span>
						</div>
					</div>
					<div class="form-actions">
						<div class="pull-right">
							<button type="submit" class="btn btn-success">
								<s:message code="button.label.submit2" text="Submit" />
							</button>
						</div>
					</div>
				</form:form>

				<br/>
				<br/>
				<h3><s:message code="label.sapo.sync.products.title" text="Sync products from Sapo" /></h3>
				<div id="sapoSyncProductsSuccess" class="alert alert-success" style="display:none;"><s:message code="label.sapo.sync.products.success" text="Sapo products synced successfully"/></div>
				<div id="sapoSyncProductsError" class="alert alert-error" style="display:none;"><s:message code="label.sapo.sync.products.error" text="Error syncing products from Sapo"/></div>
				<button type="button" id="sapoSyncProductsButton" class="btn btn-success" onclick="sapoSyncProducts();"><s:message code="label.sapo.sync.products.button" text="Sync products now" /></button>

				<br/>
				<br/>
				<h3><s:message code="label.sapo.sync.categories.title" text="Sync categories from Sapo" /></h3>
				<div id="sapoSyncCategoriesSuccess" class="alert alert-success" style="display:none;"><s:message code="label.sapo.sync.categories.success" text="Sapo categories synced successfully"/></div>
				<div id="sapoSyncCategoriesError" class="alert alert-error" style="display:none;"><s:message code="label.sapo.sync.categories.error" text="Error syncing categories from Sapo"/></div>
				<button type="button" id="sapoSyncCategoriesButton" class="btn btn-primary" onclick="sapoSyncCategories();"><s:message code="label.sapo.sync.categories.button" text="Sync categories now" /></button>
				
			</div>
		</div>
	</div>	
				

				
				
				
				


