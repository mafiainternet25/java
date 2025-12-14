<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} — QUOCSHOP</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatbot.css" />
    <style>
        :root {
            --primary: #ff6f61;
            --secondary: #2c3e50;
            --accent: #3498db;
            --text: #333;
            --light: #f8f9fa;
            --border: #e0e0e0;
        }

        .favorites-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 20px;
        }

        .favorites-header {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .favorites-header h1 {
            margin: 0;
            font-size: 2rem;
            color: var(--secondary);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .favorites-header h1 i {
            color: var(--primary);
            font-size: 2.5rem;
        }

        .favorites-count {
            background: var(--primary);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: bold;
        }

        .favorites-empty {
            background: white;
            padding: 4rem 2rem;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .empty-icon {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 1rem;
        }

        .empty-text {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .btn-back {
            display: inline-block;
            background: var(--primary);
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-back:hover {
            background: #ff5a4c;
            transform: translateY(-2px);
        }

        .favorites-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            gap: 1rem;
        }

        .favorites-toolbar .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            font-size: 0.95rem;
        }

        .back-link {
            color: #666;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
            transition: all 0.3s;
        }

        .back-link:hover {
            color: var(--primary);
            transform: translateX(-4px);
        }

        .back-link i {
            font-size: 14px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
            padding: 1rem 0;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s;
            position: relative;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .product-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .product-card:hover .product-image {
            transform: scale(1.05);
        }

        .product-info {
            padding: 1rem;
        }

        .product-name {
            font-size: 1.1rem;
            font-weight: bold;
            color: var(--secondary);
            margin-bottom: 0.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-price {
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        .product-category {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 1rem;
        }

        .card-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn-view {
            flex: 1;
            background: var(--accent);
            color: white;
            padding: 0.7rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }

        .btn-view:hover {
            background: #2980b9;
        }

        .btn-remove {
            flex: 1;
            background: white;
            color: var(--primary);
            padding: 0.7rem;
            border: 1px solid var(--primary);
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }

        .btn-remove:hover {
            background: var(--primary);
            color: white;
        }

        @media (max-width: 768px) {
            .favorites-header {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }

            .favorites-header h1 {
                font-size: 1.5rem;
            }

            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            }
        }
    </style>
</head>
<body>
    <div class="favorites-container">
        <!-- Toolbar with back button -->
        <div class="favorites-toolbar">
            <a href="${pageContext.request.contextPath}/" class="back-link">
                <i class="fas fa-arrow-left"></i>
                <span>Quay lại trang chủ</span>
            </a>
        </div>

        <!-- Header -->
        <div class="favorites-header">
            <h1>
                <i class="fas fa-heart"></i>
                <span>${pageTitle}</span>
            </h1>
            <span class="favorites-count">Tổng: ${totalFavorites} sản phẩm</span>
        </div>

        <!-- Products Grid -->
        <c:if test="${not empty products}">
            <div class="product-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <c:choose>
                            <c:when test="${not empty product.imageUrl}">
                                <img src="${product.imageUrl}" 
                                     class="product-image" alt="${product.name}"
                                     onerror="this.src='https://via.placeholder.com/300x300?text=No+Image';" />
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/300x300?text=No+Image"
                                     class="product-image" alt="${product.name}" />
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="product-info">
                            <h3 class="product-name">${product.name}</h3>
                            <div class="product-category">${product.category}</div>
                            <div class="product-price"><fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="true" /> ₫</div>
                            
                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/products/${product.id}" class="btn-view">
                                    <i class="fas fa-eye"></i> Xem
                                </a>
                                <button class="btn-remove" data-product-id="${product.id}" onclick="removeFavorite(this)">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <!-- Empty State -->
        <c:if test="${empty products}">
            <div class="favorites-empty">
                <div class="empty-icon">
                    <i class="fas fa-heart-broken"></i>
                </div>
                <p class="empty-text">Bạn chưa yêu thích sản phẩm nào</p>
                <a href="${pageContext.request.contextPath}/" class="btn-back">
                    <i class="fas fa-shopping-bag"></i> Mua sắm ngay
                </a>
            </div>
        </c:if>
    </div>

    <script>
        const contextPath = '${pageContext.request.contextPath}';
        
        function removeFavorite(button) {
            const productId = button.getAttribute('data-product-id');
            
            fetch(contextPath + '/favorites/remove', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'productId=' + productId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Remove the product card with animation
                    const card = button.closest('.product-card');
                    card.style.animation = 'fadeOut 0.3s ease-out';
                    setTimeout(() => {
                        card.remove();
                        // Check if there are no more products
                        const grid = document.querySelector('.product-grid');
                        if (grid && grid.children.length === 0) {
                            location.reload();
                        }
                    }, 300);
                }
            })
            .catch(error => console.error('Error removing favorite:', error));
        }

        // Add fade out animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes fadeOut {
                from {
                    opacity: 1;
                    transform: translateY(0);
                }
                to {
                    opacity: 0;
                    transform: translateY(10px);
                }
            }
        `;
        document.head.appendChild(style);
    </script>
<script src="${pageContext.request.contextPath}/js/chatbot.js"></script>
</body>
</html>


