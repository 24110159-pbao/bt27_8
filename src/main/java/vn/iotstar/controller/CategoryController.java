package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.io.Serial;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet({
        "/admin/categories",
        "/admin/category/add",
        "/admin/category/insert",
        "/admin/category/edit",
        "/admin/category/update",
        "/admin/category/delete"
})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
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


        // =========================
        // DANH SÁCH CATEGORY
        // =========================

        if (url.contains("/admin/categories")) {

            req.setAttribute(
                    "listCategory",
                    categoryService.findAll()
            );

            req.getRequestDispatcher(
                    "/views/admin/category-list.jsp"
            ).forward(req, resp);

        }


        // =========================
        // TRANG THÊM CATEGORY
        // =========================

        else if (url.contains("/admin/category/add")) {

            req.getRequestDispatcher(
                    "/views/admin/category-add.jsp"
            ).forward(req, resp);

        }


        // =========================
        // TRANG SỬA CATEGORY
        // =========================

        else if (url.contains("/admin/category/edit")) {

            String id =
                    req.getParameter("id");

            if (id == null || id.isEmpty()) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

                return;
            }

            int cateId;

            try {

                cateId = Integer.parseInt(id);

            } catch (NumberFormatException e) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

                return;
            }


            Category category =
                    categoryService.findById(cateId);


            if (category == null) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

                return;
            }


            req.setAttribute(
                    "category",
                    category
            );


            req.getRequestDispatcher(
                    "/views/admin/category-edit.jsp"
            ).forward(req, resp);

        }


        // =========================
        // DELETE
        // =========================

        else if (url.contains("/admin/category/delete")) {

            String id =
                    req.getParameter("id");

            if (id != null && !id.isEmpty()) {

                try {

                    int cateId =
                            Integer.parseInt(id);

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


        String url =
                req.getRequestURI();


        // =========================
        // INSERT
        // =========================

        if (url.contains("/admin/category/insert")) {

            String cateName =
                    req.getParameter("cateName");


            Part iconPart =
                    req.getPart("icon");


            String iconName =
                    uploadImage(iconPart);


            Category category =
                    new Category();

            category.setCateName(cateName);
            category.setIcons(iconName);


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


        // =========================
        // UPDATE
        // =========================

        else if (url.contains("/admin/category/update")) {

            String id =
                    req.getParameter("cateId");


            String cateName =
                    req.getParameter("cateName");


            if (id == null || id.isEmpty()) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

                return;
            }


            int cateId;

            try {

                cateId =
                        Integer.parseInt(id);

            } catch (NumberFormatException e) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

                return;
            }


            Category category =
                    categoryService.findById(cateId);


            if (category == null) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

                return;
            }


            // Giữ ảnh cũ
            String oldIcon =
                    category.getIcons();


            Part iconPart =
                    req.getPart("icon");


            // Nếu chọn ảnh mới
            if (iconPart != null
                    && iconPart.getSize() > 0) {

                String newIcon =
                        uploadImage(iconPart);

                category.setIcons(newIcon);
            }

            // Nếu không chọn ảnh
            // giữ nguyên ảnh cũ
            else {

                category.setIcons(oldIcon);
            }


            category.setCateName(cateName);


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


    // ==================================================
    // UPLOAD IMAGE
    // ==================================================

    private String uploadImage(
            Part part)
            throws IOException {

        if (part == null
                || part.getSize() == 0) {

            return null;
        }


        String originalName =
                Paths.get(
                        part.getSubmittedFileName()
                ).getFileName().toString();


        if (originalName == null
                || originalName.isEmpty()) {

            return null;
        }


        String extension = "";

        int dotIndex =
                originalName.lastIndexOf(".");


        if (dotIndex >= 0) {

            extension =
                    originalName.substring(dotIndex);
        }


        String fileName =
                System.currentTimeMillis()
                        + extension;


        File uploadDir =
                new File(Constant.DIR);


        if (!uploadDir.exists()) {

            uploadDir.mkdirs();
        }


        File file =
                new File(
                        uploadDir,
                        fileName
                );


        part.write(
                file.getAbsolutePath()
        );


        return fileName;
    }
}
