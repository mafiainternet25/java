<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatbot.css" />
    <style>
        .cart-container { max-width: 900px; margin: 40px auto; }
        .cart-item { display:flex; gap:16px; padding:12px; background:white; border-radius:8px; margin-bottom:12px; align-items:center; }
        .cart-item img { width:80px; height:80px; object-fit:cover; border-radius:6px; }
        .cart-item .meta { flex:1; }
    </style>
</head>
<body>
    <div class="container cart-container">
        <h1>Giỏ hàng (<span>${totalCount}</span> sản phẩm)</h1>

        <c:if test="${empty items}">
            <p>Giỏ hàng trống.</p>
        </c:if>

        <c:forEach var="item" items="${items}" varStatus="iterStat">
            <div class="cart-item">
                <c:choose>
                    <c:when test="${not empty item.imageUrl}">
                        <img src="${item.imageUrl}" alt="" onerror="this.src='https://via.placeholder.com/80x80?text=No+Image'" />
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/80x80?text=No+Image" alt="" />
                    </c:otherwise>
                </c:choose>
                <div class="meta">
                    <h3>${item.name}</h3>
                    <div>Giá: <span><fmt:formatNumber value="${item.price}" type="number" maxFractionDigits="0" groupingUsed="true" /></span> ₫</div>
                    <div>
                        <form action="${pageContext.request.contextPath}/cart/update" method="post" style="display:inline-block; margin-right:8px;">
                            <input type="hidden" name="productId" value="${item.id}" />
                            <input type="number" name="quantity" min="0" value="${quantities[iterStat.index]}" style="width:70px; padding:6px;" />
                            <button type="submit" class="btn-outline">Cập nhật</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/cart/remove" method="post" style="display:inline-block;">
                            <input type="hidden" name="productId" value="${item.id}" />
                            <button type="submit" class="btn-primary">Xóa</button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>

        <div style="margin-top:18px; text-align:right;">
            <div style="font-size:18px; font-weight:700; margin-bottom:8px;">Tổng: <span><fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="0" groupingUsed="true" /></span> ₫</div>
            <form action="${pageContext.request.contextPath}/cart/checkout" method="post" style="display:inline-block;">
                <button type="submit" class="btn-primary">Thanh toán</button>
            </form>
            <a href="${pageContext.request.contextPath}/" class="btn-outline" style="margin-left:8px;">Tiếp tục mua sắm</a>
        </div>

        <c:if test="${param.checkout == 'success'}">
            <div style="margin-top:12px; color:green; font-weight:600;">Thanh toán thành công. Giỏ hàng đã được làm trống.</div>
        </c:if>
    </div>
<script src="${pageContext.request.contextPath}/js/chatbot.js"></script>
</body>
</html>









