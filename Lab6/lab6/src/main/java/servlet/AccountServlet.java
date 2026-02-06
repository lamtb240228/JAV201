package servlet;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.HashUtil;

import java.io.IOException;

@WebServlet({
        "/account/sign-up",
        "/account/change-password",
        "/account/edit-profile"
})
public class AccountServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("sign-up")) {
            signUp(req, resp);
        } else if (uri.contains("change-password")) {
            changePassword(req, resp);
        } else if (uri.contains("edit-profile")) {
            editProfile(req, resp);
        }
    }

    // ================= SIGN UP =================
    private void signUp(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (req.getMethod().equalsIgnoreCase("GET")) {
            req.getRequestDispatcher("/page.jsp").forward(req, resp);
            return;
        }

        String id = req.getParameter("id");
        String email = req.getParameter("email");
        String password = HashUtil.hash(req.getParameter("password"));
        String fullname = req.getParameter("fullname");

        if (userDAO.findById(id) != null) {
            req.setAttribute("message", "User đã tồn tại!");
            req.getRequestDispatcher("/page.jsp").forward(req, resp);
            return;
        }

        User u = new User();
        u.setId(id);
        u.setEmail(email);
        u.setPassword(password);
        u.setFullname(fullname);
        u.setAdmin(false);

        userDAO.create(u);

        req.setAttribute("message", "Đăng ký thành công!");
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }

    // ================= CHANGE PASSWORD =================
    private void changePassword(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 👉 Nếu GET → chỉ mở form
        if (req.getMethod().equalsIgnoreCase("GET")) {
            req.getRequestDispatcher("/page.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String oldRaw = req.getParameter("oldPassword");
        String newRaw = req.getParameter("newPassword");

        // 🛑 CHẶN NULL
        if (oldRaw == null || newRaw == null ||
                oldRaw.isEmpty() || newRaw.isEmpty()) {

            req.setAttribute("message", "Vui lòng nhập đủ thông tin!");
            req.getRequestDispatcher("/page.jsp").forward(req, resp);
            return;
        }

        String oldPass = HashUtil.hash(oldRaw);
        String newPass = HashUtil.hash(newRaw);

        if (!user.getPassword().equals(oldPass)) {
            req.setAttribute("message", "Sai mật khẩu cũ!");
            req.getRequestDispatcher("/page.jsp").forward(req, resp);
            return;
        }

        user.setPassword(newPass);
        userDAO.update(user);

        req.setAttribute("message", "Đổi mật khẩu thành công!");
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }



    // ================= EDIT PROFILE =================
    private void editProfile(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 🔥 Lấy user từ DB lại để tránh dữ liệu session bị null
        User user = userDAO.findById(sessionUser.getId());

        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");

        if (fullname == null || fullname.trim().isEmpty()
                || email == null || email.trim().isEmpty()) {

            req.setAttribute("message", "Không được để trống thông tin!");
            req.getRequestDispatcher("/page.jsp").forward(req, resp);
            return;
        }

        user.setFullname(fullname);
        user.setEmail(email);

        userDAO.update(user);

        // cập nhật lại session
        session.setAttribute("user", user);

        req.setAttribute("message", "Cập nhật thành công!");
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }

}
