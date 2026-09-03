package vn.iotstar.controller;

import java.io.IOException;
import java.io.Serial;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet("/product-detail")
public class ProductDetailController
        extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final IProductService productService =
            new ProductServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam =
                req.getParameter("id");

        if (idParam == null
                || idParam.trim().isEmpty()) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/product"
            );

            return;
        }

        int id;

        try {

            id =
                    Integer.parseInt(idParam);

        } catch (NumberFormatException e) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/product"
            );

            return;
        }

        Product product =
                productService.findById(id);

        if (product == null
                || !product.isActive()) {

            resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Không tìm thấy sản phẩm"
            );

            return;
        }

        req.setAttribute(
                "product",
                product
        );

        req.getRequestDispatcher(
                "/views/product-detail.jsp"
        ).forward(req, resp);
    }
}
