package vn.iotstar.util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    private EmailUtil() {
    }

    public static void sendOtp(
            String recipient,
            String otp,
            String type) throws Exception {

        String username =
                System.getenv("SMTP_USERNAME");

        String password =
                System.getenv("SMTP_PASSWORD");

        if (username == null
                || username.isBlank()
                || password == null
                || password.isBlank()) {

            throw new IllegalStateException(
                    "Chưa cấu hình SMTP_USERNAME và SMTP_PASSWORD"
            );
        }

        Properties properties =
                new Properties();

        properties.put(
                "mail.smtp.host",
                "smtp.gmail.com"
        );

        properties.put(
                "mail.smtp.port",
                "587"
        );

        properties.put(
                "mail.smtp.auth",
                "true"
        );

        properties.put(
                "mail.smtp.starttls.enable",
                "true"
        );

        Session session =
                Session.getInstance(
                        properties,
                        new Authenticator() {

                            @Override
                            protected PasswordAuthentication
                            getPasswordAuthentication() {

                                return new PasswordAuthentication(
                                        username,
                                        password
                                );
                            }
                        }
                );

        Message message =
                new MimeMessage(session);

        message.setFrom(
                new InternetAddress(username)
        );

        message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(recipient)
        );

        message.setSubject(
                "Shopping MVC - Mã OTP"
        );

        String purpose =
                "REGISTER".equals(type)
                        ? "kích hoạt tài khoản"
                        : "đặt lại mật khẩu";

        message.setText(
                "Xin chào,\n\n"
                        + "Mã OTP của bạn dùng để "
                        + purpose
                        + " là: "
                        + otp
                        + "\n\n"
                        + "Mã OTP có hiệu lực trong 5 phút.\n"
                        + "Không chia sẻ mã OTP này cho người khác.\n\n"
                        + "Shopping MVC"
        );

        Transport.send(message);
    }
}
