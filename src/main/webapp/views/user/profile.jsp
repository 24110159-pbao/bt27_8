<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Hồ sơ cá nhân - Shopping Service</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/user.css">

</head>


<body class="user-page">


<!-- =====================================================
     HEADER
     ===================================================== -->

<header class="user-header">


    <a class="user-logo"
       href="${pageContext.request.contextPath}/user/home">

        Shopping<span>Service</span>

    </a>


    <nav class="user-nav">


        <a href="${pageContext.request.contextPath}/user/home">

            Trang chủ

        </a>


        <a href="${pageContext.request.contextPath}/product">

            Sản phẩm

        </a>


        <a class="active"
           href="${pageContext.request.contextPath}/profile">

            Hồ sơ

        </a>


        <div class="user-menu">


            <c:choose>

                <c:when test="${not empty user.avatar}">

                    <img
                            class="user-avatar-small"
                            src="${pageContext.request.contextPath}/image?fname=${user.avatar}"
                            alt="Avatar">

                </c:when>


                <c:otherwise>

                    <div class="user-avatar-default">

                        ${user.fullname.substring(0,1)}

                    </div>

                </c:otherwise>

            </c:choose>


            <span class="user-name">

                ${user.fullname}

            </span>


        </div>


        <a href="${pageContext.request.contextPath}/logout">

            Đăng xuất

        </a>


    </nav>

</header>



<!-- =====================================================
     MAIN
     ===================================================== -->

<main class="user-container">


    <div class="user-welcome">

        <h1>
            Hồ sơ cá nhân
        </h1>

        <p>
            Quản lý và cập nhật thông tin tài khoản của bạn.
        </p>

    </div>



    <!-- =================================================
         PROFILE
         ================================================= -->

    <div class="profile-wrapper">


        <!-- =============================================
             LEFT
             ============================================= -->

        <aside class="profile-sidebar">


            <div class="profile-avatar-large">


                <c:choose>


                    <c:when test="${not empty user.avatar}">

                        <img
                                src="${pageContext.request.contextPath}/image?fname=${user.avatar}"
                                alt="Avatar">

                    </c:when>


                    <c:otherwise>

                        <div class="profile-avatar-placeholder">

                            ${user.fullname.substring(0,1)}

                        </div>

                    </c:otherwise>


                </c:choose>


            </div>


            <h2>

                ${user.fullname}

            </h2>


            <p>

                @${user.username}

            </p>


        </aside>



        <!-- =============================================
             RIGHT
             ============================================= -->

        <section class="profile-content">


            <h2>
                Thông tin cá nhân
            </h2>


            <p class="profile-description">

                Bạn có thể cập nhật họ tên, số điện thoại
                và ảnh đại diện tại đây.

            </p>



            <!-- SUCCESS -->

            <c:if test="${not empty success}">

                <div class="profile-alert success">

                    ${success}

                </div>

            </c:if>



            <!-- ERROR -->

            <c:if test="${not empty error}">

                <div class="profile-alert error">

                    ${error}

                </div>

            </c:if>



            <!-- FORM -->

            <form
                    class="profile-form"
                    action="${pageContext.request.contextPath}/profile"
                    method="post"
                    enctype="multipart/form-data">


                <!-- USERNAME -->

                <div class="profile-form-group">

                    <label>
                        Tên tài khoản
                    </label>

                    <input
                            type="text"
                            value="${user.username}"
                            readonly>

                </div>



                <!-- EMAIL -->

                <div class="profile-form-group">

                    <label>
                        Email
                    </label>

                    <input
                            type="email"
                            value="${user.email}"
                            readonly>

                </div>



                <!-- FULLNAME -->

                <div class="profile-form-group">

                    <label for="fullname">
                        Họ và tên
                    </label>

                    <input
                            type="text"
                            id="fullname"
                            name="fullname"
                            value="${user.fullname}"
                            placeholder="Nhập họ và tên"
                            required>

                </div>



                <!-- PHONE -->

                <div class="profile-form-group">

                    <label for="phone">
                        Số điện thoại
                    </label>

                    <input
                            type="text"
                            id="phone"
                            name="phone"
                            value="${user.phone}"
                            placeholder="Nhập số điện thoại"
                            required>

                </div>



                <!-- AVATAR -->

                <div class="profile-form-group">

                    <label for="avatar">
                        Ảnh đại diện
                    </label>

                    <input
                            type="file"
                            id="avatar"
                            name="avatar"
                            accept=".jpg,.jpeg,.png,.gif,.webp">

                    <small>
                        JPG, JPEG, PNG, GIF hoặc WEBP.
                        Dung lượng tối đa 5MB.
                    </small>

                </div>



                <!-- BUTTON -->

                <button
                        type="submit"
                        class="profile-submit">

                    Cập nhật hồ sơ

                </button>


            </form>


        </section>


    </div>


</main>


</body>

</html>

