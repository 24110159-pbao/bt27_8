package vn.iotstar.controller;

import java.io.IOException;
import java.io.Serial;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final IUserService userService =
            new UserServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession(false);

        /*
         * Chỉ được vào trang reset password
         * nếu OTP đã được xác nhận.
         */
        if (session == null
                || !Boolean.TRUE.equals(
                session.getAttribute(
                        "forgotPasswordVerified"
                ))) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/forgot-password"
            );

            return;
        }

        req.getRequestDispatcher(
                Constant.RESET_PASSWORD
        ).forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session =
                req.getSession(false);

        /*
         * Kiểm tra quyền reset password.
         */
        if (session == null
                || !Boolean.TRUE.equals(
                session.getAttribute(
                        "forgotPasswordVerified"
                ))) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/forgot-password"
            );

            return;
        }

        String password =
                req.getParameter("password");

        String confirmPassword =
                req.getParameter("confirmPassword");

        /*
         * Validate rỗng
         */
        if (password == null
                || password.isBlank()
                || confirmPassword == null
                || confirmPassword.isBlank()) {

            req.setAttribute(
                    "alert",
                    "Vui lòng nhập đầy đủ mật khẩu!"
            );

            req.getRequestDispatcher(
                    Constant.RESET_PASSWORD
            ).forward(req, resp);

            return;
        }

        /*
         * Validate độ dài
         */
        if (password.length() < 6) {

            req.setAttribute(
                    "alert",
                    "Mật khẩu phải có ít nhất 6 ký tự!"
            );

            req.getRequestDispatcher(
                    Constant.RESET_PASSWORD
            ).forward(req, resp);

            return;
        }

        /*
         * Validate xác nhận mật khẩu
         */
        if (!password.equals(confirmPassword)) {

            req.setAttribute(
                    "alert",
                    "Mật khẩu xác nhận không giống nhau!"
            );

            req.getRequestDispatcher(
                    Constant.RESET_PASSWORD
            ).forward(req, resp);

            return;
        }

        /*
         * Lấy email đã được xác nhận OTP.
         */
        String email =
                (String) session.getAttribute(
                        "forgotPasswordEmail"
                );

        if (email == null
                || email.isBlank()) {

            session.removeAttribute(
                    "forgotPasswordVerified"
            );

            resp.sendRedirect(
                    req.getContextPath()
                            + "/forgot-password"
            );

            return;
        }

        /*
         * Tìm User.
         */
        User user =
                userService.findByEmail(email);

        if (user == null) {

            req.setAttribute(
                    "alert",
                    "Không tìm thấy tài khoản!"
            );

            req.getRequestDispatcher(
                    Constant.RESET_PASSWORD
            ).forward(req, resp);

            return;
        }

        /*
         * Cập nhật password mới.
         *
         * Project hiện tại đang dùng plaintext
         * giống dữ liệu test trong database.
         */
        user.setPassword(password);

        userService.update(user);

        /*
         * Xóa trạng thái reset password
         * để OTP không thể được dùng lại
         * cho một lần reset khác.
         */
        session.removeAttribute(
                "forgotPasswordVerified"
        );

        session.removeAttribute(
                "forgotPasswordEmail"
        );

        session.removeAttribute(
                "forgotPasswordOtpType"
        );

        /*
         * Quay về Login.
         */
        resp.sendRedirect(
                req.getContextPath()
                        + "/login?reset=true"
        );
    }
}
