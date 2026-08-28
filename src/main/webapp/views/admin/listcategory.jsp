<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">

    <title>Danh sách danh mục</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<div class="admin-layout">

    <aside class="sidebar">

        <div class="sidebar-logo">
            <span>🛒 Shopping</span>
        </div>

        <div class="sidebar-menu">

            <a href="${pageContext.request.contextPath}/admin/home"
               class="menu-item">

                📊
                <span>Trang chủ</span>

            </a>

            <a href="${pageContext.request.contextPath}/admin/category/list"
               class="menu-item active">

                📁
                <span>Danh mục</span>

            </a>

            <a href="#"
               class="menu-item">

                🛍
                <span>Sản phẩm</span>

            </a>

            <a href="#"
               class="menu-item">

                👥
                <span>Người dùng</span>

            </a>

            <a href="${pageContext.request.contextPath}/logout"
               class="menu-item">

                🚪
                <span>Đăng xuất</span>

            </a>

        </div>

    </aside>


    <main class="main-area">

        <header class="topbar">

            <div class="topbar-title">
                Quản lý danh mục
            </div>

        </header>


        <section class="content">

            <div class="page-title">

                <div>

                    <h1>Danh sách danh mục</h1>

                    <p>
                        Quản lý các danh mục sản phẩm
                    </p>

                </div>


                <a
                        href="${pageContext.request.contextPath}/admin/category/add"
                        class="btn btn-success">

                    + Thêm danh mục

                </a>

            </div>


            <c:if test="${not empty param.message}">

                <div style="color:green; margin-bottom:15px;">

                    ${param.message}

                </div>

            </c:if>


            <div class="card">

                <div class="card-body">

                    <table
                            border="1"
                            cellpadding="10"
                            cellspacing="0"
                            width="100%">

                        <thead>

                        <tr>

                            <th>ID</th>

                            <th>Ảnh</th>

                            <th>Tên danh mục</th>

                            <th>Thao tác</th>

                        </tr>

                        </thead>


                        <tbody>

                        <c:forEach
                                items="${listcate}"
                                var="cate">

                            <tr>

                                <td>
                                    ${cate.categoryid}
                                </td>


                                <td>

                                    <c:choose>

                                        <c:when test="${not empty cate.images}">

                                            <img
                                                    src="${pageContext.request.contextPath}/image?fname=${cate.images}"
                                                    width="150"
                                                    height="100"
                                                    style="object-fit:cover;"
                                                    alt="${cate.categoryname}">

                                        </c:when>


                                        <c:otherwise>

                                            Không có ảnh

                                        </c:otherwise>

                                    </c:choose>

                                </td>


                                <td>
                                    ${cate.categoryname}
                                </td>


                                <td>

                                    <a
                                            href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.categoryid}">

                                        Sửa

                                    </a>

                                    &nbsp; | &nbsp;

                                    <a
                                            href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.categoryid}"
                                            onclick="return confirm('Bạn có chắc muốn xóa danh mục này?');">

                                        Xóa

                                    </a>

                                </td>

                            </tr>

                        </c:forEach>


                        <c:if test="${empty listcate}">

                            <tr>

                                <td colspan="4"
                                    style="text-align:center;">

                                    Chưa có danh mục nào.

                                </td>

                            </tr>

                        </c:if>

                        </tbody>

                    </table>

                </div>

            </div>

        </section>

    </main>

</div>

</body>
</html>
