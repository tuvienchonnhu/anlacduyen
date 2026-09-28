<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

		<%-- Nut "Chup anh tim san pham" o header + cau hinh cho product-camera.js. KHONG dat directive <%@ page
			session="false" %> o day: fragment duoc nhung
			bang jsp:include, directive page cua fragment se ghi de trang cha va lam
			Spring Security mat phien (xem ghi chu trong googleSignIn.jsp).

			Cau hinh duoc truyen sang JS qua window.shopizerProductCamera, gom:
			contextPath - context path cua ung dung
			messages - nhan da ban dia hoa lay tu bundle theo ngon ngu dang chon

			Moi template CHI include fragment nay DUNG MOT LAN, o mot vi tri thay hop voi
			bo cuc header cua template do. Include hai lan se tao hai nut va ghi de
			window.shopizerProductCamera.

			Nut chi hien thi khi:
			  - tinh nang AI da duoc cau hinh (co API key), tranh de nguoi dung bam vao roi
			    gap thong bao loi;
			  - dang khong o trang gio hang / dat hang (checkout).
			--%>

			<c:set var="productCameraEnabled" value="${not empty requestScope.CONFIGS['GEMINI_API_KEY']
		or not empty requestScope.CONFIGS['AI_OPENAI_API_KEY']
		or not empty requestScope.CONFIGS['AI_GROQ_API_KEY']
		or not empty requestScope.CONFIGS['AI_CEREBRAS_API_KEY']
		or not empty requestScope.CONFIGS['AI_GOOGLE_VISION_API_KEY']}" />

			<%-- Khong hien nut o trang gio hang va trang dat hang (checkout): nguoi dung dang
				hoan tat don hang, them mot loi vao giua se lam roi luong mua hang.
				Cung dieu kien voi minicart o template bootstrap. --%>
			<c:set var="productCameraPage"
				value="${not fn:contains(requestScope['javax.servlet.forward.servlet_path'], 'order')
				and not fn:contains(requestScope['javax.servlet.forward.servlet_path'], 'cart')}" />

			<c:if test="${productCameraEnabled and productCameraPage}">

				<s:message code="label.product.camera.button" text="Chụp ảnh tìm sản phẩm" var="pcButton" />
				<s:message code="label.product.camera.title" text="Tìm sản phẩm bằng hình ảnh" var="pcTitle" />
				<s:message code="label.product.camera.hint" text="Đưa sản phẩm vào giữa khung hình rồi bấm Chụp"
					var="pcHint" />
				<s:message code="label.product.camera.shoot" text="Chụp ảnh" var="pcShoot" />
				<s:message code="label.product.camera.upload" text="Tải ảnh lên" var="pcUpload" />
				<s:message code="label.product.camera.retake" text="Chụp lại" var="pcRetake" />
				<s:message code="label.product.camera.search" text="Tìm sản phẩm này" var="pcSearch" />
				<s:message code="label.product.camera.searching" text="Đang nhận diện sản phẩm, vui lòng chờ..."
					var="pcSearching" />
				<s:message code="label.product.camera.detected" text="Đã nhận diện:" var="pcDetected" />
				<s:message code="label.product.camera.quantity" text="Số lượng tìm được" var="pcQuantity" />
				<s:message code="label.product.camera.noResults"
					text="Không tìm thấy sản phẩm phù hợp trong cửa hàng. Vui lòng thử chụp rõ hơn."
					var="pcNoResults" />
				<s:message code="label.product.camera.addToCart" text="Thêm vào giỏ" var="pcAddToCart" />
				<s:message code="label.product.camera.adding" text="Đang thêm..." var="pcAdding" />
				<s:message code="label.product.camera.added" text="Đã thêm vào giỏ" var="pcAdded" />
				<s:message code="label.product.camera.addFailed" text="Không thêm được vào giỏ hàng. Vui lòng thử lại."
					var="pcAddFailed" />
				<s:message code="label.product.camera.searchFailed" text="Không tìm được sản phẩm. Vui lòng thử lại."
					var="pcSearchFailed" />
				<s:message code="label.product.camera.noCamera"
					text="Thiết bị hoặc trình duyệt không hỗ trợ camera. Vui lòng dùng &quot;Tải ảnh lên&quot;."
					var="pcNoCamera" />
				<s:message code="label.product.camera.cameraDenied"
					text="Không mở được camera. Vui lòng cấp quyền hoặc dùng &quot;Tải ảnh lên&quot;."
					var="pcCameraDenied" />
				<s:message code="label.product.camera.notReady" text="Camera chưa sẵn sàng, vui lòng chờ một chút."
					var="pcNotReady" />
				<s:message code="label.product.camera.tooLarge" text="Ảnh quá lớn (tối đa 8MB)." var="pcTooLarge" />
				<s:message code="label.product.camera.cannotRead" text="Không đọc được tệp ảnh." var="pcCannotRead" />

				<%-- Nut tren header: logic mo modal nam trong product-camera.js --%>
					<div class="btn-group dropdown">
						<button type="button" class="btn product-camera-trigger" title="<c:out value="${pcButton}" />">
						<i class="fa fa-camera"></i>
						<span class="no-responsive uppercase">
							<c:out value="${pcButton}" />
						</span>
						</button>
					</div>

					<%--
						Cac nhan duoc truyen sang JS qua thuoc tinh data-* chu KHONG nhung
						truc tiep vao doi tuong JavaScript.

						Ly do: <c:out> escape theo HTML nen moi ky tu deu an toan. Neu nhung
						truc tiep bang escapeXml="false", mot dau nhay don trong ban dich (vd
						tieng Phap "d'ajouter", "n'est") se ket thuc chuoi JS som -> loi cu phap
						-> window.shopizerProductCamera khong duoc tao -> nut chup anh hong.
					--%>
					<span id="product-camera-config" style="display:none;"
						data-context-path="<c:url value="" />"
						data-msg-title="<c:out value="${pcTitle}" />"
						data-msg-hint="<c:out value="${pcHint}" />"
						data-msg-shoot="<c:out value="${pcShoot}" />"
						data-msg-upload="<c:out value="${pcUpload}" />"
						data-msg-retake="<c:out value="${pcRetake}" />"
						data-msg-search="<c:out value="${pcSearch}" />"
						data-msg-searching="<c:out value="${pcSearching}" />"
						data-msg-detected="<c:out value="${pcDetected}" />"
						data-msg-quantity="<c:out value="${pcQuantity}" />"
						data-msg-no-results="<c:out value="${pcNoResults}" />"
						data-msg-add-to-cart="<c:out value="${pcAddToCart}" />"
						data-msg-adding="<c:out value="${pcAdding}" />"
						data-msg-added="<c:out value="${pcAdded}" />"
						data-msg-add-failed="<c:out value="${pcAddFailed}" />"
						data-msg-search-failed="<c:out value="${pcSearchFailed}" />"
						data-msg-no-camera="<c:out value="${pcNoCamera}" />"
						data-msg-camera-denied="<c:out value="${pcCameraDenied}" />"
						data-msg-not-ready="<c:out value="${pcNotReady}" />"
						data-msg-too-large="<c:out value="${pcTooLarge}" />"
						data-msg-cannot-read="<c:out value="${pcCannotRead}" />"></span>

					<script src="<c:url value="/resources/js/product-camera.js" />" type="text/javascript"></script>

			</c:if>