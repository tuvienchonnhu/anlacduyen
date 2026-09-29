<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

		<%-- Nut "Dang nhap bang Facebook" nam NGAY DUOI nut Google. KHONG duoc khai bao <%@ page session="false" %>
			trong file nay.
			Fragment duoc nhung bang jsp:include vao header.jsp, ben trong khoi
			<sec:authorize>. Directive page cua fragment se GHI DE trang cha, khien
				container khong tao HttpSession -> Spring Security khong doc duoc
				Authentication -> ca 3 nhanh sec:authorize deu truot -> toan bo khung
				dang nhap bien mat khoi header.

				App ID duoc lay theo thu tu uu tien:
				1. ${facebookAppId} - do controller cua trang logon/register dua vao model
				2. ${requestScope.CONFIGS['FACEBOOK_APP_ID']} - co san tren MOI trang nho
				StoreFilter, nen nut Facebook hoat dong ca trong dropdown o header.

				Ca hai deu rong khi cua hang chua cau hinh -> fragment khong hien thi gi.

				Nut do trang tu ve (khong dung iframe cua Facebook), chu lay tu bundle
				theo ngon ngu dang chon. Khi bam, trinh duyet duoc chuyen sang
				/shop/customer/facebook/login.html de bat dau luong OAuth.

				Moi nhan duoc truyen sang JS qua thuoc tinh data-* chu KHONG nhung truc
				tiep vao doi tuong JavaScript: <c:out> escape theo HTML nen moi ky tu deu
					an toan, tranh loi cu phap khi ban dich co dau nhay don (vd tieng Phap
					"n'est", "d'ajouter").
					--%>
					<c:set var="facebookSignInAppId"
						value="${not empty facebookAppId ? facebookAppId : requestScope.CONFIGS['FACEBOOK_APP_ID']}" />

					<c:if test="${not empty facebookSignInAppId}">

						<s:message code="label.customer.facebook.signin.only"
							text="Sign in quickly and securely with your Facebook account." var="facebookHintLabel" />
						<s:message code="label.customer.signin.facebook" text="Sign in with Facebook"
							var="facebookSigninLabel" />

						<div class="facebook-signin-wrapper" id="facebook-signin-config" data-app-id="<c:out value="
							${facebookSignInAppId}" />"
						data-context-path="
						<c:url value="" />"
						data-login-url="
						<c:url value="/shop/customer/facebook/login.html" />"
						data-locale="
						<c:out value="${not empty facebookLocale ? facebookLocale : 'en_US'}" />"
						data-msg-signin="
						<c:out value="${facebookSigninLabel}" />">
						<div id="facebook-signin-card" class="facebook-signin-card">
							<div class="facebook-signin-button"></div>
							<p class="facebook-signin-hint">
								<c:out value="${facebookHintLabel}" />
							</p>
						</div>
						</div>

						<script src="<c:url value=" /resources/js/facebook-signin.js" />" type="text/javascript">
						</script>

					</c:if>