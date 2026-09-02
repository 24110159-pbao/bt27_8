<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Xác nhận OTP - Shopping MVC</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<div class="auth-page">

    <div class="auth-box">

        <div class="auth-logo">

            <div class="logo-icon">
                🔐
            </div>

            <h2>Xác nhận OTP</h2>

            <p>
                Nhập mã OTP 6 chữ số đã được gửi tới email của bạn.
            </p>

        </div>


        <!-- ============================= -->
        <!-- THÔNG BÁO LỖI -->
        <!-- ============================= -->

        <% if (request.getAttribute("alert") != null) { %>

        <div class="alert alert-danger">
            <%= request.getAttribute("alert") %>
        </div>

        <% } %>


        <!-- ============================= -->
        <!-- THÔNG BÁO GỬI LẠI OTP -->
        <!-- ============================= -->

        <% if ("true".equals(request.getParameter("resent"))) { %>

        <div class="alert alert-success">
            OTP mới đã được gửi tới email của bạn.
        </div>

        <% } %>


        <!-- ============================= -->
        <!-- THÔNG BÁO LỖI EMAIL -->
        <!-- ============================= -->

        <% if ("email".equals(request.getParameter("error"))) { %>

        <div class="alert alert-danger">
            Không thể gửi OTP. Vui lòng kiểm tra cấu hình email.
        </div>

        <% } %>


        <!-- ============================= -->
        <!-- FORM XÁC NHẬN OTP -->
        <!-- ============================= -->

        <form method="post"
              action="${pageContext.request.contextPath}/verify-otp">

            <!--
                type dùng để xác định OTP này thuộc chức năng nào:
                - REGISTER
                - FORGOT_PASSWORD
            -->
            <input type="hidden"
                   name="type"
                   value="${type}">


            <div class="form-group">

                <label for="otp">
                    Mã OTP
                </label>

                <input type="text"
                       id="otp"
                       name="otp"
                       class="form-control"
                       placeholder="Nhập 6 chữ số"
                       maxlength="6"
                       pattern="[0-9]{6}"
                       inputmode="numeric"
                       autocomplete="one-time-code"
                       required>

            </div>


            <button type="submit"
                    class="btn btn-primary btn-block">

                Xác nhận OTP

            </button>

        </form>


        <!-- ============================= -->
        <!-- GỬI LẠI OTP -->
        <!-- ============================= -->

        <div class="auth-footer">

            <a href="${pageContext.request.contextPath}/resend-otp">
                Gửi lại OTP
            </a>

        </div>


        <!-- ============================= -->
        <!-- QUAY LẠI TRANG TRƯỚC -->
        <!-- ============================= -->

        <% if ("FORGOT_PASSWORD".equals(request.getAttribute("type"))) { %>

            <!--
                Trường hợp quên mật khẩu
            -->
            <div class="auth-footer">

                <a href="${pageContext.request.contextPath}/forgot-password">
                    Quay lại quên mật khẩu
                </a>

            </div>

        <% } else { %>

            <!--
                Trường hợp đăng ký tài khoản
            -->
            <div class="auth-footer">

                <a href="${pageContext.request.contextPath}/register">
                    Quay lại đăng ký
                </a>

            </div>

        <% } %>


    </div>

</div>

</body>

</html>