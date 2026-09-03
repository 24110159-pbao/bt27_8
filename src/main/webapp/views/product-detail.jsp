    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

    <!DOCTYPE html>
    <html lang="vi">

    <head>

        <meta charset="UTF-8">

        <title>${product.name}</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/style.css">

        <link rel="stylesheet"
                  href="${pageContext.request.contextPath}/css/client-product.css">

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


        <c:choose>

            <c:when test="${not empty product}">


                <div class="product-detail">


                    <!-- ===================== -->
                    <!-- IMAGE -->
                    <!-- ===================== -->

                    <div class="product-detail-image">

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

                    </div>


                    <!-- ===================== -->
                    <!-- INFORMATION -->
                    <!-- ===================== -->

                    <div class="product-detail-info">


                        <h2>
                            ${product.name}
                        </h2>


                        <p>

                            <strong>
                                Danh mục:
                            </strong>

                            ${product.category.cateName}

                        </p>


                        <p class="detail-price">

                            ${product.price} VNĐ

                        </p>


                        <p>

                            <strong>
                                Số lượng:
                            </strong>

                            ${product.quantity}

                        </p>


                        <p>

                            <strong>
                                Mô tả:
                            </strong>

                        </p>


                        <p>

                            ${product.description}

                        </p>


                        <p>

                            <strong>
                                Ngày tạo:
                            </strong>

                            ${product.createdAt}

                        </p>


                        <a
                                class="back-button"
                                href="${pageContext.request.contextPath}/product">

                            Quay lại sản phẩm

                        </a>


                    </div>


                </div>


            </c:when>


            <c:otherwise>

                <h2>
                    Không tìm thấy sản phẩm
                </h2>

                <a href="${pageContext.request.contextPath}/product">
                    Quay lại
                </a>

            </c:otherwise>

        </c:choose>


    </main>


    </body>
    </html>
