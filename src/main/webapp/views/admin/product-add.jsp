<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Category" %>

<%
    List<Category> listCategory =
            (List<Category>) request.getAttribute("listCategory");
%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Thêm sản phẩm - Shopping MVC</title>

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


            <a href="${pageContext.request.contextPath}/admin/home"
               class="menu-item">

                📊

                <span>
                    Trang chủ
                </span>

            </a>


            <a href="${pageContext.request.contextPath}/admin/categories"
               class="menu-item">

                📁

                <span>
                    Danh mục
                </span>

            </a>


            <a href="${pageContext.request.contextPath}/admin/products"
               class="menu-item active">

                🛍

                <span>
                    Sản phẩm
                </span>

            </a>


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
                Thêm sản phẩm
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
                        Thêm sản phẩm
                    </h1>

                    <p>
                        Tạo một sản phẩm mới cho cửa hàng
                    </p>

                </div>


                <a
                        href="${pageContext.request.contextPath}/admin/products"
                        class="btn btn-secondary">

                    ← Quay lại

                </a>

            </div>


            <!-- ERROR -->

            <% if (request.getAttribute("error") != null) { %>

            <div class="alert alert-danger">

                <%= request.getAttribute("error") %>

            </div>

            <% } %>


            <!-- FORM CARD -->

            <div class="card form-card">


                <div class="card-header">

                    <div>

                        <h3>
                            Thông tin sản phẩm
                        </h3>

                        <span>
                            Nhập đầy đủ thông tin sản phẩm
                        </span>

                    </div>

                </div>


                <div class="card-body">


                    <form
                            method="post"
                            action="${pageContext.request.contextPath}/admin/product/insert"
                            enctype="multipart/form-data">


                        <!-- NAME -->

                        <div class="form-group">

                            <label for="name">
                                Tên sản phẩm
                            </label>

                            <input
                                    type="text"
                                    id="name"
                                    name="name"
                                    class="form-control"
                                    placeholder="Ví dụ: Áo sơ mi nam cao cấp"
                                    required>

                        </div>


                        <!-- DESCRIPTION -->

                        <div class="form-group">

                            <label for="description">
                                Mô tả
                            </label>

                            <textarea
                                    id="description"
                                    name="description"
                                    class="form-control"
                                    rows="5"
                                    placeholder="Nhập mô tả sản phẩm..."></textarea>

                        </div>


                        <!-- PRICE -->

                        <div class="form-group">

                            <label for="price">
                                Giá
                            </label>

                            <input
                                    type="number"
                                    id="price"
                                    name="price"
                                    class="form-control"
                                    min="0"
                                    step="0.01"
                                    placeholder="Ví dụ: 299000"
                                    required>

                        </div>


                        <!-- QUANTITY -->

                        <div class="form-group">

                            <label for="quantity">
                                Số lượng
                            </label>

                            <input
                                    type="number"
                                    id="quantity"
                                    name="quantity"
                                    class="form-control"
                                    min="0"
                                    placeholder="Ví dụ: 50"
                                    required>

                        </div>


                        <!-- CATEGORY -->

                        <div class="form-group">

                            <label for="categoryId">
                                Danh mục
                            </label>

                            <select
                                    id="categoryId"
                                    name="categoryId"
                                    class="form-control"
                                    required>

                                <option value="">
                                    -- Chọn danh mục --
                                </option>


                                <%

                                    if (listCategory != null) {

                                        for (Category category :
                                                listCategory) {

                                %>

                                <option
                                        value="<%= category.getCateId() %>">

                                    <%= category.getCateName() %>

                                </option>

                                <%

                                        }

                                    }

                                %>

                            </select>

                        </div>


                        <!-- IMAGE -->

                        <div class="form-group">

                            <label for="image">
                                Ảnh sản phẩm
                            </label>

                            <input
                                    type="file"
                                    id="image"
                                    name="image"
                                    class="form-control file-input"
                                    accept="image/*"
                                    onchange="previewImage(event)">

                            <small class="form-hint">

                                Chọn ảnh sản phẩm.
                                Định dạng JPG, JPEG, PNG, GIF.

                            </small>


                            <!-- PREVIEW -->

                            <div
                                    id="preview-container"
                                    style="display:none; margin-top:15px;">

                                <p class="preview-label">
                                    Xem trước:
                                </p>

                                <img
                                        id="preview"
                                        class="preview-image"
                                        alt="Ảnh xem trước">

                            </div>

                        </div>


                        <!-- ACTIVE -->

                        <div class="form-group">

                            <label>
                                Trạng thái
                            </label>

                            <div>

                                <label style="display:inline-flex;align-items:center;gap:8px;">

                                    <input
                                            type="radio"
                                            name="active"
                                            value="true"
                                            checked>

                                    Đang bán

                                </label>


                                <label style="display:inline-flex;align-items:center;gap:8px;margin-left:20px;">

                                    <input
                                            type="radio"
                                            name="active"
                                            value="false">

                                    Ngừng bán

                                </label>

                            </div>

                        </div>


                        <!-- BUTTON -->

                        <div class="form-actions">

                            <button
                                    type="submit"
                                    class="btn btn-primary">

                                ✓ Thêm sản phẩm

                            </button>


                            <a
                                    href="${pageContext.request.contextPath}/admin/products"
                                    class="btn btn-secondary">

                                Hủy

                            </a>

                        </div>


                    </form>

                </div>

            </div>

        </section>

    </main>

</div>


<!-- ================= JAVASCRIPT ================= -->

<script>

    function previewImage(event) {

        const file =
            event.target.files[0];

        const preview =
            document.getElementById("preview");

        const container =
            document.getElementById("preview-container");


        if (file) {

            preview.src =
                URL.createObjectURL(file);

            container.style.display =
                "block";

        } else {

            preview.src = "";

            container.style.display =
                "none";

        }

    }

</script>


</body>

</html>
