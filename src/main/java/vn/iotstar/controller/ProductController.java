package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.io.Serial;
import java.math.BigDecimal;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet({
        "/admin/products",
        "/admin/product/add",
        "/admin/product/insert",
        "/admin/product/edit",
        "/admin/product/update",
        "/admin/product/delete"
})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class ProductController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final IProductService productService =
            new ProductServiceImpl();

    private final ICategoryService categoryService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String url = req.getRequestURI();

        // =========================
        // PRODUCT LIST
        // =========================

        if (url.contains("/admin/products")) {

            String keyword =
                    req.getParameter("keyword");

            String categoryId =
                    req.getParameter("categoryId");

            if (keyword != null
                    && !keyword.trim().isEmpty()) {

                req.setAttribute(
                        "listProduct",
                        productService.searchByName(
                                keyword.trim()
                        )
                );

            } else if (categoryId != null
                    && !categoryId.trim().isEmpty()) {

                try {

                    int cateId =
                            Integer.parseInt(categoryId);

                    req.setAttribute(
                            "listProduct",
                            productService.findByCategory(
                                    cateId
                            )
                    );

                } catch (NumberFormatException e) {

                    req.setAttribute(
                            "listProduct",
                            productService.findAll()
                    );
                }

            } else {

                req.setAttribute(
                        "listProduct",
                        productService.findAll()
                );
            }

            req.setAttribute(
                    "listCategory",
                    categoryService.findAll()
            );

            req.getRequestDispatcher(
                    "/views/admin/product-list.jsp"
            ).forward(req, resp);

            return;
        }

        // =========================
        // PRODUCT ADD
        // =========================

        if (url.contains("/admin/product/add")) {

            req.setAttribute(
                    "listCategory",
                    categoryService.findAll()
            );

            req.getRequestDispatcher(
                    "/views/admin/product-add.jsp"
            ).forward(req, resp);

            return;
        }

        // =========================
        // PRODUCT EDIT
        // =========================

        if (url.contains("/admin/product/edit")) {

            String id =
                    req.getParameter("id");

            if (id == null || id.trim().isEmpty()) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/products"
                );

                return;
            }

            try {

                int productId =
                        Integer.parseInt(id);

                Product product =
                        productService.findById(productId);

                if (product == null) {

                    resp.sendRedirect(
                            req.getContextPath()
                                    + "/admin/products"
                    );

                    return;
                }

                req.setAttribute(
                        "product",
                        product
                );

                req.setAttribute(
                        "listCategory",
                        categoryService.findAll()
                );

                req.getRequestDispatcher(
                        "/views/admin/product-edit.jsp"
                ).forward(req, resp);

            } catch (NumberFormatException e) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/products"
                );
            }

            return;
        }

        // =========================
        // DELETE
        // =========================

        if (url.contains("/admin/product/delete")) {

            String id =
                    req.getParameter("id");

            if (id != null && !id.trim().isEmpty()) {

                try {

                    int productId =
                            Integer.parseInt(id);

                    productService.delete(productId);

                } catch (Exception e) {

                    e.printStackTrace();
                }
            }

            resp.sendRedirect(
                    req.getContextPath()
                            + "/admin/products"
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

        if (url.contains("/admin/product/insert")) {

            try {

                String name =
                        req.getParameter("name");

                String description =
                        req.getParameter("description");

                String priceStr =
                        req.getParameter("price");

                String quantityStr =
                        req.getParameter("quantity");

                String categoryIdStr =
                        req.getParameter("categoryId");

                String activeStr =
                        req.getParameter("active");

                Part imagePart =
                        req.getPart("image");

                if (isEmpty(name)
                        || isEmpty(priceStr)
                        || isEmpty(quantityStr)
                        || isEmpty(categoryIdStr)) {

                    throw new RuntimeException(
                            "Vui lòng nhập đầy đủ thông tin"
                    );
                }

                BigDecimal price =
                        new BigDecimal(priceStr);

                int quantity =
                        Integer.parseInt(quantityStr);

                int categoryId =
                        Integer.parseInt(categoryIdStr);

                Category category =
                        categoryService.findById(categoryId);

                if (category == null) {

                    throw new RuntimeException(
                            "Category không tồn tại"
                    );
                }

                String imageName =
                        uploadImage(imagePart);

                Product product =
                        new Product();

                product.setName(name.trim());
                product.setDescription(description);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setImage(imageName);
                product.setActive(
                        "true".equals(activeStr)
                );
                product.setCategory(category);

                productService.insert(product);

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/products"
                );

            } catch (Exception e) {

                e.printStackTrace();

                req.setAttribute(
                        "error",
                        e.getMessage()
                );

                req.setAttribute(
                        "listCategory",
                        categoryService.findAll()
                );

                req.getRequestDispatcher(
                        "/views/admin/product-add.jsp"
                ).forward(req, resp);
            }

            return;
        }

        // =========================
        // UPDATE
        // =========================

        if (url.contains("/admin/product/update")) {

            try {

                String idStr =
                        req.getParameter("id");

                String name =
                        req.getParameter("name");

                String description =
                        req.getParameter("description");

                String priceStr =
                        req.getParameter("price");

                String quantityStr =
                        req.getParameter("quantity");

                String categoryIdStr =
                        req.getParameter("categoryId");

                String activeStr =
                        req.getParameter("active");

                if (isEmpty(idStr)
                        || isEmpty(name)
                        || isEmpty(priceStr)
                        || isEmpty(quantityStr)
                        || isEmpty(categoryIdStr)) {

                    throw new RuntimeException(
                            "Vui lòng nhập đầy đủ thông tin"
                    );
                }

                int id =
                        Integer.parseInt(idStr);

                BigDecimal price =
                        new BigDecimal(priceStr);

                int quantity =
                        Integer.parseInt(quantityStr);

                int categoryId =
                        Integer.parseInt(categoryIdStr);

                Product product =
                        productService.findById(id);

                if (product == null) {

                    throw new RuntimeException(
                            "Không tìm thấy Product"
                    );
                }

                Category category =
                        categoryService.findById(categoryId);

                if (category == null) {

                    throw new RuntimeException(
                            "Category không tồn tại"
                    );
                }

                String oldImage =
                        product.getImage();

                Part imagePart =
                        req.getPart("image");

                String newImage =
                        uploadImage(imagePart);

                if (newImage != null) {
                    product.setImage(newImage);
                } else {
                    product.setImage(oldImage);
                }

                product.setName(name.trim());
                product.setDescription(description);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setCategory(category);
                product.setActive(
                        "true".equals(activeStr)
                );

                productService.update(product);

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/products"
                );

            } catch (Exception e) {

                e.printStackTrace();

                req.setAttribute(
                        "error",
                        e.getMessage()
                );

                String idStr =
                        req.getParameter("id");

                if (idStr != null) {

                    try {

                        Product product =
                                productService.findById(
                                        Integer.parseInt(idStr)
                                );

                        req.setAttribute(
                                "product",
                                product
                        );

                    } catch (Exception ignored) {
                    }
                }

                req.setAttribute(
                        "listCategory",
                        categoryService.findAll()
                );

                req.getRequestDispatcher(
                        "/views/admin/product-edit.jsp"
                ).forward(req, resp);
            }
        }
    }

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
                        )
                        .getFileName()
                        .toString();

        if (originalName.isEmpty()) {
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

    private boolean isEmpty(String value) {

        return value == null
                || value.trim().isEmpty();
    }
}
