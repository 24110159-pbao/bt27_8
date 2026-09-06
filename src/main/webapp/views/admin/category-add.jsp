<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<title>Thêm danh mục - Shopping MVC</title>

<section class="content">

    <!-- ================= PAGE TITLE ================= -->

    <div class="page-title">

        <div>
            <h1>
                Thêm danh mục
            </h1>

            <p>
                Tạo một danh mục mới cho hệ thống
            </p>
        </div>

        <a
                href="${pageContext.request.contextPath}/admin/categories"
                class="btn btn-secondary">

            ← Quay lại

        </a>

    </div>


    <!-- ================= ERROR ================= -->

    <% if (request.getAttribute("error") != null) { %>

        <div class="alert alert-danger alert-dismissible fade show"
             role="alert">

            <strong>⚠ Có lỗi xảy ra!</strong>

            <div>
                <%= request.getAttribute("error") %>
            </div>

            <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="alert"
                    aria-label="Close">
            </button>

        </div>

    <% } %>


    <!-- ================= FORM CARD ================= -->

    <div class="card form-card">

        <!-- HEADER -->

        <div class="card-header">

            <div>

                <h3>
                    <i class="bi bi-folder-plus text-primary me-2"></i>
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
                    id="categoryForm"
                    method="post"
                    action="${pageContext.request.contextPath}/admin/category/insert"
                    enctype="multipart/form-data"
                    novalidate>


                <!-- ================= NAME ================= -->

                <div class="form-group mb-4">

                    <label
                            for="cateName"
                            class="form-label fw-semibold">

                        Tên danh mục
                        <span class="text-danger">*</span>

                    </label>

                    <input
                            type="text"
                            id="cateName"
                            name="cateName"
                            class="form-control"
                            placeholder="Ví dụ: Điện thoại"
                            minlength="2"
                            maxlength="100"
                            required>

                    <div class="invalid-feedback">
                        Vui lòng nhập tên danh mục từ 2 đến 100 ký tự.
                    </div>

                    <small class="form-hint text-muted">
                        Tên danh mục phải có ít nhất 2 ký tự.
                    </small>

                </div>


                <!-- ================= IMAGE ================= -->

                <div class="form-group mb-4">

                    <label
                            for="icon"
                            class="form-label fw-semibold">

                        Icon danh mục

                    </label>

                    <input
                            type="file"
                            id="icon"
                            name="icon"
                            class="form-control file-input"
                            accept="image/jpeg,image/png,image/gif,image/webp">

                    <small class="form-hint text-muted">

                        Chọn ảnh JPG, JPEG, PNG, GIF hoặc WEBP.
                        Dung lượng tối đa 5MB.

                    </small>


                    <!-- ================= PREVIEW ================= -->

                    <div
                            id="preview-container"
                            class="mt-3"
                            style="display:none;">

                        <div class="card border">

                            <div class="card-body">

                                <div class="d-flex justify-content-between align-items-center mb-3">

                                    <strong>
                                        <i class="bi bi-image me-1"></i>
                                        Xem trước icon
                                    </strong>

                                    <button
                                            type="button"
                                            id="removePreview"
                                            class="btn btn-sm btn-outline-danger">

                                        ✕ Xóa ảnh

                                    </button>

                                </div>

                                <div class="text-center">

                                    <img
                                            id="preview"
                                            class="preview-image img-thumbnail"
                                            alt="Ảnh xem trước">

                                </div>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- ================= BUTTON ================= -->

                <div class="form-actions d-flex gap-2">

                    <button
                            type="submit"
                            class="btn btn-primary">

                        <i class="bi bi-check-circle me-1"></i>

                        Thêm danh mục

                    </button>


                    <a
                            href="${pageContext.request.contextPath}/admin/categories"
                            class="btn btn-secondary">

                        <i class="bi bi-x-circle me-1"></i>

                        Hủy

                    </a>

                </div>

            </form>

        </div>

    </div>

</section>


<!-- ================= JAVASCRIPT ================= -->

<script>

document.addEventListener("DOMContentLoaded", function () {

    const form =
        document.getElementById("categoryForm");

    const cateName =
        document.getElementById("cateName");

    const icon =
        document.getElementById("icon");

    const preview =
        document.getElementById("preview");

    const previewContainer =
        document.getElementById("preview-container");

    const removePreview =
        document.getElementById("removePreview");


    /*
     * ==========================================
     * VALIDATION TÊN DANH MỤC
     * ==========================================
     */

    cateName.addEventListener("input", function () {

        const value =
            cateName.value.trim();

        if (value.length >= 2 &&
            value.length <= 100) {

            cateName.classList.remove("is-invalid");
            cateName.classList.add("is-valid");

        } else {

            cateName.classList.remove("is-valid");
            cateName.classList.add("is-invalid");

        }

    });


    /*
     * ==========================================
     * PREVIEW IMAGE
     * ==========================================
     */

    icon.addEventListener("change", function () {

        const file =
            icon.files[0];

        if (!file) {

            hidePreview();

            return;

        }


        /*
         * Kiểm tra loại file
         */

        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/gif",
            "image/webp"
        ];


        if (!allowedTypes.includes(file.type)) {

            alert(
                "Vui lòng chọn file ảnh JPG, PNG, GIF hoặc WEBP."
            );

            icon.value = "";

            hidePreview();

            return;

        }


        /*
         * Kiểm tra dung lượng
         * 5MB
         */

        const maxSize =
            5 * 1024 * 1024;


        if (file.size > maxSize) {

            alert(
                "Dung lượng ảnh không được vượt quá 5MB."
            );

            icon.value = "";

            hidePreview();

            return;

        }


        /*
         * Hiển thị preview
         */

        const reader =
            new FileReader();


        reader.onload = function (event) {

            preview.src =
                event.target.result;

            previewContainer.style.display =
                "block";

        };


        reader.readAsDataURL(file);

    });


    /*
     * ==========================================
     * REMOVE IMAGE
     * ==========================================
     */

    removePreview.addEventListener(
        "click",
        function () {

            icon.value = "";

            hidePreview();

        }
    );


    function hidePreview() {

        preview.src = "";

        previewContainer.style.display =
            "none";

    }


    /*
     * ==========================================
     * FORM VALIDATION
     * ==========================================
     */

    form.addEventListener(
        "submit",
        function (event) {

            const value =
                cateName.value.trim();


            /*
             * Không nhập tên
             */

            if (value.length < 2 ||
                value.length > 100) {

                event.preventDefault();

                cateName.classList.add(
                    "is-invalid"
                );

                cateName.focus();

                return;

            }


            /*
             * Không cho khoảng trắng đầu/cuối
             */

            cateName.value =
                value;


            /*
             * Xóa trạng thái invalid
             */

            cateName.classList.remove(
                "is-invalid"
            );

            cateName.classList.add(
                "is-valid"
            );

        }
    );

});

</script>
