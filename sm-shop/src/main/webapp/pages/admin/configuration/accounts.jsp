<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>				
				
<script>
		function sapoSync() {
		var btn = document.getElementById('sapoSyncButton');
		btn.disabled = true;
		var ok = document.getElementById('sapoSyncSuccess');
		var err = document.getElementById('sapoSyncError');
		ok.style.display = 'none';
		err.style.display = 'none';
		fetch('<c:url value="/api/v1/sapo/sync"/>', {method: 'POST', credentials: 'same-origin'})
		.then(function(response) {
			return response.text().then(function(text) {
				if (response.ok) {
					ok.textContent = '<s:message code="label.sapo.sync.success" text="Sapo products synced"/>: ' + text;
					ok.style.display = 'block';
				} else {
					err.textContent = '<s:message code="label.sapo.sync.error" text="Error"/>: HTTP ' + response.status + ' ' + text;
					err.style.display = 'block';
				}
				btn.disabled = false;
			});
		})
		.catch(function(e) {
			err.textContent = '<s:message code="label.sapo.sync.error" text="Error"/>: ' + e;
			err.style.display = 'block';
			btn.disabled = false;
		});
	}

		function sapoSyncCategories() {
		var btn = document.getElementById('sapoSyncCategoriesButton');
		btn.disabled = true;
		var ok = document.getElementById('sapoSyncCategoriesSuccess');
		var err = document.getElementById('sapoSyncCategoriesError');
		ok.style.display = 'none';
		err.style.display = 'none';
		fetch('<c:url value="/api/v1/sapo/sync-categories"/>', {method: 'POST', credentials: 'same-origin'})
		.then(function(response) {
			return response.text().then(function(text) {
				if (response.ok) {
					// Hien thi so danh muc da dong bo de biet ket qua that
					ok.textContent = '<s:message code="label.sapo.sync.categories.success" text="Sapo categories synced"/>: ' + text;
					ok.style.display = 'block';
				} else {
					err.textContent = '<s:message code="label.sapo.sync.categories.error" text="Error"/>: HTTP ' + response.status + ' ' + text;
					err.style.display = 'block';
				}
				btn.disabled = false;
			});
		})
		.catch(function(e) {
			err.textContent = '<s:message code="label.sapo.sync.categories.error" text="Error"/>: ' + e;
			err.style.display = 'block';
			btn.disabled = false;
		});
	}

		function sapoPushAll() {
		if (!confirm('<s:message code="label.sapo.push.confirm" text="Push all synced products to Sapo?"/>')) {
			return;
		}
		var btn = document.getElementById('sapoPushAllButton');
		btn.disabled = true;
		var ok = document.getElementById('sapoPushAllSuccess');
		var err = document.getElementById('sapoPushAllError');
		ok.style.display = 'none';
		err.style.display = 'none';
		fetch('<c:url value="/api/v1/sapo/push-all"/>', {method: 'POST', credentials: 'same-origin'})
		.then(function(response) {
			return response.text().then(function(text) {
				if (response.ok) {
					ok.textContent = '<s:message code="label.sapo.push.success" text="Pushed"/>: ' + text;
					ok.style.display = 'block';
				} else {
					err.textContent = '<s:message code="label.sapo.push.error" text="Error"/>: HTTP ' + response.status + ' ' + text;
					err.style.display = 'block';
				}
				btn.disabled = false;
			});
		})
		.catch(function(e) {
			err.textContent = '<s:message code="label.sapo.push.error" text="Error"/>: ' + e;
			err.style.display = 'block';
			btn.disabled = false;
		});
	}

		function sapoDiagnose() {
		var out = document.getElementById('sapoDiagnoseResult');
		out.style.display = 'block';
		out.textContent = '...';
		fetch('<c:url value="/api/v1/sapo/diagnose"/>', {method: 'GET', credentials: 'same-origin'})
		.then(function(response) {
			return response.text().then(function(text) {
				out.textContent = 'HTTP ' + response.status + '\n' + text;
			});
		})
		.catch(function(e) {
			out.textContent = 'Error: ' + e;
		});
	}

		function sapoDiagnoseSync() {
		var out = document.getElementById('sapoDiagnoseResult');
		out.style.display = 'block';
		out.textContent = '...';
		fetch('<c:url value="/api/v1/sapo/sync-categories-verbose"/>', {method: 'POST', credentials: 'same-origin'})
		.then(function(response) {
			return response.text().then(function(text) {
				out.textContent = 'HTTP ' + response.status + '\n' + text;
			});
		})
		.catch(function(e) {
			out.textContent = 'Error: ' + e;
		});
	}
