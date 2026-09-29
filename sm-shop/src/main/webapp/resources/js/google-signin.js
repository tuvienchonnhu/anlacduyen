/**
 * Dang nhap bang Google su dung Google Identity Services (GIS) SDK.
 *
 * SDK duoc Google tai bang <script src="https://accounts.google.com/gsi/client">
 * o cuoi trang. Callback onGoogleSignIn nhan ID token (credential) ma SDK tra ve
 * va gui len server de xac minh chu ky, audience, issuer truoc khi tao phien
 * dang nhap.
 *
 * Cac tham so duoc JSP truyen vao qua window.shopizerGoogleSignIn:
 *   clientId   - Google Client ID cau hinh trong Admin > Configuration
 *   contextPath- context path cua ung dung
 *   redirect   - URL chuyen huong khi dang nhap thanh cong
 *   messages   - thong bao loi da ban dia hoa
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
            card.className = busy ? 'google-signin-card is-busy' : 'google-signin-card';
        }
        var text = card && card.querySelector('.google-signin-status');
        if (text) {
            text.textContent = busy ? (config.messages && config.messages.verifying) || '' : '';
            text.style.display = busy ? 'block' : 'none';
        }
    }

    /**
     * Gui ID token len server. Server tra JSON {success:true, redirect:...}
     * hoac {success:false, message:...} (thong bao da ban dia hoa).
     */
    function sendCredentialToServer(card, config, idToken) {
        setBusy(card, config, true);
        showMessage(card, '');

        var params = new URLSearchParams();
        params.append('credential', idToken);

        var request = new Request(config.contextPath + '/shop/customer/google/token.html', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            credentials: 'same-origin',
            body: params.toString()
        });

        fetch(request)
            .then(function (response) {
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status);
                }
                return response.json();
            })
            		.then(function (data) {
            			if (data && data.success) {
            				global.location.href = data.redirect || config.redirect;
            				return;
            			}
            			setBusy(card, config, false);
            			showMessage(card, (data && data.message) || (config.messages && config.messages.failed));
            		})
            		.catch(function (error) {
            			setBusy(card, config, false);
            			log('unable to complete sign-in', error);
            			showMessage(card, (config.messages && config.messages.failed) || '');
            		});
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
            		if (!global.google || !global.google.accounts || !global.google.accounts.oauth2) {
            			// SDK chua san sang: dua nguoi dung sang trang dang nhap day du.
            			global.location.href = (config.contextPath || '') + '/shop/customer/customLogon.html';
            			return;
            		}

            		setBusy(card, config, true);
            		showMessage(card, '');

            var client = global.google.accounts.oauth2.initTokenClient({
                client_id: config.clientId,
                scope: 'openid email profile',
                callback: function (tokenResponse) {
                    if (!tokenResponse || !tokenResponse.id_token) {
                        setBusy(false);
                        showMessage((config.messages && config.messages.failed) || '');
                        return;
                    }
                    sendCredentialToServer(tokenResponse.id_token);
                }
            });
            client.requestAccessToken();
        });

        container.appendChild(button);
    }

    global.onGoogleSignIn = function (response) {
        if (!response || !response.credential) {
            log('no credential returned by Google Identity Services');
            return;
        }
        var cards = findCards();
        if (cards && cards.length > 0) {
            var card = cards[0];
            sendCredentialToServer(card, readConfigFrom(card), response.credential);
        }
    };

    /**
     * Khoi tao nut dang nhap Google tren TAT CA cac khung co tren trang.
     *
     * Nut do trang tu ve (buildSignInButton) de chu luon lay tu bundle theo ngon
     * ngu dang chon. Khong dung iframe cua google.accounts.id.renderButton() vi:
     *   - Google cache noi dung nut theo client_id, nen sau khi doi ngon ngu iframe
     *     van hien chu cua ngon ngu cu (trang tieng Phap nhung nut ghi tieng Viet);
     *   - Google Identity Services khong ho tro ma ngon ngu "vi".
     *
     * SDK chi con dung de lay ID token qua OAuth popup (google.accounts.oauth2),
     * duoc goi khi nguoi dung bam nut.
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