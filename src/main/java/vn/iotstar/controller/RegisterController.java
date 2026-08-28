package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

import java.io.IOException;
import java.io.Serial;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher(
                Constant.REGISTER
        ).forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        if (isEmpty(username)
                || isEmpty(password)
                || isEmpty(email)
                || isEmpty(fullname)
                || isEmpty(phone)) {

            req.setAttribute(
                    "alert",
                    "Vui lòng nhập đầy đủ thông tin!"
            );

            req.getRequestDispatcher(
                    Constant.REGISTER
            ).forward(req, resp);

            return;
        }

        username = username.trim();
        email = email.trim();
        fullname = fullname.trim();
        phone = phone.trim();

        IUserService service = new UserServiceImpl();

        if (service.checkExistEmail(email)) {

            req.setAttribute(
                    "alert",
                    "Email đã tồn tại!"
            );

            req.getRequestDispatcher(
                    Constant.REGISTER
            ).forward(req, resp);

            return;
        }

        if (service.checkExistUsername(username)) {

            req.setAttribute(
                    "alert",
                    "Tài khoản đã tồn tại!"
            );

            req.getRequestDispatcher(
                    Constant.REGISTER
            ).forward(req, resp);

            return;
        }

        if (service.checkExistPhone(phone)) {

            req.setAttribute(
                    "alert",
                    "Số điện thoại đã tồn tại!"
            );

            req.getRequestDispatcher(
                    Constant.REGISTER
            ).forward(req, resp);

            return;
        }

        boolean success = service.register(
                email,
                password,
                username,
                fullname,
                phone
        );

        if (success) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

        } else {

            req.setAttribute(
                    "alert",
                    "Đăng ký thất bại!"
            );

            req.getRequestDispatcher(
                    Constant.REGISTER
            ).forward(req, resp);
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
