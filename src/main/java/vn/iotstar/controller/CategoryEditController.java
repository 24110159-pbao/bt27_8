package vn.iotstar.controller;

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

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/admin/category/edit")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class CategoryEditController extends HttpServlet {

    private final ICategoryService categoryService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String id =
                req.getParameter("id");

        if (id == null) {
            resp.sendRedirect(
                    req.getContextPath()
                            + "/admin/category/list"
            );
            return;
        }

        Category category =
                categoryService.get(
                        Integer.parseInt(id)
                );

        req.setAttribute(
                "category",
                category
        );

        req.getRequestDispatcher(
                "/views/admin/editcategory.jsp"
        ).forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        int id =
                Integer.parseInt(
                        req.getParameter("id")
                );

        String name =
                req.getParameter("name");

        Part filePart =
                req.getPart("icon");

        Category category =
                new Category();

        category.setId(id);
        category.setName(name);

        if (filePart != null
                && filePart.getSize() > 0) {

            String originalFileName =
                    Paths.get(
                            filePart.getSubmittedFileName()
                    ).getFileName().toString();

            String extension = "";

            int dot =
                    originalFileName.lastIndexOf(".");

            if (dot >= 0) {
                extension =
                        originalFileName.substring(dot);
            }

            String fileName =
                    UUID.randomUUID()
                            + extension;

            File uploadDir =
                    new File(
                            Constant.DIR + "/category"
                    );

            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File file =
                    new File(
                            uploadDir,
                            fileName
                    );

            filePart.write(
                    file.getAbsolutePath()
            );

            category.setIcon(
                    "category/" + fileName
            );
        }

        categoryService.edit(category);

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/category/list"
        );
    }
}
