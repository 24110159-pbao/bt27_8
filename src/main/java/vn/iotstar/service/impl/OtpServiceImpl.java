package vn.iotstar.service.impl;

import java.security.SecureRandom;
import java.time.LocalDateTime;

import vn.iotstar.dao.OtpDao;
import vn.iotstar.dao.impl.OtpDaoImpl;
import vn.iotstar.entity.OtpVerification;
import vn.iotstar.entity.User;
import vn.iotstar.service.IOtpService;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.Constant;
import vn.iotstar.util.EmailUtil;

public class OtpServiceImpl implements IOtpService {

    private static final int OTP_LENGTH = 6;

    private static final int OTP_EXPIRE_MINUTES = 5;

    private final SecureRandom secureRandom =
            new SecureRandom();

    private final OtpDao otpDao =
            new OtpDaoImpl();

    private final IUserService userService =
            new UserServiceImpl();

    @Override
    public String generateOtp() {

        int number =
                secureRandom.nextInt(1_000_000);

        return String.format(
                "%0" + OTP_LENGTH + "d",
                number
        );
    }

    @Override
    public void createOtp(
            int userId,
            String type,
            String otp) {

        User user =
                userService.findById(userId);

        if (user == null) {
            throw new RuntimeException(
                    "Không tìm thấy User"
            );
        }

        // OTP cũ không còn hiệu lực
        otpDao.invalidateOldOtp(
                userId,
                type
        );

        OtpVerification verification =
                new OtpVerification();

        verification.setUser(user);
        verification.setOtp(otp);
        verification.setType(type);

        verification.setExpiredAt(
                LocalDateTime.now()
                        .plusMinutes(OTP_EXPIRE_MINUTES)
        );

        verification.setCreatedAt(
                LocalDateTime.now()
        );

        verification.setVerified(false);

        otpDao.insert(verification);
    }

    @Override
    public boolean verifyOtp(
            int userId,
            String otp,
            String type) {

        if (otp == null
                || !otp.matches("\\d{6}")) {

            return false;
        }

        OtpVerification verification =
                otpDao.findValidOtp(
                        userId,
                        otp,
                        type
                );

        if (verification == null) {
            return false;
        }

        otpDao.markVerified(
                verification.getId()
        );

        return true;
    }
    @Override
    public void sendForgotPasswordOtp(String email) {

        if (email == null || email.isBlank()) {
            throw new IllegalArgumentException(
                    "Vui lòng nhập email!"
            );
        }

        email = email.trim();

        User user =
                userService.findByEmail(email);

        if (user == null) {
            throw new IllegalArgumentException(
                    "Email không tồn tại trong hệ thống!"
            );
        }

        if (!user.isActive()) {
            throw new IllegalArgumentException(
                    "Tài khoản chưa được kích hoạt!"
            );
        }

        String otp =
                generateOtp();

        /*
         * Vô hiệu hóa OTP cũ
         * và tạo OTP mới.
         */
        createOtp(
                user.getId(),
                Constant.OTP_FORGOT_PASSWORD,
                otp
        );

        try {

            EmailUtil.sendOtp(
                    user.getEmail(),
                    otp,
                    Constant.OTP_FORGOT_PASSWORD
            );

        } catch (Exception e) {

            throw new RuntimeException(
                    "Không thể gửi OTP qua email!",
                    e
            );
        }
    }



}
