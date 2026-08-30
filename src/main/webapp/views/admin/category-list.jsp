<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục</title>
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
            max-width: 1200px;
            margin: 40px auto;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .header h1 {
            font-size: 26px;
            color: #1a1a1a;
            font-weight: 600;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        .btn-add {
            background: #10b981;
        }
        .btn-add:hover {
            background: #059669;
        }
        .btn-edit {
            background: #f59e0b;
            color: #fff;
        }
        .btn-edit:hover {
            background: #d97706;
        }
        .btn-delete {
            background: #ef4444;
        }
        .btn-delete:hover {
            background: #dc2626;
        }
        .table-box {
            background: white;
            border-radius: 8px;
            padding: 10px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }
        th {
            background: #f3f4f6;
            color: #4b5563;
            font-weight: 600;
            padding: 14px;
            text-align: center;
            border-bottom: 2px solid #e5e7eb;
        }
        td {
            padding: 14px;
            border-bottom: 1px solid #e5e7eb;
            text-align: center;
            vertical-align: middle;
        }
        tr:hover td {
            background: #f9fafb;
        }
        .category-image {
            width: 80px;
            height: 55px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #e5e7eb;
            vertical-align: middle;
        }
        .no-image {
            font-size: 13px;
            color: #9ca3af;
            font-style: italic;
        }
        .no-data {
            padding: 40px;
            color: #6b7280;
            font-size: 16px;
        }
        .actions {
            display: flex;
            justify-content: center;
            gap: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Quản lý danh mục</h1>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-add">
                + Thêm danh mục
            </a>
        </div>
        <div class="table-box">
            <table>
                <thead>
                    <tr>
                        <th style="width: 10%;">ID</th>
                        <th style="width: 25%;">Hình ảnh</th>
                        <th style="width: 45%;">Tên danh mục</th>
                        <th style="width: 20%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty listCategory}">
                            <tr>
                                <td colspan="4" class="no-data">
                                    Chưa có danh mục nào
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listCategory}" var="category">
                                <tr>
                                    <td><strong>${category.cateId}</strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty category.icons}">
                                                <c:choose>
                                                    <c:when test="${category.icons.startsWith('http')}">
                                                        <img src="${category.icons}" class="category-image" alt="${category.cateName}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/image?fname=${category.icons}" class="category-image" alt="${category.cateName}">
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="no-image">Không có ảnh</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${category.cateName}</td>
                                    <td>
                                        <div class="actions">
                                            <a href="${pageContext.request.contextPath}/admin/category/edit?id=${category.cateId}" class="btn btn-edit">
                                                Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/category/delete?id=${category.cateId}" class="btn btn-delete" onclick="return confirm('Bạn có chắc muốn xóa danh mục này không?');">
                                                Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
