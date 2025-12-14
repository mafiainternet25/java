<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QUOCSHOP — Đăng nhập</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>
<body>
    <div class="card">
        <div class="left">
            <div class="brand">
                <div class="logo">
                    <i class="fas fa-tshirt"></i>
                </div>
                <div>
                    <h3>QUOCSHOP</h3>
                    <div class="muted">Thời trang sành điệu cho mọi người</div>
                </div>
            </div>
            <h1>Chào mừng trở lại!</h1>
            <p>Đăng nhập để trải nghiệm mua sắm tuyệt vời với các ưu đãi độc quyền, theo dõi đơn hàng và quản lý tủ đồ của bạn.</p>

            <div class="showcase">
                <div class="tile">
                    <i class="fas fa-star"></i>
                    <span>Bộ sưu tập mùa mới</span>
                </div>
                <div class="tile">
                    <i class="fas fa-truck"></i>
                    <span>Miễn phí vận chuyển > 500K</span>
                </div>
                <div class="tile">
                    <i class="fas fa-gifts"></i>
                    <span>Quà tặng hấp dẫn</span>
                </div>
                <div class="tile">
                    <i class="fas fa-shield-alt"></i>
                    <span>Bảo hành sản phẩm</span>
                </div>
            </div>
        </div>
        <div class="right">
            <h2 class="center">Đăng nhập</h2>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <c:if test="${not empty error}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>
                <div>
                    <label for="username">
                        <i class="fas fa-user"></i> Tên đăng nhập
                    </label>
                    <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required 
                           value="${param.username}" />
                </div>
                <div>
                    <label for="password">
                        <i class="fas fa-key"></i> Mật khẩu
                    </label>
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required
                           value="${param.password}" />
                </div>
                <div>
                    <input type="submit" value="Đăng nhập" />
                </div>
                <div class="footer-note">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>












