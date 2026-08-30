<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Service</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f8f9fa;
            color: #333;
            line-height: 1.5;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .header {
            background: #1f2937;
            color: white;
            padding: 18px 6%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .logo {
            font-size: 22px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }
        .menu {
            display: flex;
            align-items: center;
            gap: 24px;
        }
        .menu a {
            color: #d1d5db;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: color 0.2s ease;
        }
        .menu a:hover {
            color: #f59e0b;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
            flex: 1;
        }
        .welcome {
            background: white;
            padding: 40px 30px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
            margin-bottom: 30px;
        }
        .welcome h1 {
            color: #111827;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .welcome p {
            color: #6b7280;
            font-size: 16px;
        }
        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }
        .card {
            background: white;
            padding: 30px 24px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        .card-content h3 {
            color: #1f2937;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .card-content p {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 16px;
        }
        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 20px;
            background: #4f46e5;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            width: 100%;
            max-width: 160px;
            transition: background 0.2s ease;
        }
        .btn-action:hover {
            background: #4338ca;
        }
        .btn-logout {
            background: #ef4444;
        }
        .btn-logout:hover {
            background: #dc2626;
        }
        .footer {
            padding: 24px;
            text-align: center;
            background: #1f2937;
            color: #9ca3af;
            font-size: 14px;
            border-top: 1px solid #374151;
        }
        @media (max-width: 768px) {
            .cards {
                grid-template-columns: 1fr;
                gap: 16px;
            }
            .header {
                padding: 16px 5%;
            }
            .welcome {
                padding: 30px 20px;
            }
            .welcome h1 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="logo">Shopping Service</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </nav>
    </header>

    <main class="container">
        <section class="welcome">
            <h1>Chào mừng đến với Shopping Service</h1>
            <p>Hệ thống mua sắm trực tuyến</p>
        </section>

        <section class="cards">
            <div class="card">
                <div class="card-content">
                    <h3>Danh mục</h3>
                    <p>Xem và quản lý các danh mục sản phẩm.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/categories" class="btn-action">Khám phá</a>
            </div>

            <div class="card">
                <div class="card-content">
                    <h3>Sản phẩm</h3>
                    <p>Khám phá các sản phẩm mới nhất.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn-action">Xem ngay</a>
            </div>

            <div class="card">
                <div class="card-content">
                    <h3>Tài khoản</h3>
                    <p>Quản lý thông tin tài khoản của bạn.</p>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn-action btn-logout">Đăng xuất</a>
            </div>
        </section>
    </main>

    <footer class="footer">
        Shopping Service &copy; MVC System
    </footer>
</body>
</html>
