package vn.iotstar.controller;

import java.io.IOException;
import java.io.Serial;

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
                && session.getAttribute(
                Constant.SESSION_ACCOUNT) != null) {

            resp.sendRedirect(
                    req.getContextPath() + "/waiting"
            );

            return;
        }
        if ("true".equals(req.getParameter("reset"))) {

            req.setAttribute(
                    "alertSuccess",
                    "Đặt lại mật khẩu thành công! Vui lòng đăng nhập."
            );
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

        username = username.trim();

        IUserService service = new UserServiceImpl();

        /*
         * Kiểm tra tài khoản trước.
         */
        User account =
                service.findByUsername(username);

        if (account == null) {

            req.setAttribute(
                    "alert",
                    "Tài khoản hoặc mật khẩu không đúng"
            );

            req.getRequestDispatcher(
                    Constant.LOGIN
            ).forward(req, resp);

            return;
        }

        /*
         * Tài khoản chưa kích hoạt.
         */
        if (!account.isActive()) {

            req.setAttribute(
                    "alert",
                    "Tài khoản chưa được kích hoạt. Vui lòng xác nhận OTP."
            );

            req.getRequestDispatcher(
                    Constant.LOGIN
            ).forward(req, resp);

            return;
        }

        /*
         * Kiểm tra username + password + active.
         */
        User user = service.login(
                username,
                password
        );

        if (user != null) {

            HttpSession session =
                    req.getSession(true);

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
