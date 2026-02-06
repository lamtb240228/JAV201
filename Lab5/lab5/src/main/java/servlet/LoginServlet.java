package servlet;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Lấy dữ liệu từ form
        String keyword = req.getParameter("username"); // id hoặc email
        String password = req.getParameter("password");

        // 2. Tìm user trong CSDL
        User user = userDAO.findByIdOrEmail(keyword);

        // 3. Kiểm tra đăng nhập
        if (user == null) {
            req.setAttribute("message", "Sai username hoặc email!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        if (!user.getPassword().equals(password)) {
            req.setAttribute("message", "Sai mật khẩu!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // 4. Đăng nhập thành công → lưu session
        HttpSession session = req.getSession();
        session.setAttribute("user", user);

        // 5. Chuyển sang trang chính
        resp.sendRedirect("index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
