package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

import java.io.IOException;
import java.io.Serial;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session != null
                && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {

            resp.sendRedirect(
                    req.getContextPath() + "/waiting"
            );

            return;
        }

        req.getRequestDispatcher(
                Constant.LOGIN
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
        String remember = req.getParameter("remember");

        if (username == null
                || username.trim().isEmpty()
                || password == null
                || password.trim().isEmpty()) {

            req.setAttribute(
                    "alert",
                    "Tài khoản hoặc mật khẩu không được rỗng"
            );

            req.getRequestDispatcher(
                    Constant.LOGIN
            ).forward(req, resp);

            return;
        }

        IUserService service = new UserServiceImpl();

        User user = service.login(
                username.trim(),
                password
        );

        if (user != null) {

            HttpSession session = req.getSession(true);

            session.setAttribute(
                    Constant.SESSION_ACCOUNT,
                    user
            );

            if ("on".equals(remember)) {
                saveRememberMe(resp, username);
            }

            resp.sendRedirect(
                    req.getContextPath() + "/waiting"
            );

        } else {

            req.setAttribute(
                    "alert",
                    "Tài khoản hoặc mật khẩu không đúng"
            );

            req.getRequestDispatcher(
                    Constant.LOGIN
            ).forward(req, resp);
        }
    }

    private void saveRememberMe(
            HttpServletResponse response,
            String username) {

        Cookie cookie = new Cookie(
                Constant.COOKIE_REMEMBER,
                username
        );

        cookie.setMaxAge(30 * 60);
        cookie.setPath("/");

        response.addCookie(cookie);
    }
}
