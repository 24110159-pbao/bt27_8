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

@WebServlet("/admin/category/list")
public class CategoryListController extends HttpServlet {

    private final ICategoryService categoryService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        List<Category> cateList =
                categoryService.getAll();

        req.setAttribute(
                "cateList",
                cateList
        );

        req.getRequestDispatcher(
                "/views/admin/listcategory.jsp"
        ).forward(req, resp);
    }
}
