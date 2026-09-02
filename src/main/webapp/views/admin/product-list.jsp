<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Product" %>

<%
    List<Product> listProduct =
            (List<Product>) request.getAttribute("listProduct");
%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Quản lý sản phẩm - Shopping MVC</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<div class="admin-layout">

    <!-- ================= SIDEBAR ================= -->

    <aside class="sidebar">

        <div class="sidebar-logo">

            🛒

            <span>
                Shopping MVC
            </span>

        </div>


        <div class="sidebar-menu">

            <div class="menu-title">
                QUẢN LÝ
            </div>


            <!-- Trang chủ -->

            <a href="${pageContext.request.contextPath}/admin/home"
               class="menu-item">

                📊

                <span>
                    Trang chủ
                </span>

            </a>


            <!-- Danh mục -->

            <a href="${pageContext.request.contextPath}/admin/categories"
               class="menu-item">

                📁

                <span>
                    Danh mục
                </span>

            </a>


            <!-- Sản phẩm -->

            <a href="${pageContext.request.contextPath}/admin/products"
               class="menu-item active">

                🛍

                <span>
                    Sản phẩm
                </span>

            </a>


            <!-- Video -->

            <a href="${pageContext.request.contextPath}/admin/videos"
               class="menu-item">

                🎬

                <span>
                    Video
                </span>

            </a>


            <div class="menu-title">
                HỆ THỐNG
            </div>


            <!-- Logout -->

            <a href="${pageContext.request.contextPath}/logout"
               class="menu-item">

                🚪

                <span>
                    Đăng xuất
                </span>

            </a>

        </div>

    </aside>


    <!-- ================= MAIN ================= -->

    <main class="main-area">


        <!-- TOPBAR -->

        <header class="topbar">

            <div class="topbar-title">
                Quản lý sản phẩm
            </div>


            <div class="user-info">

                <div class="avatar">
                    A
                </div>

                <span>
                    Administrator
                </span>

            </div>

        </header>


        <!-- CONTENT -->

        <section class="content">


            <!-- PAGE TITLE -->

            <div class="page-title">

                <div>

                    <h1>
                        Sản phẩm
                    </h1>

                    <p>
                        Quản lý các sản phẩm trong cửa hàng
                    </p>

                </div>


                <a href="${pageContext.request.contextPath}/admin/product/add"
                   class="btn btn-primary">

                    + Thêm sản phẩm

                </a>

            </div>


            <!-- ERROR -->

            <% if (request.getAttribute("error") != null) { %>

            <div class="alert alert-danger">

                <%= request.getAttribute("error") %>

            </div>

            <% } %>


            <!-- CARD -->

            <div class="card">


                <!-- HEADER -->

                <div class="card-header">

                    <div>

                        <h3>
                            Danh sách sản phẩm
                        </h3>

                        <span>
                            Quản lý thông tin và trạng thái sản phẩm
                        </span>

                    </div>


                    <span class="badge">

                        Tổng số:
                        <%= listProduct != null
                                ? listProduct.size()
                                : 0 %>

                    </span>

                </div>


                <!-- BODY -->

                <div class="card-body">


                    <!-- SEARCH -->

                    <form method="get"
                          action="${pageContext.request.contextPath}/admin/products"
                          style="margin-bottom:20px;">

                        <div style="
                            display:flex;
                            gap:10px;
                            align-items:center;
                            flex-wrap:wrap;
                        ">

                            <input
                                    type="text"
                                    name="keyword"
                                    class="form-control"
                                    placeholder="Tìm kiếm sản phẩm..."
                                    value="<%= request.getParameter("keyword") != null
                                            ? request.getParameter("keyword")
                                            : "" %>"
                                    style="max-width:300px;">

                            <button
                                    type="submit"
                                    class="btn btn-primary">

                                🔍 Tìm kiếm

                            </button>


                            <a
                                    href="${pageContext.request.contextPath}/admin/products"
                                    class="btn btn-secondary">

                                Làm mới

                            </a>

                        </div>

                    </form>


                    <!-- TABLE -->

                    <div class="table-wrapper">

                        <table class="table">


                            <thead>

                            <tr>

                                <th style="width:70px;">
                                    ID
                                </th>

                                <th style="width:100px;">
                                    Ảnh
                                </th>

                                <th>
                                    Tên sản phẩm
                                </th>

                                <th>
                                    Danh mục
                                </th>

                                <th>
                                    Giá
                                </th>

                                <th>
                                    Số lượng
                                </th>

                                <th>
                                    Trạng thái
                                </th>

                                <th style="width:190px;">
                                    Thao tác
                                </th>

                            </tr>

                            </thead>


                            <tbody>


                            <%

                                if (listProduct != null
                                        && !listProduct.isEmpty()) {

                                    for (Product product :
                                            listProduct) {

                            %>


                            <tr>


                                <!-- ID -->

                                <td>

                                    <span class="id-badge">

                                        <%= product.getId() %>

                                    </span>

                                </td>


                                <!-- IMAGE -->

                                <td>

                                    <div class="category-icon">

                                        <%

                                            String image =
                                                    product.getImage();

                                            if (image != null
                                                    && !image.trim().isEmpty()) {

                                        %>

                                        <img
                                                src="${pageContext.request.contextPath}/image?fname=<%= image %>"
                                                class="category-image"
                                                alt="Ảnh sản phẩm">

                                        <%

                                        } else {

                                        %>

                                        <span class="default-icon">
                                            🛍
                                        </span>

                                        <%

                                            }

                                        %>

                                    </div>

                                </td>


                                <!-- NAME -->

                                <td>

                                    <div class="category-name">

                                        <%= product.getName() %>

                                    </div>

                                </td>


                                <!-- CATEGORY -->

                                <td>

                                    <%

                                        if (product.getCategory() != null) {

                                    %>

                                    <%= product.getCategory().getCateName() %>

                                    <%

                                    } else {

                                    %>

                                    <span>
                                        Chưa có danh mục
                                    </span>

                                    <%

                                        }

                                    %>

                                </td>


                                <!-- PRICE -->

                                <td>

                                    <strong>

                                        <%= product.getPrice() %> đ

                                    </strong>

                                </td>


                                <!-- QUANTITY -->

                                <td>

                                    <%= product.getQuantity() %>

                                </td>


                                <!-- ACTIVE -->

                                <td>

                                    <%

                                        if (product.isActive()) {

                                    %>

                                    <span class="badge"
                                          style="background:#dcfce7;color:#166534;">

                                        Đang bán

                                    </span>

                                    <%

                                    } else {

                                    %>

                                    <span class="badge"
                                          style="background:#fee2e2;color:#991b1b;">

                                        Ngừng bán

                                    </span>

                                    <%

                                        }

                                    %>

                                </td>


                                <!-- ACTION -->

                                <td>

                                    <div class="actions">


                                        <!-- EDIT -->

                                        <a
                                                href="${pageContext.request.contextPath}/admin/product/edit?id=<%= product.getId() %>"
                                                class="btn btn-warning">

                                            ✏ Sửa

                                        </a>


                                        <!-- DELETE -->

                                        <a
                                                href="${pageContext.request.contextPath}/admin/product/delete?id=<%= product.getId() %>"
                                                class="btn btn-danger"

                                                onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">

                                            🗑 Xóa

                                        </a>


                                    </div>

                                </td>


                            </tr>


                            <%

                                    }

                                } else {

                            %>


                            <!-- EMPTY -->

                            <tr>

                                <td
                                        colspan="8"
                                        class="empty-state">

                                    <div class="empty-icon">
                                        🛍
                                    </div>

                                    <h3>
                                        Chưa có sản phẩm
                                    </h3>

                                    <p>
                                        Hãy thêm sản phẩm đầu tiên cho cửa hàng.
                                    </p>

                                    <a
                                            href="${pageContext.request.contextPath}/admin/product/add"
                                            class="btn btn-primary">

                                        + Thêm sản phẩm

                                    </a>

                                </td>

                            </tr>


                            <%

                                }

                            %>


                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

        </section>

    </main>

</div>

</body>

</html>
