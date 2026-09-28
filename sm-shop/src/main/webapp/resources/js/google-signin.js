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
     * Cau hinh duoc JSP ghi vao cac thuoc tinh data-* cua #google-signin-config.
     *
     * Doc bang getAttribute nen moi ky tu trong ban dich (dau nhay don, dau
     * ngoac kep...) deu nguyen ven - khong con rui ro lam vo cu phap JavaScript
     * nhu khi nhung truc tiep vao mot doi tuong JS.
     */
    function readConfig() {
        var el = document.getElementById('google-signin-config');
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

    var config = readConfig();
    var card = document.getElementById('google-signin-card');

    /**
     * Khung dang nhap nam trong dropdown (display:none) nen Google Identity
     * Services khong the do duoc chieu rong that. Mac dinh lay 320px, rieng
     * trong #signinPane thi bang chieu rong khung tru di padding 2 ben.
     */
    function resolveButtonWidth() {
        var pane = document.getElementById('signinPane');
        if (pane) {
            var width = pane.clientWidth;
            if (width > 0) {
                return Math.max(200, Math.min(320, width - 36));
            }
            return 300;
        }
        return 320;
    }

    function log(message, error) {
        if (error && global.console && global.console.error) {
            global.console.error('[Google sign-in] ' + message, error);
        } else if (global.console && global.console.debug) {
            global.console.debug('[Google sign-in] ' + message);
        }
    }

    function showMessage(message) {
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

    function setBusy(busy) {
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
    function sendCredentialToServer(idToken) {
        setBusy(true);
        showMessage('');

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
                setBusy(false);
                showMessage((data && data.message) || (config.messages && config.messages.failed));
            })
            .catch(function (error) {
                setBusy(false);
                log('unable to complete sign-in', error);
                showMessage((config.messages && config.messages.failed) || '');
            });
    }

    /**
     * Google Identity Services chi ho tro mot so ma ngon ngu nhat dinh ("vi"
     * khong nam trong danh sach nay). Neu truyen mot ma khong duoc ho tro, SDK
     * co the bo qua va khong ve nut. Vi vay:
     *   - "vi" -> dua ve "en" (chu tieng Anh) thay vi de SDK that bai;
     *   - cac ma khac: giu nguyen, SDK se tu fallback theo cai dat cua nguoi dung.
     */
    var GIS_UNSUPPORTED_LOCALES = { vi: 'en' };

    function resolveGisLocale() {
        var locale = (config.locale || 'en').toLowerCase();
        return GIS_UNSUPPORTED_LOCALES[locale] || locale;
    }

    /**
     * Nut du phong: khi GIS SDK khong ve duoc nut (bi chan, mat mang, cache loi),
     * hien mot nut that su de nguoi dung khong bi ket. Chu tren nut lay tu bundle
     * theo ngon ngu dang chon (config.messages.signin) nen luon dung ngon ngu.
     */
    function showFallbackButton() {
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
        button.innerHTML = '<i class="fa fa-google"></i> '
            + ((config.messages && config.messages.signin) || 'Sign in with Google');

        // Nut du phong khong the dang nhap (khong co credential tu Google), nhung
        // dua nguoi dung sang trang dang nhap day du de khong bi ket.
        button.addEventListener('click', function () {
            var target = (config.contextPath || '') + '/shop/customer/customLogon.html';
            global.location.href = target;
        });

        container.appendChild(button);
    }

    /**
     * Kiem tra sau mot khoang thoi gian: neu GIS khong tao ra iframe nao trong
     * khung thi coi nhu that bai va hien nut du phong.
     */
    function verifyButtonRendered() {
        if (!card) {
            return;
        }
        var container = card.querySelector('.google-signin-button');
        if (!container) {
            return;
        }
        if (!container.querySelector('iframe')) {
            log('Google Identity Services did not render the button, showing fallback');
            showFallbackButton();
        }
    }

    global.onGoogleSignIn = function (response) {
        if (!response || !response.credential) {
            log('no credential returned by Google Identity Services');
            showMessage((config.messages && config.messages.failed) || '');
            return;
        }
        sendCredentialToServer(response.credential);
    };

    /**
     * Khoi tao GIS SDK: render nut Google chinh chu voi theme, kich thuoc va
     * ngon ngu theo trang hien tai.
     */
    global.shopizerInitGoogleSignIn = function () {
        config = readConfig();

        if (!card) {
            // Truong hop nut Google nam trong dropdown duoc render bang JSP sau khi
            // thay noi dung khung dang nhap -> tim lai phan tu.
            card = document.getElementById('google-signin-card');
        }
        if (!card) {
            return;
        }

        if (!config.clientId) {
            log('client id is not configured');
            showMessage((config.messages && config.messages.notConfigured) || '');
            return;
        }

        if (!global.google || !global.google.accounts || !global.google.accounts.id) {
            // SDK chua tai xong, thu lai sau mot nhip
            global.setTimeout(global.shopizerInitGoogleSignIn, 200);
            return;
        }

        var container = card.querySelector('.google-signin-button');
        if (!container) {
            return;
        }

        //
        // GIS SDK chi cho phep initialize() mot lan voi cung client_id, nhung
        // renderButton() co the goi lai. Khi nguoi dung doi ngon ngu, trang duoc
        // nap lai nen khoi tao moi la an toan.
        //
        global.google.accounts.id.initialize({
            client_id: config.clientId,
            callback: global.onGoogleSignIn,
            auto_select: false,
            cancel_on_tap_outside: true
        });

        // xoa nut cu (neu co) truoc khi render lai de tranh chong 2 iframe
        container.innerHTML = '';

        global.google.accounts.id.renderButton(container, {
            type: 'standard',
            theme: 'outline',
            size: 'large',
            text: 'signin_with',
            shape: 'rectangular',
            logo_alignment: 'left',
            width: resolveButtonWidth(),
            locale: resolveGisLocale()
        });

        // GIS ve nut bat dong bo ben trong mot iframe -> kiem tra sau mot nhip.
        global.setTimeout(verifyButtonRendered, 1500);
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