</script>


<div class="tabbable">
	<jsp:include page="/common/adminTabs.jsp" />
		<div class="tab-content">
  			<div class="tab-pane active" id="accounts-conf">
				<div class="sm-ui-component">
					<h3><s:message code="label.configuration.options" text="Configuration options" /></h3>
					<br/>
						<c:url var="saveAccountsConfiguration" value="/admin/configuration/saveConfiguration.html"/>
							<form:form method="POST" modelAttribute="configuration" action="${saveAccountsConfiguration}">
								<form:errors path="*"  cssClass="alert alert-error" element="div" />
									<div id="store.success" class="alert alert-success" style="<c:choose><c:when test="${success!=null}">display:block;</c:when><c:otherwise>display:none;</c:otherwise></c:choose>"><s:message code="message.success" text="Request successfull"/></div>
									<c:forEach var="merchantConfig" items="${configuration.merchantConfigs}" varStatus="counter">


		                        	   <div class="control-group">
	                        				<label><s:message code="label.configuration.${merchantConfig.key}" text="** Label for [label.configuration.${merchantConfig.key}] not found **" /> &nbsp;:&nbsp;</label>
					                        <div class="controls">
					                        		<form:input  path="merchantConfigs[${counter.index}].value" />
											        <form:hidden  path="merchantConfigs[${counter.index}].key" />
											        <form:hidden  path="merchantConfigs[${counter.index}].id" />
					                                <span class="help-inline"><form:errors path="merchantConfigs[${counter.index}].key" cssClass="error" /></span>
					                        </div>
	                  				   </div>


	                        		</c:forEach>

	                        		<div class="form-actions">
	                        				<div class="pull-right">
	                        					<button type="submit" class="btn btn-success"><s:message code="button.label.submit" text="Submit"/></button>
	                        				</div>
	                        			</div>

	                        			<div id="sapoSyncSuccess" class="alert alert-success" style="display:none;"><s:message code="label.sapo.sync.success" text="Sapo products synced successfully"/></div>
	                        			<div id="sapoSyncError" class="alert alert-error" style="display:none;"><s:message code="label.sapo.sync.error" text="Error syncing products from Sapo"/></div>

	                        			<h3><s:message code="label.sapo.sync.title" text="Sync products from Sapo" /></h3>
	                        			<button type="button" id="sapoSyncButton" class="btn btn-primary" onclick="sapoSync();"><s:message code="label.sapo.sync.button" text="Sync products now"/></button>

	                        			<div id="sapoSyncCategoriesSuccess" class="alert alert-success" style="display:none;"><s:message code="label.sapo.sync.categories.success" text="Sapo categories synced successfully"/></div>
	                        			<div id="sapoSyncCategoriesError" class="alert alert-error" style="display:none;"><s:message code="label.sapo.sync.categories.error" text="Error syncing categories from Sapo"/></div>

	                        			<h3><s:message code="label.sapo.sync.categories.title" text="Sync categories from Sapo" /></h3>
	                        			<button type="button" id="sapoSyncCategoriesButton" class="btn btn-primary" onclick="sapoSyncCategories();"><s:message code="label.sapo.sync.categories.button" text="Sync categories now"/></button>

	                        			<div id="sapoPushAllSuccess" class="alert alert-success" style="display:none;"><s:message code="label.sapo.push.success" text="Products pushed to Sapo successfully"/></div>
	                        			<div id="sapoPushAllError" class="alert alert-error" style="display:none;"><s:message code="label.sapo.push.error" text="Error pushing products to Sapo"/></div>

	                        			<h3><s:message code="label.sapo.push.title" text="Push products to Sapo" /></h3>
	                        			<button type="button" id="sapoPushAllButton" class="btn btn-primary" onclick="sapoPushAll();"><s:message code="label.sapo.push.button" text="Push products to Sapo"/></button>

	                        			<h3><s:message code="label.sapo.diagnose.title" text="Diagnose Sapo connection" /></h3>
	                        			<button type="button" class="btn" onclick="sapoDiagnose();"><s:message code="label.sapo.diagnose.button" text="Diagnose"/></button>
	                        			<button type="button" class="btn" onclick="sapoDiagnoseSync();"><s:message code="label.sapo.diagnose.sync" text="Sync categories (detailed)"/></button>
	                        			<pre id="sapoDiagnoseResult" style="display:none; margin-top:10px; white-space:pre-wrap;"></pre>
					                  

            	 			</form:form>
   		</div>
   	</div>
</div>