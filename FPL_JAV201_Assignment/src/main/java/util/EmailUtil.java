package util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil {

    private static final String FROM_EMAIL = "game240228@gmail.com";
    private static final String PASSWORD = "axrw stma hvls mlov";

    public static void sendOTP(String toEmail, String recipientName, int otp, int type) {
        String subject;
        String content;

        if (type == 0) { // create account
            subject = "Xác thực tài khoản OE";
            content = "<html><body style='font-family: Arial;'>" +
                    "<h2>Xác thực tài khoản OE</h2>" +
                    "<p>Chào " + recipientName + "!</p>" +
                    "<p>Mã OTP của bạn là: <strong style='color:#007bff;'>" + otp + "</strong></p>" +
                    "<p>Vui lòng nhập mã này để xác thực.</p>" +
                    "<hr><p style='color:#888;'>Nếu bạn không yêu cầu, vui lòng bỏ qua email này.</p>" +
                    "</body></html>";
        } else if (type == 1) { // forgot password
            subject = "Khôi phục mật khẩu OE";
            content = "<html><body style='font-family: Arial;'>" +
                    "<h2>Khôi phục mật khẩu OE</h2>" +
                    "<p>Chào " + recipientName + "!</p>" +
                    "<p>Mã OTP để đặt lại mật khẩu là: <strong style='color:#dc3545;'>" + otp + "</strong></p>" +
                    "<p>Vui lòng sử dụng mã này để hoàn tất.</p>" +
                    "<hr><p style='color:#888;'>Nếu bạn không yêu cầu, vui lòng bỏ qua email này.</p>" +
                    "</body></html>";
        } else {
            return;
        }

        sendEmail(toEmail, subject, content);
    }

    // Hàm mới: Gửi email Share video
    public static void sendVideoShare(String toEmail, String senderName, String videoLink, String videoTitle,
            String videoPoster) {
        String subject = "Một tiểu phẩm hài hay được chia sẻ với bạn";

        String content = "<html><body style='font-family: Arial, sans-serif;'>" +
                "<div style='max-width:600px; margin:auto; padding:20px; background:#f8f9fa; border-radius:10px;'>" +
                "<h2 style='color:#0d6efd; text-align:center;'>Video hay từ Focus</h2>" +
                "<p>Chào bạn,</p>" +
                "<p><strong>" + senderName + "</strong> đã chia sẻ với bạn một tiểu phẩm hài từ Focus.</p>";

        if (videoTitle != null && !videoTitle.isEmpty()) {
            content += "<p><strong>Tiêu đề:</strong> " + videoTitle + "</p>";
        }

        if (videoPoster != null && !videoPoster.isEmpty()) {
            content += "<p style='text-align:center;'><img src='" + videoPoster
                    + "' alt='Poster' style='max-width:100%; border-radius:8px;'></p>";
        }

        content += "<p style='text-align:center; margin:30px 0;'>" +
                "<a href='" + videoLink
                + "' style='padding:12px 30px; background:#0d6efd; color:white; text-decoration:none; border-radius:6px; font-weight:bold;'>"
                +
                "Xem video ngay</a>" +
                "</p>" +
                "<hr>" +
                "<p style='font-size:13px; color:#666; text-align:center;'>" +
                "Email chia sẻ từ Focus. Nếu không phải bạn nhận, vui lòng bỏ qua." +
                "</p>" +
                "</div>" +
                "</body></html>";

        sendEmail(toEmail, subject, content);
    }

    // Hàm chung để gửi email
    private static void sendEmail(String toEmail, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail.trim().toLowerCase()));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("Email đã gửi thành công đến: " + toEmail);
        } catch (MessagingException e) {
            System.out.println("Lỗi gửi email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}