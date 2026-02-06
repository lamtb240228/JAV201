package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

public class HashUtil {

    public static String hash(String input) {

        // 🚨 CHẶN NULL NGAY TỪ ĐẦU
        if (input == null || input.isEmpty()) {
            return null; // hoặc return "" nếu thầy yêu cầu
        }

        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(input.getBytes(StandardCharsets.UTF_8));

            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi hash mật khẩu", e);
        }
    }
}
