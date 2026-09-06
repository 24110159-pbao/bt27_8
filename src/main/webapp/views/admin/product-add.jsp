<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Category" %>

<%
    List<Category> listCategory =
            (List<Category>) request.getAttribute("listCategory");
%>


<title>Thêm sản phẩm - Shopping MVC</title>


<section class="content">


    <!-- =====================================================
         PAGE TITLE
         ===================================================== -->

    <div class="page-title">

        <div>

            <h1>
                Thêm sản phẩm
            </h1>

            <p>
                Tạo một sản phẩm mới cho cửa hàng
            </p>

        </div>


        <a
                href="${pageContext.request.contextPath}/admin/products"
                class="btn btn-secondary">

            <i class="bi bi-arrow-left me-1"></i>

            Quay lại

        </a>

    </div>


    <!-- =====================================================
         ERROR
         ===================================================== -->

    <% if (request.getAttribute("error") != null) { %>

    <div class="alert alert-danger alert-dismissible fade show"
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
         FORM
         ===================================================== -->

    <div class="card form-card">


        <div class="card-header">

            <div>

                <h3>

                    <i class="bi bi-box-seam me-2 text-primary"></i>

                    Thông tin sản phẩm

                </h3>

                <span>
                    Nhập đầy đủ thông tin sản phẩm
                </span>

            </div>

        </div>


        <div class="card-body">


            <form
                    id="productForm"
                    method="post"
                    action="${pageContext.request.contextPath}/admin/product/insert"
                    enctype="multipart/form-data"
                    novalidate>


                <!-- =================================================
                     NAME
                     ================================================= -->

                <div class="mb-4">

                    <label
                            for="name"
                            class="form-label fw-semibold">

                        Tên sản phẩm
                        <span class="text-danger">*</span>

                    </label>


                    <input
                            type="text"
                            id="name"
                            name="name"
                            class="form-control"
                            placeholder="Ví dụ: Áo sơ mi nam cao cấp"
                            minlength="2"
                            maxlength="255"
                            required>


                    <div class="invalid-feedback">
                        Vui lòng nhập tên sản phẩm từ 2 đến 255 ký tự.
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
                            placeholder="Nhập mô tả sản phẩm..."></textarea>


                    <div class="form-text">
                        Tối đa 1000 ký tự.
                    </div>

                </div>


                <!-- =================================================
                     PRICE + QUANTITY
                     ================================================= -->

                <div class="row g-4 mb-4">


                    <!-- PRICE -->

                    <div class="col-12 col-md-6">

                        <label
                                for="price"
                                class="form-label fw-semibold">

                            Giá
                            <span class="text-danger">*</span>

                        </label>


                        <div class="input-group">

                            <input
                                    type="number"
                                    id="price"
                                    name="price"
                                    class="form-control"
                                    min="0"
                                    max="999999999999"
                                    step="1000"
                                    placeholder="Ví dụ: 299000"
                                    required>

                            <span class="input-group-text">
                                VNĐ
                            </span>

                        </div>


                        <div class="invalid-feedback">
                            Giá phải lớn hơn hoặc bằng 0.
                        </div>

                    </div>


                    <!-- QUANTITY -->

                    <div class="col-12 col-md-6">

                        <label
                                for="quantity"
                                class="form-label fw-semibold">

                            Số lượng
                            <span class="text-danger">*</span>

                        </label>


                        <input
                                type="number"
                                id="quantity"
                                name="quantity"
                                class="form-control"
                                min="0"
                                max="999999"
                                step="1"
                                placeholder="Ví dụ: 50"
                                required>


                        <div class="invalid-feedback">
                            Số lượng phải là số nguyên từ 0 trở lên.
                        </div>

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

                                for (Category category : listCategory) {
                        %>

                        <option
                                value="<%= category.getCateId() %>">

                            <%= category.getCateName() %>

                        </option>

                        <%
                                }
                            }
                        %>

                    </select>


                    <div class="invalid-feedback">
                        Vui lòng chọn danh mục sản phẩm.
                    </div>

                </div>


                <!-- =================================================
                     IMAGE
                     ================================================= -->

                <div class="mb-4">

                    <label
                            for="image"
                            class="form-label fw-semibold">

                        Ảnh sản phẩm

                    </label>


                    <input
                            type="file"
                            id="image"
                            name="image"
                            class="form-control"
                            accept="image/jpeg,image/png,image/gif,image/webp">


                    <div class="form-text">

                        Định dạng:
                        JPG, JPEG, PNG, GIF, WEBP.
                        Kích thước tối đa nên dưới 5MB.

                    </div>


                    <!-- PREVIEW -->

                    <div
                            id="previewContainer"
                            class="mt-3 d-none">

                        <div class="border rounded-3 p-3 bg-light">

                            <div class="fw-semibold mb-2">

                                <i class="bi bi-image me-1"></i>

                                Xem trước ảnh

                            </div>


                            <img
                                    id="imagePreview"
                                    src=""
                                    alt="Ảnh xem trước"
                                    style="
                                        max-width:220px;
                                        max-height:220px;
                                        object-fit:contain;
                                        border-radius:10px;
                                    ">

                        </div>

                    </div>

                </div>


                <!-- =================================================
                     ACTIVE
                     ================================================= -->

                <div class="mb-4">

                    <label class="form-label fw-semibold">

                        Trạng thái

                    </label>


                    <div class="d-flex gap-4 flex-wrap">


                        <div class="form-check">

                            <input
                                    class="form-check-input"
                                    type="radio"
                                    name="active"
                                    id="activeTrue"
                                    value="true"
                                    checked>


                            <label
                                    class="form-check-label"
                                    for="activeTrue">

                                <span class="badge"
                                      style="
                                          background:#dcfce7;
                                          color:#166534;
                                      ">

                                    Đang bán

                                </span>

                            </label>

                        </div>


                        <div class="form-check">

                            <input
                                    class="form-check-input"
                                    type="radio"
                                    name="active"
                                    id="activeFalse"
                                    value="false">


                            <label
                                    class="form-check-label"
                                    for="activeFalse">

                                <span class="badge"
                                      style="
                                          background:#fee2e2;
                                          color:#991b1b;
                                      ">

                                    Ngừng bán

                                </span>

                            </label>

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

                        Thêm sản phẩm

                    </button>


                    <button
                            type="reset"
                            class="btn btn-outline-secondary">

                        <i class="bi bi-arrow-counterclockwise me-1"></i>

                        Nhập lại

                    </button>


                    <a
                            href="${pageContext.request.contextPath}/admin/products"
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
        document.getElementById("productForm");

    const imageInput =
        document.getElementById("image");

    const previewContainer =
        document.getElementById("previewContainer");

    const imagePreview =
        document.getElementById("imagePreview");


    /*
     * ================================
     * BOOTSTRAP VALIDATION
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
     * IMAGE VALIDATION + PREVIEW
     * ================================
     */

    imageInput.addEventListener("change", function () {

        const file =
            this.files[0];


        if (!file) {

            previewContainer.classList.add("d-none");
            imagePreview.src = "";

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
                "Kích thước ảnh không được vượt quá 5MB."
            );

            this.value = "";

            previewContainer.classList.add("d-none");

            return;

        }


        const reader =
            new FileReader();


        reader.onload = function (e) {

            imagePreview.src =
                e.target.result;

            previewContainer.classList.remove("d-none");

        };


        reader.readAsDataURL(file);

    });


    /*
     * ================================
     * RESET PREVIEW
     * ================================
     */

    form.addEventListener("reset", function () {

        setTimeout(function () {

            previewContainer.classList.add("d-none");

            imagePreview.src = "";

            form.classList.remove("was-validated");

        }, 0);

    });


})();

</script>