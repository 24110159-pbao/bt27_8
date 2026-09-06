<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    /*
     * Các giá trị bên dưới có thể lấy từ Controller nếu bạn đã truyền
     * request.setAttribute().
     *
     * Nếu Controller chưa truyền thì mặc định = 0.
     */

    Object totalProductObj =
            request.getAttribute("totalProduct");

    Object totalCategoryObj =
            request.getAttribute("totalCategory");

    Object totalVideoObj =
            request.getAttribute("totalVideo");

    Object totalUserObj =
            request.getAttribute("totalUser");


    String totalProduct =
            totalProductObj != null
                    ? totalProductObj.toString()
                    : "0";

    String totalCategory =
            totalCategoryObj != null
                    ? totalCategoryObj.toString()
                    : "0";

    String totalVideo =
            totalVideoObj != null
                    ? totalVideoObj.toString()
                    : "0";

    String totalUser =
            totalUserObj != null
                    ? totalUserObj.toString()
                    : "0";
%>


<title>Trang quản trị - Shopping MVC</title>


<section class="content">


    <!-- =====================================================
         WELCOME
         ===================================================== -->

    <div class="page-title">

        <div>

            <h1>
                Dashboard
            </h1>

            <p>
                Chào mừng bạn đến với trang quản trị Shopping MVC
            </p>

        </div>


        <div>

            <span class="badge">

                <i class="bi bi-calendar3 me-1"></i>

                Hệ thống quản trị

            </span>

        </div>

    </div>


    <!-- =====================================================
         STATISTICS
         ===================================================== -->

    <div class="row g-4 mb-4">


        <!-- PRODUCT -->

        <div class="col-12 col-sm-6 col-xl-3">

            <div class="card h-100">

                <div class="card-body">

                    <div class="d-flex justify-content-between align-items-start">

                        <div>

                            <p class="text-muted mb-2">
                                Sản phẩm
                            </p>

                            <h2 class="fw-bold mb-1">
                                <%= totalProduct %>
                            </h2>

                            <small class="text-success">

                                <i class="bi bi-box-seam me-1"></i>

                                Sản phẩm trong hệ thống

                            </small>

                        </div>


                        <div
                                class="d-flex align-items-center justify-content-center"
                                style="
                                    width:52px;
                                    height:52px;
                                    border-radius:12px;
                                    background:#eff6ff;
                                    color:#2563eb;
                                    font-size:23px;
                                ">

                            <i class="bi bi-bag-fill"></i>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- CATEGORY -->

        <div class="col-12 col-sm-6 col-xl-3">

            <div class="card h-100">

                <div class="card-body">

                    <div class="d-flex justify-content-between align-items-start">

                        <div>

                            <p class="text-muted mb-2">
                                Danh mục
                            </p>

                            <h2 class="fw-bold mb-1">
                                <%= totalCategory %>
                            </h2>

                            <small class="text-primary">

                                <i class="bi bi-folder me-1"></i>

                                Danh mục sản phẩm

                            </small>

                        </div>


                        <div
                                class="d-flex align-items-center justify-content-center"
                                style="
                                    width:52px;
                                    height:52px;
                                    border-radius:12px;
                                    background:#fff7ed;
                                    color:#f97316;
                                    font-size:23px;
                                ">

                            <i class="bi bi-folder-fill"></i>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- VIDEO -->

        <div class="col-12 col-sm-6 col-xl-3">

            <div class="card h-100">

                <div class="card-body">

                    <div class="d-flex justify-content-between align-items-start">

                        <div>

                            <p class="text-muted mb-2">
                                Video
                            </p>

                            <h2 class="fw-bold mb-1">
                                <%= totalVideo %>
                            </h2>

                            <small class="text-danger">

                                <i class="bi bi-camera-video me-1"></i>

                                Video trong hệ thống

                            </small>

                        </div>


                        <div
                                class="d-flex align-items-center justify-content-center"
                                style="
                                    width:52px;
                                    height:52px;
                                    border-radius:12px;
                                    background:#fef2f2;
                                    color:#ef4444;
                                    font-size:23px;
                                ">

                            <i class="bi bi-camera-video-fill"></i>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- USER -->

        <div class="col-12 col-sm-6 col-xl-3">

            <div class="card h-100">

                <div class="card-body">

                    <div class="d-flex justify-content-between align-items-start">

                        <div>

                            <p class="text-muted mb-2">
                                Người dùng
                            </p>

                            <h2 class="fw-bold mb-1">
                                <%= totalUser %>
                            </h2>

                            <small class="text-success">

                                <i class="bi bi-people me-1"></i>

                                Tài khoản hệ thống

                            </small>

                        </div>


                        <div
                                class="d-flex align-items-center justify-content-center"
                                style="
                                    width:52px;
                                    height:52px;
                                    border-radius:12px;
                                    background:#ecfdf5;
                                    color:#10b981;
                                    font-size:23px;
                                ">

                            <i class="bi bi-people-fill"></i>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- =====================================================
         QUICK ACTIONS
         ===================================================== -->

    <div class="card">


        <div class="card-header">

            <div>

                <h3>

                    <i class="bi bi-lightning-charge-fill text-warning me-2"></i>

                    Thao tác nhanh

                </h3>

                <span>
                    Truy cập nhanh các chức năng quản lý
                </span>

            </div>

        </div>


        <div class="card-body">

            <div class="row g-3">


                <!-- CATEGORY -->

                <div class="col-12 col-md-6 col-xl-3">

                    <a
                            href="${pageContext.request.contextPath}/admin/categories"
                            class="text-decoration-none">

                        <div
                                class="border rounded-3 p-4 h-100"
                                style="transition:.2s;">

                            <div
                                    class="mb-3"
                                    style="
                                        width:45px;
                                        height:45px;
                                        border-radius:10px;
                                        background:#fff7ed;
                                        color:#f97316;
                                        display:flex;
                                        align-items:center;
                                        justify-content:center;
                                        font-size:20px;
                                    ">

                                <i class="bi bi-folder-fill"></i>

                            </div>


                            <h5 class="fw-bold text-dark">

                                Quản lý danh mục

                            </h5>


                            <p class="text-muted small mb-0">

                                Xem, thêm, sửa và xóa danh mục sản phẩm.

                            </p>

                        </div>

                    </a>

                </div>


                <!-- PRODUCT -->

                <div class="col-12 col-md-6 col-xl-3">

                    <a
                            href="${pageContext.request.contextPath}/admin/products"
                            class="text-decoration-none">

                        <div
                                class="border rounded-3 p-4 h-100">

                            <div
                                    class="mb-3"
                                    style="
                                        width:45px;
                                        height:45px;
                                        border-radius:10px;
                                        background:#eff6ff;
                                        color:#2563eb;
                                        display:flex;
                                        align-items:center;
                                        justify-content:center;
                                        font-size:20px;
                                    ">

                                <i class="bi bi-bag-fill"></i>

                            </div>


                            <h5 class="fw-bold text-dark">

                                Quản lý sản phẩm

                            </h5>


                            <p class="text-muted small mb-0">

                                Quản lý thông tin, giá và trạng thái sản phẩm.

                            </p>

                        </div>

                    </a>

                </div>


                <!-- VIDEO -->

                <div class="col-12 col-md-6 col-xl-3">

                    <a
                            href="${pageContext.request.contextPath}/admin/videos"
                            class="text-decoration-none">

                        <div
                                class="border rounded-3 p-4 h-100">

                            <div
                                    class="mb-3"
                                    style="
                                        width:45px;
                                        height:45px;
                                        border-radius:10px;
                                        background:#fef2f2;
                                        color:#ef4444;
                                        display:flex;
                                        align-items:center;
                                        justify-content:center;
                                        font-size:20px;
                                    ">

                                <i class="bi bi-camera-video-fill"></i>

                            </div>


                            <h5 class="fw-bold text-dark">

                                Quản lý video

                            </h5>


                            <p class="text-muted small mb-0">

                                Quản lý video và nội dung multimedia.

                            </p>

                        </div>

                    </a>

                </div>


                <!-- ADD PRODUCT -->

                <div class="col-12 col-md-6 col-xl-3">

                    <a
                            href="${pageContext.request.contextPath}/admin/product/add"
                            class="text-decoration-none">

                        <div
                                class="border rounded-3 p-4 h-100">

                            <div
                                    class="mb-3"
                                    style="
                                        width:45px;
                                        height:45px;
                                        border-radius:10px;
                                        background:#ecfdf5;
                                        color:#10b981;
                                        display:flex;
                                        align-items:center;
                                        justify-content:center;
                                        font-size:20px;
                                    ">

                                <i class="bi bi-plus-circle-fill"></i>

                            </div>


                            <h5 class="fw-bold text-dark">

                                Thêm sản phẩm

                            </h5>


                            <p class="text-muted small mb-0">

                                Tạo sản phẩm mới cho cửa hàng.

                            </p>

                        </div>

                    </a>

                </div>


            </div>

        </div>

    </div>


    <!-- =====================================================
         SYSTEM INFORMATION
         ===================================================== -->

    <div class="row g-4 mt-1">


        <!-- WELCOME -->

        <div class="col-12 col-lg-8">

            <div class="card h-100">

                <div class="card-header">

                    <div>

                        <h3>

                            <i class="bi bi-shop text-primary me-2"></i>

                            Shopping MVC

                        </h3>

                        <span>
                            Hệ thống quản lý cửa hàng
                        </span>

                    </div>

                </div>


                <div class="card-body">

                    <div class="row align-items-center">


                        <div class="col-md-7">

                            <h4 class="fw-bold mb-3">

                                Chào mừng Administrator!

                            </h4>


                            <p class="text-muted">

                                Đây là trang tổng quan của hệ thống
                                Shopping MVC. Từ đây bạn có thể quản lý
                                danh mục, sản phẩm và video của cửa hàng.

                            </p>


                            <p class="text-muted mb-0">

                                Sử dụng menu bên trái để truy cập các
                                chức năng quản lý.

                            </p>

                        </div>


                        <div class="col-md-5 text-center mt-4 mt-md-0">

                            <div
                                    style="
                                        width:130px;
                                        height:130px;
                                        margin:auto;
                                        border-radius:30px;
                                        background:linear-gradient(
                                            135deg,
                                            #2563eb,
                                            #7c3aed
                                        );
                                        color:white;
                                        display:flex;
                                        align-items:center;
                                        justify-content:center;
                                        font-size:55px;
                                        box-shadow:
                                            0 15px 35px
                                            rgba(37,99,235,.25);
                                    ">

                                <i class="bi bi-cart3"></i>

                            </div>

                        </div>


                    </div>

                </div>

            </div>

        </div>


        <!-- SYSTEM -->

        <div class="col-12 col-lg-4">

            <div class="card h-100">

                <div class="card-header">

                    <div>

                        <h3>

                            <i class="bi bi-info-circle text-primary me-2"></i>

                            Thông tin hệ thống

                        </h3>

                        <span>
                            Công nghệ sử dụng
                        </span>

                    </div>

                </div>


                <div class="card-body">


                    <div class="d-flex justify-content-between mb-3">

                        <span class="text-muted">
                            Backend
                        </span>

                        <strong>
                            Java
                        </strong>

                    </div>


                    <div class="d-flex justify-content-between mb-3">

                        <span class="text-muted">
                            Framework
                        </span>

                        <strong>
                            Servlet MVC
                        </strong>

                    </div>


                    <div class="d-flex justify-content-between mb-3">

                        <span class="text-muted">
                            Database
                        </span>

                        <strong>
                            MySQL
                        </strong>

                    </div>


                    <div class="d-flex justify-content-between mb-3">

                        <span class="text-muted">
                            ORM
                        </span>

                        <strong>
                            JPA / Hibernate
                        </strong>

                    </div>


                    <div class="d-flex justify-content-between">

                        <span class="text-muted">
                            UI
                        </span>

                        <strong>
                            Bootstrap 5
                        </strong>

                    </div>


                </div>

            </div>

        </div>


    </div>


</section>
