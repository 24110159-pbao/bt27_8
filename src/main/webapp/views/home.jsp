<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Shopping Service</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<header>
    <h1>Shopping Service</h1>

    <nav>
        <a href="${pageContext.request.contextPath}/home">
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


<main>

    <section>

        <h2>Sản phẩm mới nhất</h2>

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
                                        <img
                                                src="${pageContext.request.contextPath}/image?fname=${product.image}"
                                                alt="${product.name}">
                                    </c:when>

                                    <c:otherwise>
                                        <div class="no-image">
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


                                <p>
                                    Còn lại:
                                    ${product.quantity}
                                </p>

                            </div>

                        </div>

                    </c:forEach>

                </c:when>


                <c:otherwise>

                    <p>
                        Hiện chưa có sản phẩm.
                    </p>

                </c:otherwise>

            </c:choose>

        </div>

    </section>

</main>

</body>
</html>
