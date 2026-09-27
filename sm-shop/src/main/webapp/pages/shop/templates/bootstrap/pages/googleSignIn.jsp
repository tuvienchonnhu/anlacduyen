<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

			<%--
				Nut "Dang nhap bang Google" dung Google Identity Services (GIS) SDK.

				KHONG duoc khai bao <%@ page session="false" %> trong file nay.
				Fragment duoc nhung bang jsp:include vao header.jsp, ben trong khoi
				<sec:authorize>. Directive page cua fragment se GHI DE trang cha, khien
				container khong tao HttpSession -> Spring Security khong doc duoc
				Authentication -> ca 3 nhanh sec:authorize deu truot -> toan bo khung
				dang nhap bien mat khoi header.

				Duoc nhung vao signinPane (header - moi trang), trang logon va trang register
				cua template nay.

				Client ID duoc lay theo thu tu uu tien:
				  1. ${googleClientId} - do controller cua trang logon/register dua vao model
				  2. ${requestScope.CONFIGS['GOOGLE_CLIENT_ID']} - co san tren MOI trang nho
				     StoreFilter, nen nut Google hoat dong ca trong dropdown o header.

				Ca hai deu rong khi cua hang chua cau hinh -> fragment khong hien thi gi.

				Moi nhan deu lay tu bundle qua s:message nen hien thi dung ngon ngu dang chon.
			--%>
			<c:set var="googleSignInClientId"
				value="${not empty googleClientId ? googleClientId : requestScope.CONFIGS['GOOGLE_CLIENT_ID']}" />

			<c:if test="${not empty googleSignInClientId}">

					<s:message code="label.customer.signin.social.or" text="or" var="googleOrLabel" />
					<s:message code="label.customer.google.signin.only"
						text="Sign in quickly and securely with your Google account." var="googleHintLabel" />
					<s:message code="label.customer.google.verifying" text="Verifying your account..."
						var="googleVerifyingLabel" />
					<s:message code="label.customer.google.error.notconfigured"
						text="Google sign-in is not configured. Please contact the administrator."
						var="googleNotConfiguredLabel" />
					<s:message code="label.customer.google.error.failed"
						text="Unable to sign in with Google. Please try again later." var="googleFailedLabel" />

					<div class="google-signin-wrapper">
						<span class="google-signin-divider">
							<c:out value="${googleOrLabel}" />
						</span>

						<div id="google-signin-card" class="google-signin-card">
							<div class="google-signin-button"></div>
							<p class="google-signin-hint">
								<c:out value="${googleHintLabel}" />
							</p>
							<p class="google-signin-status" style="display:none;"></p>
							<p class="google-signin-error" style="display:none;"></p>
						</div>
					</div>

					<script type="text/javascript">
						window.shopizerGoogleSignIn = {
							clientId: '<c:out value="${googleSignInClientId}" escapeXml="false"/>',
							contextPath: '<c:url value="/"/>'.replace(/\/$/, ''),
							redirect: '<c:url value="/shop/customer/dashboard.html"/>',
							locale: '<c:out value="${not empty googleLocale ? googleLocale : pageContext.request.locale.language}"/>',
							messages: {
								verifying: '<c:out value="${googleVerifyingLabel}" escapeXml="false"/>',
								notConfigured: '<c:out value="${googleNotConfiguredLabel}" escapeXml="false"/>',
								failed: '<c:out value="${googleFailedLabel}" escapeXml="false"/>'
							}
						};
					</script>

					<script src="<c:url value="/resources/js/google-signin.js" />" type="text/javascript"></script>
					<script src="https://accounts.google.com/gsi/client" async defer></script>

				</c:if>