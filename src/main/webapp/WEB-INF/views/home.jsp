<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>QUOCTRUONGSHOP - Thời Trang Sành Điệu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatbot.css" />
</head>
<body>
    <header class="site-header">
    <div class="container header-inner">
        <div class="brand">
            <a href="${pageContext.request.contextPath}/">
                <i class="fas fa-tshirt"></i>
                QUOCSHOP
            </a>
        </div>
            <nav class="main-nav">
            <a href="${pageContext.request.contextPath}/" class="active">
                <i class="fas fa-home"></i> Trang chủ
            </a>
            <!-- Gender filters: link to controller that filters by category substring -->
            <a href="${pageContext.request.contextPath}/products/gender/nam">
                <i class="fas fa-male"></i> Nam
            </a>
            <a href="${pageContext.request.contextPath}/products/gender/nu">
                <i class="fas fa-female"></i> Nữ
            </a>
            <a href="${pageContext.request.contextPath}/favorites">
                <i class="fas fa-heart"></i> Đã thích
            </a>
            <a href="${pageContext.request.contextPath}/orders">
                <i class="fas fa-receipt"></i> Đơn mua
            </a>
            <c:if test="${isAdmin}">
                <a href="${pageContext.request.contextPath}/admin/products">
                    <i class="fas fa-cog"></i> Quản lý
                </a>
            </c:if>
        </nav>
        <div class="actions">
            <form action="${pageContext.request.contextPath}/products/search" method="get" class="search-form">
    <button type="submit" class="search-button">
        <i class="fas fa-search"></i>
    </button>
    <input type="search" name="keyword" placeholder="Search products..." autocomplete="off"/>
    <div class="search-dropdown">
        <div class="search-dropdown-header">
            <h3>Advanced Search</h3>
            <button type="button" class="close-search-dropdown">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div class="search-dropdown-content">
            <div class="search-field">
                <label>Category</label>
                <select name="category">
                    <option value="">All Categories</option>
                    <option value="electronics">Electronics</option>
                    <option value="clothing">Clothing</option>
                    <option value="books">Books</option>
                    <option value="home">Home & Garden</option>
                    <option value="toys">Toys</option>
                </select>
            </div>
            <div class="search-field">
                <label>Price Range</label>
                <div class="price-inputs">
                    <input type="number" name="minPrice" placeholder="Min Price" step="0.01"/>
                    <span class="price-separator">-</span>
                    <input type="number" name="maxPrice" placeholder="Max Price" step="0.01"/>
                </div>
            </div>
        </div>
    </div>
</form>
            <a class="cart" href="${pageContext.request.contextPath}/cart">
                <i class="fas fa-shopping-cart"></i>
                <span class="cart-count">${cartCount}</span>
            </a>
            <div class="auth-buttons">
                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <span style="color: #666; margin-right: 10px;">
                            <i class="fas fa-user"></i> Xin chào, ${username}
                        </span>
                        <a class="btn-account" href="${pageContext.request.contextPath}/account">
                            <i class="fas fa-user-cog"></i> Tài khoản
                        </a>
                        <a class="btn-logout" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn-login" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>

<main class="container main-content">
    <c:if test="${param.logout == 'success'}">
        <div style="background: #d4edda; color: #155724; padding: 12px 20px; border-radius: 8px; margin: 20px 0; border: 1px solid #c3e6cb; display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-check-circle"></i>
            <span>Đăng xuất thành công!</span>
        </div>
    </c:if>
    <section class="hero">
        <div class="hero-text">
            <span class="hero-label">🌟 Bộ Sưu Tập Mới</span>
            <h1>Xu Hướng Thời Trang 2025</h1>
            <p>Khám phá bộ sưu tập mới nhất với những thiết kế độc đáo, phong cách và chất lượng. Giảm giá đặc biệt cho thành viên mới.</p>
            <div class="hero-buttons">
                <a class="btn-primary" href="#">
                    <i class="fas fa-shopping-bag"></i> Mua sắm ngay
                </a>
                <a class="btn-outline" href="#">
                    <i class="fas fa-info-circle"></i> Tìm hiểu thêm
                </a>
            </div>
            <div class="hero-features">
                <span><i class="fas fa-truck"></i> Giao hàng miễn phí</span>
                <span><i class="fas fa-undo"></i> Đổi trả trong 30 ngày</span>
                <span><i class="fas fa-shield-alt"></i> Bảo hành chất lượng</span>
            </div>
        </div>
        <div class="hero-image">
            <img src="https://th.bing.com/th/id/R.65b3f748545d2acf7ef4ec31b12d7299?rik=7Q%2fpothCcI5PQg&pid=ImgRaw&r=0" alt="fashion" />
        </div>
    </section>

    <section class="products">
        <h2><i class="fas fa-star"></i> Sản Phẩm Nổi Bật</h2>
        <div class="product-grid">
            <!-- up product to home -->
            <c:forEach var="product" items="${homeProducts}">
            <article class="product-card">
                <c:choose>
                    <c:when test="${not empty product.imageUrl}">
                        <img src="${product.imageUrl}" alt="${product.name}" />
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/300x300?text=No+Image" alt="${product.name}" />
                    </c:otherwise>
                </c:choose>
                <h3>${product.name}</h3>
                <p class="price">
                    <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="true" />₫
                </p>
                <p class="meta">
                    <i class="fas fa-palette"></i> <span>${product.category}</span>
                </p>
                <div class="card-actions">
                    <a href="${pageContext.request.contextPath}/products/${product.id}" class="btn-outline">
                        <i class="fas fa-eye"></i> Xem
                    </a>
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="${product.id}" />
                        <button type="submit" class="btn-primary">
                            <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                        </button>
                    </form>
                </div>
            </article>
            </c:forEach>
        </div>
    </section>
</main>

<footer class="site-footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h4><i class="fas fa-store"></i> QUOCSHOP</h4>
                <p>Thời trang sành điệu cho mọi người</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-tiktok"></i></a>
                </div>
            </div>
            <div class="footer-section">
                <h4>Thông Tin</h4>
                <nav>
                    <a href="#"><i class="fas fa-file-alt"></i> Chính sách</a>
                    <a href="#"><i class="fas fa-phone"></i> Liên hệ</a>
                    <a href="#"><i class="fas fa-book"></i> Hướng dẫn mua hàng</a>
                </nav>
            </div>
            <div class="footer-section">
                <h4>Dịch Vụ</h4>
                <nav>
                    <a href="#"><i class="fas fa-truck"></i> Giao hàng</a>
                    <a href="#"><i class="fas fa-exchange-alt"></i> Đổi trả</a>
                    <a href="#"><i class="fas fa-gift"></i> Quà tặng</a>
                </nav>
            </div>
            <div class="footer-section">
                <h4>Newsletter</h4>
                <form class="newsletter-form">
                    <input type="email" placeholder="Email của bạn" />
                    <button type="submit"><i class="fas fa-paper-plane"></i></button>
                </form>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 QUOCSHOP. All rights reserved.</p>
            <div class="payment-methods">
                <i class="fab fa-cc-visa"></i>
                <i class="fab fa-cc-mastercard"></i>
                <i class="fab fa-cc-paypal"></i>
            </div>
        </div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/chatbot.js"></script>
</body>
</html>

