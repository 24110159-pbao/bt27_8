<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Quên mật khẩu</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }

        .container {
            width: 400px;
            margin: 100px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            box-sizing: border-box;
            padding: 10px;
            margin-bottom: 15px;
        }

        button {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background: #0056b3;
        }

        .alert {
            color: red;
            margin-bottom: 15px;
            text-align: center;
        }

        .back {
            text-align: center;
            margin-top: 15px;
        }

    </style>

</head>

<body>

<div class="container">

    <h2>Quên mật khẩu</h2>

    <% if (request.getAttribute("alert") != null) { %>

        <div class="alert">
            <%= request.getAttribute("alert") %>
        </div>

    <% } %>

    <form action="<%= request.getContextPath() %>/forgot-password"
          method="post">

        <label for="email">
            Email
        </label>

        <input
                type="email"
                id="email"
                name="email"
                placeholder="Nhập email tài khoản"
                required
        >

        <button type="submit">
            Gửi mã OTP
        </button>

    </form>

    <div class="back">

        <a href="<%= request.getContextPath() %>/login">
            Quay lại đăng nhập
        </a>

    </div>

</div>

</body>

</html>
