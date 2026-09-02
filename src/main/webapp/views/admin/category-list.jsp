<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Category" %>

<%
List<Category> listCategory =
(List<Category>) request.getAttribute("listCategory");
%>

<!DOCTYPE html> <html lang="vi"> <head>
<meta charset="UTF-8">

<title>Quản lý danh mục - Shopping MVC</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">

</head> <body> <div class="admin-layout">
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
           class="menu-item active">

            📁

            <span>
                Danh mục
            </span>

        </a>

        <!-- Sản phẩm -->
        <a href="${pageContext.request.contextPath}/admin/products"
           class="menu-item">

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
            Quản lý danh mục
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
                    Danh mục sản phẩm
                </h1>

                <p>
                    Quản lý các danh mục trong cửa hàng
                </p>

            </div>


            <a href="${pageContext.request.contextPath}/admin/category/add"
               class="btn btn-primary">

                + Thêm danh mục

            </a>

        </div>



        <!-- CARD -->

        <div class="card">


            <!-- HEADER -->

            <div class="card-header">

                <div>

                    <h3>
                        Danh sách danh mục
                    </h3>

                    <span>
                        Quản lý tên và icon danh mục
                    </span>

                </div>


                <span class="badge">

                    Tổng số:
                    <%= listCategory != null
                            ? listCategory.size()
                            : 0 %>

                </span>

            </div>



            <!-- BODY -->

            <div class="card-body">

                <div class="table-wrapper">

                    <table class="table">


                        <!-- TABLE HEADER -->

                        <thead>

                        <tr>

                            <th style="width:80px;">
                                ID
                            </th>

                            <th style="width:120px;">
                                Icon
                            </th>

                            <th>
                                Tên danh mục
                            </th>

                            <th style="width:190px;">
                                Thao tác
                            </th>

                        </tr>

                        </thead>



                        <!-- TABLE BODY -->

                        <tbody>


                        <%

                            if (listCategory != null
                                    && !listCategory.isEmpty()) {

                                for (Category category :
                                        listCategory) {

                        %>


                        <tr>


                            <!-- ID -->

                            <td>

                                <span class="id-badge">

                                    <%= category.getCateId() %>

                                </span>

                            </td>



                            <!-- ICON -->

                            <td>

                                <div class="category-icon">

                                    <%

                                        String icon =
                                                category.getIcons();

                                        if (icon != null
                                                && !icon.trim().isEmpty()) {

                                    %>


                                    <img
                                            src="${pageContext.request.contextPath}/image?fname=<%= icon %>"
                                            class="category-image"
                                            alt="Icon">


                                    <%

                                        } else {

                                    %>


                                    <span class="default-icon">
                                        📁
                                    </span>


                                    <%

                                        }

                                    %>

                                </div>

                            </td>



                            <!-- NAME -->

                            <td>

                                <div class="category-name">

                                    <%= category.getCateName() %>

                                </div>

                            </td>



                            <!-- ACTION -->

                            <td>

                                <div class="actions">


                                    <!-- EDIT -->

                                    <a
                                            href="${pageContext.request.contextPath}/admin/category/edit?id=<%= category.getCateId() %>"
                                            class="btn btn-warning">

                                        ✏ Sửa

                                    </a>



                                    <!-- DELETE -->

                                    <a
                                            href="${pageContext.request.contextPath}/admin/category/delete?id=<%= category.getCateId() %>"
                                            class="btn btn-danger"

                                            onclick="return confirm('Bạn có chắc muốn xóa danh mục này?');">

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
                                    colspan="4"
                                    class="empty-state">


                                <div class="empty-icon">
                                    📁
                                </div>


                                <h3>
                                    Chưa có danh mục
                                </h3>


                                <p>
                                    Hãy thêm danh mục đầu tiên cho cửa hàng.
                                </p>


                                <a
                                        href="${pageContext.request.contextPath}/admin/category/add"
                                        class="btn btn-primary">

                                    + Thêm danh mục

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

</div> </body> </html>