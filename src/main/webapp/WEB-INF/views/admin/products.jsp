<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QUOCSHOP - Quản lý sản phẩm</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <style>
        :root {
            --brand: #4a90e2;
            --brand-light: #5c9ee6;
            --brand-dark: #357abd;
            --danger: #e74c3c;
            --success: #27ae60;
            --warning: #f39c12;
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
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
            color: var(--text-dark);
            margin: 0;
            padding: 0;
        }

        .admin-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }

        .admin-header {
            background: white;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: var(--shadow-md);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .admin-header h1 {
            margin: 0;
            color: var(--text-dark);
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .admin-header h1 i {
            color: var(--brand);
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            border: none;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .btn-primary {
            background: var(--brand);
            color: white;
        }

        .btn-primary:hover {
            background: var(--brand-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: var(--text-gray);
            color: white;
        }

        .btn-secondary:hover {
            background: var(--text-dark);
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background: #c0392b;
        }

        .btn-warning {
            background: var(--warning);
            color: white;
        }

        .btn-warning:hover {
            background: #e67e22;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .products-table-container {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: var(--shadow-md);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: var(--bg-light);
        }

        th {
            padding: 16px;
            text-align: left;
            font-weight: 600;
            color: var(--text-dark);
            border-bottom: 2px solid var(--border-light);
        }

        td {
            padding: 16px;
            border-bottom: 1px solid var(--border-light);
        }

        tr:hover {
            background: var(--bg-light);
        }

        .product-image-cell {
            width: 80px;
        }

        .product-image-cell img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
        }

        .product-name {
            font-weight: 600;
            color: var(--text-dark);
        }

        .product-price {
            color: var(--brand);
            font-weight: 600;
        }

        .product-category {
            color: var(--text-gray);
            font-size: 14px;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 14px;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-gray);
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 16px;
            opacity: 0.5;
        }

        .empty-state h3 {
            margin: 0 0 8px 0;
            color: var(--text-dark);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--text-gray);
            text-decoration: none;
            margin-bottom: 16px;
            transition: color 0.3s;
        }

        .back-link:hover {
            color: var(--brand);
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <a href="${pageContext.request.contextPath}/home" class="back-link">
            <i class="fas fa-arrow-left"></i>
            Quay lại trang chủ
        </a>

        <div class="admin-header">
            <h1>
                <i class="fas fa-box"></i>
                Quản lý sản phẩm
            </h1>
            <a href="${pageContext.request.contextPath}/admin/products/new" class="btn btn-primary">
                <i class="fas fa-plus"></i>
                Thêm sản phẩm mới
            </a>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${success}</span>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <div class="products-table-container">
            <c:choose>
                <c:when test="${not empty products && products.size() > 0}">
                    <table>
                        <thead>
                            <tr>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá</th>
                                <th>Danh mục</th>
                                <th>Mô tả</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td class="product-image-cell">
                                        <c:choose>
                                            <c:when test="${not empty product.imageUrl}">
                                                <img src="${product.imageUrl}" alt="${product.name}" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://via.placeholder.com/80x80?text=No+Image" alt="${product.name}" />
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="product-name">${product.name}</div>
                                    </td>
                                    <td>
                                        <div class="product-price">
                                            <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="true" />₫
                                        </div>
                                    </td>
                                    <td>
                                        <div class="product-category">${product.category}</div>
                                    </td>
                                    <td>
                                        <div style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: var(--text-gray);">
                                            ${product.description}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/products/${product.id}/edit" class="btn btn-warning btn-sm">
                                                <i class="fas fa-edit"></i>
                                                Sửa
                                            </a>
                                            <form action="${pageContext.request.contextPath}/admin/products/${product.id}/delete" method="post" style="display: inline;" 
                                                  onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
                                                <button type="submit" class="btn btn-danger btn-sm">
                                                    <i class="fas fa-trash"></i>
                                                    Xóa
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-box-open"></i>
                        <h3>Chưa có sản phẩm nào</h3>
                        <p>Hãy thêm sản phẩm đầu tiên của bạn!</p>
                        <a href="${pageContext.request.contextPath}/admin/products/new" class="btn btn-primary" style="margin-top: 16px;">
                            <i class="fas fa-plus"></i>
                            Thêm sản phẩm mới
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>





