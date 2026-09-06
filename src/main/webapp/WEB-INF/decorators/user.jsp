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


    <!-- Bootstrap -->

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">


    <!-- Bootstrap Icons -->

    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <!-- Project CSS -->

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


<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">

    <div class="container">

        <a
                class="navbar-brand fw-bold"
                href="${pageContext.request.contextPath}/user/home">

            <i class="bi bi-cart3 me-1"></i>

            Shopping<span class="text-warning">
                Service
            </span>

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

                        <i class="bi bi-house-door me-1"></i>

                        Trang chủ

                    </a>

                </li>


                <li class="nav-item">

                    <a
                            class="nav-link"
                            href="${pageContext.request.contextPath}/user/product">

                        <i class="bi bi-bag me-1"></i>

                        Sản phẩm

                    </a>

                </li>


                <li class="nav-item">

                    <a
                            class="nav-link"
                            href="${pageContext.request.contextPath}/user/profile">

                        <i class="bi bi-person me-1"></i>

                        Hồ sơ

                    </a>

                </li>


            </ul>


            <div class="d-flex">

                <a
                        class="btn btn-outline-light btn-sm"
                        href="${pageContext.request.contextPath}/logout">

                    <i class="bi bi-box-arrow-right me-1"></i>

                    Đăng xuất

                </a>

            </div>


        </div>

    </div>

</nav>


<main>

    <sitemesh:write property="body"/>

</main>


<footer class="bg-dark text-white text-center py-4 mt-5">

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
