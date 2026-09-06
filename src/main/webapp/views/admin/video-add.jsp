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


<title>Thêm video - Shopping MVC</title>


<section class="content">


    <!-- =====================================================
         PAGE TITLE
         ===================================================== -->

    <div class="page-title">

        <div>

            <h1>
                Thêm video
            </h1>

            <p>
                Tạo một video mới cho hệ thống
            </p>

        </div>


        <a
                href="${pageContext.request.contextPath}/admin/videos"
                class="btn btn-secondary">

            <i class="bi bi-arrow-left me-1"></i>

            Quay lại

        </a>

    </div>


    <!-- =====================================================
         ERROR
         ===================================================== -->

    <% if (request.getAttribute("error") != null) { %>

    <div
            class="alert alert-danger alert-dismissible fade show"
            role="alert">

        <i class="bi bi-exclamation-triangle-fill me-2"></i>

        <%= request.getAttribute("error") %>


        <button
                type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>

    </div>

    <% } %>


    <!-- =====================================================
         FORM CARD
         ===================================================== -->

    <div class="card form-card">


        <div class="card-header">

            <div>

                <h3>

                    <i class="bi bi-camera-video-fill text-danger me-2"></i>

                    Thông tin video

                </h3>

                <span>
                    Nhập thông tin video bên dưới
                </span>

            </div>

        </div>


        <div class="card-body">


            <form
                    id="videoForm"
                    method="post"
                    action="${pageContext.request.contextPath}/admin/video/insert"
                    enctype="multipart/form-data"
                    novalidate>


                <!-- =================================================
                     VIDEO ID
                     ================================================= -->

                <div class="mb-4">

                    <label
                            for="videoId"
                            class="form-label fw-semibold">

                        Video ID
                        <span class="text-danger">*</span>

                    </label>


                    <input
                            type="text"
                            id="videoId"
                            name="videoId"
                            class="form-control"
                            placeholder="Ví dụ: video001"
                            value="<%= video != null
                                    && video.getVideoId() != null
                                    ? video.getVideoId()
                                    : "" %>"
                            minlength="2"
                            maxlength="100"
                            required>


                    <div class="form-text">

                        ID video phải là duy nhất.

                    </div>


                    <div class="invalid-feedback">

                        Vui lòng nhập Video ID từ 2 đến 100 ký tự.

                    </div>

                </div>


                <!-- =================================================
                     TITLE
                     ================================================= -->

                <div class="mb-4">

                    <label
                            for="title"
                            class="form-label fw-semibold">

                        Tiêu đề video
                        <span class="text-danger">*</span>

                    </label>


                    <input
                            type="text"
                            id="title"
                            name="title"
                            class="form-control"
                            placeholder="Nhập tiêu đề video"
                            value="<%= video != null
                                    && video.getTitle() != null
                                    ? video.getTitle()
                                    : "" %>"
                            minlength="2"
                            maxlength="255"
                            required>


                    <div class="invalid-feedback">

                        Vui lòng nhập tiêu đề video từ 2 đến 255 ký tự.

                    </div>

                </div>


                <!-- =================================================
                     CATEGORY
                     ================================================= -->

                <div class="mb-4">

                    <label
                            for="categoryId"
                            class="form-label fw-semibold">

                        Danh mục
                        <span class="text-danger">*</span>

                    </label>


                    <select
                            id="categoryId"
                            name="categoryId"
                            class="form-select"
                            required>

                        <option value="">
                            -- Chọn danh mục --
                        </option>


                        <%
                            if (listCategory != null
                                    && !listCategory.isEmpty()) {

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
                                <%= selected
                                        ? "selected"
                                        : "" %>>

                            <%= category.getCateName() %>

                        </option>

                        <%
                                }
                            }
                        %>

                    </select>


                    <div class="invalid-feedback">

                        Vui lòng chọn danh mục video.

                    </div>

                </div>


                <!-- =================================================
                     DESCRIPTION
                     ================================================= -->

                <div class="mb-4">

                    <label
                            for="description"
                            class="form-label fw-semibold">

                        Mô tả

                    </label>


                    <textarea
                            id="description"
                            name="description"
                            class="form-control"
                            rows="5"
                            maxlength="1000"
                            placeholder="Nhập mô tả video"><%= video != null
                                    && video.getDescription() != null
                                    ? video.getDescription()
                                    : "" %></textarea>


                    <div class="form-text">

                        Tối đa 1000 ký tự.

                    </div>

                </div>


                <!-- =================================================
                     VIEWS
                     ================================================= -->

                <div class="mb-4">

                    <label
                            for="views"
                            class="form-label fw-semibold">

                        Lượt xem

                    </label>


                    <input
                            type="number"
                            id="views"
                            name="views"
                            class="form-control"
                            min="0"
                            max="999999999"
                            step="1"
                            value="<%= video != null
                                    ? video.getViews()
                                    : 0 %>">


                    <div class="invalid-feedback">

                        Lượt xem phải là số nguyên lớn hơn hoặc bằng 0.

                    </div>

                </div>


                <!-- =================================================
                     ACTIVE
                     ================================================= -->

                <div class="mb-4">

                    <label
                            for="active"
                            class="form-label fw-semibold">

                        Trạng thái

                    </label>


                    <select
                            id="active"
                            name="active"
                            class="form-select">


                        <option value="1">

                            Hoạt động

                        </option>


                        <option value="0">

                            Không hoạt động

                        </option>


                    </select>

                </div>


                <!-- =================================================
                     POSTER
                     ================================================= -->

                <div class="mb-4">

                    <label
                            for="poster"
                            class="form-label fw-semibold">

                        Poster video

                    </label>


                    <input
                            type="file"
                            id="poster"
                            name="poster"
                            class="form-control"
                            accept="image/jpeg,image/png,image/gif,image/webp">


                    <div class="form-text">

                        Định dạng:
                        JPG, JPEG, PNG, GIF, WEBP.
                        Kích thước tối đa nên dưới 5MB.

                    </div>


                    <!-- PREVIEW -->

                    <div
                            id="posterPreviewContainer"
                            class="mt-3 d-none">

                        <div class="border rounded-3 p-3 bg-light">

                            <div class="fw-semibold mb-2">

                                <i class="bi bi-image me-1"></i>

                                Xem trước poster

                            </div>


                            <img
                                    id="posterPreview"
                                    src=""
                                    alt="Poster xem trước"
                                    style="
                                        max-width:320px;
                                        max-height:220px;
                                        object-fit:contain;
                                        border-radius:10px;
                                    ">

                        </div>

                    </div>

                </div>


                <!-- =================================================
                     BUTTONS
                     ================================================= -->

                <hr class="my-4">


                <div class="d-flex gap-2 flex-wrap">


                    <button
                            type="submit"
                            class="btn btn-primary">

                        <i class="bi bi-check-circle me-1"></i>

                        Thêm video

                    </button>


                    <button
                            type="reset"
                            class="btn btn-outline-secondary">

                        <i class="bi bi-arrow-counterclockwise me-1"></i>

                        Nhập lại

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


