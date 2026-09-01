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
import vn.iotstar.util.EmailUtil;

import java.io.IOException;
import java.io.Serial;

@WebServlet("/resend-otp")
public class ResendOtpController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final IUserService userService =
            new UserServiceImpl();

    private final IOtpService otpService =
            new OtpServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession(false);

        if (session == null
                || session.getAttribute("otpUserId") == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/register"
            );

            return;
        }

        int userId =
                (Integer) session.getAttribute(
                        "otpUserId"
                );

        User user =
                userService.findById(userId);

        if (user == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/register"
            );

            return;
        }

        String otp =
                otpService.generateOtp();

        otpService.createOtp(
                userId,
                Constant.OTP_REGISTER,
                otp
        );

        try {

            EmailUtil.sendOtp(
                    user.getEmail(),
                    otp,
                    Constant.OTP_REGISTER
            );

            resp.sendRedirect(
                    req.getContextPath()
                            + "/verify-otp?resent=true"
            );

        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                    req.getContextPath()
                            + "/verify-otp?error=email"
            );
        }
    }
}
