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

    <title>Thêm video - Shopping MVC</title>

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
                Thêm video
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
                        Thêm video
                    </h1>

                    <p>
                        Tạo một video mới cho hệ thống
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
                            Nhập thông tin video bên dưới
                        </span>

                    </div>

                </div>


                <div class="card-body">

                    <form method="post"
                          action="${pageContext.request.contextPath}/admin/video/insert"
                          enctype="multipart/form-data">


                        <!-- VIDEO ID -->

                        <div class="form-group">

                            <label for="videoId">
                                Video ID
                            </label>

                            <input
                                    type="text"
                                    id="videoId"
                                    name="videoId"
                                    class="form-control"
                                    placeholder="Ví dụ: video001"
                                    value="<%= video != null && video.getVideoId() != null
                                            ? video.getVideoId()
                                            : "" %>"
                                    required>

                            <small class="form-hint">
                                ID video phải là duy nhất.
                            </small>

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
                                    placeholder="Nhập tiêu đề video"
                                    value="<%= video != null && video.getTitle() != null
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
                                                    video != null
                                                    && video.getCategory() != null
                                                    && video.getCategory().getCateId()
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
                                    placeholder="Nhập mô tả video"><%= video != null && video.getDescription() != null
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
                                    value="<%= video != null
                                            ? video.getViews()
                                            : 0 %>">

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

                                <option value="1">
                                    Hoạt động
                                </option>

                                <option value="0">
                                    Không hoạt động
                                </option>

                            </select>

                        </div>


                        <!-- POSTER -->

                        <div class="form-group">

                            <label for="poster">
                                Poster video
                            </label>

                            <input
                                    type="file"
                                    id="poster"
                                    name="poster"
                                    class="form-control file-input"
                                    accept="image/*"
                                    onchange="previewImage(event)">

                            <small class="form-hint">

                                Định dạng hỗ trợ:
                                JPG, JPEG, PNG, GIF.

                            </small>


                            <div
                                    id="preview-container"
                                    style="display:none; margin-top:15px;">

                                <p class="preview-label">
                                    Xem trước:
                                </p>

                                <img
                                        id="preview"
                                        class="preview-image"
                                        alt="Poster xem trước">

                            </div>

                        </div>


                        <!-- BUTTON -->

                        <div class="form-actions">

                            <button
                                    type="submit"
                                    class="btn btn-primary">

                                ✓ Thêm video

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