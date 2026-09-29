/**
 * Nut "Them tu khoa bang AI" o trang /admin/products/product/keywords.html.
 *
 * Luong xu ly:
 *   1. Gui POST /admin/products/product/generateKeywords.html?id={productId}
 *   2. Server doc TEN + MO TA san pham, goi AI sinh tu khoa cho moi ngon ngu
 *      ma cua hang dang ho tro, tra ve JSON:
 *        { success: true, sourceLanguage: "vi",
 *          languages: { "vi": ["..."], "en": ["..."], "fr": ["..."], "zh": [...] } }
 *   3. JS dien tung tu khoa vao o Keyword, doi o Language sang dung ngon ngu,
 *      bam "Them" roi cho form luu xong - lap lai cho tung tu khoa.
 *
 * AI khong tu ghi vao co so du lieu: moi tu khoa deu di qua form "Them" hien co,
 * nho vay du lieu luon duoc luu dung cho tung ngon ngu (metatagKeywords nam trong
 * ProductDescription theo ngon ngu).
 */
(function (global) {
    'use strict';

    /** Thoi gian cho toi da cho mot lan bam "Them" (ms). */
    var SUBMIT_TIMEOUT_MS = 15000;

    /** Khoang nghi nho giua cac lan submit, tranh qua tai server. */
    var SUBMIT_DELAY_MS = 300;

    function log(message, error) {
        if (error && global.console && global.console.error) {
            global.console.error('[Product keywords AI] ' + message, error);
        } else if (global.console && global.console.debug) {
            global.console.debug('[Product keywords AI] ' + message);
        }
    }

    function statusBox() {
        return document.getElementById('keyword-ai-status');
    }

    function setStatus(message, kind) {
        var box = statusBox();
        if (!box) {
            return;
        }
        if (!message) {
            box.style.display = 'none';
            box.textContent = '';
            return;
        }
        box.textContent = message;
        box.className = 'alert ' + (kind === 'error' ? 'alert-error' : 'alert-success');
        box.style.display = 'block';
    }

    /**
     * Form "Them" nam trong cung khoi tabbable voi nut AI.
     * Tra ve null neu khong tim thay (de bao loi ro rang thay vi im lang that bai).
     */
    function findKeywordForm() {
        var button = document.getElementById('generate-keywords-ai');
        if (!button) {
            return null;
        }
        var scope = button.closest('.sm-ui-component') || document;
        // Form them tu khoa la form duy nhat POST toi addKeyword.html
        var forms = scope.querySelectorAll('form');
        for (var i = 0; i < forms.length; i++) {
            var action = forms[i].getAttribute('action') || '';
            if (action.indexOf('addKeyword') !== -1) {
                return forms[i];
            }
        }
        return null;
    }

    function findInForm(form, name) {
        if (!form) {
            return null;
        }
        return form.querySelector('[name="' + name + '"]');
    }

    /**
     * Dien mot tu khoa va bam "Them", cho toi khi trang nap lai xong.
     *
     * Form "Them" la submit dong bo (server tra ve trang keywords.html), nen sau
     * khi submit thanh cong trang se duoc nap lai. Vi vay phai submit tuan tu:
     * moi tu khoa chi gui sau khi tu khoa truoc da luu xong.
     */
    function submitKeyword(form, keyword, languageCode) {

        return new Promise(function (resolve) {

            var keywordInput = findInForm(form, 'keyword');
            var languageSelect = findInForm(form, 'languageCode');

            if (!keywordInput || !languageSelect) {
                log('cannot find keyword or language field in the add form');
                resolve(false);
                return;
            }

            keywordInput.value = keyword;
            languageSelect.value = languageCode;

            log('adding keyword "' + keyword + '" for language ' + languageCode);

            // Cho qua thoi gian submit; form se lam trang nap lai nen khong co
            // callback nao chay tiep sau day trong cung execution context.
            global.setTimeout(function () {
                resolve(true);
            }, SUBMIT_DELAY_MS);

            form.submit();
        });
    }

    /**
     * Sau khi trang nap lai, tiep tuc gui cac tu khoa con lai.
     *
     * Hang doi duoc luu trong sessionStorage de song sot qua lan nap trang.
     */
    function queueKey() {
        var button = document.getElementById('generate-keywords-ai');
        return 'keywordAiQueue_' + (button ? button.getAttribute('data-product-id') : 'unknown');
    }

    function readQueue() {
        try {
            var raw = global.sessionStorage.getItem(queueKey());
            return raw ? JSON.parse(raw) : null;
        } catch (e) {
            return null;
        }
    }

    function writeQueue(queue) {
        try {
            if (!queue || queue.length === 0) {
                global.sessionStorage.removeItem(queueKey());
            } else {
                global.sessionStorage.setItem(queueKey(), JSON.stringify(queue));
            }
        } catch (e) {
            log('cannot persist keyword queue', e);
        }
    }

    /**
     * Gui tiep hang doi sau khi trang da nap lai.
     * Khong lam gi neu hang doi trong (truong hop binh thuong).
     */
    function resumeQueue() {

        var queue = readQueue();
        if (!queue || queue.length === 0) {
            return;
        }

        var form = findKeywordForm();
        if (!form) {
            log('add form not found, dropping the remaining queue');
            writeQueue(null);
            return;
        }

        var next = queue.shift();
        writeQueue(queue);

        // Thong bao tien do de Admin biet AI van dang dien.
        var total = (next.total || queue.length + 1);
        var done = total - queue.length;
        setStatus('(' + done + '/' + total + ') ' + (next.message || ''), 'success');

        submitKeyword(form, next.keyword, next.languageCode).then(function () {
            // Trang se nap lai, lan sau resumeQueue se gui tu khoa ke tiep.
        });
    }

    function buildQueue(languages, successMessage) {

        var queue = [];
        var codes = Object.keys(languages);

        codes.forEach(function (code) {
            var list = languages[code] || [];
            list.forEach(function (keyword) {
                queue.push({
                    keyword: keyword,
                    languageCode: code,
                    message: successMessage
                });
            });
        });

        var total = queue.length;
        queue.forEach(function (item) {
            item.total = total;
        });

        return queue;
    }

    function onGenerateClick(button) {

        var url = button.getAttribute('data-url');
        var productId = button.getAttribute('data-product-id');
        var working = button.getAttribute('data-msg-working');
        var success = button.getAttribute('data-msg-success');
        var failed = button.getAttribute('data-msg-failed');

        if (!url || !productId) {
            setStatus(failed, 'error');
            return;
        }

        // Ngon ngu Admin dang chon trong o Language: dung lam ngon ngu nguon cho AI.
        var form = findKeywordForm();
        var languageSelect = findInForm(form, 'languageCode');
        var sourceLanguage = languageSelect ? languageSelect.value : '';

        // Chong bam lap: tu khoa duoc them tuan tu, bam them se lam lech hang doi.
        if (readQueue()) {
            setStatus(working, 'success');
            return;
        }

        button.disabled = true;
        setStatus(working, 'success');

        var params = new URLSearchParams();
        params.append('id', productId);
        if (sourceLanguage) {
            params.append('languageCode', sourceLanguage);
        }

        fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            credentials: 'same-origin',
            body: params.toString()
        })
            .then(function (response) {
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status);
                }
                return response.json();
            })
            .then(function (data) {
                button.disabled = false;

                if (!data || !data.success) {
                    setStatus((data && data.message) || failed, 'error');
                    return;
                }

                var languages = data.languages || {};
                var queue = buildQueue(languages, success);
                if (queue.length === 0) {
                    setStatus(failed, 'error');
                    return;
                }

                log('AI returned keywords for languages: ' + Object.keys(languages).join(', '));

                // Gui tu khoa dau tien, phan con lai tiep tuc sau moi lan nap trang.
                var first = queue.shift();
                writeQueue(queue);
                setStatus(success, 'success');
                submitKeyword(form, first.keyword, first.languageCode);
            })
            .catch(function (error) {
                button.disabled = false;
                log('unable to generate keywords', error);
                setStatus(failed, 'error');
            });
    }

    function init() {
        var button = document.getElementById('generate-keywords-ai');
        if (!button) {
            return;
        }

        button.addEventListener('click', function () {
            onGenerateClick(button);
        });

        // Neu lan truoc bi gian doan giua chung (Admin dong tab), tiep tuc gui not.
        resumeQueue();
    }

    if (document.readyState === 'complete' || document.readyState === 'interactive') {
        global.setTimeout(init, 0);
    } else if (document.addEventListener) {
        document.addEventListener('DOMContentLoaded', init);
    }

}(window));