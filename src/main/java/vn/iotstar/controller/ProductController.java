package vn.iotstar.controller;

import java.io.IOException;
import java.io.Serial;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet("/product")
public class ProductController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private static final int PAGE_SIZE = 6;

    private final IProductService productService =
            new ProductServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        int page = 1;

        String pageParam =
                req.getParameter("page");

        if (pageParam != null
                && !pageParam.trim().isEmpty()) {

            try {

                page =
                        Integer.parseInt(
                                pageParam
                        );

            } catch (NumberFormatException e) {

                page = 1;
            }
        }

        if (page < 1) {
            page = 1;
        }

        int totalProduct =
                productService.count();

        int totalPage =
                (int) Math.ceil(
                        (double) totalProduct
                                / PAGE_SIZE
                );

        if (totalPage > 0
                && page > totalPage) {

            page = totalPage;
        }

        List<Product> listProduct =
                productService.findAll(
                        page,
                        PAGE_SIZE
                );

        req.setAttribute(
                "listProduct",
                listProduct
        );

        req.setAttribute(
                "currentPage",
                page
        );

        req.setAttribute(
                "totalPage",
                totalPage
        );

        req.setAttribute(
                "pageSize",
                PAGE_SIZE
        );

        req.getRequestDispatcher(
                "/views/product.jsp"
        ).forward(req, resp);
    }
}
