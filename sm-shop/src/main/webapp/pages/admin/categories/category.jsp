<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>

<%-- PHAI khai bao TRUOC khi dung: khoi script ben duoi can gia tri nay de tao langIndex --%>
<c:set var="categoryLanguage" value="${LANGUAGE.code}" />

<script src="<c:url value="/resources/js/ckeditor/ckeditor.js" />"></script>
<script src="<c:url value="/resources/js/jquery.alphanumeric.pack.js" />"></script>

<script type="text/javascript">
// Thong bao cho phan AI goi y danh muc - da ngon ngu lay tu bundles/messages_*.properties
// theo ngon ngu giao dien Admin dang hien thi (LANGUAGE).
// LUU Y: KHONG dung truc tiep <--s:message .../--> trong chuoi JavaScript.
// The <--s:message--> se escape dau nhay don (') thanh &#39; va lam vo chuoi JavaScript.
// Vi vay: (1) htmlEscape="false" de giu nguyen ky tu goc va (2) bieu dien chuoi JS bang
// dau nhay kep ("...") de dau nhay don (') trong ban dich khong lam vo chuoi JavaScript.
<s:message code="category.ai.need.name" text="Please enter the Category Name before using AI suggestions." var="aiMsgNeedName" htmlEscape="false"/>
<s:message code="category.ai.processing" text="AI is generating category data, please wait 10-30 seconds..." var="aiMsgProcessing" htmlEscape="false"/>
<s:message code="category.ai.success" text="Category data has been generated for all languages. Please review and edit before saving!" var="aiMsgSuccess" htmlEscape="false"/>
<s:message code="category.ai.missing.fields" text="AI did not return data for any language. Please try again or check the AI configuration." var="aiMsgMissingFields" htmlEscape="false"/>
<s:message code="category.ai.parse.error" text="Error processing the AI response." var="aiMsgParseError" htmlEscape="false"/>
<s:message code="category.ai.server.error" text="Server error" var="aiMsgServerError" htmlEscape="false"/>
<s:message code="category.ai.no.connection" text="Cannot connect to the server." var="aiMsgNoConnection" htmlEscape="false"/>
var CATEGORY_AI_I18N = {
	needName : "${aiMsgNeedName}",
	processing : "${aiMsgProcessing}",
	success : "${aiMsgSuccess}",
	missingFields : "${aiMsgMissingFields}",
	parseError : "${aiMsgParseError}",
	serverError : "${aiMsgServerError}",
	noConnection : "${aiMsgNoConnection}"
};
</script>

	<script type="text/javascript">

	$(function(){
		$('#order').numeric();
		// ensure CKEditor instances sync their content into the textareas before submit
		$('form').on('submit', function() {
			for (var name in CKEDITOR.instances) {
				CKEDITOR.instances[name].updateElement();
			}
		});
		if($("#code").val()=="") {
			$('.btn').addClass('disabled');
		}
		<c:forEach items="${category.descriptions}" var="description" varStatus="counter">
			$("#name${counter.index}").friendurl({id : 'seUrl${counter.index}'});
		</c:forEach>
	});

	function validateCode(input) {
		$('#checkCodeStatus').html('<img src="<c:url value="/resources/img/ajax-loader.gif" />');
		$('#checkCodeStatus').show();
		var code = $("#code").val();
		var id = $("#id").val();
		checkCode(code,id,'<c:url value="/admin/categories/checkCategoryCode.html" />');
	}

	function callBackCheckCode(msg,code) {
		console.log(code);
		if(code==0) {
			$('.btn').removeClass('disabled');
		}
		if(code==9999) {
			$('#checkCodeStatus').html('<font color="green"><s:message code="message.code.available" text="This code is available"/></font>');
			$('#checkCodeStatus').show();
			$('.btn').removeClass('disabled');
		}
		if(code==9998) {
			$('#checkCodeStatus').html('<font color="red"><s:message code="message.code.exist" text="This code already exist"/></font>');
			$('#checkCodeStatus').show();
			$('.btn').addClass('disabled');
		}
	}

	// ===== GOI Y DU LIEU DANH MUC BANG AI =====
	// Goi POST /api/v1/category/ai/generate voi category_name + supported_languages,
	// sau do tu dong dien ket qua tra ve vao cac o input / CKEditor theo tung ngon ngu.
	// Nguoi dung VAN xem lai va chinh sua truoc khi bam Luu.
	//
	// LUU Y: khoi script nay nam TRUOC phan <form> trong JSP. Neu goi
	// document.getElementById('aiSuggestBtn') ngay lap tuc thi nut chua ton tai
	// trong DOM -> khong gan duoc su kien click. Vi vay phai doi DOM san sang.
	(function(){

		function init() {
			var aiBtn = document.getElementById('aiSuggestBtn');
			var aiStatus = document.getElementById('aiSuggestStatus');
			if(!aiBtn) {
				// Nut khong co tren trang nay
				return;
			}

			// Danh sach ngon ngu he thong dang ho tro (tu cac tab ngon ngu tren form)
			var langIndex = {};
			<c:forEach items="${category.descriptions}" var="description" varStatus="counter">
			langIndex['<c:out value="${description.language.code}"/>'] = '${counter.index}';
			</c:forEach>

			function setAiStatus(msg, color) {
				if(aiStatus) {
					aiStatus.innerHTML = msg || '';
					aiStatus.style.color = color || '#d9534f';
				}
			}

			function setValue(id, value) {
				var el = document.getElementById(id);
				if(el && value) {
					el.value = value;
				}
			}

			// Dong bo textarea goc truoc (day la du lieu that se submit len server)
			function setEditorValue(name, html) {
				var textarea = document.getElementsByName(name)[0];
				if(textarea) {
					textarea.value = html;
				}
				if(window.CKEDITOR && CKEDITOR.instances && CKEDITOR.instances[name]) {
					var editor = CKEDITOR.instances[name];
					try {
						editor.setData(html);
						editor.updateElement();
					} catch (ignored) {
						editor.on('instanceReady', function(){ editor.setData(html); editor.updateElement(); });
					}
				} else {
					// CKEditor chua khoi tao xong - dien lai khi san sang
					window.__aiCategoryPending = window.__aiCategoryPending || {};
					window.__aiCategoryPending[name] = html;
				}
			}

			if(window.CKEDITOR) {
				CKEDITOR.on('instanceReady', function(){
					var pending = window.__aiCategoryPending;
					if(!pending) return;
					for(var name in pending) {
						if(!pending.hasOwnProperty(name)) continue;
						if(CKEDITOR.instances[name]) {
							CKEDITOR.instances[name].setData(pending[name]);
							CKEDITOR.instances[name].updateElement();
						}
					}
				});
			}

			// Dien du lieu AI tra ve vao cac o input theo tung ngon ngu.
			// Tra ve so ngon ngu dien duoc de con bao cho nguoi dung biet.
			function fillLanguages(languages) {
				var filled = 0;
				if(!languages) {
					return filled;
				}
				for(var lang in languages) {
					if(!languages.hasOwnProperty(lang)) continue;

					// Cac tab ngon ngu he thong khong ho tro thi bo qua
					var idx = langIndex[lang];
					if(idx === undefined) {
						continue;
					}

					var l = languages[lang] || {};

					if(l.name) { setValue('name' + idx, l.name); filled++; }
					if(l.seUrl) setValue('seUrl' + idx, l.seUrl);
					if(l.shortDescription) setValue('categoryHighlight' + idx, l.shortDescription);
					if(l.description) setEditorValue('descriptions[' + idx + '].description', l.description);
					if(l.metaTitle) setValue('descriptions[' + idx + '].metatagTitle', l.metaTitle);
					if(l.metaKeywords) setValue('descriptions[' + idx + '].metatagKeywords', l.metaKeywords);
					if(l.metaDescription) setValue('descriptions[' + idx + '].metatagDescription', l.metaDescription);
				}
				return filled;
			}

			aiBtn.addEventListener('click', function(){
				// Ten danh muc nguoi dung da nhap: uu tien o dau tien co noi dung
				var categoryName = '';
				for(var lang in langIndex) {
					if(!langIndex.hasOwnProperty(lang)) continue;
					var el = document.getElementById('name' + langIndex[lang]);
					if(el && el.value && el.value.trim()) {
						categoryName = el.value.trim();
						break;
					}
				}
				if(!categoryName) {
					setAiStatus(CATEGORY_AI_I18N.needName);
					return;
				}

				setAiStatus(CATEGORY_AI_I18N.processing, '#333333');
				aiBtn.disabled = true;

				var xhr = new XMLHttpRequest();
				xhr.open('POST', '<c:url value="/api/v1/category/ai/generate"/>', true);
				xhr.setRequestHeader('Content-Type', 'application/json');
				xhr.onload = function() {
					aiBtn.disabled = false;
					if(xhr.status === 200) {
						try {
							var data = JSON.parse(xhr.responseText);
							var filled = fillLanguages(data.languages);
							// Ma danh muc chi dien khi o con trong de khong ghi de du lieu nguoi dung da nhap
							if(data.categoryCode) {
								var codeEl = document.getElementById('code');
								if(codeEl && !codeEl.value) {
									codeEl.value = data.categoryCode;
								}
							}
							if(filled === 0) {
								setAiStatus(CATEGORY_AI_I18N.missingFields);
								return;
							}
							setAiStatus(CATEGORY_AI_I18N.success, '#468847');
							setTimeout(function(){ setAiStatus(''); }, 10000);
						} catch (e) {
							setAiStatus(CATEGORY_AI_I18N.parseError);
						}
					} else {
						var msg = CATEGORY_AI_I18N.serverError + ' (' + xhr.status + ')';
						try {
							var err = JSON.parse(xhr.responseText);
							if(err && err.message) msg = err.message;
						} catch (ignored) {}
						setAiStatus(msg);
					}
				};
				xhr.onerror = function() {
					aiBtn.disabled = false;
					setAiStatus(CATEGORY_AI_I18N.noConnection);
				};

				// supported_languages: cac ngon ngu he thong dang bat tren form
				var supported = [];
				for(var lang in langIndex) {
					if(langIndex.hasOwnProperty(lang)) supported.push(lang);
				}

				xhr.send(JSON.stringify({
					category_name: categoryName,
					supported_languages: supported
				}));
			});
		}

		// Doi DOM san sang (nut nam trong <form> ben duoi khoi script nay)
		if(document.readyState === 'loading') {
			document.addEventListener('DOMContentLoaded', init);
		} else {
			init();
		}
	})();
	</script>
