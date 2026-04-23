package controller;

import dao.impl.VideoDAOImpl;
import entity.User;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/user/video",
        "/user/video/edit"
})
public class VideoManagementServlet extends HttpServlet {
    VideoDAOImpl dao = new VideoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/Login.jsp");
            return;
        }
        // Lấy danh sách video của user (có thể thêm paging sau)
        List<Video> videos = dao.findByUser(user.getId());
        req.setAttribute("videos", videos);
        req.setAttribute("activeTab", "list");

        if (uri.contains("/edit")) {
            String title = req.getParameter("title");
            Video video = dao.findByTitleAndUser(title, user.getId());

            if (video != null) {
                req.setAttribute("video", video);
                req.setAttribute("activeTab", "edit");
            } else {
                // Handle not found, ví dụ redirect về list
                req.setAttribute("activeTab", "list");
            }
        }
        req.getRequestDispatcher("/user/VideoManager.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/Login.jsp");
            return;
        }

        // Lấy data từ form
        String oldTitle = req.getParameter("oldTitle");
        String newTitle = req.getParameter("title");
        String description = req.getParameter("description");
        String visibility = req.getParameter("visibility");  // Mới thêm
        boolean active = "public".equals(visibility);  // Map visibility to active
        Video video = dao.findByTitleAndUser(oldTitle, user.getId());
        if (video != null) {
            video.setTitle(newTitle);
            video.setDescription(description);
            video.setActive(active);
            dao.update(video);
        }

        // Redirect về list sau update
        resp.sendRedirect(req.getContextPath() + "/user/video");
    }
}
