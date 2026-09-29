
 

	/**
	 * Kiem tra khung dang nhap da duoc render san bang JSP chua.
	 * Dau hieu: ton tai #login (form dang nhap) hoac #signinPane trong trang.
	 *
	 * Khai bao truoc $(function(){}) de chac chan co san khi document ready.
	 */
	function hasServerRenderedLogin() {
		return document.getElementById('login') != null || document.getElementById('signinPane') != null;
	}

	/**
	 * Chuyen nut "Dang nhap bang Google / Facebook" vao menu tai khoan o header.
	 *
	 * Menu tai khoan cua template december duoc Hogan render bang JavaScript tu the
	 * <script type="text/html" id="customerNotLoggedInAccountTemplate">, nen KHONG
	 * the dat jsp:include truc tiep trong do (fragment chua <script> that se bi
	 * Hogan tra ve nhu van ban tho).
	 *
	 * Vi vay fragment duoc JSP render san vao #header-social-signin (vung an), roi
	 * ham nay chuyen noi dung vao cuoi menu tai khoan sau khi Hogan da render.
	 *
	 * Ham chay lai duoc nhieu lan: moi lan chi chuyen neu menu chua co nut, tranh
	 * nhan doi nut khi header duoc render lai.
	 */
	function moveSocialSignInToAccountMenu() {
		var source = document.getElementById('header-social-signin');
		if(!source) {
			return;
		}

		// Menu tai khoan that su dang hien (sau khi Hogan render) nam trong
		// #customerAccount, khong phai the <script type="text/html">.
		var menu = document.querySelector('#customerAccount .dropdown-menu');
		if(!menu) {
			return;
		}

		// Da chuyen roi thi khong lam lai.
		if(menu.querySelector('.header-social-signin')) {
			return;
		}

		var block = document.createElement('li');
		block.className = 'header-social-signin';
		while(source.firstChild) {
			block.appendChild(source.firstChild);
		}
		menu.appendChild(block);

		// Nut do JS ve sau khi DOM san sang, nen bao cho chung ve lai trong menu moi.
		if(window.shopizerInitGoogleSignIn) {
			window.shopizerInitGoogleSignIn();
		}
		if(window.shopizerInitFacebookSignIn) {
			window.shopizerInitFacebookSignIn();
		}
	}

	$(function(){
		//log('Check for customer account');
		if(supportsCustomerLogin()) {
			//
			// Mot so template (bootstrap, exoticamobilia) render khung dang nhap bang JSP ngay tren
			// trang de co the nhung fragment googleSignIn.jsp (chua nut dang nhap Google).
			// Trong truong hop do TUYET DOI khong duoc ghi de #customerAccount,
			// neu khong khung dang nhap se bi xoa mat.
			//
			if(!hasServerRenderedLogin()) {
				var template = document.getElementById("customerNotLoggedInAccountTemplate");
				if(template) {
					var customerNotLoggedInTemplate = Hogan.compile(template.innerHTML);
					var customerNotLoggedInRendered = customerNotLoggedInTemplate.render('');
					$('#customerAccount').html('');
					$('#customerAccount').append(customerNotLoggedInRendered);
				}
			}
			moveSocialSignInToAccountMenu();
			initUserAccount();
		}

	});

	function initUserAccount() {
		var userName = getUserName();
		//log('userName ' + userName);
		if(userName!=null) {
			displayUserAccount(userName);
		}
	}




function displayUserAccount(userName){
	url = getContextPath() + '/shop/customer/accountSummary.json?userName='+userName;
	$.ajax({
		 type: 'GET',
		 url: url,
		 error: function(xhr) {
			if(xhr.status==401) {//not authenticated
				removeUserName();
			}

		 },
		 success: function(customer) {
			 log('From account summary');
			 if(customer!=null) {
				 //display user
				 if($('#customerLoggedInAccountTemplate').length > 0) {
					var customerLoggedInTemplate = Hogan.compile(document.getElementById("customerLoggedInAccountTemplate").innerHTML);
					var customerLoggedInRendered = customerLoggedInTemplate.render(customer);
					$('#customerAccount').html('');
					$('#customerAccount').append(customerLoggedInRendered);
				 }
			 }
		} 
	});
}



/** returns the user name from the cookie **/
function getUserName() {
	
	var user = $.cookie('user'); //should be [storecode_userName]
	var code = new Array();
	
	if(user!=null) {
		user = user.replace(/['"]+/g, '');
		code = user.split('_');
		if(code[0]==getMerchantStoreCode()) {
			return code[1];
		}
	}
}

/** removes username from cookie **/
function removeUserName() {
	log('Removing user cookie');
	var userName = getUserName();
	if(userName!=null) {
		$.cookie('user',null, { expires: 1, path:'/' });
	}
	
}


