package vn.iotstar.controller;

import java.io.IOException;
import java.io.Serial;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.Product;
import vn.iotstar.entity.User;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet("/user/home")
public class UserHomeController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final IProductService productService =
            new ProductServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession(false);

        if (session == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        User user =
                (User) session.getAttribute(
                        Constant.SESSION_ACCOUNT
                );

        if (user == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        List<Product> listProduct =
                productService.findTop10Newest();

        req.setAttribute(
                "listProduct",
                listProduct
        );

        req.setAttribute(
                "currentUser",
                user
        );

        req.getRequestDispatcher(
                "/views/user/home.jsp"
        ).forward(req, resp);
    }
}