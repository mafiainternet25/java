<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QUOCSHOP — Tìm kiếm sản phẩm</title>
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
            --gradient: linear-gradient(135deg, var(--brand) 0%, var(--brand-light) 100%);
            --sidebar-width: 280px;
            --content-max-width: 1200px;
            --header-height: 60px;
        }

        body {
            background-color: var(--bg-light);
            margin: 0;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
            color: var(--text-dark);
            line-height: 1.5;
        }

        .page-header {
            background: white;
            border-bottom: 1px solid var(--border-light);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            height: var(--header-height);
            box-shadow: var(--shadow-sm);
        }

        .header-content {
            max-width: var(--content-max-width);
            margin: 0 auto;
            padding: 0 20px;
            height: 100%;
            display: flex;
            align-items: center;
        }

        .back-button {
            display: inline-flex;
            align-items: center;
            text-decoration: none;
            color: #666;
            font-weight: 500;
            margin-right: 20px;
            transition: all 0.3s;
        }

        .back-button i {
            margin-right: 8px;
            font-size: 14px;
        }

        .back-button:hover {
            color: var(--brand);
            transform: translateX(-4px);
        }

        .search-container {
            max-width: var(--content-max-width);
            margin: calc(var(--header-height) + 20px) auto 20px;
            padding: 0 20px;
        }

        .main-content {
            display: grid;
            grid-template-columns: var(--sidebar-width) 1fr;
            gap: 30px;
            align-items: start;
        }

        .filter-sidebar {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: var(--shadow-md);
            position: sticky;
            top: calc(var(--header-height) + 20px);
            border: 1px solid var(--border-light);
        }

        .filter-section {
            padding-bottom: 24px;
            margin-bottom: 24px;
            border-bottom: 1px solid var(--border-light);
        }

        .filter-section:last-child {
            padding-bottom: 0;
            margin-bottom: 0;
            border-bottom: none;
        }

        .filter-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-dark);
            margin: 0 0 16px 0;
        }

        .filter-group {
            margin-bottom: 16px;
        }

        .filter-group:last-child {
            margin-bottom: 0;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 32px;
        }

        .product-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-light);
            position: relative;
            height: 100%;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg);
        }

        .product-image {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-bottom: 1px solid var(--border-light);
            transition: transform 0.4s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.05);
        }

        .product-info {
            padding: 20px;
            display: flex;
            flex-direction: column;
            height: 100%;
            background: linear-gradient(180deg, rgba(255,255,255,0) 0%, rgba(255,255,255,1) 100%);
        }

        .product-name {
            font-size: 17px;
            font-weight: 600;
            margin: 0 0 12px 0;
            color: var(--text-dark);
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-category {
            font-size: 14px;
            color: var(--text-gray);
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .product-category i {
            color: var(--brand);
            font-size: 12px;
        }

        .product-price {
            font-size: 20px;
            font-weight: 700;
            color: var(--brand);
            margin-top: auto;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .no-results {
            background: white;
            border-radius: 16px;
            padding: 48px 24px;
            text-align: center;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-light);
            margin-top: 32px;
        }

        .no-results i {
            font-size: 48px;
            color: var(--brand-light);
            margin-bottom: 24px;
            opacity: 0.8;
        }

        .no-results h3 {
            color: var(--text-dark);
            font-size: 20px;
            margin: 0 0 12px 0;
        }

        .no-results p {
            color: var(--text-gray);
            margin: 0;
            font-size: 15px;
            max-width: 400px;
            margin: 0 auto;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 14px 16px;
            border-radius: 12px;
            border: 2px solid var(--border-light);
            font-size: 15px;
            transition: all 0.3s ease;
            background: white;
            color: var(--text-dark);
        }

        input[type="text"]:hover, input[type="number"]:hover {
            border-color: var(--brand-light);
        }

        input[type="text"]:focus, input[type="number"]:focus {
            outline: none;
            border-color: var(--brand);
            box-shadow: 0 0 0 4px rgba(74, 144, 226, 0.1);
            background: white;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: var(--text-dark);
            font-weight: 500;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        label i {
            color: var(--brand);
            font-size: 14px;
        }

        .price-inputs {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        select {
            padding: 14px 16px;
            border-radius: 12px;
            border: 2px solid var(--border-light);
            font-size: 15px;
            width: 100%;
            appearance: none;
            background: white url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%234a90e2'%3E%3Cpath d='M7 10l5 5 5-5z'/%3E%3C/svg%3E") no-repeat right 16px center;
            background-size: 20px;
            transition: all 0.3s ease;
            color: var(--text-dark);
        }

        select:focus {
            outline: none;
            border-color: var(--brand);
            box-shadow: 0 0 0 4px rgba(74, 144, 226, 0.1);
        }

        .search-button {
            background: var(--gradient);
            color: white;
            padding: 14px 32px;
            border-radius: 12px;
            border: none;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            width: 100%;
        }

        .search-button:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding: 16px;
            background: white;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
        }

        .results-count {
            font-size: 15px;
            color: var(--text-gray);
        }

        .results-count span {
            font-weight: 600;
            color: var(--text-dark);
        }

        .sort-select {
            padding: 8px 12px;
            border-radius: 8px;
            border: 1px solid var(--border-light);
            font-size: 14px;
            color: var(--text-dark);
            background-color: white;
        }

        @media (max-width: 768px) {
            .main-content {
                grid-template-columns: 1fr;
            }

            .filter-sidebar {
                position: fixed;
                left: 0;
                right: 0;
                bottom: 0;
                top: var(--header-height);
                border-radius: 0;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 999;
            }

            .products-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="page-header">
        <div class="header-content">
            <a href="${pageContext.request.contextPath}/" class="back-button">
                <i class="fas fa-arrow-left"></i>
                <span>Quay lại trang chủ</span>
            </a>
            <h1>Tìm kiếm sản phẩm</h1>
        </div>
    </div>

    <div class="search-container">
        <div class="main-content">
            <!-- Sidebar with filters -->
            <aside class="filter-sidebar">
                <form action="${pageContext.request.contextPath}/products/search" method="get" class="filter-form">
                    <div class="filter-section">
                        <h3 class="filter-title">Tìm kiếm</h3>
                        <div class="filter-group">
                            <label for="keyword">
                                <i class="fas fa-search"></i> Từ khóa
                            </label>
                            <input type="text" id="keyword" name="keyword" value="${keyword}"
                                   placeholder="Tìm kiếm sản phẩm..." />
                        </div>
                    </div>

                    <div class="filter-section">
                        <h3 class="filter-title">Danh mục</h3>
                        <div class="filter-group">
                            <select id="category" name="category">
                                <option value="">Tất cả danh mục</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat}" ${cat == selectedCategory ? 'selected' : ''}>${cat}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="filter-section">
                        <h3 class="filter-title">Khoảng giá</h3>
                        <div class="filter-group">
                            <div class="price-inputs">
                                <div class="price-field">
                                    <label for="minPrice">Từ</label>
                                    <input type="number" id="minPrice" name="minPrice" 
                                           value="${minPrice}" placeholder="Giá thấp nhất" />
                                </div>
                                <div class="price-field">
                                    <label for="maxPrice">Đến</label>
                                    <input type="number" id="maxPrice" name="maxPrice"
                                           value="${maxPrice}" placeholder="Giá cao nhất" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i> Áp dụng 
                    </button>
                </form>
            </aside>

            <!-- Main content area with products -->
            <main class="products-area">
                <c:if test="${not empty products}">
                    <div class="results-header">
                        <div class="results-count">
                            <span>${products.size()}</span> sản phẩm được tìm thấy
                        </div>
                        <div class="results-sort">
                            <select id="sort" name="sort" class="sort-select">
                                <option value="relevance">Sắp xếp theo liên quan</option>
                                <option value="price-asc">Giá tăng dần</option>
                                <option value="price-desc">Giá giảm dần</option>
                                <option value="name-asc">Tên A-Z</option>
                                <option value="name-desc">Tên Z-A</option>
                            </select>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty products}">
                    <div class="no-results">
                        <div class="no-results-content">
                            <i class="fas fa-search"></i>
                            <h3>Không tìm thấy sản phẩm nào</h3>
                            <p>Hãy thử tìm kiếm với từ khóa khác hoặc điều chỉnh bộ lọc của bạn.</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty products}">
                    <div class="products-grid">
                        <c:forEach var="product" items="${products}">
                            <a href="${pageContext.request.contextPath}/products/${product.id}" 
                               style="text-decoration: none; color: inherit;">
                                <div class="product-card">
                                    <div class="product-card-inner">
                                        <div class="product-image-wrapper">
                                            <c:choose>
                                                <c:when test="${not empty product.imageUrl}">
                                                    <img src="${product.imageUrl}" 
                                                         class="product-image" alt="${product.name}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/300x200?text=No+Image"
                                                         class="product-image" alt="${product.name}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="product-info">
                                            <h3 class="product-name">${product.name}</h3>
                                            <div class="product-category">
                                                <i class="fas fa-tag"></i>
                                                <span>${product.category}</span>
                                            </div>
                                            <div class="product-price">
                                                <span class="price-amount"><fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="true" /></span>
                                                <span class="price-currency">₫</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
            </main>
        </div>
    </div>
<script src="${pageContext.request.contextPath}/js/chatbot.js"></script>
</body>
</html>









