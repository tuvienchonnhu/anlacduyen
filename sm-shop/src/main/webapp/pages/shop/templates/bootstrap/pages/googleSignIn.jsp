<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

				CANH BAO: cac nhan duoc nhung vao doi tuong JavaScript ben duoi PHAI duoc
				escape an toan cho JS (dung googleJsQuote / googleJsBackslash ben duoi). Neu ghi
				truc tiep bang escapeXml="false", mot dau nhay don trong ban dich se ket thuc
				chuoi JS som -> loi cu phap -> window.shopizerGoogleSignIn khong duoc tao ->
				nut Google khong hien thi. Day chinh la loi chi xay ra voi tieng Phap vi nhan
				label.customer.google.error.notconfigured chua "n'est" (co dau nhay don).
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
					<s:message code="label.customer.signin.google" text="Sign in with Google" var="googleSigninLabel" />

					<%--
						Cac nhan duoc truyen sang JS qua thuoc tinh data-* chu KHONG nhung
						truc tiep vao doi tuong JavaScript.

						Ly do: <c:out> escape theo HTML nen moi ky tu deu an toan. Neu nhung
						truc tiep bang escapeXml="false", mot dau nhay don trong ban dich (vd
						tieng Phap "n'est", "d'ajouter") se ket thuc chuoi JS som -> loi cu phap
						-> window.shopizerGoogleSignIn khong duoc tao -> nut Google khong hien
						thi. Day chinh la loi chi xay ra voi tieng Phap.
					--%>
					<div class="google-signin-wrapper" id="google-signin-config"
						data-client-id="<c:out value="${googleSignInClientId}" />"
						data-context-path="<c:url value="" />"
						data-redirect="<c:url value="/shop/customer/dashboard.html" />"
						data-locale="<c:out value="${not empty googleLocale ? googleLocale : pageContext.request.locale.language}" />"
						data-msg-verifying="<c:out value="${googleVerifyingLabel}" />"
						data-msg-not-configured="<c:out value="${googleNotConfiguredLabel}" />"
						data-msg-failed="<c:out value="${googleFailedLabel}" />"
						data-msg-signin="<c:out value="${googleSigninLabel}" />">
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

					<script src="<c:url value="/resources/js/google-signin.js" />" type="text/javascript"></script>

				</c:if>