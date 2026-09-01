<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đăng ký - Shopping MVC</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<div class="auth-page">

    <div class="auth-box">

        <div class="auth-logo">

            <div class="logo-icon">
                🛍
            </div>

            <h2>Tạo tài khoản</h2>

            <p>Đăng ký tài khoản Shopping MVC</p>

        </div>


        <% if (request.getAttribute("alert") != null) { %>

        <div class="alert alert-danger">
            <%= request.getAttribute("alert") %>
        </div>

        <% } %>


        <form method="post"
              action="${pageContext.request.contextPath}/register">

            <div class="form-group">

                <label>Họ và tên</label>

                <input type="text"
                       name="fullname"
                       class="form-control"
                       placeholder="Nguyễn Văn A"
                       required>

            </div>


            <div class="form-group">

                <label>Tài khoản</label>

                <input type="text"
                       name="username"
                       class="form-control"
                       placeholder="username"
                       required>

            </div>


            <div class="form-group">

                <label>Email</label>

                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="example@gmail.com"
                       required>

            </div>


            <div class="form-group">

                <label>Số điện thoại</label>

                <input type="text"
                       name="phone"
                       class="form-control"
                       placeholder="0987654321"
                       required>

            </div>


            <div class="form-group">

                <label>Mật khẩu</label>

                <input type="password"
                       name="password"
                       class="form-control"
                       placeholder="••••••••"
                       minlength="6"
                       required>

            </div>


            <div class="form-group">

                <label>Xác nhận mật khẩu</label>

                <input type="password"
                       name="confirmPassword"
                       class="form-control"
                       placeholder="Nhập lại mật khẩu"
                       minlength="6"
                       required>

            </div>


            <button type="submit"
                    class="btn btn-primary btn-block">

                Tạo tài khoản

            </button>

        </form>


        <div class="auth-footer">

            Đã có tài khoản?

            <a href="${pageContext.request.contextPath}/login">
                Đăng nhập
            </a>

        </div>

    </div>

</div>

</body>

</html>
