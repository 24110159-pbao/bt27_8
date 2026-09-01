<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Video" %>
<%@ page import="vn.iotstar.entity.Category" %>

<%
    Video video =
            (Video) request.getAttribute("video");

    List<Category> listCategory =
            (List<Category>) request.getAttribute("listCategory");
%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Chỉnh sửa video - Shopping MVC</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<div class="admin-layout">

    <!-- SIDEBAR -->

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
                <span>Trang chủ</span>

            </a>

            <a href="${pageContext.request.contextPath}/admin/categories"
               class="menu-item">

                📁
                <span>Danh mục</span>

            </a>

            <a href="${pageContext.request.contextPath}/admin/videos"
               class="menu-item active">

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


    <!-- MAIN -->

    <main class="main-area">

        <header class="topbar">

            <div class="topbar-title">
                Chỉnh sửa video
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


        <section class="content">

            <div class="page-title">

                <div>

                    <h1>
                        Chỉnh sửa video
                    </h1>

                    <p>
                        Cập nhật thông tin video
                    </p>

                </div>

                <a href="${pageContext.request.contextPath}/admin/videos"
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
                            Thông tin video
                        </h3>

                        <span>
                            Cập nhật thông tin bên dưới
                        </span>

                    </div>

                </div>


                <div class="card-body">

                    <form method="post"
                          action="${pageContext.request.contextPath}/admin/video/update"
                          enctype="multipart/form-data">


                        <!-- ID -->

                        <div class="form-group">

                            <label>
                                Video ID
                            </label>

                            <input
                                    type="text"
                                    class="form-control"
                                    value="<%= video.getVideoId() %>"
                                    disabled>

                            <input
                                    type="hidden"
                                    name="videoId"
                                    value="<%= video.getVideoId() %>">

                        </div>


                        <!-- TITLE -->

                        <div class="form-group">

                            <label for="title">
                                Tiêu đề video
                            </label>

                            <input
                                    type="text"
                                    id="title"
                                    name="title"
                                    class="form-control"
                                    value="<%= video.getTitle() != null
                                            ? video.getTitle()
                                            : "" %>"
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
                                                    video.getCategory() != null
                                                    && video.getCategory()
                                                            .getCateId()
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
                                    placeholder="Nhập mô tả video"><%= video.getDescription() != null
                                    ? video.getDescription()
                                    : "" %></textarea>

                        </div>


                        <!-- VIEWS -->

                        <div class="form-group">

                            <label for="views">
                                Lượt xem
                            </label>

                            <input
                                    type="number"
                                    id="views"
                                    name="views"
                                    class="form-control"
                                    min="0"
                                    value="<%= video.getViews() %>">

                        </div>


                        <!-- ACTIVE -->

                        <div class="form-group">

                            <label for="active">
                                Trạng thái
                            </label>

                            <select
                                    id="active"
                                    name="active"
                                    class="form-control">

                                <option
                                        value="1"
                                        <%= video.isActive()
                                                ? "selected"
                                                : "" %>>

                                    Hoạt động

                                </option>

                                <option
                                        value="0"
                                        <%= !video.isActive()
                                                ? "selected"
                                                : "" %>>

                                    Không hoạt động

                                </option>

                            </select>

                        </div>


                        <!-- OLD POSTER -->

                        <div class="form-group">

                            <label>
                                Poster hiện tại
                            </label>

                            <div>

                                <% if (video.getPoster() != null
                                        && !video.getPoster().isEmpty()) { %>

                                <img
                                        src="${pageContext.request.contextPath}/image?fname=<%= video.getPoster() %>"
                                        class="preview-image"
                                        alt="Poster hiện tại">

                                <% } else { %>

                                <div class="no-image">
                                    🎬 Chưa có poster
                                </div>

                                <% } %>

                            </div>

                        </div>


                        <!-- NEW POSTER -->

                        <div class="form-group">

                            <label for="poster">
                                Chọn poster mới
                            </label>

                            <input
                                    type="file"
                                    id="poster"
                                    name="poster"
                                    class="form-control file-input"
                                    accept="image/*"
                                    onchange="previewImage(event)">

                            <img
                                    id="preview"
                                    class="preview-image"
                                    style="display:none;"
                                    alt="Poster mới">


                            <small class="form-hint">

                                Nếu không chọn ảnh mới,
                                poster hiện tại sẽ được giữ nguyên.

                            </small>

                        </div>


                        <!-- BUTTON -->

                        <div class="form-actions">

                            <button
                                    type="submit"
                                    class="btn btn-primary">

                                💾 Lưu thay đổi

                            </button>

                            <a
                                    href="${pageContext.request.contextPath}/admin/videos"
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

        preview.src = "";

        preview.style.display =
                "none";
    }
}

</script>

</body>

</html>