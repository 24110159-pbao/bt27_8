<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container py-5">

    <!-- PAGE TITLE -->

    <div class="mb-4">

        <h1 class="fw-bold">
            Tất cả sản phẩm
        </h1>

        <p class="text-muted">
            Khám phá các sản phẩm đang được bán tại cửa hàng
        </p>

    </div>


    <!-- PRODUCT LIST -->

    <div class="row g-4">

        <c:choose>

            <c:when test="${not empty listProduct}">

                <c:forEach
                        var="product"
                        items="${listProduct}">

                    <div class="col-md-6 col-lg-4">

                        <div class="card h-100 shadow-sm">


                            <!-- PRODUCT IMAGE -->

                            <a
                                    href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
                                    class="text-decoration-none">

                                <c:choose>

                                    <c:when test="${not empty product.image}">

                                        <img
                                                src="${pageContext.request.contextPath}/image?fname=${product.image}"
                                                class="card-img-top"
                                                alt="${product.name}"
                                                style="height:220px; object-fit:cover;">

                                    </c:when>

                                    <c:otherwise>

                                        <div
                                                class="bg-light d-flex align-items-center justify-content-center"
                                                style="height:220px;">

                                            <span class="text-muted">
                                                Không có hình
                                            </span>

                                        </div>

                                    </c:otherwise>

                                </c:choose>

                            </a>


                            <!-- PRODUCT INFO -->

                            <div class="card-body">

                                <h5 class="card-title">

                                    <a
                                            href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
                                            class="text-decoration-none text-dark">

                                        ${product.name}

                                    </a>

                                </h5>


                                <p class="text-muted mb-2">

                                    Danh mục:
                                    ${product.category.cateName}

                                </p>


                                <p class="text-primary fw-bold mb-2">

                                    ${product.price} VNĐ

                                </p>


                                <p class="mb-0">

                                    Còn lại:
                                    ${product.quantity} sản phẩm

                                </p>

                            </div>

                        </div>

                    </div>

                </c:forEach>

            </c:when>


            <c:otherwise>

                <div class="col-12">

                    <div class="alert alert-info">

                        Hiện chưa có sản phẩm.

                    </div>

                </div>

            </c:otherwise>

        </c:choose>

    </div>


    <!-- PAGINATION -->

    <c:if test="${totalPage > 1}">

        <nav class="mt-5">

            <ul class="pagination justify-content-center">


                <!-- PREVIOUS -->

                <c:if test="${currentPage > 1}">

                    <li class="page-item">

                        <a
                                class="page-link"
                                href="${pageContext.request.contextPath}/user/product?page=${currentPage - 1}">

                            &laquo; Trước

                        </a>

                    </li>

                </c:if>


                <!-- PAGE NUMBERS -->

                <c:forEach
                        begin="1"
                        end="${totalPage}"
                        var="page">

                    <li
                            class="page-item
                            ${page == currentPage ? 'active' : ''}">

                        <a
                                class="page-link"
                                href="${pageContext.request.contextPath}/user/product?page=${page}">

                            ${page}

                        </a>

                    </li>

                </c:forEach>


                <!-- NEXT -->

                <c:if test="${currentPage < totalPage}">

                    <li class="page-item">

                        <a
                                class="page-link"
                                href="${pageContext.request.contextPath}/user/product?page=${currentPage + 1}">

                            Sau &raquo;

                        </a>

                    </li>

                </c:if>

            </ul>

        </nav>

    </c:if>

</div>
