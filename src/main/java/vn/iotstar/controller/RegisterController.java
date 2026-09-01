package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.User;
import vn.iotstar.service.IOtpService;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.OtpServiceImpl;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.EmailUtil;

import java.io.IOException;
import java.io.Serial;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

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

        String username =
                trim(req.getParameter("username"));

        String password =
                req.getParameter("password");

        String confirmPassword =
                req.getParameter("confirmPassword");

        String email =
                trim(req.getParameter("email"));

        String fullname =
                trim(req.getParameter("fullname"));

        String phone =
                trim(req.getParameter("phone"));

        // =========================
        // VALIDATION
        // =========================

        if (isEmpty(username)
                || isEmpty(password)
                || isEmpty(confirmPassword)
                || isEmpty(email)
                || isEmpty(fullname)
                || isEmpty(phone)) {

            forwardError(
                    req,
                    resp,
                    "Vui lòng nhập đầy đủ thông tin!"
            );

            return;
        }

        if (!email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {

            forwardError(
                    req,
                    resp,
                    "Email không hợp lệ!"
            );

            return;
        }

        if (!password.equals(confirmPassword)) {

            forwardError(
                    req,
                    resp,
                    "Mật khẩu xác nhận không giống nhau!"
            );

            return;
        }

        if (password.length() < 6) {

            forwardError(
                    req,
                    resp,
                    "Mật khẩu phải có ít nhất 6 ký tự!"
            );

            return;
        }

        // =========================
        // CHECK EXIST
        // =========================

        if (userService.checkExistEmail(email)) {

            forwardError(
                    req,
                    resp,
                    "Email đã tồn tại!"
            );

            return;
        }

        if (userService.checkExistUsername(username)) {

            forwardError(
                    req,
                    resp,
                    "Tài khoản đã tồn tại!"
            );

            return;
        }

        if (userService.checkExistPhone(phone)) {

            forwardError(
                    req,
                    resp,
                    "Số điện thoại đã tồn tại!"
            );

            return;
        }

        // =========================
        // CREATE USER
        // =========================

        boolean success =
                userService.register(
                        email,
                        password,
                        username,
                        fullname,
                        phone
                );

        if (!success) {

            forwardError(
                    req,
                    resp,
                    "Đăng ký thất bại!"
            );

            return;
        }

        // =========================
        // FIND USER
        // =========================

        User user =
                userService.findByEmail(email);

        if (user == null) {

            forwardError(
                    req,
                    resp,
                    "Không tìm thấy tài khoản vừa tạo!"
            );

            return;
        }

        // =========================
        // CREATE OTP
        // =========================

        String otp =
                otpService.generateOtp();

        otpService.createOtp(
                user.getId(),
                Constant.OTP_REGISTER,
                otp
        );

        // =========================
        // SEND EMAIL
        // =========================

        try {

            EmailUtil.sendOtp(
                    user.getEmail(),
                    otp,
                    Constant.OTP_REGISTER
            );

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute(
                    "alert",
                    "Tạo tài khoản thành công nhưng không gửi được OTP. "
                            + "Vui lòng kiểm tra cấu hình email."
            );

            req.setAttribute(
                    "email",
                    user.getEmail()
            );

            req.getRequestDispatcher(
                    Constant.REGISTER
            ).forward(req, resp);

            return;
        }

        // =========================
        // SAVE SESSION OTP USER
        // =========================

        req.getSession(true).setAttribute(
                "otpUserId",
                user.getId()
        );

        req.getSession(true).setAttribute(
                "otpEmail",
                user.getEmail()
        );

        resp.sendRedirect(
                req.getContextPath()
                        + "/verify-otp"
        );
    }

    private void forwardError(
            HttpServletRequest req,
            HttpServletResponse resp,
            String message)
            throws ServletException, IOException {

        req.setAttribute(
                "alert",
                message
        );

        req.getRequestDispatcher(
                Constant.REGISTER
        ).forward(req, resp);
    }

    private boolean isEmpty(String value) {
        return value == null
                || value.trim().isEmpty();
    }

    private String trim(String value) {
        return value == null
                ? null
                : value.trim();
    }
}
