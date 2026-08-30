<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">

    <title>Thêm danh mục - Shopping MVC</title>

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
               class="menu-item active">

                📁

                <span>
                    Danh mục
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
                Thêm danh mục
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
                        Thêm danh mục
                    </h1>

                    <p>
                        Tạo một danh mục mới cho hệ thống
                    </p>

                </div>

                <a href="${pageContext.request.contextPath}/admin/categories"
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

                <!-- HEADER -->

                <div class="card-header">

                    <div>

                        <h3>
                            Thông tin danh mục
                        </h3>

                        <span>
                            Nhập thông tin và chọn icon cho danh mục
                        </span>

                    </div>

                </div>

                <!-- BODY -->

                <div class="card-body">

                    <form
                        method="post"
                        action="${pageContext.request.contextPath}/admin/category/insert"
                        enctype="multipart/form-data">

                        <!-- ================= NAME ================= -->

                        <div class="form-group">

                            <label for="cateName">
                                Tên danh mục
                            </label>

                            <input
                                type="text"
                                id="cateName"
                                name="cateName"
                                class="form-control"
                                placeholder="Ví dụ: Điện thoại"
                                required>

                        </div>

                        <!-- ================= IMAGE ================= -->

                        <div class="form-group">

                            <label for="icon">
                                Icon danh mục
                            </label>

                            <input
                                type="file"
                                id="icon"
                                name="icon"
                                class="form-control file-input"
                                accept="image/*"
                                onchange="previewImage(event)">

                            <small class="form-hint">

                                Chọn ảnh từ máy tính.
                                Định dạng hỗ trợ: JPG, JPEG, PNG, GIF.

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

                        <!-- ================= BUTTON ================= -->

                        <div class="form-actions">

                            <button
                                type="submit"
                                class="btn btn-primary">

                                ✓ Thêm danh mục

                            </button>

                            <a
                                href="${pageContext.request.contextPath}/admin/categories"
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

        const file = event.target.files[0];

        const preview = document.getElementById("preview");

        const container = document.getElementById("preview-container");

        if (file) {

            preview.src = URL.createObjectURL(file);

            container.style.display = "block";

        } else {

            preview.src = "";

            container.style.display = "none";

        }

    }

</script>

</body>

</html>
