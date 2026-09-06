<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.iotstar.entity.Category" %>

<%
    List<Category> listCategory =
            (List<Category>) request.getAttribute("listCategory");
%>


<title>Quản lý danh mục - Shopping MVC</title>


<section class="content">


    <!-- =====================================================
         PAGE HEADER
         ===================================================== -->

    <div class="page-title">

        <div>

            <h1>
                Danh mục sản phẩm
            </h1>

            <p>
                Quản lý các danh mục trong cửa hàng
            </p>

        </div>


        <a
                href="${pageContext.request.contextPath}/admin/category/add"
                class="btn btn-primary">

            <i class="bi bi-plus-lg me-1"></i>

            Thêm danh mục

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
         CATEGORY CARD
         ===================================================== -->

    <div class="card">


        <!-- HEADER -->

        <div class="card-header">

            <div>

                <h3>
                    <i class="bi bi-folder-fill text-primary me-2"></i>
                    Danh sách danh mục
                </h3>

                <span>
                    Quản lý tên và icon danh mục
                </span>

            </div>


            <span class="badge">

                Tổng số:

                <%= listCategory != null
                        ? listCategory.size()
                        : 0 %>

            </span>

        </div>


        <!-- BODY -->

        <div class="card-body">

            <div class="table-wrapper">

                <table class="table">


                    <thead>

                    <tr>

                        <th style="width:80px;">
                            ID
                        </th>

                        <th style="width:120px;">
                            Icon
                        </th>

                        <th>
                            Tên danh mục
                        </th>

                        <th style="width:190px;">
                            Thao tác
                        </th>

                    </tr>

                    </thead>


                    <tbody>


                    <%

                        if (listCategory != null
                                && !listCategory.isEmpty()) {

                            for (Category category : listCategory) {

                    %>


                    <tr>


                        <!-- ID -->

                        <td>

                            <span class="id-badge">

                                <%= category.getCateId() %>

                            </span>

                        </td>


                        <!-- ICON -->

                        <td>

                            <div class="category-icon">

                                <%

                                    String icon =
                                            category.getIcons();

                                    if (icon != null
                                            && !icon.trim().isEmpty()) {

                                %>

                                <img
                                        src="${pageContext.request.contextPath}/image?fname=<%= icon %>"
                                        class="category-image"
                                        alt="Icon danh mục">

                                <%

                                } else {

                                %>

                                <span class="default-icon">
                                    <i class="bi bi-folder-fill text-warning"></i>
                                </span>

                                <%

                                    }

                                %>

                            </div>

                        </td>


                        <!-- NAME -->

                        <td>

                            <div class="category-name">

                                <%= category.getCateName() %>

                            </div>

                        </td>


                        <!-- ACTION -->

                        <td>

                            <div class="actions">


                                <a
                                        href="${pageContext.request.contextPath}/admin/category/edit?id=<%= category.getCateId() %>"
                                        class="btn btn-sm btn-warning">

                                    <i class="bi bi-pencil-square me-1"></i>

                                    Sửa

                                </a>


                                <a
                                        href="${pageContext.request.contextPath}/admin/category/delete?id=<%= category.getCateId() %>"
                                        class="btn btn-sm btn-danger"

                                        onclick="
                                            return confirm(
                                                'Bạn có chắc muốn xóa danh mục này?'
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
                                colspan="4"
                                class="empty-state">

                            <div class="empty-icon">

                                <i class="bi bi-folder-x text-secondary"></i>

                            </div>

                            <h3>
                                Chưa có danh mục
                            </h3>

                            <p>
                                Hãy thêm danh mục đầu tiên cho cửa hàng.
                            </p>

                            <a
                                    href="${pageContext.request.contextPath}/admin/category/add"
                                    class="btn btn-primary">

                                <i class="bi bi-plus-lg me-1"></i>

                                Thêm danh mục

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