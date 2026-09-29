/**
 * Nut "Dang nhap bang Google".
 *
 * Nut do trang tu ve (khong dung iframe cua Google) va khi bam se CHUYEN HUONG
 * sang /shop/customer/google/login.html de bat dau luong OAuth authorization code.
 * Toan bo viec doi code lay token, xac minh chu ky/audience/issuer va tao phien
 * dang nhap deu do server xu ly (xem GoogleOAuthController).
 *
 * Vi sao khong dung popup cua GIS SDK (google.accounts.oauth2.initTokenClient):
 *   - SDK la script ben thu ba (async defer) nen co the chua tai xong khi bam;
 *   - neu popup mo ma nguoi dung dong lai, SDK khong goi callback nao -> trang thai
 *     "dang xac minh" bi ket vinh vien;
 *   - popup con bi chan boi trinh duyet/trinh chan quang cao.
 *
 * Cac tham so duoc JSP truyen vao qua thuoc tinh data-* cua #google-signin-config:
 *   data-client-id   - Google Client ID cau hinh trong Admin > Configuration
 *   data-context-path- context path cua ung dung
 *   data-locale      - ma ngon ngu de hien thi (khong dung de ve nut)
 *   data-msg-signin  - nhan tren nut, da ban dia hoa
 */
(function (global) {
    'use strict';

    /**
     * Doc cau hinh cho MOT fragment cu the (moi fragment co #google-signin-config rieng).
     *
     * Doc bang getAttribute nen moi ky tu trong ban dich (dau nhay don, dau
     * ngoac kep...) deu nguyen ven - khong con rui ro lam vo cu phap JavaScript
     * nhu khi nhung truc tiep vao mot doi tuong JS.
     */
    function readConfigFrom(root) {
        var el = root.querySelector('#google-signin-config')
            || root.closest('.google-signin-wrapper')
            || document.getElementById('google-signin-config');
        if (!el) {
            return {};
        }
        return {
            clientId: el.getAttribute('data-client-id') || '',
            contextPath: el.getAttribute('data-context-path') || '',
            redirect: el.getAttribute('data-redirect') || '',
            locale: el.getAttribute('data-locale') || 'en',
            messages: {
                verifying: el.getAttribute('data-msg-verifying') || '',
                notConfigured: el.getAttribute('data-msg-not-configured') || '',
                failed: el.getAttribute('data-msg-failed') || '',
                signin: el.getAttribute('data-msg-signin') || ''
            }
        };
    }

    /**
     * Danh sach cac khung nut Google tren trang.
     *
     * Fragment duoc nhung o NHIEU noi (dropdown o header, trang logon, trang
     * register...), nen phai xu ly TAT CA chu khong chi phan tu dau tien - neu
     * chi lay mot phan tu thi nut o cac khung con lai se trong.
     */
    function findCards() {
        return document.querySelectorAll('#google-signin-card');
    }

    function log(message, error) {
        if (error && global.console && global.console.error) {
            global.console.error('[Google sign-in] ' + message, error);
        } else if (global.console && global.console.debug) {
            global.console.debug('[Google sign-in] ' + message);
        }
    }

    function showMessage(card, message) {
        if (!card) {
            return;
        }
        var text = card.querySelector('.google-signin-error');
        if (!text) {
            return;
        }
        text.textContent = message || '';
        text.style.display = message ? 'block' : 'none';
    }

    function setBusy(card, config, busy) {
        if (card) {
            // Dung classList thay vi gan lai className: className = '...' se xoa het
            // cac class khac cua the (ke ca class do template them vao), va lam mat
            // trang thai busy cua khung khac khi nhieu khung cung ton tai tren trang.
            if (busy) {
                card.classList.add('is-busy');
            } else {
                card.classList.remove('is-busy');
            }
        }
        var text = card && card.querySelector('.google-signin-status');
        if (text) {
            var messages = (config && config.messages) || {};
            text.textContent = busy ? (messages.verifying || '') : '';
            text.style.display = busy ? 'block' : 'none';
        }
    }

            /**
             * Nut dang nhap Google do CHUNG TA tu ve, chu lay tu bundle theo ngon ngu
             * dang chon.
             *
             * Ly do khong dung iframe cua google.accounts.id.renderButton():
             * Google cache noi dung nut theo client_id, nen sau khi nguoi dung doi ngon
             * ngu, iframe van hien chu cua ngon ngu truoc do (thuc te: da gap truong hop
             * trang tieng Phap nhung nut van ghi "Dang nhap bang Google").
             *
             * Doc chu tu data-msg-signin nen nut luon dung ngon ngu cua trang.
             */
            function buildSignInButton(card, config) {
            	if (!card || card.querySelector('.google-signin-fallback')) {
            		return;
            	}
            	var container = card.querySelector('.google-signin-button');
            	if (!container) {
            		return;
            	}

            	var button = document.createElement('button');
            	button.type = 'button';
            	button.className = 'google-signin-fallback';

            	button.textContent = '';
            	var icon = document.createElement('i');
            	icon.className = 'fa fa-google';
            	button.appendChild(icon);
            	var label = document.createElement('span');
            	label.textContent = (config.messages && config.messages.signin) || 'Sign in with Google';
            	button.appendChild(label);

            	button.addEventListener('click', function () {
            	    //
            	    // Chuyen huong sang /shop/customer/google/login.html de bat dau luong
            	    // OAuth authorization code, giong het nut Facebook.
            	    //
            	    // Vi sao khong dung popup cua google.accounts.oauth2 (initTokenClient):
            	    //   - SDK la script ben thu ba (async defer) nen co the chua tai xong;
            	    //   - neu popup mo ma nguoi dung dong lai, SDK khong goi callback nao
            	    //     -> trang thai "dang xac minh" bi ket vinh vien;
            	    //   - popup con bi chan boi trinh duyet/trinh chan quang cao.
            	    //
            	    // Luong chuyen huong khong phu thuoc SDK phia client, server tu doi
            	    // code lay token va xac minh, nguoi dung chi thay trang Google roi
            	    // quay lai dashboard.
            	    //
            	    var loginUrl = (config.contextPath || '') + '/shop/customer/google/login.html';
            	    global.location.href = loginUrl;
            	});

        container.appendChild(button);
    }

    /**
     * Khoi tao nut dang nhap Google tren TAT CA cac khung co tren trang.
     *
     * Nut do trang tu ve (buildSignInButton) de chu luon lay tu bundle theo ngon
     * ngu dang chon. Khong dung iframe cua google.accounts.id.renderButton() vi:
     *   - Google cache noi dung nut theo client_id, nen sau khi doi ngon ngu iframe
     *     van hien chu cua ngon ngu cu (trang tieng Phap nhung nut ghi tieng Viet);
     *   - Google Identity Services khong ho tro ma ngon ngu "vi".
     *
     * Khi bam, nut chuyen huong sang /shop/customer/google/login.html; toan bo
     * luong OAuth (doi code lay token, xac minh, dang nhap) do server xu ly nen
     * khong phu thuoc SDK phia client.
     */
    global.shopizerInitGoogleSignIn = function () {
        var cards = findCards();
        if (!cards || cards.length === 0) {
            return;
        }

        for (var i = 0; i < cards.length; i++) {
            var card = cards[i];
            var config = readConfigFrom(card);

            if (!config.clientId) {
                log('client id is not configured');
                showMessage(card, (config.messages && config.messages.notConfigured) || '');
                continue;
            }

            // Luon ve lai nut de chu khop ngon ngu hien tai.
            var container = card.querySelector('.google-signin-button');
            if (container) {
                container.innerHTML = '';
            }
            var existing = card.querySelector('.google-signin-fallback');
            if (existing && existing.parentNode) {
                existing.parentNode.removeChild(existing);
            }
            buildSignInButton(card, config);
        }
    };

    /**
     * Khi dropdown duoc mo, khung dang nhap moi co chieu rong thuc -> render lai
     * nut Google cho vua khung.
     */
    function bindDropdownRefresh() {
        if (!global.jQuery) {
            return;
        }
        global.jQuery(document).on('shown.bs.dropdown', function () {
            global.shopizerInitGoogleSignIn();
        });
    }

    if (document.readyState === 'complete' || document.readyState === 'interactive') {
        global.setTimeout(global.shopizerInitGoogleSignIn, 0);
    } else if (document.addEventListener) {
        document.addEventListener('DOMContentLoaded', global.shopizerInitGoogleSignIn);
    }

    bindDropdownRefresh();

}(window));