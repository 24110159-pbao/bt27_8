package vn.iotstar.controller;

import java.io.IOException;
import java.io.Serial;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;

@WebServlet({
        "/admin/categories",
        "/admin/category/add",
        "/admin/category/insert",
        "/admin/category/edit",
        "/admin/category/update",
        "/admin/category/delete"
})
public class CategoryController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final ICategoryService categoryService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String url = req.getRequestURI();

        // Danh sách Category
        if (url.contains("/admin/categories")) {

            req.setAttribute(
                    "listCategory",
                    categoryService.findAll()
            );

            req.getRequestDispatcher(
                    "/views/admin/category-list.jsp"
            ).forward(req, resp);

        }

        // Trang thêm Category
        else if (url.contains("/admin/category/add")) {

            req.getRequestDispatcher(
                    "/views/admin/category-add.jsp"
            ).forward(req, resp);

        }

        // Trang sửa Category
        else if (url.contains("/admin/category/edit")) {

            String id = req.getParameter("id");

            if (id == null || id.isEmpty()) {
                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );
                return;
            }

            int cateId = Integer.parseInt(id);

            Category category =
                    categoryService.findById(cateId);

            if (category == null) {
                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );
                return;
            }

            req.setAttribute("category", category);

            req.getRequestDispatcher(
                    "/views/admin/category-edit.jsp"
            ).forward(req, resp);

        }

        // Xóa Category
        else if (url.contains("/admin/category/delete")) {

            String id = req.getParameter("id");

            if (id != null && !id.isEmpty()) {

                int cateId = Integer.parseInt(id);

                try {

                    categoryService.delete(cateId);

                } catch (Exception e) {

                    e.printStackTrace();

                }
            }

            resp.sendRedirect(
                    req.getContextPath()
                            + "/admin/categories"
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        // Insert Category
        if (url.contains("/admin/category/insert")) {

            String cateName =
                    req.getParameter("cateName");

            String icons =
                    req.getParameter("icons");

            Category category = new Category();

            category.setCateName(cateName);
            category.setIcons(icons);

            try {

                categoryService.insert(category);

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

            } catch (Exception e) {

                e.printStackTrace();

                req.setAttribute(
                        "error",
                        e.getMessage()
                );

                req.setAttribute(
                        "category",
                        category
                );

                req.getRequestDispatcher(
                        "/views/admin/category-add.jsp"
                ).forward(req, resp);
            }
        }

        // Update Category
        else if (url.contains("/admin/category/update")) {

            String id =
                    req.getParameter("cateId");

            String cateName =
                    req.getParameter("cateName");

            String icons =
                    req.getParameter("icons");

            if (id == null || id.isEmpty()) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

                return;
            }

            int cateId =
                    Integer.parseInt(id);

            Category category =
                    categoryService.findById(cateId);

            if (category == null) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

                return;
            }

            category.setCateName(cateName);
            category.setIcons(icons);

            try {

                categoryService.update(category);

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

            } catch (Exception e) {

                e.printStackTrace();

                req.setAttribute(
                        "error",
                        e.getMessage()
                );

                req.setAttribute(
                        "category",
                        category
                );

                req.getRequestDispatcher(
                        "/views/admin/category-edit.jsp"
                ).forward(req, resp);
            }
        }
    }
}