<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Product" %>

<%
    List<Product> listProduct =
            (List<Product>) request.getAttribute("listProduct");

    String keyword =
            request.getParameter("keyword");
%>


<title>Quản lý sản phẩm - Shopping MVC</title>


<section class="content">


    <!-- =====================================================
         PAGE HEADER
         ===================================================== -->

    <div class="page-title">

        <div>

            <h1>
                Sản phẩm
            </h1>

            <p>
                Quản lý các sản phẩm trong cửa hàng
            </p>

        </div>


        <a
                href="${pageContext.request.contextPath}/admin/product/add"
                class="btn btn-primary">

            <i class="bi bi-plus-lg me-1"></i>

            Thêm sản phẩm

        </a>

    </div>


    <!-- =====================================================
         ERROR
         ===================================================== -->

    <% if (request.getAttribute("error") != null) { %>

    <div
            class="alert alert-danger alert-dismissible fade show"
            role="alert">

        <i class="bi bi-exclamation-triangle-fill me-2"></i>

        <%= request.getAttribute("error") %>

        <button
                type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>

    </div>

    <% } %>


    <!-- =====================================================
         SEARCH
         ===================================================== -->

    <div class="card">

        <div class="card-body">

            <form
                    method="get"
                    action="${pageContext.request.contextPath}/admin/products"
                    class="row g-2 needs-validation"
                    novalidate>


                <div class="col-12 col-md-6 col-lg-4">

                    <label
                            for="keyword"
                            class="form-label">

                        Tìm kiếm sản phẩm

                    </label>

                    <input
                            type="text"
                            id="keyword"
                            name="keyword"
                            class="form-control"
                            placeholder="Nhập tên sản phẩm..."
                            maxlength="100"
                            value="<%= keyword != null ? keyword : "" %>">

                    <div class="invalid-feedback">

                        Từ khóa không được vượt quá 100 ký tự.

                    </div>

                </div>


                <div class="col-12 col-md-auto d-flex align-items-end gap-2">

                    <button
                            type="submit"
                            class="btn btn-primary">

                        <i class="bi bi-search me-1"></i>

                        Tìm kiếm

                    </button>


                    <a
                            href="${pageContext.request.contextPath}/admin/products"
                            class="btn btn-secondary">

                        <i class="bi bi-arrow-clockwise me-1"></i>

                        Làm mới

                    </a>

                </div>

            </form>

        </div>

    </div>


    <!-- =====================================================
         PRODUCT LIST
         ===================================================== -->

    <div class="card">


        <!-- HEADER -->

        <div class="card-header">

            <div>

                <h3>

                    <i class="bi bi-bag-fill text-primary me-2"></i>

                    Danh sách sản phẩm

                </h3>

                <span>
                    Quản lý thông tin và trạng thái sản phẩm
                </span>

            </div>


            <span class="badge">

                Tổng số:

                <%= listProduct != null
                        ? listProduct.size()
                        : 0 %>

            </span>

        </div>


        <!-- BODY -->

        <div class="card-body">

            <div class="table-wrapper">

                <table class="table">


                    <thead>

                    <tr>

                        <th style="width:70px;">
                            ID
                        </th>

                        <th style="width:100px;">
                            Ảnh
                        </th>

                        <th>
                            Tên sản phẩm
                        </th>

                        <th>
                            Danh mục
                        </th>

                        <th>
                            Giá
                        </th>

                        <th>
                            Số lượng
                        </th>

                        <th>
                            Trạng thái
                        </th>

                        <th style="width:190px;">
                            Thao tác
                        </th>

                    </tr>

                    </thead>


                    <tbody>


                    <%

                        if (listProduct != null
                                && !listProduct.isEmpty()) {

                            for (Product product : listProduct) {

                    %>


                    <tr>


                        <!-- ID -->

                        <td>

                            <span class="id-badge">

                                <%= product.getId() %>

                            </span>

                        </td>


                        <!-- IMAGE -->

                        <td>

                            <div class="category-icon">

                                <%

                                    String image =
                                            product.getImage();

                                    if (image != null
                                            && !image.trim().isEmpty()) {

                                %>

                                <img
                                        src="${pageContext.request.contextPath}/image?fname=<%= image %>"
                                        class="category-image"
                                        alt="Ảnh sản phẩm">

                                <%

                                } else {

                                %>

                                <span class="default-icon">

                                    <i class="bi bi-bag-fill text-secondary"></i>

                                </span>

                                <%

                                    }

                                %>

                            </div>

                        </td>


                        <!-- NAME -->

                        <td>

                            <div class="category-name">

                                <%= product.getName() %>

                            </div>

                        </td>


                        <!-- CATEGORY -->

                        <td>

                            <%

                                if (product.getCategory() != null) {

                            %>

                            <span class="badge">

                                <%= product.getCategory().getCateName() %>

                            </span>

                            <%

                                } else {

                            %>

                            <span class="text-muted">

                                Chưa có danh mục

                            </span>

                            <%

                                }

                            %>

                        </td>


                        <!-- PRICE -->

                        <td>

                            <strong class="text-danger">

                                <%= product.getPrice() %> đ

                            </strong>

                        </td>


                        <!-- QUANTITY -->

                        <td>

                            <%= product.getQuantity() %>

                        </td>


                        <!-- STATUS -->

                        <td>

                            <%

                                if (product.isActive()) {

                            %>

                            <span
                                    class="badge"
                                    style="
                                        background:#dcfce7;
                                        color:#166534;
                                    ">

                                <i class="bi bi-check-circle me-1"></i>

                                Đang bán

                            </span>

                            <%

                                } else {

                            %>

                            <span
                                    class="badge"
                                    style="
                                        background:#fee2e2;
                                        color:#991b1b;
                                    ">

                                <i class="bi bi-x-circle me-1"></i>

                                Ngừng bán

                            </span>

                            <%

                                }

                            %>

                        </td>


                        <!-- ACTION -->

                        <td>

                            <div class="actions">


                                <a
                                        href="${pageContext.request.contextPath}/admin/product/edit?id=<%= product.getId() %>"
                                        class="btn btn-sm btn-warning">

                                    <i class="bi bi-pencil-square me-1"></i>

                                    Sửa

                                </a>


                                <a
                                        href="${pageContext.request.contextPath}/admin/product/delete?id=<%= product.getId() %>"
                                        class="btn btn-sm btn-danger"

                                        onclick="
                                            return confirm(
                                                'Bạn có chắc muốn xóa sản phẩm này?'
                                            );
                                        ">

                                    <i class="bi bi-trash me-1"></i>

                                    Xóa

                                </a>

                            </div>

                        </td>

                    </tr>


                    <%

                            }

                        } else {

                    %>


                    <!-- EMPTY -->

                    <tr>

                        <td
                                colspan="8"
                                class="empty-state">

                            <div class="empty-icon">

                                <i class="bi bi-bag-x text-secondary"></i>

                            </div>

                            <h3>
                                Chưa có sản phẩm
                            </h3>

                            <p>
                                Hãy thêm sản phẩm đầu tiên cho cửa hàng.
                            </p>

                            <a
                                    href="${pageContext.request.contextPath}/admin/product/add"
                                    class="btn btn-primary">

                                <i class="bi bi-plus-lg me-1"></i>

                                Thêm sản phẩm

                            </a>

                        </td>

                    </tr>


                    <%

                        }

                    %>


                    </tbody>

                </table>

            </div>

        </div>

    </div>


</section>