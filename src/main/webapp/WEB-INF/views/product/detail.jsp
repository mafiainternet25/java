<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} — QUOCSHOP</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatbot.css" />
    <style>
        :root {
            --brand: #4a90e2;
            --brand-light: #5c9ee6;
            --brand-dark: #357abd;
            --accent: #2c3e50;
            --bg-light: #f5f7fa;
            --text-dark: #2d3436;
            --text-gray: #636e72;
            --border-light: #dfe6e9;
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.05);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.07);
            --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
        }

        body {
            background-color: var(--bg-light);
            margin: 0;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
            color: var(--text-dark);
            line-height: 1.5;
        }

        .breadcrumb {
            background: white;
            padding: 16px 20px;
            margin-bottom: 24px;
            border-bottom: 1px solid var(--border-light);
        }

        .breadcrumb-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
        }

        .breadcrumb a {
            color: var(--brand);
            text-decoration: none;
            transition: all 0.3s;
        }

        .breadcrumb a:hover {
            color: var(--brand-dark);
        }

        .breadcrumb span {
            color: var(--text-gray);
        }

        .product-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px 40px;
        }

        .product-detail {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            margin-bottom: 40px;
            padding: 40px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: start;
        }

        .product-image-container {
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-light);
            border-radius: 12px;
            aspect-ratio: 1/1;
            overflow: hidden;
        }

        .product-image-container img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 20px;
        }

        .product-info h1 {
            font-size: 28px;
            color: var(--text-dark);
            margin: 0 0 16px 0;
            line-height: 1.3;
        }

        .product-category {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--text-gray);
            font-size: 14px;
            margin-bottom: 24px;
        }

        .product-category i {
            color: var(--brand);
            font-size: 14px;
        }

        .product-price {
            font-size: 32px;
            font-weight: 700;
            color: var(--brand);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .price-currency {
            font-size: 24px;
            font-weight: 500;
        }

        .product-description {
            color: var(--text-gray);
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 32px;
            padding-bottom: 32px;
            border-bottom: 1px solid var(--border-light);
        }

        .product-actions {
            display: flex;
            gap: 12px;
            margin-bottom: 32px;
            min-height: 50px;
        }

        .btn {
            padding: 14px 32px;
            border-radius: 8px;
            border: none;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--brand) 0%, var(--brand-light) 100%);
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: white;
            color: var(--brand);
            border: 2px solid var(--brand);
            flex: 1;
        }

        .btn-secondary:hover {
            background: var(--bg-light);
        }

        .product-details-tabs {
            border-top: 1px solid var(--border-light);
            padding-top: 32px;
        }

        .tabs-header {
            display: flex;
            gap: 32px;
            border-bottom: 2px solid var(--border-light);
            margin-bottom: 24px;
        }

        .tab-button {
            background: none;
            border: none;
            padding: 12px 0;
            font-size: 15px;
            font-weight: 600;
            color: var(--text-gray);
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }

        .tab-button.active {
            color: var(--brand);
        }

        .tab-button.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--brand);
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        .related-section {
            margin-top: 40px;
        }

        .section-title {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 24px;
        }

        .related-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-light);
            transition: all 0.3s;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .product-card-image {
            width: 100%;
            height: 200px;
            object-fit: contain;
            background: var(--bg-light);
            padding: 12px;
        }

        .product-card-info {
            padding: 16px;
        }

        .product-card-name {
            font-size: 15px;
            font-weight: 600;
            color: var(--text-dark);
            margin: 0 0 8px 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-card-price {
            font-size: 16px;
            font-weight: 700;
            color: var(--brand);
        }

        @media (max-width: 768px) {
            .product-grid {
                grid-template-columns: 1fr;
                gap: 24px;
            }

            .product-detail {
                padding: 24px;
            }

            .product-image-container {
                aspect-ratio: 4/3;
            }

            .product-info h1 {
                font-size: 22px;
            }

            .product-price {
                font-size: 24px;
            }

            .product-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .tabs-header {
                gap: 16px;
            }

            .related-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 16px;
            }
        }
    </style>
