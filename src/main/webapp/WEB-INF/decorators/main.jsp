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

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/style.css">

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/user.css">

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/client-product.css">

    <sitemesh:write property="head"/>

</head>

<body class="user-page">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">

    <div class="container-fluid">

        <a
                class="navbar-brand"
                href="${pageContext.request.contextPath}/user/home">

            Shopping<span class="text-warning">Service</span>

        </a>

        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#mainNavbar"
                aria-controls="mainNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div
                class="collapse navbar-collapse"
                id="mainNavbar">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">

                    <a
                            class="nav-link"
                            href="${pageContext.request.contextPath}/user/home">

                        Trang chủ

                    </a>

                </li>

                <li class="nav-item">

                    <a
                            class="nav-link"
                            href="${pageContext.request.contextPath}/product">

                        Sản phẩm

                    </a>

                </li>

                <li class="nav-item">

                    <a
                            class="nav-link"
                            href="${pageContext.request.contextPath}/user/profile">

                        Hồ sơ

                    </a>

                </li>

            </ul>

            <div class="d-flex">

                <a
                        class="btn btn-outline-light btn-sm"
                        href="${pageContext.request.contextPath}/logout">

                    Đăng xuất

                </a>

            </div>

        </div>

    </div>

</nav>

<main>

    <sitemesh:write property="body"/>

</main>

<footer class="bg-dark text-white text-center py-3 mt-5">

    <div class="container">

        <small>
            Shopping Service © 2026
        </small>

    </div>

</footer>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>
