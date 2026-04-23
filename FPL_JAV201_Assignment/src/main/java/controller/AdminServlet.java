package controller;

import dao.impl.UserDAOImpl;
import dao.impl.VideoDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({ "/admin/user", "/admin/admin" })
public class AdminServlet extends HttpServlet {
    private UserDAOImpl userDAO = new UserDAOImpl();
    private VideoDAOImpl videoDAO = new VideoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/user")) {

            String action = req.getParameter("action");
            // Luôn gửi danh sách user mới nhất qua
            req.setAttribute("users", userDAO.findAll());

            req.getRequestDispatcher("/admin/User.jsp").forward(req, resp);
            return;
        }
        if (uri.contains("/admin")) {
            req.setAttribute("totalUsers", userDAO.findAll().size());
            req.setAttribute("totalVideos", videoDAO.findAll().size());
            req.setAttribute("topVideos", videoDAO.findTopViews(5));

            req.getRequestDispatcher("/admin/Admin.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String action = req.getParameter("action");
        String idRaw = req.getParameter("id");

        if (idRaw != null && !idRaw.isEmpty()) {
            int id = Integer.parseInt(idRaw);

            if ("update".equals(action)) {
                String fullname = req.getParameter("fullname");
                String email = req.getParameter("email");
                // Nhận giá trị admin từ Radio Button (true/false)
                boolean isAdmin = Boolean.parseBoolean(req.getParameter("admin"));

                User user = userDAO.findById(id);
                if (user != null) {
                    user.setFullname(fullname);
                    user.setEmail(email);
                    user.setAdmin(isAdmin); // Cập nhật vai trò
                    userDAO.update(user);
                }
            } else if ("delete".equals(action)) {
                userDAO.delete(id);
            }
        }

        // Sau khi xử lý xong, redirect về lại trang list để tránh "Double Submit" (ấn
        // F5 bị gửi lại yêu cầu)
        resp.sendRedirect(req.getContextPath() + "/admin/user");
    }
}