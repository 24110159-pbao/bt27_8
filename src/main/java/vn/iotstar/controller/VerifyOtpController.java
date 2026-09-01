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

        if (session == null
                || session.getAttribute("otpUserId") == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/register"
            );

            return;
        }

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

        String otp =
                req.getParameter("otp");

        if (otp == null
                || !otp.matches("\\d{6}")) {

            req.setAttribute(
                    "alert",
                    "OTP phải gồm đúng 6 chữ số!"
            );

            req.getRequestDispatcher(
                    Constant.VERIFY_OTP
            ).forward(req, resp);

            return;
        }

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

            req.getRequestDispatcher(
                    Constant.VERIFY_OTP
            ).forward(req, resp);

            return;
        }

        // Kích hoạt tài khoản
        user.setActive(true);

        userService.update(user);

        session.removeAttribute("otpUserId");
        session.removeAttribute("otpEmail");

        resp.sendRedirect(
                req.getContextPath()
                        + "/login?activated=true"
        );
    }

    @Override
    protected void doPut(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        // Không sử dụng
    }
}
