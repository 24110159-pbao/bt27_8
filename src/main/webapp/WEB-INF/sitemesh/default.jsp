<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sitemesh"
uri="http://www.sitemesh.org/sitemesh3" %>

<!DOCTYPE html>

<html lang="vi">

<head>

<meta charset="UTF-8">

<title>
    <sitemesh:write property="title">
        Shopping Service
    </sitemesh:write>
</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/client-product.css">
```

</head>

<body class="client-page">

<header class="client-header">

```
<a class="client-logo"
   href="${pageContext.request.contextPath}/user/home">

    Shopping<span>Service</span>

</a>


<nav class="client-nav">

    <a
        href="${pageContext.request.contextPath}/user/home">

        Trang chủ

    </a>


    <a
        href="${pageContext.request.contextPath}/product">

        Sản phẩm

    </a>


    <a
        href="${pageContext.request.contextPath}/user/profile">

        Hồ sơ

    </a>


    <a
        href="${pageContext.request.contextPath}/logout">

        Đăng xuất

    </a>

</nav>

</header>

<main class="client-container">

<sitemesh:write property="body"/>

</main>

</body>

</html>
