<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>				
				
<script>
		function sapoSync() {
		var btn = document.getElementById('sapoSyncButton');
		btn.disabled = true;
		fetch('<c:url value="/api/v1/sapo/sync"/>', {method: 'POST', credentials: 'same-origin'})
		.then(function(response) {
			if (response.ok) {
				var msg = document.getElementById('sapoSyncSuccess');
				msg.style.display = 'block';
			} else {
				var msg = document.getElementById('sapoSyncError');
				msg.style.display = 'block';
			}
			btn.disabled = false;
		})
		.catch(function() {
			var msg = document.getElementById('sapoSyncError');
			msg.style.display = 'block';
			btn.disabled = false;
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
					                  

            	 			</form:form>
   		</div>
   	</div>
</div>