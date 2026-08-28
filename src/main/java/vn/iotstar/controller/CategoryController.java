package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/admin/categories",
        "/admin/category/add",
        "/admin/category/insert",
        "/admin/category/edit",
        "/admin/category/update",
        "/admin/category/delete"
})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ICategoryService categoryService =
            new CategoryServiceImpl();


    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();


        // ==========================
        // LIST
        // ==========================

        if (uri.endsWith("/admin/categories")) {

            List<Category> list =
                    categoryService.findAll();

            req.setAttribute("listcate", list);

            req.getRequestDispatcher(
                    "/views/admin/category-list.jsp"
            ).forward(req, resp);

            return;
        }


        // ==========================
        // ADD
        // ==========================

        if (uri.endsWith("/admin/category/add")) {

            req.getRequestDispatcher(
                    "/views/admin/category-add.jsp"
            ).forward(req, resp);

            return;
        }


        // ==========================
        // EDIT
        // ==========================

        if (uri.endsWith("/admin/category/edit")) {

            String idString =
                    req.getParameter("id");

            try {

                int id = Integer.parseInt(idString);

                Category category =
                        categoryService.findById(id);

                if (category == null) {

                    resp.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Không tìm thấy Category"
                    );

                    return;
                }

                req.setAttribute(
                        "cate",
                        category
                );

                req.getRequestDispatcher(
                        "/views/admin/category-edit.jsp"
                ).forward(req, resp);

            } catch (NumberFormatException e) {

                resp.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "ID không hợp lệ"
                );
            }

            return;
        }


        // ==========================
        // DELETE
        // ==========================

        if (uri.endsWith("/admin/category/delete")) {

            String idString =
                    req.getParameter("id");

            try {

                int id =
                        Integer.parseInt(idString);

                categoryService.delete(id);

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

            } catch (Exception e) {

                e.printStackTrace();

                resp.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Không thể xóa Category"
                );
            }
        }
    }


    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");


        String uri = req.getRequestURI();


        // ==========================
        // INSERT
        // ==========================

        if (uri.endsWith("/admin/category/insert")) {

            String categoryname =
                    req.getParameter("categoryname");

            String images =
                    req.getParameter("images");


            Category category =
                    new Category();

            category.setCategoryname(
                    categoryname
            );

            category.setImages(
                    images
            );


            try {

                categoryService.insert(category);

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

            } catch (Exception e) {

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

            return;
        }


        // ==========================
        // UPDATE
        // ==========================

        if (uri.endsWith("/admin/category/update")) {

            try {

                int categoryid =
                        Integer.parseInt(
                                req.getParameter(
                                        "categoryid"
                                )
                        );

                String categoryname =
                        req.getParameter(
                                "categoryname"
                        );

                String images =
                        req.getParameter(
                                "images"
                        );


                Category category =
                        categoryService.findById(
                                categoryid
                        );

                if (category == null) {

                    resp.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Không tìm thấy Category"
                    );

                    return;
                }


                category.setCategoryname(
                        categoryname
                );

                category.setImages(
                        images
                );


                categoryService.update(
                        category
                );


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

                req.getRequestDispatcher(
                        "/views/admin/category-edit.jsp"
                ).forward(req, resp);
            }
        }
    }
}