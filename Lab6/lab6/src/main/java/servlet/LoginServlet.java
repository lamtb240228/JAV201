package servlet;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import util.HashUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.findByIdOrEmail(keyword);

        // ===== 1. KIỂM TRA USER =====
        if (user == null) {
            req.setAttribute("message", "Sai username hoặc email!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // ===== 2. SO SÁNH PASSWORD ĐÃ HASH =====
        String hashedInput = HashUtil.hash(password);
        if (!hashedInput.equals(user.getPassword())) {
            req.setAttribute("message", "Sai mật khẩu!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // ===== 3. LẤY securityUri TRƯỚC KHI HỦY SESSION =====
        HttpSession oldSession = req.getSession(false);
        String securityUri = null;
        if (oldSession != null) {
            securityUri = (String) oldSession.getAttribute("securityUri");
            oldSession.invalidate(); // chống session fixation
        }

        // ===== 4. TẠO SESSION MỚI =====
        HttpSession session = req.getSession(true);
        session.setAttribute("user", user);
        session.setMaxInactiveInterval(30 * 60); // 30 phút

        // ===== 5. QUAY LẠI TRANG TRƯỚC LOGIN =====
        if (securityUri != null) {
            resp.sendRedirect(req.getContextPath() + securityUri);

        } else {
            resp.sendRedirect(req.getContextPath() + "/video/list");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
