/**
 * Dang nhap bang Facebook.
 *
 * Nut do trang tu ve (khong dung iframe cua Facebook), chu lay tu bundle theo
 * ngon ngu dang chon. Khi bam, trinh duyet duoc chuyen sang
 * /shop/customer/facebook/login.html - controller se tao state chong CSRF roi
 * chuyen tiep sang trang dong y cap quyen cua Facebook.
 *
 * Cac tham so duoc JSP truyen vao qua thuoc tinh data-* cua #facebook-signin-config:
 *   data-app-id      - Facebook App ID cau hinh trong Admin > Configuration
 *   data-context-path- context path cua ung dung
 *   data-login-url   - URL bat dau luong dang nhap
 *   data-locale      - ma ngon ngu kieu Facebook (vi_VN, fr_FR)
 *   data-msg-signin  - nhan tren nut, da ban dia hoa
 */
(function (global) {
    'use strict';

    /**
     * Doc cau hinh cho MOT fragment cu the (moi fragment co #facebook-signin-config rieng).
     *
     * Doc bang getAttribute nen moi ky tu trong ban dich (dau nhay don, dau
     * ngoac kep...) deu nguyen ven - khong con rui ro lam vo cu phap JavaScript.
     */
    function readConfigFrom(root) {
        var el = root.querySelector('#facebook-signin-config') || document.getElementById('facebook-signin-config');
        if (!el) {
            return {};
        }
        return {
            appId: el.getAttribute('data-app-id') || '',
            contextPath: el.getAttribute('data-context-path') || '',
            loginUrl: el.getAttribute('data-login-url') || '',
            locale: el.getAttribute('data-locale') || 'en_US',
            messages: {
                signin: el.getAttribute('data-msg-signin') || ''
            }
        };
    }

    /**
     * Danh sach cac khung nut Facebook tren trang.
     *
     * Fragment duoc nhung o NHIEU noi (dropdown o header, trang logon, trang
     * register...), nen phai xu ly TAT CA chu khong chi phan tu dau tien - neu
     * chi lay mot phan tu thi nut o cac khung con lai se trong.
     */
    function findCards() {
        return document.querySelectorAll('#facebook-signin-card');
    }

    function log(message, error) {
        if (error && global.console && global.console.error) {
            global.console.error('[Facebook sign-in] ' + message, error);
        } else if (global.console && global.console.debug) {
            global.console.debug('[Facebook sign-in] ' + message);
        }
    }

    /** Nut dang nhap Facebook do trang tu ve, chu lay tu bundle. */
    function buildSignInButton(card, config) {
        if (!card || card.querySelector('.facebook-signin-fallback')) {
            return;
        }
        var container = card.querySelector('.facebook-signin-button');
        if (!container) {
            return;
        }

        var button = document.createElement('button');
        button.type = 'button';
        button.className = 'facebook-signin-fallback';

        var icon = document.createElement('i');
        icon.className = 'fa fa-facebook';
        button.appendChild(icon);

        var label = document.createElement('span');
        label.textContent = config.messages.signin || 'Sign in with Facebook';
        button.appendChild(label);

        button.addEventListener('click', function () {
            var url = config.loginUrl
                || ((config.contextPath || '') + '/shop/customer/facebook/login.html');
            global.location.href = url;
        });

        container.appendChild(button);
    }

    /**
     * Khoi tao nut dang nhap Facebook tren TAT CA cac khung co tren trang.
     *
     * Luon ve lai nut de chu khop ngon ngu hien tai (trang duoc nap lai khi doi
     * ngon ngu, nhung dropdown co the duoc mo lai sau do).
     */
    global.shopizerInitFacebookSignIn = function () {
        var cards = findCards();
        if (!cards || cards.length === 0) {
            return;
        }

        for (var i = 0; i < cards.length; i++) {
            var card = cards[i];
            var config = readConfigFrom(card);

            if (!config.appId) {
                log('app id is not configured');
                continue;
            }

            var container = card.querySelector('.facebook-signin-button');
            if (container) {
                container.innerHTML = '';
            }
            var existing = card.querySelector('.facebook-signin-fallback');
            if (existing && existing.parentNode) {
                existing.parentNode.removeChild(existing);
            }

            buildSignInButton(card, config);
        }
    };

    /** Khi dropdown duoc mo, khung dang nhap moi co kich thuoc thuc -> ve lai nut. */
    function bindDropdownRefresh() {
        if (!global.jQuery) {
            return;
        }
        global.jQuery(document).on('shown.bs.dropdown', function () {
            global.shopizerInitFacebookSignIn();
        });
    }

    if (document.readyState === 'complete' || document.readyState === 'interactive') {
        global.setTimeout(global.shopizerInitFacebookSignIn, 0);
    } else if (document.addEventListener) {
        document.addEventListener('DOMContentLoaded', global.shopizerInitFacebookSignIn);
    }

    bindDropdownRefresh();

}(window));