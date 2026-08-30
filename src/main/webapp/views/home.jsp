<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Trang chủ - Shopping</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(
                    135deg,
                    #667eea,
                    #764ba2
            );
            min-height: 100vh;
            color: #1f2937;
        }

        .navbar {
            height: 70px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 50px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, .08);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 22px;
            font-weight: 700;
            color: #111827;
        }

        .logo-icon {
            font-size: 28px;
        }

        .logout {
            text-decoration: none;
            color: #667eea;
            border: 1px solid #667eea;
            padding: 9px 18px;
            border-radius: 8px;
            transition: .2s;
        }

        .logout:hover {
            background: #667eea;
            color: white;
        }

        .container {
            min-height: calc(100vh - 70px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
        }

        .welcome-card {
            width: 100%;
            max-width: 650px;
            background: white;
            border-radius: 20px;
            padding: 55px 45px;
            text-align: center;
            box-shadow: 0 20px 50px rgba(0, 0, 0, .18);
        }

        .welcome-icon {
            width: 90px;
            height: 90px;
            margin: 0 auto 25px;
            border-radius: 22px;
            background: linear-gradient(
                    135deg,
                    #667eea,
                    #764ba2
            );
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 42px;
        }

        h1 {
            margin: 0 0 12px;
            font-size: 32px;
            color: #111827;
        }

        .subtitle {
            margin: 0 auto 30px;
            color: #6b7280;
            font-size: 16px;
            line-height: 1.6;
        }

        .welcome-button {
            display: inline-block;
            padding: 12px 25px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 9px;
            font-weight: 600;
            transition: .2s;
        }

        .welcome-button:hover {
            background: #5568d9;
            transform: translateY(-1px);
        }

        .footer-text {
            margin-top: 30px;
            color: #9ca3af;
            font-size: 13px;
        }

        @media (max-width: 600px) {

            .navbar {
                padding: 0 20px;
            }

            .welcome-card {
                padding: 40px 25px;
            }

            h1 {
                font-size: 26px;
            }

        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<header class="navbar">

    <div class="logo">

        <span class="logo-icon">🛒</span>

        <span>Shopping</span>

    </div>

    <a
            href="${pageContext.request.contextPath}/logout"
            class="logout">

        Đăng xuất

    </a>

</header>


<!-- CONTENT -->

<main class="container">

    <div class="welcome-card">

        <div class="welcome-icon">
            🛍️
        </div>

        <h1>
            Chào mừng bạn đến Shopping!
        </h1>

        <p class="subtitle">
            Xin chào 👋<br>
            Chúc bạn có một trải nghiệm mua sắm
            thật tuyệt vời.
        </p>

        <a
                href="#"
                class="welcome-button">

            🛒 Khám phá ngay

        </a>

        <div class="footer-text">
            Shopping MVC &copy; 2026
        </div>

    </div>

</main>

</body>

</html>