<div class="tabbable">
					<jsp:include page="/common/adminTabs.jsp" />

<c:set var="categoryLanguage" value="${LANGUAGE.code}" />
  					 <div class="tab-content">
    					<div class="tab-pane active" id="catalogue-section">
								<div class="sm-ui-component">
				<h3>
					<c:choose>
						<c:when test="${category.category.id!=null && category.category.id>0}">
								<s:message code="label.category.editcategory" text="Edit category" /> <c:out value="${category.category.code}"/>
						</c:when>
						<c:otherwise>
								<s:message code="label.category.createcategory" text="Create category" />
						</c:otherwise>
					</c:choose>
				</h3>
				<br/>
				<c:url var="categorySave" value="/admin/categories/save.html"/>

				<form:form method="POST" modelAttribute="category" action="${categorySave}">
      				<form:errors path="*" cssClass="alert alert-error" element="div" />
					<div id="store.success" class="alert alert-success" style="<c:choose><c:when test="${success!=null}">display:block;</c:when><c:otherwise>display:none;</c:otherwise></c:choose>"><s:message code="message.success" text="Request successfull"/></div>
      			 <div class="control-group">
                        <label><s:message code="label.category.parentcategory" text="Category vsible"/></label>
                        <div class="controls">
	                        <div class="controls">
	                        		<s:message code="label.category.root" text="Root" var="rootVar"/>
	                        		<form:select path="category.parent.id">
	                        			<form:option value="-1" label="${rootVar}" />
					  					<form:options items="${categories}" itemValue="category.id" itemLabel="descriptions[0].name"/>
				       				</form:select>
	                                <span class="help-inline"><form:errors path="category.parent.id" cssClass="error" /></span>
	                        </div>
                        </div>
                  </div>
				  <div class="control-group">
                        <label><s:message code="label.entity.visible" text="Visible"/></label>
                        <div class="controls">
                                    <form:checkbox path="category.visible" />

                        </div>
                  </div>
                  <div class="control-group">
                        <label><s:message code="label.entity.featured" text="Featured category"/></label>
                        <div class="controls">
                                    <form:checkbox path="category.featured" />

                        </div>
                  </div>
                  <div class="control-group">
                        <label><s:message code="label.category.code" text="Category code"/></label>
	                        <div class="controls">
	                        		<form:input cssClass="input-large highlight" id="code" path="category.code" onblur="validateCode(this)"/>
	                                <span class="help-inline"><div id="checkCodeStatus" style="display:none;"></div><form:errors path="category.code" cssClass="error" /></span>
	                        </div>
                  </div>
                 <c:forEach items="${category.descriptions}" var="description" varStatus="counter">
                 <c:set var="descriptionLanguage" value="${description.language.code==null ? categoryLanguage : description.language.code}" />
                 <c:if test="${counter.first}">
                 <div class="control-group" id="aiSuggestGroup">
                        <label><s:message code="button.label.suggest_category_with_AI" text="Gợi ý dữ liệu danh mục bằng AI"/></label>
                        <div class="controls">
                              <button type="button" id="aiSuggestBtn" class="btn btn-primary" style="margin-bottom:5px;">
                                    <i class="icon-magic"></i> <s:message code="button.label.suggest_with_AI" text="Gợi ý bằng AI"/> &#10024;
                              </button>
                              <span id="aiSuggestStatus" style="margin-left:10px;color:#d9534f;font-weight:bold;"></span>
                              <p class="help-inline" style="margin-top:5px;">
							  	<s:message code="button.label.AI_Suggest_Category_Description" text="Nhập Tên danh mục ở ô bên dưới, sau đó bấm nút này - AI sẽ tự động điền mã danh mục, tên, URL, mô tả và SEO cho tất cả ngôn ngữ. Bạn vẫn xem lại và chỉnh sửa trước khi lưu."/>
                              </p>
                        </div>
                 </div>
                 </c:if>
                 <div class="control-group">
                        <label><s:message code="label.productedit.categoryname" text="Category name"/> (<c:out value="${descriptionLanguage}"/>)</label>
                        <div class="controls">
                        				<form:input cssClass="input-large highlight" id="name${counter.index}" path="descriptions[${counter.index}].name"/>
                        						<span class="help-inline"><form:errors path="descriptions[${counter.index}].name" cssClass="error" /></span>
                        </div>
                 </div>
                 <div class="control-group">
                        <label><s:message code="label.category.highlight" text="Category highlight"/> (<c:out value="${descriptionLanguage}"/>)</label>
                        <div class="controls">
                        						<form:input cssClass="input-large" id="categoryHighlight${counter.index}" path="descriptions[${counter.index}].categoryHighlight"/>
                        						<span class="help-inline"><form:errors path="descriptions[${counter.index}].categoryHighlight" cssClass="error" /></span>
                        </div>
                 </div>
                 <div class="control-group">
                        <label><s:message code="label.sefurl" text="SEF Url"/> (<c:out value="${descriptionLanguage}"/>)</label>
                        <div class="controls">
                        			<form:input cssClass="highlight" id="seUrl${counter.index}" path="descriptions[${counter.index}].seUrl"/>
                        			<span class="help-inline"><form:errors path="descriptions[${counter.index}].seUrl" cssClass="error" /></span>
                        </div>
                  </div>
                  <div class="control-group">
                        <label><s:message code="label.category.categorydescription" text="Category description"/> (<c:out value="${descriptionLanguage}"/>)</label>
                        <div class="controls">
                        <textarea cols="30" id="descriptions[${counter.index}].description" class="ckeditor" name="descriptions[${counter.index}].description"><c:out value="${category.descriptions[counter.index].description}" escapeXml="false"/></textarea>
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
                        <label><s:message code="label.category.title" text="Metatag title"/> (<c:out value="${descriptionLanguage}"/>)</label>
                        <div class="controls">
                        			<form:input id="descriptions[${counter.index}].metatagTitle" path="descriptions[${counter.index}].metatagTitle"/>
                        			<span class="help-inline"><form:errors path="descriptions[${counter.index}].metatagTitle" cssClass="error" /></span>
                        </div>
                  </div>
                  <div class="control-group">
                        <label><s:message code="label.metatags.keywords" text="Metatag keywords"/> (<c:out value="${descriptionLanguage}"/>)</label>
                        <div class="controls">
                        			<form:input id="descriptions[${counter.index}].metatagKeywords" path="descriptions[${counter.index}].metatagKeywords"/>
                        			<span class="help-inline"><form:errors path="descriptions[${counter.index}].metatagKeywords" cssClass="error" /></span>
                        </div>
                  </div>
                 <div class="control-group">
                        <label><s:message code="label.metatags.description" text="Metatag description"/> (<c:out value="${descriptionLanguage}"/>)</label>
                        <div class="controls">
                        			<form:input id="descriptions[${counter.index}].metatagDescription" path="descriptions[${counter.index}].metatagDescription"/>
                        			<span class="help-inline"><form:errors path="descriptions[${counter.index}].metatagDescription" cssClass="error" /></span>
                        </div>
                  </div>
                  <form:hidden path="descriptions[${counter.index}].language.code" />
                  <form:hidden path="descriptions[${counter.index}].id" />
                  </c:forEach>
                  <div class="control-group">
                        <label><s:message code="label.entity.order" text="Sort order"/></label>
                        <div class="controls">
                                    <form:input id="order" cssClass="" path="category.sortOrder"/>
                                    <span class="help-inline"><form:errors path="category.sortOrder" cssClass="error" /></span>
                        </div>
                  </div>
                  <form:hidden path="category.id" />
			      <div class="form-actions">
                  		<div class="pull-right">
                  			<button type="submit" class="btn btn-success"><s:message code="button.label.submit" text="Submit"/></button>
                  		</div>
            	 </div>
            	 </form:form>
      					</div>
   					</div>
  					</div>
				</div>