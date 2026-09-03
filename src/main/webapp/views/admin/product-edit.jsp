<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Category" %>
<%@ page import="vn.iotstar.entity.Product" %>

<%
    Product product =
            (Product) request.getAttribute("product");

    List<Category> listCategory =
            (List<Category>) request.getAttribute("listCategory");
%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Chỉnh sửa sản phẩm - Shopping MVC</title>

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
                Chỉnh sửa sản phẩm
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
                        Chỉnh sửa sản phẩm
                    </h1>

                    <p>
                        Cập nhật thông tin sản phẩm
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
                            Cập nhật thông tin bên dưới
                        </span>

                    </div>

                </div>


                <div class="card-body">


                    <form
                            method="post"
                            action="${pageContext.request.contextPath}/admin/product/update"
                            enctype="multipart/form-data">


                        <!-- ID -->

                        <div class="form-group">

                            <label>
                                ID
                            </label>

                            <input
                                    type="text"
                                    class="form-control"
                                    value="<%= product.getId() %>"
                                    disabled>

                            <input
                                    type="hidden"
                                    name="id"
                                    value="<%= product.getId() %>">

                        </div>


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
                                    value="<%= product.getName() %>"
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
                                    rows="5"><%= product.getDescription() != null
                                        ? product.getDescription()
                                        : "" %></textarea>

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
                                    value="<%= product.getPrice() %>"
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
                                    value="<%= product.getQuantity() %>"
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

                                            boolean selected =
                                                    product.getCategory() != null
                                                            && product.getCategory().getCateId()
                                                            == category.getCateId();

                                %>

                                <option
                                        value="<%= category.getCateId() %>"
                                        <%= selected ? "selected" : "" %>>

                                    <%= category.getCateName() %>

                                </option>

                                <%

                                        }

                                    }

                                %>

                            </select>

                        </div>


                        <!-- OLD IMAGE -->

                        <div class="form-group">

                            <label>
                                Ảnh hiện tại
                            </label>


                            <div>

                                <%

                                    String oldImage =
                                            product.getImage();

                                    if (oldImage != null
                                            && !oldImage.trim().isEmpty()) {

                                %>

                                <img
                                        src="${pageContext.request.contextPath}/image?fname=<%= oldImage %>"
                                        class="preview-image"
                                        alt="Ảnh sản phẩm hiện tại">

                                <%

                                } else {

                                %>

                                <div class="no-image">

                                    🛍 Chưa có ảnh

                                </div>

                                <%

                                    }

                                %>

                            </div>

                        </div>


                        <!-- NEW IMAGE -->

                        <div class="form-group">

                            <label for="image">
                                Chọn ảnh mới
                            </label>

                            <input
                                    type="file"
                                    id="image"
                                    name="image"
                                    class="form-control file-input"
                                    accept="image/*"
                                    onchange="previewImage(event)">


                            <!-- NEW IMAGE PREVIEW -->

                            <img
                                    id="preview"
                                    class="preview-image"
                                    style="display:none;"
                                    alt="Ảnh mới">


                            <small class="form-hint">

                                Nếu không chọn ảnh mới,
                                ảnh hiện tại sẽ được giữ nguyên.

                            </small>

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
                                            <%= product.isActive()
                                                    ? "checked"
                                                    : "" %>>

                                    Đang bán

                                </label>


                                <label style="display:inline-flex;align-items:center;gap:8px;margin-left:20px;">

                                    <input
                                            type="radio"
                                            name="active"
                                            value="false"
                                            <%= !product.isActive()
                                                    ? "checked"
                                                    : "" %>>

                                    Ngừng bán

                                </label>


                            </div>

                        </div>


                        <!-- BUTTON -->

                        <div class="form-actions">


                            <button
                                    type="submit"
                                    class="btn btn-primary">

                                💾 Lưu thay đổi

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


        if (file) {

            preview.src =
                URL.createObjectURL(file);

            preview.style.display =
                "block";

        } else {

            preview.src = "";

            preview.style.display =
                "none";

        }

    }

</script>


</body>

</html>