<script>

(function () {

    "use strict";


    const form =
        document.getElementById("videoForm");

    const posterInput =
        document.getElementById("poster");

    const previewContainer =
        document.getElementById(
            "posterPreviewContainer"
        );

    const preview =
        document.getElementById(
            "posterPreview"
        );


    /*
     * ================================
     * BOOTSTRAP FORM VALIDATION
     * ================================
     */

    form.addEventListener("submit", function (event) {

        if (!form.checkValidity()) {

            event.preventDefault();
            event.stopPropagation();

        }

        form.classList.add("was-validated");

    });


    /*
     * ================================
     * POSTER VALIDATION
     * ================================
     */

    posterInput.addEventListener("change", function () {

        const file =
            this.files[0];


        if (!file) {

            previewContainer.classList.add("d-none");

            preview.src = "";

            return;

        }


        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/gif",
            "image/webp"
        ];


        if (!allowedTypes.includes(file.type)) {

            alert(
                "Vui lòng chọn file ảnh JPG, JPEG, PNG, GIF hoặc WEBP."
            );

            this.value = "";

            previewContainer.classList.add("d-none");

            return;

        }


        /*
         * 5MB
         */

        if (file.size > 5 * 1024 * 1024) {

            alert(
                "Kích thước poster không được vượt quá 5MB."
            );

            this.value = "";

            previewContainer.classList.add("d-none");

            return;

        }


        const reader =
            new FileReader();


        reader.onload = function (event) {

            preview.src =
                event.target.result;

            previewContainer.classList.remove(
                "d-none"
            );

        };


        reader.readAsDataURL(file);

    });


    /*
     * ================================
     * RESET
     * ================================
     */

    form.addEventListener("reset", function () {

        setTimeout(function () {

            previewContainer.classList.add(
                "d-none"
            );

            preview.src = "";

            form.classList.remove(
                "was-validated"
            );

        }, 0);

    });


})();

</script>