<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Mua - QUOCSHOP</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatbot.css" />
    <style>
        .orders-main {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .page-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 3px solid var(--primary);
        }

        .page-header-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary), #ff8f7f);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 28px;
        }

        .page-header h1 {
            color: var(--secondary);
            margin: 0;
            font-size: 2.2rem;
        }

        .back-btn-container {
            margin-bottom: 15px;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            padding: 6px 12px;
            border-radius: 8px;
        }

        .back-btn:hover {
            background: rgba(255, 111, 97, 0.1);
            transform: translateX(-3px);
        }

        .no-orders-card {
            text-align: center;
            padding: 50px 30px;
            background: linear-gradient(135deg, #f8f9fa 0%, #f0f1f5 100%);
            border-radius: 12px;
            border: 2px dashed var(--border);
        }

        .no-orders-card i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 15px;
            opacity: 0.6;
        }

        .no-orders-card p {
            margin: 10px 0;
            color: #666;
            font-size: 1.1rem;
        }

        .no-orders-card a {
            display: inline-block;
            margin-top: 15px;
            color: white;
            background: var(--primary);
            padding: 10px 24px;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .no-orders-card a:hover {
            background: #ff5a4c;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(255, 111, 97, 0.3);
        }

        .order-item {
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            margin-bottom: 20px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .order-header {
            background: #f8f9fa;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            transition: background 0.3s;
        }

        .order-header:hover {
            background: #e9ecef;
        }

        .order-header-left {
            flex: 1;
        }

        .order-id {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .order-id span {
            color: #ff6b9d;
        }

        .order-date {
            font-size: 14px;
            color: #666;
        }

        .order-header-right {
            text-align: right;
            min-width: 200px;
        }

        .order-total {
            font-size: 18px;
            font-weight: bold;
            color: #ff6b9d;
            margin-bottom: 5px;
        }

        .order-status {
            font-size: 12px;
            color: #28a745;
            font-weight: bold;
        }

        .toggle-arrow {
            margin-left: 20px;
            font-size: 14px;
            color: #666;
            transition: transform 0.3s;
        }

        .toggle-arrow.open {
            transform: rotate(180deg);
        }

        .order-details {
            display: none;
            padding: 20px;
            border-top: 1px solid #e0e0e0;
        }

        .order-details.open {
            display: block;
        }

        .order-items-list {
            margin-bottom: 15px;
        }

        .order-product {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .order-product:last-child {
            border-bottom: none;
        }

        .product-info {
            flex: 1;
        }

        .product-info h4 {
            margin: 0 0 5px 0;
            color: #333;
            font-size: 14px;
        }

        .product-info p {
            margin: 0;
            font-size: 13px;
            color: #666;
        }

        .product-price {
            text-align: right;
            min-width: 150px;
        }

        .product-price p {
            margin: 0;
            font-size: 13px;
            color: #666;
        }

        .product-subtotal {
            font-weight: bold;
            color: #ff6b9d;
            font-size: 14px;
        }

        .order-summary {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            text-align: right;
            margin-top: 15px;
        }

        .summary-row {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 8px;
            gap: 30px;
        }

        .summary-label {
            font-size: 14px;
            color: #666;
        }

        .summary-value {
            font-size: 14px;
            color: #333;
            font-weight: bold;
            min-width: 100px;
            text-align: right;
        }

        .summary-total {
            font-size: 18px;
            color: #ff6b9d;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <header class="site-header">
        <div class="container header-inner">
            <div class="brand">
                <a href="${pageContext.request.contextPath}/"><i class="fas fa-tshirt"></i> QUOCSHOP</a>
            </div>
            <nav class="main-nav">
                <a href="${pageContext.request.contextPath}/">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <a href="${pageContext.request.contextPath}/products/gender/nam">
                    <i class="fas fa-male"></i> Nam
                </a>
                <a href="${pageContext.request.contextPath}/products/gender/nu">
                    <i class="fas fa-female"></i> Nữ
                </a>
                <a href="#" class="sale">
                    <i class="fas fa-tags"></i> Giảm giá
                </a>
                <a href="${pageContext.request.contextPath}/orders" class="active">
                    <i class="fas fa-receipt"></i> Đơn mua
                </a>
            </nav>
            <div class="actions">
                <a class="cart" href="${pageContext.request.contextPath}/cart">
                    <i class="fas fa-shopping-cart"></i>
                    <span>${cartCount}</span>
                </a>
                <div class="auth-buttons">
                    <c:choose>
                        <c:when test="${isLoggedIn}">
                            <span style="color: #666; margin-right: 10px;">
                                <i class="fas fa-user"></i> ${username}
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

    <div class="orders-main">
        <div class="back-btn-container">
            <a href="${pageContext.request.contextPath}/" class="back-btn">
                <i class="fas fa-arrow-left"></i> Quay lại trang chủ
            </a>
        </div>

        <div class="page-header">
            <div class="page-header-icon">
                <i class="fas fa-receipt"></i>
            </div>
            <h1>Đơn Mua Của Bạn</h1>
        </div>

        <c:if test="${empty orders}">
            <div class="no-orders-card">
                <i class="fas fa-inbox"></i>
                <p>Bạn chưa có đơn mua nào</p>
                <p style="font-size: 0.95rem; color: #999; margin-top: 5px;">Hãy bắt đầu mua sắm để tạo đơn hàng đầu tiên của bạn.</p>
                <a href="${pageContext.request.contextPath}/">Bắt đầu mua sắm</a>
            </div>
        </c:if>

        <c:forEach var="order" items="${orders}">
            <div class="order-item">
                <div class="order-header" onclick="toggleDetails(this)">
                    <div class="order-header-left">
                        <div class="order-id">
                            Đơn hàng <span>#${order.id}</span>
                        </div>
                        <div class="order-date">
                            ${order.formattedOrderDate}
                        </div>
                    </div>
                    <div class="order-header-right">
                        <div class="order-total"><fmt:formatNumber value="${order.totalPrice}" type="number" maxFractionDigits="0" groupingUsed="true" /> ₫</div>
                        <div class="order-status">Đã thanh toán</div>
                    </div>
                    <div class="toggle-arrow">
                        <i class="fas fa-chevron-down"></i>
                    </div>
                </div>
                <div class="order-details">
                    <div class="order-items-list">
                        <h4 style="color: #333; margin-bottom: 15px;">Chi tiết đơn hàng</h4>
                        <c:forEach var="item" items="${order.items}">
                            <div class="order-product">
                                <div class="product-info">
                                    <h4>${item.productName}</h4>
                                    <p>Số lượng: <strong>${item.quantity}</strong></p>
                                </div>
                                <div class="product-price">
                                    <p><fmt:formatNumber value="${item.unitPrice}" type="number" maxFractionDigits="0" groupingUsed="true" /> ₫/cái</p>
                                    <p class="product-subtotal"><fmt:formatNumber value="${item.subtotal}" type="number" maxFractionDigits="0" groupingUsed="true" /> ₫</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="order-summary">
                        <div class="summary-row">
                            <span class="summary-label">Tổng tiền:</span>
                            <span class="summary-value summary-total"><fmt:formatNumber value="${order.totalPrice}" type="number" maxFractionDigits="0" groupingUsed="true" /> ₫</span>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <script>
        function toggleDetails(header) {
            const details = header.nextElementSibling;
            const arrow = header.querySelector('.toggle-arrow');
            details.classList.toggle('open');
            arrow.classList.toggle('open');
        }
    </script>
<script src="${pageContext.request.contextPath}/js/chatbot.js"></script>
</body>
</html>

