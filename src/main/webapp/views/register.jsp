<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
            padding: 20px;
        }
        .register-box {
            width: 100%;
            max-width: 480px;
            background: white;
            padding: 40px 35px;
            border-radius: 16px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #1f2937;
            font-size: 28px;
            font-weight: 700;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #4b5563;
            font-size: 14px;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 11px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            color: #1f2937;
            transition: all 0.2s ease;
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }
        input::placeholder {
            color: #9ca3af;
        }
        .alert {
            background: #fee2e2;
            border-left: 4px solid #ef4444;
            color: #991b1b;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
        }
        .btn-register {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background: #4f46e5;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.2s ease;
        }
        .btn-register:hover {
            background: #4338ca;
        }
        .login {
            text-align: center;
            margin-top: 24px;
            font-size: 14px;
            color: #6b7280;
        }
        .login a {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 600;
            margin-left: 4px;
        }
        .login a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="register-box">
        <h1>Đăng ký tài khoản</h1>

        <c:if test="${not empty alert}">
            <div class="alert">
                ${alert}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="fullname">Họ và tên</label>
                <input
                    type="text"
                    id="fullname"
                    name="fullname"
                    value="${user.fullname}"
                    placeholder="Nhập họ và tên"
                    required>
            </div>

            <div class="form-group">
                <label for="username">Tài khoản</label>
                <input
                    type="text"
                    id="username"
                    name="username"
                    value="${user.username}"
                    placeholder="Nhập tài khoản"
                    required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    value="${user.email}"
                    placeholder="example@gmail.com"
                    required>
            </div>

            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input
                    type="text"
                    id="phone"
                    name="phone"
                    value="${user.phone}"
                    placeholder="Nhập số điện thoại"
                    required>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Nhập mật khẩu"
                    required>
            </div>

            <button type="submit" class="btn-register">
                Đăng ký
            </button>
        </form>

        <div class="login">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
        </div>
    </div>
</body>
</html>
