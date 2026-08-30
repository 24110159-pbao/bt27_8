<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
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
        .login-box {
            width: 100%;
            max-width: 400px;
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
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #4b5563;
            font-size: 14px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            color: #1f2937;
            transition: all 0.2s ease;
        }
        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }
        input::placeholder {
            color: #9ca3af;
        }
        .remember {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 24px;
        }
        .remember input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
            accent-color: #4f46e5;
        }
        .remember label {
            margin: 0;
            font-weight: normal;
            color: #4b5563;
            font-size: 14px;
            cursor: pointer;
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
        .btn-login {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background: #4f46e5;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease;
        }
        .btn-login:hover {
            background: #4338ca;
        }
        .register {
            text-align: center;
            margin-top: 24px;
            font-size: 14px;
            color: #6b7280;
        }
        .register a {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 600;
            margin-left: 4px;
        }
        .register a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h1>Đăng nhập</h1>

        <c:if test="${not empty alert}">
            <div class="alert">
                ${alert}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Tài khoản</label>
                <input
                    type="text"
                    id="username"
                    name="username"
                    placeholder="Nhập tài khoản"
                    value="${cookie.remember.value}"
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

            <div class="remember">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Ghi nhớ tài khoản</label>
            </div>

            <button type="submit" class="btn-login">
                Đăng nhập
            </button>
        </form>

        <div class="register">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
        </div>
    </div>
</body>
</html>
