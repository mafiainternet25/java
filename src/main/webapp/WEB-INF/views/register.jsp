<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QUOCSHOP — Đăng ký</title>
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
            <h1>Tạo tài khoản mới!</h1>
            <p>Đăng ký để trở thành thành viên của QUOCSHOP và tận hưởng các ưu đãi độc quyền, theo dõi đơn hàng và quản lý tủ đồ của bạn.</p>

            <div class="showcase">
                <div class="tile">
                    <i class="fas fa-percent"></i>
                    <span>Giảm giá cho thành viên mới</span>
                </div>
                <div class="tile">
                    <i class="fas fa-truck"></i>
                    <span>Miễn phí vận chuyển > 500K</span>
                </div>
                <div class="tile">
                    <i class="fas fa-user-shield"></i>
                    <span>Bảo vệ thông tin cá nhân</span>
                </div>
                <div class="tile">
                    <i class="fas fa-headset"></i>
                    <span>Hỗ trợ khách hàng 24/7</span>
                </div>
            </div>
        </div>
        <div class="right">
            <h2 class="center">Đăng ký tài khoản</h2>
            <form action="${pageContext.request.contextPath}/register" method="post">
                <c:if test="${not empty error}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="error-message" style="background: #e8f5e9; border-color: #a5d6a7; color: #2e7d32;">
                        <i class="fas fa-check-circle"></i>
                        <span>${success}</span>
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
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required />
                </div>
                <div>
                    <input type="submit" value="Đăng ký" />
                </div>
                <div class="footer-note">
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>












