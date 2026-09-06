<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <sitemesh:write property="title"/>
    </title>

    <!-- =====================================================
         BOOTSTRAP 5
         ===================================================== -->

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">


    <!-- Bootstrap Icons -->

    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <!-- =====================================================
         PROJECT CSS
         ===================================================== -->

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/style.css">


    <sitemesh:write property="head"/>


    <!-- =====================================================
         ADMIN DECORATOR STYLE
         ===================================================== -->

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f5f7fb;
            font-family:
                    Inter,
                    -apple-system,
                    BlinkMacSystemFont,
                    "Segoe UI",
                    sans-serif;
            color: #1f2937;
        }


        /* =====================================================
           ADMIN LAYOUT
           ===================================================== */

        .admin-layout {
            min-height: 100vh;
            display: flex;
        }


        /* =====================================================
           SIDEBAR
           ===================================================== */

        .sidebar {
            width: 260px;
            min-height: 100vh;

            background: #111827;
            color: white;

            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;

            z-index: 1000;

            display: flex;
            flex-direction: column;
        }


        .sidebar-logo {
            height: 70px;

            display: flex;
            align-items: center;

            gap: 12px;

            padding: 0 24px;

            font-size: 20px;
            font-weight: 700;

            border-bottom:
                1px solid rgba(255,255,255,.08);
        }


        .sidebar-logo-icon {
            width: 38px;
            height: 38px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #2563eb;

            border-radius: 10px;

            font-size: 20px;
        }


        .sidebar-menu {
            padding: 20px 14px;
        }


        .menu-title {
            padding: 12px 12px 8px;

            font-size: 11px;

            font-weight: 700;

            color: #9ca3af;

            letter-spacing: .08em;
        }


        .menu-item {
            display: flex;

            align-items: center;

            gap: 12px;

            width: 100%;

            padding: 12px 14px;

            margin-bottom: 5px;

            color: #d1d5db;

            text-decoration: none;

            border-radius: 9px;

            transition: all .2s ease;
        }


        .menu-item:hover {
            background: #1f2937;

            color: white;

            transform: translateX(2px);
        }


        .menu-item.active {
            background: #2563eb;

            color: white;

            box-shadow:
                0 5px 15px rgba(37,99,235,.25);
        }


        .menu-item i {
            width: 20px;

            font-size: 17px;

            text-align: center;
        }


        /* =====================================================
           MAIN AREA
           ===================================================== */

        .main-area {
            width: calc(100% - 260px);

            margin-left: 260px;

            min-height: 100vh;
        }


        /* =====================================================
           TOPBAR
           ===================================================== */

        .topbar {
            height: 70px;

            background: white;

            border-bottom: 1px solid #e5e7eb;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 30px;

            position: sticky;

            top: 0;

            z-index: 900;
        }


        .topbar-title {
            font-size: 20px;

            font-weight: 700;

            color: #111827;
        }


        .user-info {
            display: flex;

            align-items: center;

            gap: 10px;

            font-weight: 600;

            color: #374151;
        }


        .avatar {
            width: 38px;
            height: 38px;

            border-radius: 50%;

            background: #2563eb;

            color: white;

            display: flex;

            align-items: center;

            justify-content: center;

            font-weight: 700;
        }


        /* =====================================================
           CONTENT
           ===================================================== */

        .content {
            padding: 30px;
        }


        .page-title {
            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 20px;

            margin-bottom: 25px;
        }


        .page-title h1 {
            margin: 0 0 5px;

            font-size: 28px;

            font-weight: 700;

            color: #111827;
        }


        .page-title p {
            margin: 0;

            color: #6b7280;
        }


        /* =====================================================
           CARD
           ===================================================== */

        .card {
            border: 0;

            border-radius: 14px;

            background: white;

            box-shadow:
                0 2px 12px rgba(15,23,42,.05);

            overflow: hidden;

            margin-bottom: 24px;
        }


        .card-header {
            min-height: 75px;

            padding: 18px 22px;

            background: white;

            border-bottom: 1px solid #eef0f4;

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;
        }


        .card-header h3 {
            margin: 0 0 4px;

            font-size: 18px;

            font-weight: 700;
        }


        .card-header span {
            color: #6b7280;

            font-size: 14px;
        }


        .card-body {
            padding: 22px;
        }


        /* =====================================================
           TABLE
           ===================================================== */

        .table-wrapper {
            width: 100%;

            overflow-x: auto;
        }


        .table {
            margin-bottom: 0;

            min-width: 850px;

            vertical-align: middle;
        }


        .table thead th {
            background: #f8fafc;

            color: #64748b;

            font-size: 13px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: .03em;

            white-space: nowrap;

            border-bottom: 1px solid #e5e7eb;

            padding: 14px;
        }


        .table tbody td {
            padding: 15px 14px;

            border-color: #f1f5f9;

            color: #374151;
        }


        .table tbody tr {
            transition: background .15s ease;
        }


        .table tbody tr:hover {
            background: #f8fafc;
        }


        /* =====================================================
           ID
           ===================================================== */

        .id-badge {
            display: inline-flex;

            align-items: center;

            justify-content: center;

            min-width: 38px;

            padding: 5px 9px;

            border-radius: 7px;

            background: #eff6ff;

            color: #2563eb;

            font-size: 13px;

            font-weight: 700;
        }


        /* =====================================================
           IMAGE
           ===================================================== */

        .category-icon {
            width: 55px;
            height: 55px;

            border-radius: 10px;

            overflow: hidden;

            background: #f1f5f9;

            display: flex;

            align-items: center;

            justify-content: center;
        }


        .category-image {
            width: 100%;
            height: 100%;

            object-fit: cover;
        }


        .default-icon {
            font-size: 25px;
        }


        .category-name {
            font-weight: 600;

            color: #111827;
        }


        /* =====================================================
           BADGE
           ===================================================== */

        .badge {
            display: inline-flex;

            align-items: center;

            padding: 6px 10px;

            border-radius: 999px;

            background: #eff6ff;

            color: #2563eb;

            font-size: 12px;

            font-weight: 700;
        }


        /* =====================================================
           ACTIONS
           ===================================================== */

        .actions {
            display: flex;

            gap: 7px;

            flex-wrap: wrap;
        }


        .actions .btn {
            white-space: nowrap;
        }


        /* =====================================================
           EMPTY
           ===================================================== */

        .empty-state {
            text-align: center;

            padding: 60px 20px !important;

            color: #6b7280;
        }


        .empty-icon {
            font-size: 48px;

            margin-bottom: 10px;
        }


        .empty-state h3 {
            margin-bottom: 8px;

            color: #374151;
        }


        .empty-state p {
            margin-bottom: 20px;
        }


        /* =====================================================
           FORM
           ===================================================== */

        .form-control,
        .form-select {
            border-radius: 8px;

            border-color: #d1d5db;

            padding: 10px 12px;
        }


        .form-control:focus,
        .form-select:focus {
            border-color: #2563eb;

            box-shadow:
                0 0 0 .2rem rgba(37,99,235,.12);
        }


        .form-label {
            font-weight: 600;

            color: #374151;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        .admin-footer {
            padding: 20px 30px;

            text-align: center;

            color: #6b7280;

            font-size: 13px;
        }


        /* =====================================================
           MOBILE
           ===================================================== */

        @media (max-width: 992px) {

            .sidebar {
                width: 220px;
            }

            .main-area {
                width: calc(100% - 220px);

                margin-left: 220px;
            }

            .content {
                padding: 20px;
            }

        }


        @media (max-width: 768px) {

            .sidebar {
                position: relative;

                width: 100%;

                min-height: auto;
            }


            .sidebar-menu {
                padding-bottom: 10px;
            }


            .admin-layout {
                display: block;
            }


            .main-area {
                width: 100%;

                margin-left: 0;
            }


            .topbar {
                position: relative;

                padding: 0 18px;
            }


            .content {
                padding: 18px;
            }


            .page-title {
                align-items: flex-start;

                flex-direction: column;
            }


            .page-title .btn {
                width: 100%;
            }


            .user-info span {
                display: none;
            }

        }

    </style>

