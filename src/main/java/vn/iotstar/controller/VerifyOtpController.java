package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.service.IOtpService;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.OtpServiceImpl;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

import java.io.IOException;
import java.io.Serial;

@WebServlet("/verify-otp")
public class VerifyOtpController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final IOtpService otpService =
            new OtpServiceImpl();

    private final IUserService userService =
            new UserServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession(false);

        String type =
                req.getParameter("type");

        /*
         * ========================================
         * FORGOT PASSWORD
         * ========================================
         */
        if (Constant.OTP_FORGOT_PASSWORD.equals(type)) {

            if (session == null
                    || session.getAttribute(
                    "forgotPasswordEmail"
            ) == null) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/forgot-password"
                );

                return;
            }

            req.setAttribute(
                    "type",
                    Constant.OTP_FORGOT_PASSWORD
            );

            req.getRequestDispatcher(
                    Constant.VERIFY_OTP
            ).forward(req, resp);

            return;
        }

        /*
         * ========================================
         * REGISTER
         * ========================================
         */

        if (session == null
                || session.getAttribute(
                "otpUserId"
        ) == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/register"
            );

            return;
        }

        req.setAttribute(
                "type",
                Constant.OTP_REGISTER
        );

        req.getRequestDispatcher(
                Constant.VERIFY_OTP
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

        if (session == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/login"
            );

            return;
        }

        String type =
                req.getParameter("type");

        String otp =
                req.getParameter("otp");

        /*
         * OTP phải gồm đúng 6 chữ số
         */
        if (otp == null
                || !otp.matches("\\d{6}")) {

            req.setAttribute(
                    "alert",
                    "OTP phải gồm đúng 6 chữ số!"
            );

            req.setAttribute(
                    "type",
                    type
            );

            req.getRequestDispatcher(
                    Constant.VERIFY_OTP
            ).forward(req, resp);

            return;
        }

        /*
         * ========================================
         * FORGOT PASSWORD
         * ========================================
         */
        if (Constant.OTP_FORGOT_PASSWORD.equals(type)) {

            String email =
                    (String) session.getAttribute(
                            "forgotPasswordEmail"
                    );

            if (email == null
                    || email.isBlank()) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/forgot-password"
                );

                return;
            }

            User user =
                    userService.findByEmail(email);

            if (user == null) {

                req.setAttribute(
                        "alert",
                        "Không tìm thấy tài khoản!"
                );

                req.setAttribute(
                        "type",
                        Constant.OTP_FORGOT_PASSWORD
                );

                req.getRequestDispatcher(
                        Constant.VERIFY_OTP
                ).forward(req, resp);

                return;
            }

            boolean valid =
                    otpService.verifyOtp(
                            user.getId(),
                            otp,
                            Constant.OTP_FORGOT_PASSWORD
                    );

            if (!valid) {

                req.setAttribute(
                        "alert",
                        "OTP không đúng hoặc đã hết hạn!"
                );

                req.setAttribute(
                        "type",
                        Constant.OTP_FORGOT_PASSWORD
                );

                req.getRequestDispatcher(
                        Constant.VERIFY_OTP
                ).forward(req, resp);

                return;
            }

            /*
             * OTP chính xác.
             *
             * Cho phép người dùng reset password.
             */
            session.setAttribute(
                    "forgotPasswordVerified",
                    true
            );

            resp.sendRedirect(
                    req.getContextPath()
                            + "/reset-password"
            );

            return;
        }

        /*
         * ========================================
         * REGISTER
         * ========================================
         */

        Object userIdObject =
                session.getAttribute(
                        "otpUserId"
                );

        if (userIdObject == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/register"
            );

            return;
        }

        int userId =
                (Integer) userIdObject;

        boolean valid =
                otpService.verifyOtp(
                        userId,
                        otp,
                        Constant.OTP_REGISTER
                );

        if (!valid) {

            req.setAttribute(
                    "alert",
                    "OTP không đúng hoặc đã hết hạn!"
            );

            req.setAttribute(
                    "type",
                    Constant.OTP_REGISTER
            );

            req.getRequestDispatcher(
                    Constant.VERIFY_OTP
            ).forward(req, resp);

            return;
        }

        User user =
                userService.findById(userId);

        if (user == null) {

            req.setAttribute(
                    "alert",
                    "Không tìm thấy tài khoản!"
            );

            req.setAttribute(
                    "type",
                    Constant.OTP_REGISTER
            );

            req.getRequestDispatcher(
                    Constant.VERIFY_OTP
            ).forward(req, resp);

            return;
        }

        /*
         * Kích hoạt tài khoản
         */
        user.setActive(true);

        userService.update(user);

        session.removeAttribute(
                "otpUserId"
        );

        session.removeAttribute(
                "otpEmail"
        );

        resp.sendRedirect(
                req.getContextPath()
                        + "/login?activated=true"
        );
    }
}
