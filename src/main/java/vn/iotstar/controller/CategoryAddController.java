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

@WebServlet("/admin/category/add")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class CategoryAddController extends HttpServlet {

    private final ICategoryService categoryService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher(
                "/views/admin/add-category.jsp"
        ).forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name =
                req.getParameter("name");

        Part filePart =
                req.getPart("icon");

        String iconPath = null;

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

            iconPath =
                    "category/" + fileName;
        }

        Category category =
                new Category();

        category.setName(name);
        category.setIcon(iconPath);

        categoryService.insert(category);

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/category/list"
        );
    }
}
