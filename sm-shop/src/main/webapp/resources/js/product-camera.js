/**
 * Tim san pham bang cach chup anh (Product image search).
 *
 * Luong hoat dong:
 *   1. Nguoi dung bam nut "Chup anh" o header.
 *   2. Mo modal, xin quyen camera (getUserMedia) va hien thi khung hinh truc tiep.
 *   3. Bam "Chup" -> ve mot khung hinh ra canvas -> chuyen thanh JPEG Base64.
 *   4. Gui Base64 len /shop/product/imageSearch.html.
 *   5. Backend goi AI nhan dien roi tim san pham khop trong catalogue.
 *   6. Hien thi ket qua; nguoi dung bam "Them vao gio" cho san pham muon mua.
 *
 * Anh KHONG duoc luu o dau ca - chi nam trong bo nho cua request.
 * Neu thiet bi khong co camera, nguoi dung van co the tai anh tu may len
 * (input type=file co capture) nho nut "Tai anh len".
 */
    (function (global) {
        'use strict';

        /**
         * Cau hinh duoc JSP ghi vao cac thuoc tinh data-* cua #product-camera-config.
         *
         * Doc bang getAttribute nen moi ky tu trong ban dich (dau nhay don, dau
         * ngoac kep...) deu nguyen ven - khong con rui ro lam vo cu phap JavaScript
         * nhu khi nhung truc tiep vao mot doi tuong JS.
         */
        var MESSAGE_KEYS = [
            ['title', 'data-msg-title'],
            ['hint', 'data-msg-hint'],
            ['shoot', 'data-msg-shoot'],
            ['upload', 'data-msg-upload'],
            ['retake', 'data-msg-retake'],
            ['search', 'data-msg-search'],
            ['searching', 'data-msg-searching'],
            ['detected', 'data-msg-detected'],
            ['quantity', 'data-msg-quantity'],
            ['noResults', 'data-msg-no-results'],
            ['addToCart', 'data-msg-add-to-cart'],
            ['adding', 'data-msg-adding'],
            ['added', 'data-msg-added'],
            ['addFailed', 'data-msg-add-failed'],
            ['searchFailed', 'data-msg-search-failed'],
            ['noCamera', 'data-msg-no-camera'],
            ['cameraDenied', 'data-msg-camera-denied'],
            ['notReady', 'data-msg-not-ready'],
            ['tooLarge', 'data-msg-too-large'],
            ['cannotRead', 'data-msg-cannot-read']
        ];

        function readConfig() {
            var el = document.getElementById('product-camera-config');
            var cfg = { contextPath: '', messages: {} };
            if (!el) {
                return cfg;
            }
            cfg.contextPath = el.getAttribute('data-context-path') || '';
            for (var i = 0; i < MESSAGE_KEYS.length; i++) {
                var key = MESSAGE_KEYS[i][0];
                cfg.messages[key] = el.getAttribute(MESSAGE_KEYS[i][1]) || '';
            }
            return cfg;
        }

        var config = readConfig();

        /** MediaStream dang mo (phai stop khi dong modal de tat den camera). */
        var stream = null;
        var modal = null;
        var video = null;

        function t(key, fallback) {
            var messages = config.messages || {};
            return messages[key] || fallback || key;
        }

        function log(message, error) {
            if (error && global.console && global.console.error) {
                global.console.error('[Product camera] ' + message, error);
            } else if (global.console && global.console.debug) {
                global.console.debug('[Product camera] ' + message);
            }
        }

        /* ------------------------------------------------------------------ *
         * Modal
         * ------------------------------------------------------------------ */

        /** Tao modal mot lan duy nhat roi tai su dung cho cac lan chup sau. */
        function buildModal() {
            if (modal) {
                return modal;
            }

            modal = document.createElement('div');
            modal.id = 'productCameraModal';
            modal.className = 'product-camera-modal';
            modal.setAttribute('role', 'dialog');
            modal.setAttribute('aria-modal', 'true');
            modal.style.display = 'none';

            modal.innerHTML =
                '<div class="product-camera-backdrop"></div>' +
                '<div class="product-camera-dialog">' +
                '  <div class="product-camera-header">' +
                '    <h4 class="product-camera-title"></h4>' +
                '    <button type="button" class="product-camera-close" aria-label="Close">&times;</button>' +
                '  </div>' +
                '  <div class="product-camera-body">' +
                '    <div class="product-camera-stage">' +
                '      <video class="product-camera-video" autoplay playsinline muted></video>' +
                '      <canvas class="product-camera-canvas" style="display:none;"></canvas>' +
                '      <img class="product-camera-preview" alt="" style="display:none;">' +
                '      <div class="product-camera-hint"></div>' +
                '    </div>' +
                '    <div class="product-camera-actions">' +
                '      <button type="button" class="btn btn-large product-camera-shoot"></button>' +
                '      <button type="button" class="btn btn-large product-camera-upload"></button>' +
                '      <button type="button" class="btn btn-large product-camera-retake" style="display:none;"></button>' +
                '      <button type="button" class="btn btn-large product-camera-search" style="display:none;"></button>' +
                '    </div>' +
                '    <input type="file" class="product-camera-file" accept="image/*" style="display:none;">' +
                '    <div class="product-camera-status" style="display:none;"></div>' +
                '    <div class="product-camera-error" style="display:none;"></div>' +
                '    <div class="product-camera-results"></div>' +
                '  </div>' +
                '</div>';

            document.body.appendChild(modal);

            video = modal.querySelector('.product-camera-video');

            // nut dong + bam ra ngoai de dong
            modal.querySelector('.product-camera-close').addEventListener('click', closeModal);
            modal.querySelector('.product-camera-backdrop').addEventListener('click', closeModal);
            modal.querySelector('.product-camera-shoot').addEventListener('click', function () {
                captureFrame();
            });
            modal.querySelector('.product-camera-upload').addEventListener('click', function () {
                modal.querySelector('.product-camera-file').click();
            });
            modal.querySelector('.product-camera-retake').addEventListener('click', function () {
                hidePreview();
                startCamera();
            });
            modal.querySelector('.product-camera-search').addEventListener('click', function () {
                var preview = modal.querySelector('.product-camera-preview');
                if (preview && preview.src) {
                    searchByImage(preview.src);
                }
            });
            modal.querySelector('.product-camera-file').addEventListener('change', function (e) {
                handleFile(e.target);
            });

            // phim Esc de dong
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' && modal.style.display !== 'none') {
                    closeModal();
                }
            });

            applyLabels();
            return modal;
        }

        /** Gan nhan da ban dia hoa vao cac phan tu cua modal. */
        function applyLabels() {
            if (!modal) {
                return;
            }
            modal.querySelector('.product-camera-title').textContent =
                t('title', 'Tìm sản phẩm bằng hình ảnh');
            modal.querySelector('.product-camera-hint').textContent =
                t('hint', 'Đưa sản phẩm vào giữa khung hình rồi bấm Chụp');
            modal.querySelector('.product-camera-shoot').textContent = t('shoot', 'Chụp ảnh');
            modal.querySelector('.product-camera-upload').textContent = t('upload', 'Tải ảnh lên');
            modal.querySelector('.product-camera-retake').textContent = t('retake', 'Chụp lại');
            modal.querySelector('.product-camera-search').textContent =
                t('search', 'Tìm sản phẩm này');
        }

        /* ------------------------------------------------------------------ *
         * Camera
         * ------------------------------------------------------------------ */

        function startCamera() {
            hidePreview();

            if (!global.navigator || !global.navigator.mediaDevices
                || !global.navigator.mediaDevices.getUserMedia) {
                showError(t('noCamera',
                    'Thiết bị hoặc trình duyệt không hỗ trợ camera. Vui lòng dùng "Tải ảnh lên".'));
                return;
            }

            // uu tien camera sau (dien thoai) vi thuong chup san pham
            var constraints = { video: { facingMode: { ideal: 'environment' } }, audio: false };

            global.navigator.mediaDevices.getUserMedia(constraints)
                .then(function (mediaStream) {
                    stream = mediaStream;
                    video.srcObject = mediaStream;
                    video.style.display = '';
                    showMessage('');
                    showError('');
                })
                .catch(function (error) {
                    log('cannot open camera', error);
                    // Thu lai bang camera mac dinh truoc khi bao loi
                    global.navigator.mediaDevices.getUserMedia({ video: true, audio: false })
                        .then(function (mediaStream) {
                            stream = mediaStream;
                            video.srcObject = mediaStream;
                            video.style.display = '';
                            showMessage('');
                            showError('');
                        })
                        .catch(function (secondError) {
                            log('cannot open default camera', secondError);
                            showError(t('cameraDenied',
                                'Không mở được camera. Vui lòng cấp quyền hoặc dùng "Tải ảnh lên".'));
                        });
                });
        }

        function stopCamera() {
            if (stream) {
                try {
                    stream.getTracks().forEach(function (track) {
                        track.stop();
                    });
                } catch (e) {
                    log('cannot stop camera tracks', e);
                }
                stream = null;
            }
            if (video) {
                video.srcObject = null;
            }
        }

        /* ------------------------------------------------------------------ *
         * Chup / chon anh
         * ------------------------------------------------------------------ */

        function captureFrame() {
            if (!video || !video.videoWidth) {
                showError(t('notReady', 'Camera chưa sẵn sàng, vui lòng chờ một chút.'));
                return;
            }

            var canvas = modal.querySelector('.product-camera-canvas');
            var maxWidth = 1024;
            var scale = Math.min(1, maxWidth / video.videoWidth);

            canvas.width = Math.round(video.videoWidth * scale);
            canvas.height = Math.round(video.videoHeight * scale);

            var ctx = canvas.getContext('2d');
            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

            showPreview(canvas.toDataURL('image/jpeg', 0.85));
        }

        function handleFile(input) {
            var file = input.files && input.files[0];
            if (!file) {
                return;
            }

            if (file.size > 8 * 1024 * 1024) {
                showError(t('tooLarge', 'Ảnh quá lớn (tối đa 8MB).'));
                input.value = '';
                return;
            }

            var reader = new FileReader();
            reader.onload = function (e) {
                // Thu nho anh tai len de tranh payload qua lon
                var img = new Image();
                img.onload = function () {
                    var maxWidth = 1024;
                    var scale = Math.min(1, maxWidth / img.width);
                    var canvas = modal.querySelector('.product-camera-canvas');
                    canvas.width = Math.round(img.width * scale);
                    canvas.height = Math.round(img.height * scale);
                    canvas.getContext('2d').drawImage(img, 0, 0, canvas.width, canvas.height);
                    showPreview(canvas.toDataURL('image/jpeg', 0.85));
                };
                img.onerror = function () {
                    showError(t('cannotRead', 'Không đọc được tệp ảnh.'));
                };
                img.src = e.target.result;
            };
            reader.onerror = function () {
                showError(t('cannotRead', 'Không đọc được tệp ảnh.'));
            };
            reader.readAsDataURL(file);
            input.value = '';
        }

        function showPreview(dataUrl) {
            stopCamera();
            var preview = modal.querySelector('.product-camera-preview');
            preview.src = dataUrl;
            preview.style.display = '';
            video.style.display = 'none';
            modal.querySelector('.product-camera-hint').style.display = 'none';
            modal.querySelector('.product-camera-retake').style.display = '';
            modal.querySelector('.product-camera-search').style.display = '';
            showError('');
            showMessage('');
            clearResults();
        }

        function hidePreview() {
            if (!modal) {
                return;
            }
            var preview = modal.querySelector('.product-camera-preview');
            preview.style.display = 'none';
            preview.src = '';
            video.style.display = '';
            modal.querySelector('.product-camera-hint').style.display = '';
            modal.querySelector('.product-camera-retake').style.display = 'none';
            modal.querySelector('.product-camera-search').style.display = 'none';
            clearResults();
        }

        /* ------------------------------------------------------------------ *
         * Goi API tim kiem
         * ------------------------------------------------------------------ */

        function searchByImage(dataUrl) {
            showError('');
            clearResults();
            setBusy(true, t('searching', 'Đang nhận diện sản phẩm, vui lòng chờ...'));

            var request = new Request(config.contextPath + '/shop/product/imageSearch.html', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json;charset=UTF-8' },
                credentials: 'same-origin',
                body: JSON.stringify({ imageBase64: dataUrl })
            });

            fetch(request)
                .then(function (response) {
                    return response.json().then(function (data) {
                        return { ok: response.ok, data: data };
                    });
                })
                .then(function (result) {
                    setBusy(false, '');
                    if (!result.ok) {
                        var message = (result.data && (result.data.message || result.data.error))
                            || t('searchFailed', 'Không tìm được sản phẩm. Vui lòng thử lại.');
                        showError(message);
                        return;
                    }
                    renderResults(result.data);
                })
                .catch(function (error) {
                    setBusy(false, '');
                    log('image search failed', error);
                    showError(t('searchFailed', 'Không tìm được sản phẩm. Vui lòng thử lại.'));
                });
        }

        /** Hien thi danh sach san pham tim duoc, moi san pham mot dong co so luong + nut them vao gio. */
        function renderResults(data) {
            if (!modal) {
                return;
            }
            var container = modal.querySelector('.product-camera-results');
            container.innerHTML = '';

            var rows = (data && data.products) || [];

            // Danh sach san pham AI nhan dien (co the nhieu san pham trong 1 khung hinh)
            var detectedList = (data && data.detected) || [];
            if (detectedList.length && typeof detectedList === 'object' && !detectedList.length) {
                detectedList = [detectedList];
            }
            var names = [];
            for (var d = 0; d < detectedList.length; d++) {
                if (detectedList[d] && detectedList[d].name) {
                    names.push(detectedList[d].name);
                }
            }
            if (names.length > 0) {
                var summary = document.createElement('p');
                summary.className = 'product-camera-detected';
                summary.textContent = t('detected', 'Đã nhận diện:') + ' ' + names.join(', ');
                container.appendChild(summary);
            }

            if (rows.length === 0) {
                var empty = document.createElement('p');
                empty.className = 'product-camera-empty';
                empty.textContent = t('noResults',
                    'Không tìm thấy sản phẩm phù hợp trong cửa hàng. Vui lòng thử chụp rõ hơn.');
                container.appendChild(empty);
                return;
            }

            var list = document.createElement('div');
            list.className = 'product-camera-result-list';

            for (var i = 0; i < rows.length; i++) {
                list.appendChild(buildResultRow(rows[i]));
            }

            container.appendChild(list);
        }

        /**
         * Tao URL anh day du tu duong dan ma backend tra ve.
         *
         * Backend co the tra ve 2 dang:
         *   - URL tuyet doi: "http://domain/static/products/..." (cau hinh local image)
         *   - Duong dan tuong doi: "/static/products/..." hoac "static/products/..."
         * Chi ghep contextPath cho dang tuong doi, neu khong se thanh
         * "<contextPath>http://..." va anh khong hien.
         *
         * imageType == 1 la video -> khong hien thi nhu anh.
         */
        function resolveImageUrl(image) {
            if (!image) {
                return '';
            }
            if (typeof image === 'object' && image.imageType === 1) {
                return '';
            }
            var path = typeof image === 'string' ? image : (image.imageUrl || image.externalUrl || '');
            if (!path) {
                return '';
            }
            if (/^(https?:)?\/\//i.test(path)) {
                return path;
            }
            var base = config.contextPath || '';
            return path.charAt(0) === '/' ? (base + path) : (base + '/' + path);
        }

        /**
         * Tao mot dong ket qua cho MOT san pham.
         *
         * Backend tra ve moi ket qua dang:
         *   { "product": {...ReadableProduct...},
         *     "quantity": <so luong TIM DUOC, luon = 1 cho moi san pham khop>,
         *     "inStock":  <so luong ton kho that, chi dung lam muc toi da> }
         *
         * So luong hien thi la SO LUONG TIM DUOC (khong phai ton kho trong database).
         * O so luong mac dinh bang so luong tim duoc, cho phep nguoi dung tang len
         * nhung khong vuot qua ton kho thuc (inStock).
         */
        function buildResultRow(row) {
            var product = (row && row.product) || row || {};
            // So luong hien thi = so luong tim duoc
            var foundQty = parseInt(row && row.quantity, 10);
            if (isNaN(foundQty) || foundQty < 1) {
                foundQty = 1;
            }
            // Ton kho that chi dung lam muc toi da khi them vao gio
            var inStock = parseInt(row && row.inStock, 10);
            if (isNaN(inStock) || inStock < foundQty) {
                inStock = foundQty;
            }

            var rowEl = document.createElement('div');
            rowEl.className = 'product-camera-result';

            var imageUrl = resolveImageUrl(product.image);

            // ReadableProduct khong co truong "name" o cap goc: ten nam trong description.name
            // (xem ReadableProductPopulator.populateDescription). Truong price la BigDecimal tho,
            // khong phai chuoi da dinh dang -> uu tien finalPrice (da format theo store).
            var name = (product.description && product.description.name) || product.name || '';
            var price = product.finalPrice || product.price || '';
            var productId = product.id;
            // friendlyUrl nam trong description (xem ReadableProductPopulator.populateDescription)
            var friendlyUrl = (product.description && product.description.friendlyUrl) || '';

            rowEl.innerHTML =
                '<div class="product-camera-result-image">' +
                (imageUrl ? '<img src="' + escapeAttribute(imageUrl) + '" alt="' + escapeAttribute(name) + '">' : '') +
                '</div>' +
                '<div class="product-camera-result-info">' +
                '  <p class="product-camera-result-name">' + escapeHtml(name) + '</p>' +
                '  <p class="product-camera-result-price">' + escapeHtml(price) + '</p>' +
                '</div>' +
                '<div class="product-camera-result-qty">' +
                '  <label class="product-camera-qty-label">' + escapeHtml(t('quantity', 'Số lượng')) + '</label>' +
                '  <input type="number" class="product-camera-qty-input" min="1" max="' + inStock + '" value="' + foundQty + '">' +
                '</div>';

            var detailUrl = friendlyUrl
                ? config.contextPath + '/shop/product/' + friendlyUrl + '.html'
                : '';

            // Bam vao anh hoac ten de xem chi tiet san pham
            var info = rowEl.querySelector('.product-camera-result-info');
            if (detailUrl) {
                var link = document.createElement('a');
                link.href = detailUrl;
                link.className = 'product-camera-result-link';
                link.textContent = name;
                info.querySelector('.product-camera-result-name').innerHTML = '';
                info.querySelector('.product-camera-result-name').appendChild(link);
            }

            // Anh loi (404, ten file sai...) thi bo khung anh thay vi de bieu tuong vo anh
            var image = rowEl.querySelector('.product-camera-result-image img');
            if (image) {
                if (detailUrl) {
                    var imageLink = document.createElement('a');
                    imageLink.href = detailUrl;
                    image.parentNode.insertBefore(imageLink, image);
                    imageLink.appendChild(image);
                }
                image.addEventListener('error', function () {
                    var box = rowEl.querySelector('.product-camera-result-image');
                    if (box) {
                        box.style.display = 'none';
                    }
                });
            }

            var button = document.createElement('button');
            button.type = 'button';
            button.className = 'btn btn-large product-camera-add';
            button.textContent = t('addToCart', 'Thêm vào giỏ');
            button.addEventListener('click', function () {
                var qtyInput = rowEl.querySelector('.product-camera-qty-input');
                var quantity = parseInt(qtyInput && qtyInput.value, 10);
                if (isNaN(quantity) || quantity < 1) {
                    quantity = 1;
                }
                // Khong cho them vuot qua ton kho thuc (inStock)
                if (quantity > inStock) {
                    quantity = inStock;
                    if (qtyInput) {
                        qtyInput.value = inStock;
                    }
                }
                addProductToCart(productId, quantity, button);
            });
            rowEl.appendChild(button);

            return rowEl;
        }

        /**
         * Them san pham vao gio bang endpoint co san cua shopizer.
         *
         * Tai day KHONG goi addToCart() cua shopping-cart.js vi ham do doc them
         * thuoc tinh san pham tu form chi tiet san pham (khong co tren header).
         * Payload o day chi gom productId + quantity, dung voi
         * ShoppingCartController.addShoppingCartItem.
         */
        function addProductToCart(productId, quantity, button) {
            if (!productId) {
                return;
            }

            var qty = parseInt(quantity, 10);
            if (isNaN(qty) || qty < 1) {
                qty = 1;
            }

            var originalText = button.textContent;
            button.disabled = true;
            button.textContent = t('adding', 'Đang thêm...');

            var cartCode = getCartCode ? getCartCode() : null;
            var payload = { quantity: qty, productId: productId };
            if (cartCode) {
                payload.code = cartCode;
            }

            var request = new Request(config.contextPath + '/shop/cart/addShoppingCartItem', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json;charset=UTF-8' },
                credentials: 'same-origin',
                body: JSON.stringify(payload)
            });

            fetch(request)
                .then(function (response) {
                    if (!response.ok) {
                        throw new Error('HTTP ' + response.status);
                    }
                    return response.json();
                })
                .then(function (cart) {
                    button.disabled = false;

                    if (cart && cart.message) {
                        // shopizer tra message khi san pham het hang / khong the them
                        button.textContent = originalText;
                        showError(cart.message);
                        return;
                    }

                    button.textContent = t('added', 'Đã thêm vào giỏ') + ' (' + qty + ')';

                    // Luu ma gio hang va cap nhat mini cart o header
                    if (cart && cart.code && typeof saveCart === 'function') {
                        saveCart(cart.code);
                    }
                    if (typeof displayMiniCart === 'function') {
                        displayMiniCart();
                    }
                    	if (typeof displayMiniCartSummary === 'function'
                    		&& cart && cart.code) {
                    		displayMiniCartSummary(cart.code);
                    	}

                    	// Khung hinh CHI dong khi nguoi dung bam nut dong (hoac Esc/bam ra ngoai).
                    	// Khong tu dong dong de nguoi dung xem lai ket qua va tiep tuc chon san pham.
                    })
                .catch(function (error) {
                    button.disabled = false;
                    button.textContent = originalText;
                    log('cannot add product to cart', error);
                    showError(t('addFailed', 'Không thêm được vào giỏ hàng. Vui lòng thử lại.'));
                });
        }

        /* ------------------------------------------------------------------ *
         * Tien ich hien thi
         * ------------------------------------------------------------------ */

        function setBusy(busy, message) {
            if (!modal) {
                return;
            }
            var stage = modal.querySelector('.product-camera-stage');
            stage.className = busy ? 'product-camera-stage is-busy' : 'product-camera-stage';
            showMessage(busy ? message : '');
            modal.querySelector('.product-camera-shoot').disabled = busy;
            modal.querySelector('.product-camera-upload').disabled = busy;
            modal.querySelector('.product-camera-retake').disabled = busy;
            modal.querySelector('.product-camera-search').disabled = busy;
        }

        function showMessage(message) {
            if (!modal) {
                return;
            }
            var el = modal.querySelector('.product-camera-status');
            el.textContent = message || '';
            el.style.display = message ? 'block' : 'none';
        }

        function showError(message) {
            if (!modal) {
                return;
            }
            var el = modal.querySelector('.product-camera-error');
            el.textContent = message || '';
            el.style.display = message ? 'block' : 'none';
        }

        function clearResults() {
            if (modal) {
                modal.querySelector('.product-camera-results').innerHTML = '';
            }
        }

        function escapeHtml(value) {
            return String(value == null ? '' : value)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        function escapeAttribute(value) {
            return escapeHtml(value);
        }

        /* ------------------------------------------------------------------ *
         * Mo / dong
         * ------------------------------------------------------------------ */

        function openModal() {
            buildModal();
            modal.style.display = '';
            document.body.className = (document.body.className + ' product-camera-open').trim();
            hidePreview();
            showError('');
            showMessage('');
            startCamera();
        }

        function closeModal() {
            stopCamera();
            if (modal) {
                modal.style.display = 'none';
            }
            document.body.className = document.body.className
                .replace(/\s*product-camera-open/g, '')
                .trim();
        }

        /** Gan su kien cho moi nut chup anh tren trang (header co the co 1 nut). */
        function bindTriggers() {
            var triggers = document.querySelectorAll('.product-camera-trigger');
            for (var i = 0; i < triggers.length; i++) {
                triggers[i].addEventListener('click', function (e) {
                    e.preventDefault();
                    openModal();
                });
            }
        }

        global.shopizerOpenProductCamera = openModal;
        global.shopizerCloseProductCamera = closeModal;

        if (document.readyState === 'complete' || document.readyState === 'interactive') {
            global.setTimeout(bindTriggers, 0);
        } else if (document.addEventListener) {
            document.addEventListener('DOMContentLoaded', bindTriggers);
        }

    }(window));