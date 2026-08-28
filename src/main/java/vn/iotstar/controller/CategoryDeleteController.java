package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;

import java.io.IOException;

@WebServlet("/admin/category/delete")
public class CategoryDeleteController extends HttpServlet {

    private final ICategoryService categoryService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String id =
                req.getParameter("id");

        if (id != null) {

            categoryService.delete(
                    Integer.parseInt(id)
            );
        }

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/category/list"
        );
    }
}
