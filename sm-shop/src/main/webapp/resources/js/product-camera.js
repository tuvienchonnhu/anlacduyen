m tin/**
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

        var config = global.shopizerProductCamera || {};

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

        /** Hien thi danh sach san pham tim duoc, moi san pham co nut them vao gio. */
        function renderResults(data) {
            if (!modal) {
                return;
            }
            var container = modal.querySelector('.product-camera-results');
            container.innerHTML = '';

            var products = (data && data.products) || [];
            var detected = (data && data.detected) || null;

            // Cho nguoi dung biet AI da nhan dien ra cai gi
            if (detected && detected.name) {
                var summary = document.createElement('p');
                summary.className = 'product-camera-detected';
                summary.textContent = t('detected', 'Đã nhận diện:') + ' ' + detected.name;
                container.appendChild(summary);
            }

            if (products.length === 0) {
                var empty = document.createElement('p');
                empty.className = 'product-camera-empty';
                empty.textContent = t('noResults',
                    'Không tìm thấy sản phẩm phù hợp trong cửa hàng. Vui lòng thử chụp rõ hơn.');
                container.appendChild(empty);
                return;
            }

            var list = document.createElement('div');
            list.className = 'product-camera-result-list';

            products.forEach(function (product) {
                list.appendChild(buildResultCard(product));
            });

            container.appendChild(list);
        }

        function buildResultCard(product) {
            var card = document.createElement('div');
            card.className = 'product-camera-result';

            var imageUrl = product.image
                ? (config.contextPath + product.image)
                : (config.placeholderImage || '');

            var name = product.name || '';
            var price = product.price || '';
            var productId = product.id;

            card.innerHTML =
                '<div class="product-camera-result-image">' +
                (imageUrl ? '<img src="' + escapeAttribute(imageUrl) + '" alt="' + escapeAttribute(name) + '">' : '') +
                '</div>' +
                '<div class="product-camera-result-info">' +
                '  <p class="product-camera-result-name">' + escapeHtml(name) + '</p>' +
                '  <p class="product-camera-result-price">' + escapeHtml(price) + '</p>' +
                '</div>';

            var button = document.createElement('button');
            button.type = 'button';
            button.className = 'btn btn-large product-camera-add';
            button.textContent = t('addToCart', 'Thêm vào giỏ');
            button.addEventListener('click', function () {
                addProductToCart(productId, button);
            });
            card.appendChild(button);

            return card;
        }

        /**
         * Them san pham vao gio bang endpoint co san cua shopizer.
         *
         * Tai day KHONG goi addToCart() cua shopping-cart.js vi ham do doc them
         * thuoc tinh san pham tu form chi tiet san pham (khong co tren header).
         * Payload o day chi gom productId + quantity, dung voi
         * ShoppingCartController.addShoppingCartItem.
         */
        function addProductToCart(productId, button) {
            if (!productId) {
                return;
            }

            var originalText = button.textContent;
            button.disabled = true;
            button.textContent = t('adding', 'Đang thêm...');

            var cartCode = getCartCode ? getCartCode() : null;
            var payload = { quantity: 1, productId: productId };
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

                    button.textContent = t('added', 'Đã thêm vào giỏ');

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

                    // Cho nguoi dung thay thong bao roi moi dong modal
                    global.setTimeout(closeModal, 1200);
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