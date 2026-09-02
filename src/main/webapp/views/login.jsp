<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html> <html lang="vi"> <head> <meta charset="UTF-8"> <title>Đăng nhập - Shopping MVC</title>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">

</head> <body> <div class="auth-page">
<div class="auth-box">

    <div class="auth-logo">

        <div class="logo-icon">
            🛒
        </div>

        <h2>Shopping MVC</h2>

        <p>Đăng nhập vào hệ thống</p>

    </div>

    <% if (request.getAttribute("alert") != null) { %>

    <div class="alert alert-danger">
        <%= request.getAttribute("alert") %>
    </div>

    <% } %>

    <% if (request.getAttribute("alertSuccess") != null) { %>

    <div class="alert alert-success">
        <%= request.getAttribute("alertSuccess") %>
    </div>

    <% } %>

    <form method="post"
          action="${pageContext.request.contextPath}/login">

        <div class="form-group">

            <label>Tài khoản</label>

            <input type="text"
                   name="username"
                   class="form-control"
                   placeholder="Nhập tài khoản"
                   required>

        </div>

        <div class="form-group">

            <label>Mật khẩu</label>

            <input type="password"
                   name="password"
                   class="form-control"
                   placeholder="Nhập mật khẩu"
                   required>

        </div>

        <div style="margin-bottom:20px;">

            <label>
                <input type="checkbox"
                       name="remember">
                Ghi nhớ đăng nhập
            </label>

        </div>

        <button type="submit"
                class="btn btn-primary btn-block">

            Đăng nhập

        </button>

    </form>

    <div class="auth-footer">

        <a href="${pageContext.request.contextPath}/forgot-password">
            Quên mật khẩu?
        </a>

    </div>

    <div class="auth-footer">

        Chưa có tài khoản?

        <a href="${pageContext.request.contextPath}/register">
            Đăng ký ngay
        </a>

    </div>

</div>

</div> </body> </html>