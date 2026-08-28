Dưới đây là code được ghi lại, giữ nguyên nội dung và cấu trúc của bạn:

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">

    <title>Thêm danh mục</title>

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
                Thêm danh mục
            </div>

        </header>


        <section class="content">

            <div class="page-title">

                <div>

                    <h1>Thêm danh mục</h1>

                    <p>
                        Tạo một danh mục sản phẩm mới
                    </p>

                </div>

            </div>


            <div class="card form-card">

                <div class="card-body">

                    <c:if test="${not empty error}">

                        <div style="color:red; margin-bottom:15px;">
                            ${error}
                        </div>

                    </c:if>


                    <form
                            method="post"
                            action="${pageContext.request.contextPath}/admin/category/add"
                            enctype="multipart/form-data">


                        <div class="form-group">

                            <label for="categoryname">
                                Tên danh mục
                            </label>

                            <input
                                    type="text"
                                    id="categoryname"
                                    name="categoryname"
                                    class="form-control"
                                    placeholder="Ví dụ: Điện thoại"
                                    required>

                        </div>


                        <div class="form-group">

                            <label for="images">
                                Link ảnh
                            </label>

                            <input
                                    type="text"
                                    id="images"
                                    name="images"
                                    class="form-control"
                                    placeholder="category/phone.jpg">

                        </div>


                        <div class="form-group">

                            <label for="images1">
                                Upload ảnh
                            </label>

                            <input
                                    type="file"
                                    id="images1"
                                    name="images1"
                                    class="form-control file-input"
                                    accept="image/*"
                                    onchange="previewImage(event)">

                            <br>

                            <img
                                    id="preview"
                                    width="200"
                                    height="150"
                                    style="display:none; object-fit:cover;"
                                    alt="Preview">

                        </div>


                        <div style="display:flex;gap:10px;">

                            <button
                                    type="submit"
                                    class="btn btn-success">

                                ✓ Thêm danh mục

                            </button>


                            <a
                                    href="${pageContext.request.contextPath}/admin/category/list"
                                    class="btn btn-secondary">

                                Quay lại

                            </a>

                        </div>

                    </form>

                </div>

            </div>

        </section>

    </main>

</div>


<script>

    function previewImage(event) {

        const file = event.target.files[0];

        const preview = document.getElementById("preview");

        if (file) {

            preview.src = URL.createObjectURL(file);

            preview.style.display = "block";

        } else {

            preview.style.display = "none";

        }

    }

</script>

</body>
</html>