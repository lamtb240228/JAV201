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


@WebServlet
public class VideoViewServlet  extends HttpServlet {
    VideoDAOImpl dao = new VideoDAOImpl();
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("user");
        int userId = (currentUser != null) ? currentUser.getId() : -1;  // Guest = -1

        Video video = dao.findByIdforUser(req.getParameter("id"), userId);
        if (video == null) {
            // Redirect hoặc error: "Video riêng tư, chỉ owner xem được"
            req.setAttribute("error", "Bạn không có quyền xem video này.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
            return;
        }
// Tiếp tục display video
    }
}
