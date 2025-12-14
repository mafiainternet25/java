<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QUOCSHOP - ${product.id == null ? 'Thêm' : 'Sửa'} sản phẩm</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <style>
        :root {
            --brand: #4a90e2;
            --brand-light: #5c9ee6;
            --brand-dark: #357abd;
            --danger: #e74c3c;
            --success: #27ae60;
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
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }

        .form-header {
            background: white;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: var(--shadow-md);
        }

        .form-header h1 {
            margin: 0;
            color: var(--text-dark);
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .form-header h1 i {
            color: var(--brand);
        }

        .form-container {
            background: white;
            border-radius: 12px;
            padding: 32px;
            box-shadow: var(--shadow-md);
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-dark);
            font-weight: 600;
            font-size: 15px;
        }

        .form-group label.required::after {
            content: " *";
            color: var(--danger);
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 16px;
            border-radius: 8px;
            border: 2px solid var(--border-light);
            font-size: 15px;
            font-family: inherit;
            transition: all 0.3s;
            box-sizing: border-box;
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="number"]:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--brand);
            box-shadow: 0 0 0 4px rgba(74, 144, 226, 0.1);
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .form-group .help-text {
            margin-top: 6px;
            font-size: 13px;
            color: var(--text-gray);
        }

        .form-actions {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid var(--border-light);
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

        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
        <a href="${pageContext.request.contextPath}/admin/products" class="back-link">
            <i class="fas fa-arrow-left"></i>
            Quay lại danh sách sản phẩm
        </a>

        <div class="form-header">
            <h1>
                <i class="fas fa-${product.id == null ? 'plus' : 'edit'}"></i>
                ${product.id == null ? 'Thêm sản phẩm mới' : 'Sửa sản phẩm'}
            </h1>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <div class="form-container">
            <c:choose>
                <c:when test="${product.id == null}">
                    <form action="${pageContext.request.contextPath}/admin/products/new" method="post">
                </c:when>
                <c:otherwise>
                    <form action="${pageContext.request.contextPath}/admin/products/${product.id}/edit" method="post">
                </c:otherwise>
            </c:choose>
                <div class="form-group">
                    <label for="name" class="required">Tên sản phẩm</label>
                    <input type="text" id="name" name="name" value="${product.name}" required 
                           placeholder="Nhập tên sản phẩm" />
                </div>

                <div class="form-group">
                    <label for="price" class="required">Giá (₫)</label>
                    <input type="number" id="price" name="price" value="${product.price}" 
                           step="0.01" min="0" required placeholder="Nhập giá sản phẩm" />
                    <div class="help-text">Nhập giá bằng số (ví dụ: 199000)</div>
                </div>

                <div class="form-group">
                    <label for="category" class="required">Danh mục</label>
                    <select id="category" name="category" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach var="cat" items="${categories}">
                            <c:choose>
                                <c:when test="${not empty product.category && cat == product.category}">
                                    <option value="${cat}" selected>${cat}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${cat}">${cat}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                    <div class="help-text">Hoặc nhập danh mục mới trong ô input bên dưới</div>
                </div>

                <div class="form-group">
                    <label for="categoryNew">Danh mục mới (nếu không có trong danh sách)</label>
                    <input type="text" id="categoryNew" name="categoryNew" 
                           placeholder="Nhập danh mục mới (ví dụ: Áo nam, Quần nữ, ...)" />
                    <div class="help-text">Nếu bạn nhập danh mục mới, nó sẽ được sử dụng thay vì danh mục đã chọn ở trên</div>
                </div>

                <div class="form-group">
                    <label for="imageUrl">URL hình ảnh</label>
                    <input type="text" id="imageUrl" name="imageUrl" value="${product.imageUrl}" 
                           placeholder="https://example.com/image.jpg" />
                    <div class="help-text">Nhập URL đầy đủ của hình ảnh sản phẩm</div>
                </div>

                <div class="form-group">
                    <label for="description">Mô tả</label>
                    <textarea id="description" name="description" 
                              placeholder="Nhập mô tả chi tiết về sản phẩm">${product.description}</textarea>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Hủy
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        ${product.id == null ? 'Thêm sản phẩm' : 'Cập nhật'}
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Nếu có categoryNew được nhập, sử dụng nó thay vì category từ select
        document.querySelector('form').addEventListener('submit', function(e) {
            const categoryNew = document.getElementById('categoryNew').value.trim();
            const categorySelect = document.getElementById('category');
            
            if (categoryNew) {
                // Set giá trị category mới vào select
                categorySelect.value = categoryNew;
                // Hoặc tạo option mới nếu chưa có
                if (!Array.from(categorySelect.options).some(opt => opt.value === categoryNew)) {
                    const newOption = document.createElement('option');
                    newOption.value = categoryNew;
                    newOption.textContent = categoryNew;
                    newOption.selected = true;
                    categorySelect.appendChild(newOption);
                } else {
                    categorySelect.value = categoryNew;
                }
            }
        });
    </script>
</body>
</html>

