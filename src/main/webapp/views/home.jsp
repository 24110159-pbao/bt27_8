<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Shopping Service</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/client-product.css">

</head>

<body class="client-page">

<header class="client-header">

    <a class="client-logo"
       href="${pageContext.request.contextPath}/home">

        Shopping<span>Service</span>

    </a>

    <nav class="client-nav">

        <a class="active"
           href="${pageContext.request.contextPath}/home">
            Trang chủ
        </a>

        <a href="${pageContext.request.contextPath}/product">
            Sản phẩm
        </a>

        <a href="${pageContext.request.contextPath}/login">
            Đăng nhập
        </a>

    </nav>

</header>


<main class="client-container">

    <div class="client-page-title">

        <h1>Sản phẩm mới nhất</h1>

        <p>
            Những sản phẩm mới được cập nhật tại cửa hàng
        </p>

    </div>


    <div class="product-grid">

        <c:choose>

            <c:when test="${not empty listProduct}">

                <c:forEach
                        var="product"
                        items="${listProduct}">

                    <div class="product-card">

                        <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}">

                            <c:choose>

                                <c:when test="${not empty product.image}">

                                    <div class="product-card-image">

                                        <img
                                            src="${pageContext.request.contextPath}/image?fname=${product.image}"
                                            alt="${product.name}">

                                    </div>

                                </c:when>

                                <c:otherwise>

                                    <div class="product-card-no-image">
                                        Không có hình
                                    </div>

                                </c:otherwise>

                            </c:choose>

                        </a>


                        <div class="product-info">

                            <h3>

                                <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}">

                                    ${product.name}

                                </a>

                            </h3>


                            <p class="category">

                                Danh mục:
                                ${product.category.cateName}

                            </p>


                            <p class="price">

                                ${product.price} VNĐ

                            </p>


                            <p class="quantity">

                                Còn lại:
                                ${product.quantity} sản phẩm

                            </p>

                        </div>

                    </div>

                </c:forEach>

            </c:when>


            <c:otherwise>

                <div class="product-empty">

                    Hiện chưa có sản phẩm.

                </div>

            </c:otherwise>

        </c:choose>

    </div>

</main>

</body>
</html>
