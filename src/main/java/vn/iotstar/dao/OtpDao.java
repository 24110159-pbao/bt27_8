package vn.iotstar.dao;

import vn.iotstar.entity.OtpVerification;

public interface OtpDao {

    void invalidateOldOtp(int userId, String type);

    void insert(OtpVerification otp);

    OtpVerification findValidOtp(
            int userId,
            String otp,
            String type
    );

    void markVerified(int id);
}
