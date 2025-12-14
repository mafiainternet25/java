<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tài khoản - Cập nhật</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</head>
<body>
    <header class="site-header">
        <div class="container header-inner">
            <div class="brand">
                <a href="${pageContext.request.contextPath}/"><i class="fas fa-tshirt"></i> QUOCSHOP</a>
            </div>
            <nav class="main-nav">
                <a href="${pageContext.request.contextPath}/">Trang chủ</a>
            </nav>
            <div class="actions">
                <a class="cart" href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i></a>
            </div>
        </div>
    </header>

    <div class="container account-container">
        <div class="account-card">
            <div style="display:flex;align-items:center;gap:16px;margin-bottom:8px;">
                <div style="width:56px;height:56px;border-radius:12px;background:linear-gradient(135deg,var(--primary),#ff8f7f);display:flex;align-items:center;justify-content:center;color:white;font-size:22px;">
                    <i class="fas fa-user"></i>
                </div>
                <div>
                    <h2>Cập nhật tài khoản</h2>
                    <p class="lead">Thay đổi tên đăng nhập hoặc mật khẩu của bạn. Bạn có thể thay đổi một trong hai hoặc cả hai.</p>
                </div>
            </div>

            <c:if test="${not empty error}">
                <div class="msg-error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="msg-success">${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/account" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Username hiện tại</label>
                        <input class="form-control" type="text" name="currentUsername" required placeholder="Nhập username hiện tại" />
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu hiện tại</label>
                        <input class="form-control" type="password" name="currentPassword" required placeholder="Mật khẩu hiện tại" />
                    </div>

                    <div class="form-group">
                        <label>Username mới <span style="color: #999; font-weight: normal;">(để trống nếu không muốn thay đổi)</span></label>
                        <input class="form-control" type="text" name="newUsername" placeholder="Username mới" />
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu mới <span style="color: #999; font-weight: normal;">(để trống nếu không muốn thay đổi)</span></label>
                        <input class="form-control" type="password" name="newPassword" placeholder="Mật khẩu mới" />
                    </div>

                    <div class="form-group">
                        <label>Xác nhận mật khẩu <span style="color: #999; font-weight: normal;">(bắt buộc nếu thay đổi mật khẩu)</span></label>
                        <input class="form-control" type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" />
                    </div>
                    <div class="form-group note" style="align-self:center;">
                        <p class="note">Lưu ý: Bạn có thể thay đổi username hoặc mật khẩu riêng lẻ. Mật khẩu nên có ít nhất 8 ký tự, gồm chữ và số.</p>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/" class="btn-outline">Hủy</a>
                    <button type="submit" class="btn-primary">Cập nhật</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>



