<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm" %>

<%@ page session="false" %>			
<script type="text/javascript">
var priceFormatMessage = '<s:message code="message.price.cents" text="Wrong format" />';

// Thong bao da ngon ngu cho phan AI
var AI_I18N = {
	needImage : '<s:message code="message.ai.needImage" text="Vui lòng chụp hoặc tải ảnh sản phẩm trước khi tạo mô tả AI." />',
	imageTooLarge : '<s:message code="message.ai.imageTooLarge" text="Ảnh quá lớn (tối đa 8MB)." />',
	cannotReadFile : '<s:message code="message.ai.cannotReadFile" text="Không thể đọc tệp ảnh." />',
	processing : '<s:message code="message.ai.processing" text="Đang phân tích ảnh, vui lòng chờ 10-30 giây..." />',
	success : '<s:message code="message.ai.success" text="Đã tạo thông tin sản phẩm thành công cho tất cả các ngôn ngữ!" />',
	parseError : '<s:message code="message.ai.parseError" text="Lỗi xử lý kết quả từ AI." />',
	serverError : '<s:message code="message.ai.serverError" text="Lỗi từ server" />',
	noConnection : '<s:message code="message.ai.noConnection" text="Không thể kết nối đến server." />',
	imageRemoved : '<s:message code="message.ai.imageRemoved" text="Đã xóa ảnh sản phẩm." />'
};
</script>

    <link href="<c:url value="/resources/css/bootstrap/css/datepicker.css" />" rel="stylesheet"></link>
	<script src="<c:url value="/resources/js/bootstrap/bootstrap-datepicker.js" />"></script>
	<script src="<c:url value="/resources/js/ckeditor/ckeditor.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.formatCurrency-1.4.0.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.alphanumeric.pack.js" />"></script>
	<script src="<c:url value="/resources/js/adminFunctions.js" />"></script>



