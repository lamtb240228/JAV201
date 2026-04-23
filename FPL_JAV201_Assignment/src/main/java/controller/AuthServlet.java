package controller;

import dao.impl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet({
        "/auth",
        "/auth/login",
        "/auth/Login",
        "/auth/Register",
        "/auth/register",
        "/logout"
})
public class AuthServlet extends HttpServlet {

    private UserDAOImpl userDAO = new UserDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if ( uri.toLowerCase().contains("register") ) {
            req.getRequestDispatcher("/auth/Register.jsp").forward(req, resp);
        }
        if ( uri.toLowerCase().contains("login") ) {
            req.getRequestDispatcher("/auth/Login.jsp").forward(req, resp);
        }

        if ( uri.toLowerCase().contains("logout") ) {
            HttpSession session = req.getSession();

            // 2. Xóa sạch mọi dữ liệu trong session (bao gồm "user" và "securityUri")
            session.invalidate();

            // 3. Điều hướng người dùng về trang chủ hoặc trang đăng nhập
            resp.sendRedirect(req.getContextPath() + "/auth/Login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if ( uri.toLowerCase().contains("register") ) {

            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            // kiểm tra email/id đã tồn tại chưa
            User existing = userDAO.findByEmail(email);

            if (existing != null) {
                req.setAttribute("error", "User ID hoặc Email đã tồn tại!");
                req.getRequestDispatcher("/auth/Register.jsp").forward(req, resp);
                return;
            }

            // tạo user mới
            User user = new User();
            user.setFullname(fullname);
            user.setEmail(email);
            user.setPassword(password);
            user.setAdmin(false);

            userDAO.create(user);

            req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/auth/Register.jsp").forward(req, resp);
            return;

        }

        if ( uri.toLowerCase().contains("login") ) {
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            User existing = userDAO.findByEmail(email);

            if (existing == null) {
                req.setAttribute("error", "Email không tồn tại!");
                req.getRequestDispatcher("/auth/Login.jsp").forward(req, resp);
                return;
            }
            if (!password.equals(existing.getPassword())) {
                req.setAttribute("error", "Sai mật khẩu!");
                req.getRequestDispatcher("/auth/Login.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession();
            session.setAttribute("user", existing);

            if (existing.getAdmin() == true) {
                resp.sendRedirect(req.getContextPath() + "/admin/admin") ;
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        }


    }

}
