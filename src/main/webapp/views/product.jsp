<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Tất cả sản phẩm</title>

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

    </nav>

</header>


<main>

    <h2>Tất cả sản phẩm</h2>


    <div class="product-grid">

        <c:choose>

            <c:when test="${not empty listProduct}">

                <c:forEach
                        var="product"
                        items="${listProduct}">

                    <div class="product-card">


                        <!-- ===================== -->
                        <!-- IMAGE -->
                        <!-- ===================== -->

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


                        <!-- ===================== -->
                        <!-- INFORMATION -->
                        <!-- ===================== -->

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

                                Số lượng:
                                ${product.quantity}

                            </p>


                        </div>

                    </div>

                </c:forEach>

            </c:when>


            <c:otherwise>

                <p>
                    Không có sản phẩm.
                </p>

            </c:otherwise>

        </c:choose>

    </div>


    <!-- ===================== -->
    <!-- PAGINATION -->
    <!-- ===================== -->

    <c:if test="${totalPage > 1}">

        <div class="pagination">


            <!-- PREVIOUS -->

            <c:if test="${currentPage > 1}">

                <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}">
                    &laquo; Trước
                </a>

            </c:if>


            <!-- PAGE NUMBER -->

            <c:forEach
                    begin="1"
                    end="${totalPage}"
                    var="page">

                <c:choose>

                    <c:when test="${page == currentPage}">

                        <span class="active">
                            ${page}
                        </span>

                    </c:when>


                    <c:otherwise>

                        <a href="${pageContext.request.contextPath}/product?page=${page}">
                            ${page}
                        </a>

                    </c:otherwise>

                </c:choose>

            </c:forEach>


            <!-- NEXT -->

            <c:if test="${currentPage < totalPage}">

                <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">
                    Sau &raquo;
                </a>

            </c:if>


        </div>

    </c:if>


</main>

</body>
</html>
