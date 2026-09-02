<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đặt lại mật khẩu - Shopping MVC</title>

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

            <h2>Đặt lại mật khẩu</h2>

            <p>
                Nhập mật khẩu mới cho tài khoản của bạn.
            </p>

        </div>


        <% if (request.getAttribute("alert") != null) { %>

        <div class="alert alert-danger">

            <%= request.getAttribute("alert") %>

        </div>

        <% } %>


        <form method="post"
              action="${pageContext.request.contextPath}/reset-password">

            <div class="form-group">

                <label for="password">
                    Mật khẩu mới
                </label>

                <input type="password"
                       id="password"
                       name="password"
                       class="form-control"
                       placeholder="Nhập mật khẩu mới"
                       minlength="6"
                       required>

            </div>


            <div class="form-group">

                <label for="confirmPassword">
                    Xác nhận mật khẩu
                </label>

                <input type="password"
                       id="confirmPassword"
                       name="confirmPassword"
                       class="form-control"
                       placeholder="Nhập lại mật khẩu"
                       minlength="6"
                       required>

            </div>


            <button type="submit"
                    class="btn btn-primary btn-block">

                Đặt lại mật khẩu

            </button>

        </form>

    </div>

</div>

</body>

</html>
