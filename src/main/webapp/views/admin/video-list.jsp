<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Video" %>

<%
    List<Video> listVideo =
            (List<Video>) request.getAttribute("listVideo");

    String keyword =
            (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Quản lý video - Shopping MVC</title>

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


            <a href="${pageContext.request.contextPath}/admin/videos"
               class="menu-item active">

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


    <!-- MAIN -->

    <main class="main-area">


        <!-- TOPBAR -->

        <header class="topbar">

            <div class="topbar-title">
                Quản lý video
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
                        Video
                    </h1>

                    <p>
                        Quản lý các video trong hệ thống
                    </p>

                </div>


                <a
                        href="${pageContext.request.contextPath}/admin/video/add"
                        class="btn btn-primary">

                    + Thêm video

                </a>

            </div>


            <!-- SEARCH -->

            <div class="card">

                <div class="card-body">

                    <form
                            method="get"
                            action="${pageContext.request.contextPath}/admin/videos"
                            style="display:flex; gap:10px;">

                        <input
                                type="text"
                                name="keyword"
                                class="form-control"
                                placeholder="Tìm kiếm theo tiêu đề video..."
                                value="<%= keyword != null
                                        ? keyword
                                        : "" %>">

                        <button
                                type="submit"
                                class="btn btn-primary">

                            🔍 Tìm kiếm

                        </button>


                        <a
                                href="${pageContext.request.contextPath}/admin/videos"
                                class="btn btn-secondary">

                            Làm mới

                        </a>

                    </form>

                </div>

            </div>


            <!-- VIDEO CARD -->

            <div class="card">


                <!-- HEADER -->

                <div class="card-header">

                    <div>

                        <h3>
                            Danh sách video
                        </h3>

                        <span>
                            Quản lý thông tin video
                        </span>

                    </div>


                    <span class="badge">

                        Tổng số:
                        <%= listVideo != null
                                ? listVideo.size()
                                : 0 %>

                    </span>

                </div>


                <!-- BODY -->

                <div class="card-body">

                    <div class="table-wrapper">

                        <table class="table">

                            <thead>

                            <tr>

                                <th>
                                    ID
                                </th>

                                <th style="width:130px;">
                                    Poster
                                </th>

                                <th>
                                    Tiêu đề
                                </th>

                                <th>
                                    Danh mục
                                </th>

                                <th>
                                    Lượt xem
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

                                if (listVideo != null
                                        && !listVideo.isEmpty()) {

                                    for (Video video :
                                            listVideo) {

                            %>


                            <tr>


                                <!-- ID -->

                                <td>

                                    <span class="id-badge">

                                        <%= video.getVideoId() %>

                                    </span>

                                </td>


                                <!-- POSTER -->

                                <td>

                                    <div class="category-icon">

                                        <%

                                            String poster =
                                                    video.getPoster();

                                            if (poster != null
                                                    && !poster.trim().isEmpty()) {

                                        %>

                                        <img
                                                src="${pageContext.request.contextPath}/image?fname=<%= poster %>"
                                                class="category-image"
                                                alt="Poster">


                                        <%

                                            } else {

                                        %>

                                        <span class="default-icon">
                                            🎬
                                        </span>

                                        <%

                                            }

                                        %>

                                    </div>

                                </td>


                                <!-- TITLE -->

                                <td>

                                    <div class="category-name">

                                        <%= video.getTitle() != null
                                                ? video.getTitle()
                                                : "" %>

                                    </div>

                                </td>


                                <!-- CATEGORY -->

                                <td>

                                    <%

                                        if (video.getCategory() != null) {

                                    %>

                                    <span class="badge">

                                        <%= video.getCategory()
                                                .getCateName() %>

                                    </span>

                                    <%

                                        } else {

                                    %>

                                    <span class="no-image">
                                        Chưa có danh mục
                                    </span>

                                    <%

                                        }

                                    %>

                                </td>


                                <!-- VIEWS -->

                                <td>

                                    👁

                                    <%= video.getViews() %>

                                </td>


                                <!-- ACTIVE -->

                                <td>

                                    <%

                                        if (video.isActive()) {

                                    %>

                                    <span
                                            class="badge"
                                            style="background:#dcfce7;color:#166534;">

                                        Hoạt động

                                    </span>

                                    <%

                                        } else {

                                    %>

                                    <span
                                            class="badge"
                                            style="background:#fee2e2;color:#991b1b;">

                                        Không hoạt động

                                    </span>

                                    <%

                                        }

                                    %>

                                </td>


                                <!-- ACTION -->

                                <td>

                                    <div class="actions">


                                        <a
                                                href="${pageContext.request.contextPath}/admin/video/edit?id=<%= video.getVideoId() %>"
                                                class="btn btn-warning">

                                            ✏ Sửa

                                        </a>


                                        <a
                                                href="${pageContext.request.contextPath}/admin/video/delete?id=<%= video.getVideoId() %>"
                                                class="btn btn-danger"

                                                onclick="return confirm('Bạn có chắc muốn xóa video này?');">

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
                                        colspan="7"
                                        class="empty-state">


                                    <div class="empty-icon">
                                        🎬
                                    </div>


                                    <h3>
                                        Chưa có video
                                    </h3>


                                    <p>
                                        Hãy thêm video đầu tiên cho hệ thống.
                                    </p>


                                    <a
                                            href="${pageContext.request.contextPath}/admin/video/add"
                                            class="btn btn-primary">

                                        + Thêm video

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