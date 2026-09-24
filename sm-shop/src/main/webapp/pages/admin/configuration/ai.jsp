<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
		<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
			<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

				<%@ page session="false" %>

					<div class="tabbable">
						<jsp:include page="/common/adminTabs.jsp" />
						<div class="tab-content">
							<div class="tab-pane active" id="ai-conf">
								<div class="sm-ui-component">
									<h3>
										<s:message code="label.configuration.ai.title" text="AI Configuration" />
									</h3>
									<br />
									<c:url var="saveAiConfiguration"
										value="/admin/configuration/saveAiConfiguration.html" />
									<form:form method="POST" modelAttribute="configuration"
										action="${saveAiConfiguration}">
										<form:errors path="*" cssClass="alert alert-error" element="div" />
										<div id="store.success" class="alert alert-success"
											style="<c:choose><c:when test=" ${success!=null}">display:block;</c:when>
											<c:otherwise>display:none;</c:otherwise>
											</c:choose>">
											<s:message code="message.success" text="Request successfull" />
										</div>

										<c:forEach var="merchantConfig" items="${configuration.merchantConfigs}"
											varStatus="counter">
											<div class="control-group">
												<c:choose>
													<%-- Nha cung cap AI: hien thi dang dropdown de tranh nhap sai gia
														tri --%>
														<c:when test="${merchantConfig.key=='AI_PROVIDER'}">
															<label>
																<s:message code="label.configuration.AI_PROVIDER"
																	text="AI provider" /> &nbsp;:&nbsp;
															</label>
															<div class="controls">
																<form:select
																	path="merchantConfigs[${counter.index}].value">
																	<form:option value="gemini">
																		<s:message
																			code="label.configuration.AI_PROVIDER.gemini"
																			text="Google Gemini" />
																	</form:option>
																					<form:option value="openai">
																						<s:message
																							code="label.configuration.AI_PROVIDER.openai"
																							text="OpenAI" />
																					</form:option>
																											<form:option value="groq">
																												<s:message
																													code="label.configuration.AI_PROVIDER.groq"
																							text="Groq" />
																											</form:option>
																					<form:option value="cerebras">
																												<s:message
																													code="label.configuration.AI_PROVIDER.cerebras"
																													text="Cerebras" />
																											</form:option>
																</form:select>
																<form:hidden
																	path="merchantConfigs[${counter.index}].key" />
																<form:hidden
																	path="merchantConfigs[${counter.index}].id" />
																<span class="help-inline">
																	<form:errors
																		path="merchantConfigs[${counter.index}].key"
																		cssClass="error" />
																</span>
															</div>
														</c:when>
														<%-- Cac truong con lai (model, API key) nhap bang text nhu cu
															--%>
															<c:otherwise>
																<label>
																	<s:message
																		code="label.configuration.${merchantConfig.key}"
																		text="** Label for [label.configuration.${merchantConfig.key}] not found **" />
																	&nbsp;:&nbsp;
																</label>
																<div class="controls">
																	<form:input
																		path="merchantConfigs[${counter.index}].value" />
																	<form:hidden
																		path="merchantConfigs[${counter.index}].key" />
																	<form:hidden
																		path="merchantConfigs[${counter.index}].id" />
																	<span class="help-inline">
																		<form:errors
																			path="merchantConfigs[${counter.index}].key"
																			cssClass="error" />
																	</span>
																</div>
															</c:otherwise>
												</c:choose>
											</div>
										</c:forEach>

										<div class="form-actions">
											<div class="pull-right">
												<button type="submit" class="btn btn-success">
													<s:message code="button.label.submit" text="Submit" />
												</button>
											</div>
										</div>


									</form:form>
								</div>
							</div>
						</div>