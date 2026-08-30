<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm danh mục</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f8f9fa;
            color: #333;
            line-height: 1.5;
        }
        .container {
            width: 95%;
            max-width: 600px;
            margin: 50px auto;
        }
        .form-box {
            background: white;
            padding: 35px;
            border-radius: 8px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }
        h1 {
            font-size: 24px;
            color: #1a1a1a;
            margin-bottom: 25px;
            font-weight: 600;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #4b5563;
            font-size: 14px;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 15px;
            color: #1f2937;
            transition: all 0.2s ease;
        }
        input[type="text"]:focus {
            outline: none;
            border-color: #10b981;
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
        }
        input[type="text"]::placeholder {
            color: #9ca3af;
        }
        .error {
            background: #fee2e2;
            border-left: 4px solid #ef4444;
            color: #991b1b;
            padding: 12px 16px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        .btn-save {
            background: #10b981;
            color: white;
            flex: 1;
        }
        .btn-save:hover {
            background: #059669;
        }
        .btn-back {
            background: #4b5563;
            color: white;
        }
        .btn-back:hover {
            background: #374151;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-box">
            <h1>Thêm danh mục</h1>

            <c:if test="${not empty error}">
                <div class="error">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/category/insert" method="post">
                <div class="form-group">
                    <label for="cateName">Tên danh mục</label>
                    <input 
                        type="text" 
                        id="cateName" 
                        name="cateName" 
                        value="${category.cateName}" 
                        placeholder="Nhập tên danh mục" 
                        required>
                </div>

                <div class="form-group">
                    <label for="icons">Đường dẫn hình ảnh</label>
                    <input 
                        type="text" 
                        id="icons" 
                        name="icons" 
                        value="${category.icons}" 
                        placeholder="Ví dụ: category/ao-nam.jpg">
                </div>

                <div class="buttons">
                    <button type="submit" class="btn btn-save">
                        Thêm danh mục
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-back">
                        Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