</head>


<body>

<div class="admin-layout">


    <!-- =====================================================
         SIDEBAR
         ===================================================== -->

    <aside class="sidebar">

        <div class="sidebar-logo">

            <div class="sidebar-logo-icon">
                <i class="bi bi-cart3"></i>
            </div>

            <span>
                Shopping MVC
            </span>

        </div>


        <nav class="sidebar-menu">


            <div class="menu-title">
                QUẢN LÝ
            </div>


            <a
                    href="${pageContext.request.contextPath}/admin/home"
                    class="menu-item">

                <i class="bi bi-grid-1x2-fill"></i>

                <span>
                    Trang chủ
                </span>

            </a>


            <a
                    href="${pageContext.request.contextPath}/admin/categories"
                    class="menu-item">

                <i class="bi bi-folder-fill"></i>

                <span>
                    Danh mục
                </span>

            </a>


            <a
                    href="${pageContext.request.contextPath}/admin/products"
                    class="menu-item">

                <i class="bi bi-bag-fill"></i>

                <span>
                    Sản phẩm
                </span>

            </a>


            <a
                    href="${pageContext.request.contextPath}/admin/videos"
                    class="menu-item">

                <i class="bi bi-camera-video-fill"></i>

                <span>
                    Video
                </span>

            </a>


            <div class="menu-title">
                HỆ THỐNG
            </div>


            <a
                    href="${pageContext.request.contextPath}/logout"
                    class="menu-item">

                <i class="bi bi-box-arrow-right"></i>

                <span>
                    Đăng xuất
                </span>

            </a>

        </nav>

    </aside>


    <!-- =====================================================
         MAIN
         ===================================================== -->

    <main class="main-area">


        <!-- TOPBAR -->

        <header class="topbar">

            <div class="topbar-title">

                <i class="bi bi-speedometer2 me-2"></i>

                Shopping Administration

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


        <!-- PAGE CONTENT -->

        <sitemesh:write property="body"/>


        <!-- FOOTER -->

        <footer class="admin-footer">

            Shopping Service © 2026

        </footer>


    </main>

</div>


<!-- =====================================================
     BOOTSTRAP JS
     ===================================================== -->

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<!-- =====================================================
     FORM VALIDATION GLOBAL
     ===================================================== -->

<script>

    document.addEventListener("DOMContentLoaded", function () {

        const forms =
            document.querySelectorAll("form.needs-validation");


        forms.forEach(function (form) {

            form.addEventListener(
                "submit",
                function (event) {

                    if (!form.checkValidity()) {

                        event.preventDefault();
                        event.stopPropagation();

                    }

                    form.classList.add("was-validated");

                },
                false
            );

        });

    });

</script>


</body>

</html>