</head>
<body>
    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <div class="breadcrumb-content">
            <a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Trang chủ</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/products/search">Sản phẩm</a>
            <span>/</span>
            <span>${product.category}</span>
        </div>
    </div>

    <!-- Product Detail -->
    <div class="product-container">
        <div class="product-detail">
            <div class="product-grid">
                <!-- Product Image -->
                <div class="product-image-container">
                    <c:choose>
                        <c:when test="${not empty product.imageUrl}">
                            <img src="${product.imageUrl}" 
                                 alt="${product.name}"
                                 onerror="this.src='https://via.placeholder.com/500x500?text=No+Image';" />
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/500x500?text=No+Image"
                                 alt="${product.name}" />
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Product Info -->
                <div class="product-info">
                    <h1>${product.name}</h1>
                    
                    <div class="product-category">
                        <i class="fas fa-tag"></i>
                        <span>${product.category}</span>
                    </div>

                    <div class="product-price">
                        <span><fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="true" /></span>
                        <span class="price-currency">₫</span>
                    </div>

                    <div class="product-description">${product.description}</div>

                    <div class="product-actions">
                        <form method="post" action="${pageContext.request.contextPath}/cart/add" style="flex: 1;">
                            <input type="hidden" name="productId" value="${product.id}" />
                            <button type="submit" class="btn btn-primary" style="width: 100%; display: flex; align-items: center; justify-content: center; gap: 8px;">
                                <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
                            </button>
                        </form>
                        <button type="button" class="btn btn-secondary favorite-btn" data-product-id="${product.id}" style="flex: 1;">
                            <i class="fas fa-heart"></i> <span class="favorite-text">Yêu thích</span>
                        </button>
                    </div>

                    <div class="product-details-tabs">
                        <div class="tabs-header">
                            <button class="tab-button active" onclick="switchTab('specs', event)">
                                <i class="fas fa-info-circle"></i> Thông tin
                            </button>
                            <button class="tab-button" onclick="switchTab('reviews', event)">
                                <i class="fas fa-comments"></i> Đánh giá
                            </button>
                            <button class="tab-button" onclick="switchTab('shipping', event)">
                                <i class="fas fa-truck"></i> Vận chuyển
                            </button>
                        </div>

                        <div id="specs" class="tab-content active">
                            <p><strong>Mã sản phẩm:</strong> <span>${product.id}</span></p>
                            <p><strong>Danh mục:</strong> <span>${product.category}</span></p>
                            <p><strong>Tình trạng:</strong> Còn hàng</p>
                        </div>

                        <div id="reviews" class="tab-content">
                            <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                        </div>

                        <div id="shipping" class="tab-content">
                            <p><strong>Phí vận chuyển:</strong> Miễn phí</p>
                            <p><strong>Thời gian giao hàng:</strong> 3-5 ngày làm việc</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Related Products -->
        <c:if test="${not empty relatedProducts}">
            <div class="related-section">
                <h2 class="section-title">Sản phẩm liên quan</h2>
                <div class="related-grid">
                    <c:forEach var="relatedProduct" items="${relatedProducts}">
                        <div class="product-card">
                            <a href="${pageContext.request.contextPath}/products/${relatedProduct.id}" style="text-decoration: none; color: inherit;">
                                <c:choose>
                                    <c:when test="${not empty relatedProduct.imageUrl}">
                                        <img src="${relatedProduct.imageUrl}" 
                                             class="product-card-image" alt="${relatedProduct.name}"
                                             onerror="this.src='https://via.placeholder.com/300x300?text=No+Image';" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/300x300?text=No+Image"
                                             class="product-card-image" alt="${relatedProduct.name}" />
                                    </c:otherwise>
                                </c:choose>
                                <div class="product-card-info">
                                    <h3 class="product-card-name">${relatedProduct.name}</h3>
                                    <div class="product-card-price"><fmt:formatNumber value="${relatedProduct.price}" type="number" maxFractionDigits="0" groupingUsed="true" /> ₫</div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>

    <script>
        function switchTab(tabName, event) {
            event.preventDefault();
            
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Remove active class from all buttons
            document.querySelectorAll('.tab-button').forEach(btn => {
                btn.classList.remove('active');
            });
            
            // Show selected tab
            document.getElementById(tabName).classList.add('active');
            
            // Add active class to clicked button
            event.target.closest('.tab-button').classList.add('active');
        }

        // Favorite functionality
        document.addEventListener('DOMContentLoaded', function() {
            const favoriteBtn = document.querySelector('.favorite-btn');
            if (favoriteBtn) {
                const productId = favoriteBtn.getAttribute('data-product-id');
                
                // Check if product is already favorited
                checkFavoriteStatus(productId);
                
                // Add click handler
                favoriteBtn.addEventListener('click', function() {
                    toggleFavorite(productId);
                });
            }
        });

        const contextPath = '${pageContext.request.contextPath}';
        
        function checkFavoriteStatus(productId) {
            fetch(contextPath + '/favorites/check?productId=' + productId)
                .then(response => response.json())
                .then(data => {
                    updateFavoriteButton(data.isFavorited);
                })
                .catch(error => console.error('Error checking favorite status:', error));
        }

        function toggleFavorite(productId) {
            const favoriteBtn = document.querySelector('.favorite-btn');
            const isFavorited = favoriteBtn.classList.contains('favorited');
            
            const url = isFavorited ? contextPath + '/favorites/remove' : contextPath + '/favorites/add';
            
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'productId=' + productId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    updateFavoriteButton(data.isFavorited);
                }
            })
            .catch(error => console.error('Error toggling favorite:', error));
        }

        function updateFavoriteButton(isFavorited) {
            const favoriteBtn = document.querySelector('.favorite-btn');
            const icon = favoriteBtn.querySelector('i');
            const text = favoriteBtn.querySelector('.favorite-text');
            
            if (isFavorited) {
                favoriteBtn.classList.add('favorited');
                icon.style.color = '#ff6f61';
                icon.style.fontWeight = 'bold';
                text.textContent = 'Đã yêu thích';
            } else {
                favoriteBtn.classList.remove('favorited');
                icon.style.color = 'inherit';
                icon.style.fontWeight = 'normal';
                text.textContent = 'Yêu thích';
            }
        }
    </script>
<script src="${pageContext.request.contextPath}/js/chatbot.js"></script>
</body>
</html>


