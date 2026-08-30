<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="vn.iotstar.entity.Category" %>

<%
    Category category =
            (Category) request.getAttribute("category");
%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Chỉnh sửa danh mục</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<div class="admin-layout">

    <aside class="sidebar">

        <div class="sidebar-logo">
            🛒 <span>Shopping MVC</span>
        </div>

        <div class="sidebar-menu">

            <div class="menu-title">
                QUẢN LÝ
            </div>

            <a href="${pageContext.request.contextPath}/admin/home"
               class="menu-item">

                📊
                <span>Trang chủ</span>

            </a>

            <a href="${pageContext.request.contextPath}/admin/categories"
               class="menu-item active">

                📁
                <span>Danh mục</span>

            </a>

            <a href="${pageContext.request.contextPath}/admin/videos"
               class="menu-item">

                🎬
                <span>Video</span>

            </a>

            <div class="menu-title">
                HỆ THỐNG
            </div>

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
                Chỉnh sửa danh mục
            </div>

        </header>


        <section class="content">

            <div class="page-title">

                <div>

                    <h1>
                        Chỉnh sửa danh mục
                    </h1>

                    <p>
                        Cập nhật thông tin danh mục
                    </p>

                </div>

                <a href="${pageContext.request.contextPath}/admin/categories"
                   class="btn btn-secondary">

                    ← Quay lại

                </a>

            </div>


            <% if (request.getAttribute("error") != null) { %>

            <div class="alert alert-danger">

                <%= request.getAttribute("error") %>

            </div>

            <% } %>


            <div class="card form-card">

                <div class="card-header">

                    <div>

                        <h3>
                            Thông tin danh mục
                        </h3>

                        <span>
                            Cập nhật thông tin bên dưới
                        </span>

                    </div>

                </div>


                <div class="card-body">


                    <form method="post"
                          action="${pageContext.request.contextPath}/admin/category/update"
                          enctype="multipart/form-data">


                        <!-- ID -->

                        <div class="form-group">

                            <label>
                                ID
                            </label>

                            <input type="text"
                                   class="form-control"
                                   value="<%= category.getCateId() %>"
                                   disabled>

                            <input type="hidden"
                                   name="cateId"
                                   value="<%= category.getCateId() %>">

                        </div>


                        <!-- NAME -->

                        <div class="form-group">

                            <label>
                                Tên danh mục
                            </label>

                            <input type="text"
                                   name="cateName"
                                   class="form-control"
                                   value="<%= category.getCateName() %>"
                                   required>

                        </div>


                        <!-- OLD IMAGE -->

                        <div class="form-group">

                            <label>
                                Icon hiện tại
                            </label>

                            <div>

                                <% if (category.getIcons() != null
                                        && !category.getIcons().isEmpty()) { %>

                                <img
                                    src="${pageContext.request.contextPath}/image?fname=<%= category.getIcons() %>"
                                    class="preview-image"
                                    alt="Icon hiện tại">

                                <% } else { %>

                                <div class="no-image">
                                    📁 Chưa có icon
                                </div>

                                <% } %>

                            </div>

                        </div>


                        <!-- NEW IMAGE -->

                        <div class="form-group">

                            <label>
                                Chọn icon mới
                            </label>

                            <input type="file"
                                   name="icon"
                                   class="form-control file-input"
                                   accept="image/*"
                                   onchange="previewImage(event)">

                            <img
                                id="preview"
                                class="preview-image"
                                style="display:none;">

                            <small class="form-hint">

                                Nếu không chọn ảnh mới,
                                icon hiện tại sẽ được giữ nguyên.

                            </small>

                        </div>


                        <!-- BUTTON -->

                        <div class="form-actions">

                            <button type="submit"
                                    class="btn btn-primary">

                                💾 Lưu thay đổi

                            </button>

                            <a href="${pageContext.request.contextPath}/admin/categories"
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

        preview.style.display =
            "none";
    }
}

</script>

</body>

</html>
