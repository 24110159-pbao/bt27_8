package vn.iotstar.controller;

import java.io.IOException;
import java.io.Serial;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.service.IOtpService;
import vn.iotstar.service.impl.OtpServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final IOtpService otpService =
            new OtpServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher(
                Constant.FORGOT_PASSWORD
        ).forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String email =
                req.getParameter("email");

        if (email == null || email.isBlank()) {

            req.setAttribute(
                    "alert",
                    "Vui lòng nhập email!"
            );

            req.getRequestDispatcher(
                    Constant.FORGOT_PASSWORD
            ).forward(req, resp);

            return;
        }

        email = email.trim();

        try {

            /*
             * Tạo OTP + lưu DB + gửi email
             */
            otpService.sendForgotPasswordOtp(
                    email
            );

            /*
             * Lưu email vào session.
             * Sau này VerifyOtpController
             * sẽ dùng email này để tìm User.
             */
            HttpSession session =
                    req.getSession(true);

            session.setAttribute(
                    "forgotPasswordEmail",
                    email
            );

            /*
             * Đánh dấu đang trong flow
             * quên mật khẩu.
             */
            session.setAttribute(
                    "forgotPasswordOtpType",
                    Constant.OTP_FORGOT_PASSWORD
            );

            /*
             * Chuyển sang nhập OTP.
             */
            resp.sendRedirect(
                    req.getContextPath()
                            + "/verify-otp?type="
                            + Constant.OTP_FORGOT_PASSWORD
            );

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute(
                    "alert",
                    e.getMessage()
            );

            req.getRequestDispatcher(
                    Constant.FORGOT_PASSWORD
            ).forward(req, resp);
        }
    }
}
