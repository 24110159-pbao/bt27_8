package vn.iotstar.service;

public interface IOtpService {

    String generateOtp();

    void createOtp(int userId, String type, String otp);

    boolean verifyOtp(
            int userId,
            String otp,
            String type
    );
    void sendForgotPasswordOtp(String email);

}