<script type="text/javascript">


	$(function(){
		$('#sku').alphanumeric();
		$('#productPriceAmount').numeric({allow:"."});
		$('#quantity').numeric();
		$('#ordermin').numeric();
		$('#ordermax').numeric();
		$('#order').numeric();
		$('#weight').numeric({allow:"."});
		$('#width').numeric({allow:"."});
		$('#length').numeric({allow:"."});
		$('#hight').numeric({allow:"."});
			<c:forEach items="${product.descriptions}" var="description" varStatus="counter">
				$("#name${counter.index}").friendurl({id : 'seUrl${counter.index}'});
			</c:forEach>

			// Nut Chup/Tai anh - mo hop chon file khi bam vao button
			$(document).on('click', '#imagePickBtn', function(e) {
				e.preventDefault();
				$('#image').val('').click();
			});

			// hien thi ten file da chon + xem truoc anh (input bi an nen phai preview bang JS)
			$(document).on('change', '#image', function() {
			var f = this.files && this.files[0];
			$('#imageFileName').text(f ? f.name : '');
			var preview = $('#imagePreview');
			if (f) {
				var reader = new FileReader();
				reader.onload = function(e) { preview.attr('src', e.target.result).show(); };
				reader.readAsDataURL(f);
			} else {
				preview.hide().attr('src', '');
			}
			});
			});

	
	function removeImage(imageId){
			$("#store.error").show();
			$.ajax({
			  type: 'POST',
			  url: '<c:url value="/admin/products/product/removeImage.html"/>',
			  data: 'imageId=' + imageId,
			  dataType: 'json',
			  success: function(response){
		
					var status = isc.XMLTools.selectObjects(response, "/response/status");
					if(status==0 || status ==9999) {
						
						//remove delete
						$("#imageControlRemove").html('');
						//add lai nut Chup/Tai anh + input file bi an (kem khung preview)
						$("#imageControl").html('<button type="button" id="imagePickBtn" class="btn" style="margin-bottom:5px;"><i class="icon-camera"></i> <s:message code="button.label.Capture_UploadImage" text="Capture/Upload Image"/></button>' +
							'<span id="imageFileName" style="margin-left:8px;color:#999;"></span>' +
							'<img id="imagePreview" src="" alt="" style="display:none;max-width:200px;margin-left:10px;vertical-align:middle;"/>' +
							'<input class="input-file" id="image" name="image" type="file" accept="image/*" style="display:none;">');
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
	
	
</script>
	
				
<div class="tabbable">


					<jsp:include page="/common/adminTabs.jsp" />
  					
  					 <div class="tab-content">

    					<div class="tab-pane active" id="catalogue-section">


								<div class="sm-ui-component">
								
								
								<c:if test="${product.product.id!=null && product.product.id>0}">
									<c:set value="${product.product.id}" var="productId" scope="request"/>
									<jsp:include page="/pages/admin/products/product-menu.jsp" />
								</c:if>	
								
								
				<h3>
					<c:choose>
						<c:when test="${product.product.id!=null && product.product.id>0}">
								<s:message code="label.product.edit" text="Edit product" /> <c:out value="${product.product.sku}"/>
						</c:when>
						<c:otherwise>
								<s:message code="label.product.create" text="Create product" />
						</c:otherwise>
					</c:choose>
					
				</h3>	
				<br/>
				<c:if test="${product.product.id!=null && product.product.id>0}">
					<c:forEach items="${product.descriptions}" var="description" varStatus="counter">
						<strong><sm:productUrl productDescription="${description}" /></strong><br/>
					</c:forEach>
				</c:if>
				<br/><br/>

      					<c:url var="productSave" value="/admin/products/save.html"/>
                        <form:form method="POST" enctype="multipart/form-data" modelAttribute="product" action="${productSave}">

                            <form:errors path="*" cssClass="alert alert-error" element="div" />
                            <div id="store.success" class="alert alert-success" style="<c:choose><c:when test="${success!=null}">display:block;</c:when><c:otherwise>display:none;</c:otherwise></c:choose>"><s:message code="message.success" text="Request successfull"/></div>   
                            <div id="store.error" class="alert alert-error" style="display:none;"><s:message code="message.error" text="An error occured"/></div>

                  <!-- Khu vuc Anh + AI: dat len dau trang -->
                  <div class="control-group">
                        <label><s:message code="label.product.image" text="Image"/>&nbsp;<c:if test="${product.productImage.productImage!=null && product.productImage.productImage!=''}"><span id="imageControlRemove"> - <a href="#" onClick="removeImage('${product.productImage.id}')"><s:message code="label.generic.remove" text="Remove"/></a></span></c:if></label>
                        <div class="controls" id="imageControl">
                                <c:choose>
                                        <c:when test="${product.productImage.productImage==null || product.productImage.productImage==''}">
                                                  <button type="button" id="imagePickBtn" class="btn" style="margin-bottom:5px;">
                                                      <i class="icon-camera"></i> <s:message code="button.label.Capture_UploadImage" text="Capture/Upload Image"/>
                                                  </button>
                                                  <span id="imageFileName" style="margin-left:8px;color:#999;"></span>
                                                  <img id="imagePreview" src="" alt="" style="display:none;max-width:200px;margin-left:10px;vertical-align:middle;"/>
                                                  <input class="input-file" id="image" name="image" type="file" accept="image/*" style="display:none;">
                                        </c:when>
                                        <c:otherwise>
                                                  <img id="imageCurrent" src="<sm:productImage imageName="${product.productImage.productImage}" product="${product.product}"/>" width="200"/>
                                                  <button type="button" id="imagePickBtn" class="btn" style="margin-left:10px;">
                                                      <i class="icon-camera"></i> <s:message code="button.label.Capture_UploadAnotherImage" text="Capture/Upload another image"/>
                                                  </button>
                                                  <span id="imageFileName" style="margin-left:8px;color:#999;"></span>
                                                  <img id="imagePreview" src="" alt="" style="display:none;max-width:200px;margin-left:10px;vertical-align:middle;"/>
                                                  <input class="input-file" id="image" name="image" type="file" accept="image/*" style="display:none;">
                                        </c:otherwise>
                                </c:choose>
                        </div>
                  </div>

                  <div class="control-group" id="aiGenerateGroup">
                        <label><s:message code="button.label.generate_product_information_with_AI" text="Automatically generate product information with AI"/></label>
                        <div class="controls">
                              <button type="button" id="aiGenerateBtn" class="btn btn-primary" style="margin-bottom:5px;">
                                    <i class="icon-magic"></i> <s:message code="button.label.generate_product_information_with_AI" text="Automatically generate product information with AI"/>
                              </button>
                              <span id="aiStatus" style="margin-left:10px;color:#d9534f;"></span>
                              <p class="help-inline" style="margin-top:5px;">
                                    <s:message code="button.label.AI_Description" text="Capture or upload the product image above, then click this button — AI will automatically fill in the SKU, name, URL, description, and SEO for all store languages."/>
                              </p>
                        </div>
                  </div>

                        <div class="control-group">
	                        <label><s:message code="label.product.sku" text="Sku"/></label>
	                        <div class="controls">
	                        		  <form:input cssClass="input-large highlight" id="sku" path="product.sku"/>
	                                  <span class="help-inline"><s:message code="label.generic.alphanumeric" text="Alphanumeric" /><form:errors path="product.sku" cssClass="error" /></span>
	                        </div>
                  		</div>
                  		
                  		<div class="control-group">
	                        <label><s:message code="label.product.refsku" text="External system identifier"/></label>
	                        <div class="controls">
	                        		  <form:input cssClass="input-large" id="refSku" path="product.refSku"/>
	                        </div>
                  		</div>

						<form:hidden path="product.id" />
                 	

                  		<div class="control-group">
                        	<label><s:message code="label.product.available" text="Product available"/></label>
                        	<div class="controls">
                                    <form:checkbox path="product.available" />
                        	</div>
                  		</div>
                  		
                  		
                  	    <div class="control-group">
                        	<label><s:message code="label.product.preorder" text="Pre-order"/></label>
                        	<div class="controls">
                                    <form:checkbox path="product.preOrder" />
                        	</div>
                  		</div>
                  		
                  		
                  		<div class="control-group">
	                        <label><s:message code="label.product.availabledate" text="Date available"/></label>
	                        <div class="controls">
	                        		 <input id="dateAvailable" name="dateAvailable" value="${product.dateAvailable}" class="small" type="text" data-date-format="<%=com.salesmanager.core.business.constants.Constants.DEFAULT_DATE_FORMAT%>" data-datepicker="datepicker"> 
	                                 <script type="text/javascript">
	                                 $('#dateAvailable').datepicker();
	                                 </script>
	                                 <span class="help-inline"><form:errors path="dateAvailable" cssClass="error" /></span>
	                        </div>
	                  	</div>
	                  	
	                  	<div class="control-group">
                        	<label><s:message code="label.product.manufacturer" text="Manufacturer"/></label>
                          	<div class="controls">
                          		      <form:select items="${manufacturers}" itemValue="id" itemLabel="descriptions[0].name"  path="product.manufacturer.id"/> 
	                                  <span class="help-inline"></span>
                          	</div>
                    	</div>




                  		<div class="control-group">
                        	<label><s:message code="label.productedit.producttype" text="Product type"/></label>
                        	<div class="controls">
                        		         <form:select items="${productTypes}" itemValue="id" itemLabel="code"  path="product.type.id"/> 
	                                     <span class="help-inline"></span>
                        	</div>
                 		 </div>

                 

                  <c:forEach items="${product.descriptions}" var="description" varStatus="counter">

                 

                        <div class="control-group">

                              <label class="required"><s:message code="label.productedit.productname" text="Product name"/> (<c:out value="${description.language.code}"/>)</label>
                              <div class="controls">
                                          <form:input cssClass="input-large highlight" id="name${counter.index}" path="descriptions[${counter.index}].name"/>
                                          <span class="help-inline"><form:errors path="descriptions[${counter.index}].name" cssClass="error" /></span>
                              </div>

                       </div>

                      
                        <div class="control-group">
                              <label class="required"><s:message code="label.sefurl" text="Search engine friendly url"/> (<c:out value="${description.language.code}"/>)</label>
                              <div class="controls">
                                          <form:input id="seUrl${counter.index}" cssClass="input-large" path="descriptions[${counter.index}].seUrl"/>
                                          <span class="help-inline"><form:errors path="descriptions[${counter.index}].seUrl" cssClass="error" /></span>
                              </div>
                       </div>
                       

                        <div class="control-group">
                              <label class="required"><s:message code="label.productedit.producthl" text="Product highlight"/> (<c:out value="${description.language.code}"/>)</label>
                              <div class="controls">
                                          <form:input cssClass="input-large" path="descriptions[${counter.index}].productHighlight"/>
                                          <span class="help-inline"><form:errors path="descriptions[${counter.index}].productHighlight" cssClass="error" /></span>
                              </div>

                       </div>


                        <div class="control-group">
                              <label class="required"><s:message code="label.productedit.productdesc" text="Product description"/> (<c:out value="${description.language.code}"/>)</label>
                              <div class="controls">
                              		 
                              		 
                              	     <textarea cols="30" id="descriptions${counter.index}.description" name="descriptions[${counter.index}].description">
                        				<c:out value="${product.descriptions[counter.index].description}"/>
                        			 </textarea>
                              </div>



                        <script type="text/javascript">
						//<![CDATA[

							CKEDITOR.replace('descriptions[${counter.index}].description',
							{
								skin : 'office2003',
								toolbar :
								[
									['Source','-','Save','NewPage','Preview'],
									['Cut','Copy','Paste','PasteText','-','Print'],
									['Undo','Redo','-','Find','-','SelectAll','RemoveFormat'], '/',
									['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
									['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
									['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
									['Link','Unlink','Anchor'],
									['Image','Flash','Table','HorizontalRule','SpecialChar','PageBreak'], '/',
									['Styles','Format','Font','FontSize'], ['TextColor','BGColor'],
									['Maximize', 'ShowBlocks']
								],

								filebrowserWindowWidth : '720',
        						filebrowserWindowHeight : '740',
								filebrowserImageBrowseUrl :    '<c:url value="/admin/content/fileBrowser.html"/>'


							});

						//]]>
						</script>

						</div>


                        <div class="control-group">
                              <label class="required"><s:message code="label.product.title" text="Product title"/> (<c:out value="${description.language.code}"/>)</label>
                              <div class="controls">
                                          <form:input cssClass="input-large" path="descriptions[${counter.index}].metatagTitle"/>
                                          <span class="help-inline"><form:errors path="descriptions[${counter.index}].metatagTitle" cssClass="error" /></span>
                              </div>
                       </div>



                        <div class="control-group">
                              <label class="required"><s:message code="label.metatags.description" text="Metatag description"/> (<c:out value="${description.language.code}"/>)</label>
                              <div class="controls">
                                          <form:input cssClass="input-large" path="descriptions[${counter.index}].metatagDescription"/>
                                          <span class="help-inline"><form:errors path="descriptions[${counter.index}].metatagDescription" cssClass="error" /></span>
                              </div>
                       </div>



                         <form:hidden path="descriptions[${counter.index}].language.id" />
                         <form:hidden path="descriptions[${counter.index}].language.code" />
						 <form:hidden path="descriptions[${counter.index}].id" />
						 <form:hidden path="descriptions[${counter.index}].metatagKeywords" />
						 <form:hidden path="descriptions[${counter.index}].productExternalDl" />



                  </c:forEach>



                 <div class="control-group">

                        <label class="required"><s:message code="label.product.price" text="Price"/></label>

                        <div class="controls">
                                    <form:input id="productPriceAmount" cssClass="highlight" path="productPrice"/>
                                    <span id="help-price" class="help-inline"><form:errors path="productPrice" cssClass="error" /></span>
                        </div>
                  </div>



                 <div class="control-group">

                        <label><s:message code="label.productedit.qtyavailable" text="Quantity available"/></label>
                        <div class="controls">
                                    <form:input id="quantity" cssClass="highlight" path="availability.productQuantity"/>
                                    <span class="help-inline"><form:errors path="availability.productQuantity" cssClass="error" /></span>
                        </div>
                  </div>



                  <div class="control-group">
                        <label><s:message code="label.product.ordermin" text="Quantity order minimum"/></label>
                        <div class="controls">
                                    <form:input id="ordermin" cssClass="highlight" path="availability.productQuantityOrderMin"/>
                                    <span class="help-inline"><form:errors path="availability.productQuantityOrderMin" cssClass="error" /></span>

                        </div>
                  </div>



                  <div class="control-group">
                        <label><s:message code="label.product.ordermax" text="Quantity order maximum"/></label>
                        <div class="controls">
                                    <form:input id="ordermax" cssClass="highlight" path="availability.productQuantityOrderMax"/>
                                    <span class="help-inline"><form:errors path="availability.productQuantityOrderMax" cssClass="error" /></span>
                        </div>
                  </div>

                 <div class="control-group">
                        	<label><s:message code="label.product.shipeable" text="Product will be shipped"/></label>
                        	<div class="controls">
                                    <form:checkbox path="product.productShipeable" />
                        	</div>
                 </div>


                 <form:hidden path="availability.region" />
                 <form:hidden path="availability.id" />
                 <form:hidden path="price.id" />
                 <form:hidden path="product.productVirtual" />

                 <div class="control-group">
                        <label><s:message code="label.product.weight" text="Weight"/></label>
                        <div class="controls">
                                    <form:input id="weight" cssClass="" path="product.productWeight"/>
                                    <span class="help-inline"><form:errors path="product.productWeight" cssClass="error" /></span>
                        </div>
                  </div>

                 <div class="control-group">
                        <label><s:message code="label.product.height" text="Height"/></label>
                        <div class="controls">
                                    <form:input id="height" cssClass="" path="product.productHeight"/>
                                    <span class="help-inline"><form:errors path="product.productHeight" cssClass="error" /></span>
                        </div>
                  </div>


                 <div class="control-group">
                        <label><s:message code="label.product.width" text="Width"/></label>
                        <div class="controls">
                                    <form:input id="width" cssClass="" path="product.productWidth"/>
                                    <span class="help-inline"><form:errors path="product.productWidth" cssClass="error" /></span>
                        </div>
                  </div>

                  <div class="control-group">
                        <label><s:message code="label.product.length" text="Length"/></label>
                        <div class="controls">
                                    <form:input id="length" cssClass="" path="product.productLength"/>
                                    <span class="help-inline"><form:errors path="product.productLength" cssClass="error" /></span>
                        </div>
                  </div>

                  <div class="control-group">
                        <label><s:message code="label.entity.order" text="Sort order"/></label>
                        <div class="controls">
                                    <form:input id="order" cssClass="" path="product.sortOrder"/>
                                    <span class="help-inline"><form:errors path="product.sortOrder" cssClass="error" /></span>
                        </div>
                  </div>


                  <form:hidden path="productImage.productImage" />

                  <script type="text/javascript">
						//<![CDATA[
						(function() {
							var btn = document.getElementById('aiGenerateBtn');
							var status = document.getElementById('aiStatus');
							if (!btn) return;

							function setStatus(msg, color) {
								if (status) {
									status.textContent = msg || '';
									status.style.color = color || '#d9534f';
								}
							}

										function getSel(name) {
											var els = document.getElementsByName(name);
											return els.length > 0 ? els[0] : null;
										}

										// Bat log chan doan: mo DevTools (F12) > Console se thay [AI] ...
										var AI_DEBUG = true;
										function aiLog() {
											if (!AI_DEBUG || !window.console || !console.log) return;
											console.log.apply(console, ['[AI]'].concat(Array.prototype.slice.call(arguments)));
										}

										// Tim editor theo name cua textarea goc - dam bao dung instance
										function findEditor(name) {
											if (!window.CKEDITOR) return null;
											for (var instName in CKEDITOR.instances) {
												if (!CKEDITOR.instances.hasOwnProperty(instName)) continue;
												var inst = CKEDITOR.instances[instName];
												var el = inst.element && inst.element.$ ? inst.element.$ : null;
												if (el && (el.getAttribute('name') === name || instName === name)) return inst;
											}
											return null;
										}

										// Dien noi dung vao textarea goc (khong dung CKEditor) - day la cach
										// chac chan nhat: du lieu nam trong textarea nen submit form se gui len,
										// dong thoi noi dung duoc sao chep vao vung soan thao de nguoi dung nhin thay.
										function setTextareaOnly(name, html) {
											var ta = getSel(name);
											if (ta) ta.value = html;
											aiLog('setTextareaOnly', name, 'tim thay textarea =', !!ta);
											return ta;
										}

										// Ghi noi dung vao CKEditor mot cach an toan:
										// - neu co editor: luon ghi vao textarea goc truoc, roi ghi vao editor khi
										//   editor da o che do wysiwyg (mode duoc thiet lap trong su kien 'mode',
										//   sau khi iframe load). setData() khi chua co mode chi luu vao _data
										//   => noi dung bi mat, do la ly do truong hop loi truoc day.
										// - neu khong co editor thi chi ghi textarea.
											function whenEditorReady(editor, callback) {
										// LUU Y: CKEditor 3.6.4 KHONG co editor.status === 'ready'.
										// Chi co CKEDITOR.status (basic_ready/basic_loaded/loaded) va editor.mode.
										// Dieu kien duy nhat can cho setData/loadData la editor.mode da san sang.
										function isReady() {
										return !!(editor.mode && editor.getMode(editor.mode));
										}
										if (isReady()) {
										callback();
										return;
										}
										var attempts = 0;
										var maxAttempts = 80; // ~20 giay
										(function waitMode() {
										attempts++;
										if (isReady()) {
										callback();
										return;
										}
										if (attempts >= maxAttempts) {
										aiLog('whenEditorReady: het luot cho editor', editor.name,
										'mode=', editor.mode, '- textarea van giu du lieu');
										return;
										}
											setTimeout(waitMode, 250);
										})();
										}

											// Ghi thang vao vung soan thao cua che do wysiwyg.
										// Dung mode.loadData() - ghi truc tiep vao body cua iframe.
										// KHONG goi editor.setData() sau do vi trong CKEditor 3.6.4, setData phat
										// su kien 'afterSetData' va editingblock se goi lai
										// getMode().loadData(getData()) -> ghi _data cu de len, xoa mat noi dung vua ghi.
										function forceSetEditorBody(editor, html) {
											try {
										if (!editor.mode) {
										aiLog('forceSetEditorBody: editor chua co mode', editor.name);
										return false;
										}
										var mode = editor.getMode(editor.mode);
										if (!mode || typeof mode.loadData != 'function') {
										aiLog('forceSetEditorBody: mode khong dung dang', editor.name, editor.mode);
										return false;
										}
										// ghi truc tiep vao body cua che do hien hanh
										mode.loadData(html);
										// cap nhat _data noi bo bang cach goi setData voi co che khong phat su kien (tham so 3 = true)
										// de tranh afterSetData ghi de lai body
											try { editor.setData(html, null, true); } catch (ignoredSetData) {}
										var current = '';
											try { current = mode.getData() || ''; } catch (ignoredRead) {}
										aiLog('forceSetEditorBody', editor.name, 'mode=', editor.mode, 'len =', current.length);
										return true;
										} catch (e) {
										aiLog('forceSetEditorBody LOI', editor.name, e);
										return false;
										}
										}

										function setCkEditorValue(name, html) {
											// LUON dong bo textarea goc truoc - day la du lieu that se submit len server
											setTextareaOnly(name, html);

											var editor = findEditor(name);
											if (!editor) {
												aiLog('setCkEditorValue', name, ': chua co editor, chi ghi textarea');
												return;
											}

											whenEditorReady(editor, function() {
												forceSetEditorBody(editor, html);
												// dam bao textarea goc van giu noi dung truoc khi submit
												if (editor.updateElement) editor.updateElement();
											});
										}

							btn.addEventListener('click', function() {
								// lay anh tu o Chup/Tai anh (ca 2 input: image moi hoac anh hien tai)
								var imageInput = document.getElementById('image');
								var file = null;
								if (imageInput && imageInput.files && imageInput.files.length > 0) {
									file = imageInput.files[0];
								}
								if (!file) {
									setStatus(AI_I18N.needImage);
									return;
								}
								if (file.size > 8 * 1024 * 1024) {
									setStatus(AI_I18N.imageTooLarge);
									return;
								}

								var reader = new FileReader();
								reader.onload = function(e) {
									generate(e.target.result, file.type || 'image/jpeg');
								};
								reader.onerror = function() { setStatus(AI_I18N.cannotReadFile); };
								reader.readAsDataURL(file);
							});

							function generate(imageBase64, mimeType) {
								setStatus(AI_I18N.processing, '#333333');
								btn.disabled = true;

								var xhr = new XMLHttpRequest();
								xhr.open('POST', '<c:url value="/admin/product/gemini/generate"/>', true);
								xhr.setRequestHeader('Content-Type', 'application/json');
								xhr.onload = function() {
									btn.disabled = false;
									if (xhr.status === 200) {
										try {
											var data = JSON.parse(xhr.responseText);
											apply(data);
											setStatus(AI_I18N.success, '#468847');
											setTimeout(function(){ setStatus(''); }, 8000);
										} catch (e) {
											setStatus(AI_I18N.parseError);
										}
									} else {
										var msg = AI_I18N.serverError + ' (' + xhr.status + ')';
										try {
											var err = JSON.parse(xhr.responseText);
											if (err && err.message) msg = err.message;
										} catch (ignored) {}
										setStatus(msg);
									}
								};
								xhr.onerror = function() {
									btn.disabled = false;
									setStatus(AI_I18N.noConnection);
								};
								xhr.send(JSON.stringify({ imageBase64: imageBase64, mimeType: mimeType }));
							}

							function apply(data) {
								// map ngon ngu -> chi so descriptions trong form
								var langIndex = {};
								<c:forEach items="${product.descriptions}" var="description" varStatus="counter">
								langIndex['${description.language.code}'] = '${counter.index}';
								</c:forEach>

								var languages = data.languages || {};
								aiLog('apply() nhan duoc languages =', Object.keys(languages), 'langIndex =', langIndex);

								for (var lang in languages) {
									if (!languages.hasOwnProperty(lang)) continue;
									var idx = langIndex[lang];
									if (idx === undefined) {
										aiLog('BO QUA ngon ngu', lang, '- khong khop voi langIndex', langIndex, '. Cac o tren form co ma ngon ngu:', Object.keys(langIndex));
										continue;
									}
									var l = languages[lang] || {};
									aiLog('xu ly ngon ngu', lang, '=> index', idx, ', cac truong =', Object.keys(l));

									if (l.name) {
										var nameEl = getSel('descriptions[' + idx + '].name');
										if (nameEl) nameEl.value = l.name;
									}
									if (l.seUrl) {
										var seUrlEl = getSel('descriptions[' + idx + '].seUrl');
										if (seUrlEl) seUrlEl.value = l.seUrl;
									}
									if (l.shortDescription) {
										var hlEl = getSel('descriptions[' + idx + '].productHighlight');
										if (hlEl) hlEl.value = l.shortDescription;
									}
									if (l.description) {
										// luu lai de dien lai khi CKEditor khoi tao xong (tranh bi ghi de)
										window.__aiDescriptionPending = window.__aiDescriptionPending || {};
										window.__aiDescriptionPending['descriptions[' + idx + '].description'] = l.description;
										aiLog('description ngon ngu', lang, '-> index', idx, ', do dai =', (l.description || '').length);
										setCkEditorValue('descriptions[' + idx + '].description', l.description);
									} else {
										aiLog('CANH BAO: ngon ngu', lang, 'khong co truong description!');
									}
									if (l.metaTitle) {
										var titleEl = getSel('descriptions[' + idx + '].metatagTitle');
										if (titleEl) titleEl.value = l.metaTitle;
									}
									if (l.metaDescription) {
										var descEl = getSel('descriptions[' + idx + '].metatagDescription');
										if (descEl) descEl.value = l.metaDescription;
									}
								}

								if (data.sku) {
									var skuEl = document.getElementById('sku');
									if (skuEl && !skuEl.value) skuEl.value = data.sku;
								}
								if (data.refCode) {
									var refEl = document.getElementById('refSku');
									if (refEl && !refEl.value) refEl.value = data.refCode;
								}
							}

							// Neu no luong AI chay truoc khi CKEditor khoi tao xong (hoac editor bi khoi tao lai),
							// dien lai mo ta chi tiet tu bo dem tam de khong bi mat noi dung.
							function flushPendingDescriptions() {
								var pending = window.__aiDescriptionPending;
								if (!pending) return;
								for (var name in pending) {
									if (!pending.hasOwnProperty(name)) continue;
									setCkEditorValue(name, pending[name]);
								}
							}
							if (window.CKEDITOR) {
								CKEDITOR.on('instanceReady', flushPendingDescriptions);
							}
						})();
						//]]>
				</script>
                  
                  <form:hidden path="productImage.productImage" />
                  
                  <div class="control-group">
                        	<label><s:message code="label.taxclass" text="Tax class"/></label>
                          	<div class="controls">
                          		      <form:select items="${taxClasses}" itemValue="id" itemLabel="code"  path="product.taxClass.id"/> 
	                                  <span class="help-inline"></span>
                          	</div>
                   </div>


                   <div class="form-actions">
                            <div class="pull-right">
                                    <button type="submit" class="btn btn-success"><s:message code="button.label.submit2" text="Submit"/></button>
                            </div>
                   </div>
                   
                   

                   


                   

                 

 

 

                                   

                        </form:form>
                        
                  <c:if test="${product.product.id!=null && product.product.id>0}">      
                  <c:url var="createSimilar" value="/admin/products/product/duplicate.html"/>
                  <form:form method="POST" enctype="multipart/form-data" modelAttribute="product" action="${createSimilar}">
							<input type="hidden" name="productId" value="${product.product.id}" />
	                        <div class="form-actions">
	                            <div class="pull-right">
	                                    <button type="submit" class="btn"><s:message code="label.product.createsimilar" text="Create similar product"/></button>
	                            </div>
	                   		</div>

                   </form:form>
                   </c:if>
                   
                   
                   
                   
                   	    
                        
      				</div>
      					

      			     
      			     


      			     
      			     
    


   					</div>


  					</div>

				</div>