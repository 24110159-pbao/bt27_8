<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Video" %>

<%
    List<Video> listVideo =
            (List<Video>) request.getAttribute("listVideo");

    String keyword =
            (String) request.getAttribute("keyword");
%>


<title>Quản lý video - Shopping MVC</title>


<section class="content">


    <!-- =====================================================
         PAGE HEADER
         ===================================================== -->

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

            <i class="bi bi-plus-lg me-1"></i>

            Thêm video

        </a>

    </div>


    <!-- =====================================================
         SEARCH
         ===================================================== -->

    <div class="card">

        <div class="card-body">

            <form
                    method="get"
                    action="${pageContext.request.contextPath}/admin/videos"
                    class="row g-2 needs-validation"
                    novalidate>


                <div class="col-12 col-md-6 col-lg-5">

                    <label
                            for="keyword"
                            class="form-label">

                        Tìm kiếm video

                    </label>

                    <input
                            type="text"
                            id="keyword"
                            name="keyword"
                            class="form-control"
                            placeholder="Tìm kiếm theo tiêu đề video..."
                            maxlength="100"
                            value="<%= keyword != null ? keyword : "" %>">

                    <div class="invalid-feedback">

                        Từ khóa không được vượt quá 100 ký tự.

                    </div>

                </div>


                <div class="col-12 col-md-auto d-flex align-items-end gap-2">

                    <button
                            type="submit"
                            class="btn btn-primary">

                        <i class="bi bi-search me-1"></i>

                        Tìm kiếm

                    </button>


                    <a
                            href="${pageContext.request.contextPath}/admin/videos"
                            class="btn btn-secondary">

                        <i class="bi bi-arrow-clockwise me-1"></i>

                        Làm mới

                    </a>

                </div>

            </form>

        </div>

    </div>


    <!-- =====================================================
         VIDEO CARD
         ===================================================== -->

    <div class="card">


        <!-- HEADER -->

        <div class="card-header">

            <div>

                <h3>

                    <i class="bi bi-camera-video-fill text-primary me-2"></i>

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

                        <th style="width:70px;">
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

                            for (Video video : listVideo) {

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
                                        alt="Poster video">

                                <%

                                } else {

                                %>

                                <span class="default-icon">

                                    <i class="bi bi-camera-video-fill text-secondary"></i>

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

                            <span class="text-muted">

                                Chưa có danh mục

                            </span>

                            <%

                                }

                            %>

                        </td>


                        <!-- VIEWS -->

                        <td>

                            <i class="bi bi-eye me-1"></i>

                            <%= video.getViews() %>

                        </td>


                        <!-- STATUS -->

                        <td>

                            <%

                                if (video.isActive()) {

                            %>

                            <span
                                    class="badge"
                                    style="
                                        background:#dcfce7;
                                        color:#166534;
                                    ">

                                <i class="bi bi-check-circle me-1"></i>

                                Hoạt động

                            </span>

                            <%

                                } else {

                            %>

                            <span
                                    class="badge"
                                    style="
                                        background:#fee2e2;
                                        color:#991b1b;
                                    ">

                                <i class="bi bi-x-circle me-1"></i>

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
                                        class="btn btn-sm btn-warning">

                                    <i class="bi bi-pencil-square me-1"></i>

                                    Sửa

                                </a>


                                <a
                                        href="${pageContext.request.contextPath}/admin/video/delete?id=<%= video.getVideoId() %>"
                                        class="btn btn-sm btn-danger"

                                        onclick="
                                            return confirm(
                                                'Bạn có chắc muốn xóa video này?'
                                            );
                                        ">

                                    <i class="bi bi-trash me-1"></i>

                                    Xóa

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

                                <i class="bi bi-camera-video-off text-secondary"></i>

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

                                <i class="bi bi-plus-lg me-1"></i>

                                Thêm video

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