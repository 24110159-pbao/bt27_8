Dưới đây là code Sửa danh mục được ghi lại và format lại cho dễ đọc, giữ nguyên chức năng:

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">

    <title>Sửa danh mục</title>

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
                Sửa danh mục
            </div>

        </header>


        <section class="content">

            <div class="page-title">

                <div>

                    <h1>Sửa danh mục</h1>

                    <p>
                        Cập nhật thông tin danh mục
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
                            action="${pageContext.request.contextPath}/admin/category/update"
                            method="post"
                            enctype="multipart/form-data">


                        <input
                                type="hidden"
                                name="categoryid"
                                value="${cate.categoryid}">


                        <div class="form-group">

                            <label for="categoryname">
                                Tên danh mục
                            </label>

                            <input
                                    type="text"
                                    id="categoryname"
                                    name="categoryname"
                                    class="form-control"
                                    value="${cate.categoryname}"
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
                                    value="${cate.images}">

                        </div>


                        <c:if test="${not empty cate.images}">

                            <div class="form-group">

                                <label>
                                    Ảnh hiện tại
                                </label>

                                <br>

                                <img
                                        src="${pageContext.request.contextPath}/image?fname=${cate.images}"
                                        width="200"
                                        height="150"
                                        style="object-fit:cover;"
                                        alt="${cate.categoryname}">

                            </div>

                        </c:if>


                        <div class="form-group">

                            <label for="images1">
                                Upload ảnh mới
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

                                ✓ Cập nhật

                            </button>


                            <a
                                    href="${pageContext.request.contextPath}/admin/category/list"
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