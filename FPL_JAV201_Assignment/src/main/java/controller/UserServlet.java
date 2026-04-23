package controller;

import dao.impl.FavoritesDAOImpl;
import dao.impl.UserDAOImpl;
import entity.Favorite;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import util.EmailUtil;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.UUID;

@WebServlet({ "/user", "/user/profile","/user/favorite", "/user/change-password", "/forgot-password", "/reset-password", "/verify-otp" })
public class UserServlet extends HttpServlet {

    private final FavoritesDAOImpl favoriteDAO = new FavoritesDAOImpl();
    private final UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String uri = req.getRequestURI();
        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/Login");
            return;
        }

        if (uri.contains("/profile")) {
            req.getRequestDispatcher("/user/Profile.jsp").forward(req, resp);
            return;
        }

        if (uri.contains("/forgot-password")) {
            req.getRequestDispatcher("/auth/ForgotPassword.jsp").forward(req, resp);
            return;
        }

        if (uri.contains("/reset-password")) {

            User resetUser = (User) req.getSession().getAttribute("resetUser");
            if (resetUser == null) {
                resp.sendRedirect("/forgot-password");
                return;
            }
            req.getRequestDispatcher("/auth/reset-password.jsp").forward(req, resp);

            return;
        }

        if (uri.contains("/favorite")) {

            String idParam = req.getParameter("userId");
            int userId = (idParam != null) ? Integer.parseInt(idParam) : user.getId();

            req.setAttribute("favorites", favoriteDAO.findByUser(userId));
            req.getRequestDispatcher("/user/Favorites.jsp").forward(req, resp);
            return;
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("/favorite")) {
            // Lấy userId từ query string
            int userId = Integer.parseInt(req.getParameter("userId"));

            // Nếu không truyền userId thì fallback về currentUser trong session
            if (userId == -1) {
                User currentUser = (User) req.getSession().getAttribute("currentUser");
                if (currentUser != null) {
                    userId = currentUser.getId();
                }
            }

            if (userId != -1) {
                // Lấy danh sách video yêu thích của user
                List<Favorite> favorites = favoriteDAO.findByUser(userId);
                req.setAttribute("favorites", favorites);
            }

            // Forward sang trang hiển thị favorites.jsp
            req.getRequestDispatcher("/user/Favorites.jsp").forward(req, resp);

        } else if (uri.contains("/profile")) {

            try {
                User currentUser = (User) req.getSession().getAttribute("user");

                if (currentUser != null) {
                    BeanUtils.populate(currentUser, req.getParameterMap());
                    userDAO.update(currentUser);
                    req.getSession().setAttribute("user", currentUser);
                    req.setAttribute("message", "Cập nhật thông tin thành công!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
            }
            req.getRequestDispatcher("/user/Profile.jsp").forward(req, resp);

        } else if (uri.contains("/user/change-password")) {

            User currentUser = (User) req.getSession().getAttribute("user");
            if (currentUser == null) {
                resp.sendRedirect(req.getContextPath() + "/auth/login");
                return;
            }

            String currentPassword = req.getParameter("currentPassword");
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            // 1) Bắt buộc đúng mật khẩu cũ mới đổi được
            if (currentPassword == null || !currentPassword.equals(currentUser.getPassword())) {
                req.setAttribute("pwError", "Mật khẩu hiện tại không đúng!");
                req.getRequestDispatcher("/user/Profile.jsp").forward(req, resp);
                return;
            }

            // 2) Validate mật khẩu mới
            if (newPassword == null || newPassword.isBlank()) {
                req.setAttribute("pwError", "Mật khẩu mới không được để trống!");
                req.getRequestDispatcher("/user/Profile.jsp").forward(req, resp);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("pwError", "Mật khẩu mới và xác nhận không khớp!");
                req.getRequestDispatcher("/user/Profile.jsp").forward(req, resp);
                return;
            }

            // (tuỳ chọn) rule đơn giản
            if (newPassword.length() < 8) {
                req.setAttribute("pwError", "Mật khẩu mới phải >= 8 ký tự!");
                req.getRequestDispatcher("/user/Profile.jsp").forward(req, resp);
                return;
            }

            // 3) Update DB + session
            currentUser.setPassword(newPassword);
            userDAO.update(currentUser);
            req.getSession().setAttribute("user", currentUser);

            req.setAttribute("pwMessage", "Đổi mật khẩu thành công!");
            req.getRequestDispatcher("/user/Profile.jsp").forward(req, resp);

        } else if (uri.contains("forgot-password")) {

            String email = req.getParameter("email");

            try {
                User user = userDAO.findByEmail(email);
                if (user == null) {
                    req.setAttribute("message", "Email không tồn tại");
                    req.getRequestDispatcher("/auth/ForgotPassword.jsp").forward(req, resp);
                    return;
                }

                // 2. Tạo OTP 6 số
                int otp = new Random().nextInt(900000) + 100000;

                // 3. Lưu OTP + user vào session
                HttpSession session = req.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("resetUser", user);

                // 4. Gửi OTP qua email
                EmailUtil.sendOTP(
                        user.getEmail(),
                        user.getFullname(),
                        otp,
                        1 // forgot password
                );

                System.out.println("ĐÃ GỬI OTP: " + otp);

                // 5. Chuyển sang trang nhập OTP
                req.getRequestDispatcher("/auth/VerifyOTP.jsp").forward(req, resp);

            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
                req.getRequestDispatcher("/auth/ForgotPassword.jsp").forward(req, resp);
            }
        } else if (uri.contains("reset-password")) {

            HttpSession session = req.getSession();
            User resetUser = (User) req.getSession().getAttribute("resetUser");
            Boolean emailVerified = (Boolean) session.getAttribute("emailVerified");
            if (resetUser == null || !emailVerified) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
                return;
            }
            String newPassword = req.getParameter("newPassword");
            try {
                resetUser.setPassword(newPassword);
                userDAO.update(resetUser);
                req.getSession().getAttribute("resetUser");
                req.setAttribute("message", "Mật khẩu đã được thay đổi");
                // Dọn session
                session.removeAttribute("resetUser");
                session.removeAttribute("emailVerified");

                resp.sendRedirect(req.getContextPath() + "/auth/Login.jsp"); // Trả về trang login
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("messange", "Báo Lỗi" + e.getMessage());
                req.getRequestDispatcher("/auth/ResetPass.jsp").forward(req, resp);
            }

        } else if (uri.contains("verify-otp")) {

            HttpSession session = req.getSession();
            Integer sessionOtp = (Integer) session.getAttribute("otp");
            User resetUser = (User) session.getAttribute("resetUser");

            int userOtp = Integer.parseInt(req.getParameter("otp"));

            if (sessionOtp == null || resetUser == null || userOtp != sessionOtp) {
                req.setAttribute("message", "OTP không đúng");
                req.getRequestDispatcher("/auth/VerifyOTP.jsp").forward(req, resp);
                return;
            }

            // OTP ĐÚNG → email đã xác thực
            session.setAttribute("emailVerified", true);
            session.removeAttribute("otp"); // XÓA OTP SAU KHI DÙNG

            req.getRequestDispatcher("/auth/ResetPass.jsp").forward(req, resp);
        }

    }
}
