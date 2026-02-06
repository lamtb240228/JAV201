package servlet;

import dao.UserDAO;
import dao.VideoDAO;
import dao.FavoriteDAO;
import dao.ShareDAO;
import dao.impl.UserDAOImpl;
import dao.impl.VideoDAOImpl;
import dao.impl.FavoriteDAOImpl;
import dao.impl.ShareDAOImpl;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({
        "/admin/video",
        "/admin/user",
        "/admin/like",
        "/admin/share"
})
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();
    private VideoDAO videoDAO = new VideoDAOImpl();
    private FavoriteDAO favoriteDAO = new FavoriteDAOImpl();
    private ShareDAO shareDAO = new ShareDAOImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ===== 1. KIỂM TRA LOGIN + QUYỀN ADMIN =====
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !Boolean.TRUE.equals(user.getAdmin())) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ===== 2. PHÂN LUỒNG THEO URL =====
        String uri = req.getRequestURI();

        if (uri.contains("/admin/video")) {
            manageVideo(req, resp);
        } else if (uri.contains("/admin/user")) {
            manageUser(req, resp);
        } else if (uri.contains("/admin/like")) {
            manageLike(req, resp);
        } else if (uri.contains("/admin/share")) {
            manageShare(req, resp);
        }
    }

    // ================= QUẢN LÝ VIDEO =================
    private void manageVideo(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("videos", videoDAO.findAll());
        req.setAttribute("message", "Trang quản lý VIDEO (ADMIN)");
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }

    // ================= QUẢN LÝ USER =================
    private void manageUser(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("users", userDAO.findAll());
        req.setAttribute("message", "Trang quản lý USER (ADMIN)");
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }

    // ================= QUẢN LÝ LIKE =================
    private void manageLike(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("likes", favoriteDAO.findAll());
        req.setAttribute("message", "Trang quản lý LIKE (ADMIN)");
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }

    // ================= QUẢN LÝ SHARE =================
    private void manageShare(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("shares", shareDAO.findAll());
        req.setAttribute("message", "Trang quản lý SHARE (ADMIN)");
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }
}
