<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container py-5">

    <div class="mb-4">

        <h1 class="fw-bold">
            Hồ sơ cá nhân
        </h1>

        <p class="text-muted">
            Quản lý và cập nhật thông tin tài khoản của bạn.
        </p>

    </div>


    <!-- ALERT -->

    <c:if test="${not empty alert}">

        <div
                class="alert alert-danger alert-dismissible fade show"
                role="alert">

            ${alert}

            <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="alert">
            </button>

        </div>

    </c:if>


    <c:if test="${param.success eq 'true'}">

        <div
                class="alert alert-success alert-dismissible fade show"
                role="alert">

            Cập nhật hồ sơ thành công.

            <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="alert">
            </button>

        </div>

    </c:if>


    <div class="row g-4">


        <!-- PROFILE INFO -->

        <div class="col-lg-4">

            <div class="card shadow-sm h-100">

                <div class="card-body text-center">

                    <c:choose>

                        <c:when test="${not empty currentUser.avatar}">

                            <img
                                    src="${pageContext.request.contextPath}/image?fname=${currentUser.avatar}"
                                    alt="Avatar"
                                    class="rounded-circle mb-3"
                                    style="width:160px;height:160px;object-fit:cover;">

                        </c:when>

                        <c:otherwise>

                            <div
                                    class="rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center mx-auto mb-3"
                                    style="width:160px;height:160px;font-size:60px;">

                                <c:choose>

                                    <c:when test="${not empty currentUser.fullname}">

                                        ${currentUser.fullname.substring(0,1)}

                                    </c:when>

                                    <c:otherwise>

                                        U

                                    </c:otherwise>

                                </c:choose>

                            </div>

                        </c:otherwise>

                    </c:choose>


                    <h3 class="fw-bold">

                        ${currentUser.fullname}

                    </h3>


                    <p class="text-muted">

                        @${currentUser.username}

                    </p>


                    <hr>


                    <div class="text-start">

                        <p class="mb-2">

                            <strong>Email:</strong>
                            ${currentUser.email}

                        </p>


                        <p class="mb-0">

                            <strong>Phone:</strong>

                            <c:choose>

                                <c:when test="${not empty currentUser.phone}">

                                    ${currentUser.phone}

                                </c:when>

                                <c:otherwise>

                                    <span class="text-muted">
                                        Chưa cập nhật
                                    </span>

                                </c:otherwise>

                            </c:choose>

                        </p>

                    </div>

                </div>

            </div>

        </div>


        <!-- FORM -->

        <div class="col-lg-8">

            <div class="card shadow-sm">

                <div class="card-body p-4">

                    <h3 class="fw-bold mb-2">

                        Thông tin cá nhân

                    </h3>


                    <p class="text-muted mb-4">

                        Cập nhật họ tên, số điện thoại
                        và ảnh đại diện.

                    </p>


                    <form
                            action="${pageContext.request.contextPath}/user/profile"
                            method="post"
                            enctype="multipart/form-data"
                            class="needs-validation"
                            novalidate>


                        <!-- USERNAME -->

                        <div class="mb-3">

                            <label
                                    for="username"
                                    class="form-label">

                                Tên tài khoản

                            </label>

                            <input
                                    type="text"
                                    id="username"
                                    class="form-control"
                                    value="${currentUser.username}"
                                    readonly>

                        </div>


                        <!-- EMAIL -->

                        <div class="mb-3">

                            <label
                                    for="email"
                                    class="form-label">

                                Email

                            </label>

                            <input
                                    type="email"
                                    id="email"
                                    class="form-control"
                                    value="${currentUser.email}"
                                    readonly>

                        </div>


                        <!-- FULLNAME -->

                        <div class="mb-3">

                            <label
                                    for="fullname"
                                    class="form-label">

                                Họ và tên
                                <span class="text-danger">*</span>

                            </label>

                            <input
                                    type="text"
                                    id="fullname"
                                    name="fullname"
                                    class="form-control"
                                    value="${currentUser.fullname}"
                                    placeholder="Nhập họ và tên"
                                    minlength="2"
                                    maxlength="100"
                                    required>

                            <div class="invalid-feedback">

                                Vui lòng nhập họ và tên
                                từ 2 đến 100 ký tự.

                            </div>

                        </div>


                        <!-- PHONE -->

                        <div class="mb-3">

                            <label
                                    for="phone"
                                    class="form-label">

                                Số điện thoại
                                <span class="text-danger">*</span>

                            </label>

                            <input
                                    type="tel"
                                    id="phone"
                                    name="phone"
                                    class="form-control"
                                    value="${currentUser.phone}"
                                    placeholder="Nhập số điện thoại"
                                    pattern="^(0|\+84)[0-9]{9,10}$"
                                    required>

                            <div class="invalid-feedback">

                                Số điện thoại không hợp lệ.

                            </div>

                        </div>


                        <!-- AVATAR -->

                        <div class="mb-4">

                            <label
                                    for="avatar"
                                    class="form-label">

                                Ảnh đại diện

                            </label>

                            <input
                                    type="file"
                                    id="avatar"
                                    name="avatar"
                                    class="form-control"
                                    accept=".jpg,.jpeg,.png,.gif,.webp">

                            <div class="form-text">

                                JPG, JPEG, PNG hoặc WEBP.
                                Dung lượng tối đa 5MB.

                            </div>

                            <div
                                    id="avatarError"
                                    class="text-danger small mt-1">
                            </div>

                        </div>


                        <!-- BUTTON -->

                        <button
                                type="submit"
                                class="btn btn-primary px-4">

                            Cập nhật hồ sơ

                        </button>


                        <a
                                href="${pageContext.request.contextPath}/user/home"
                                class="btn btn-outline-secondary ms-2">

                            Quay lại

                        </a>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>


<script>

(function () {

    'use strict';

    const forms =
        document.querySelectorAll('.needs-validation');

    Array.from(forms).forEach(function (form) {

        form.addEventListener('submit', function (event) {

            if (!form.checkValidity()) {

                event.preventDefault();
                event.stopPropagation();

            }

            form.classList.add('was-validated');

        }, false);

    });


    const avatar =
        document.getElementById('avatar');

    const avatarError =
        document.getElementById('avatarError');


    if (avatar) {

        avatar.addEventListener('change', function () {

            avatarError.textContent = '';

            if (!this.files || !this.files[0]) {

                return;

            }

            const file = this.files[0];

            const allowedTypes = [
                'image/jpeg',
                'image/png',
                'image/gif',
                'image/webp'
            ];


            if (!allowedTypes.includes(file.type)) {

                avatarError.textContent =
                    'Chỉ được chọn file ảnh JPG, JPEG, PNG hoặc WEBP.';

                this.value = '';

                return;

            }


            if (file.size > 5 * 1024 * 1024) {

                avatarError.textContent =
                    'Dung lượng ảnh không được vượt quá 5MB.';

                this.value = '';

            }

        });

    }

})();

</script>
