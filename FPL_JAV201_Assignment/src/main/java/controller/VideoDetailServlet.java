package controller;

import dao.impl.FavoritesDAOImpl; // ← thêm dòng này
import dao.impl.VideoDAOImpl;
import entity.User; // ← thêm dòng này
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/video/detail")
public class VideoDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VideoDAOImpl dao = new VideoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");
        Video video = (id != null) ? dao.findById(id) : dao.findAll().get(0);

        if (video != null) {

            // lưu video vào danh sách đã xem (session)
            @SuppressWarnings("unchecked")
            List<Video> watched = (List<Video>) req.getSession().getAttribute("watchedVideos");

            if (watched == null) {
                watched = new ArrayList<>();
            }
            if (!watched.contains(video)) {
                watched.add(video);
            }
            req.getSession().setAttribute("watchedVideos", watched);

            req.setAttribute("videoDetail", video);

            User currentUser = (User) req.getSession().getAttribute("user");
            boolean isFavorite = false;

            if (currentUser != null && video != null) {
                FavoritesDAOImpl favoriteDAO = new FavoritesDAOImpl();
                isFavorite = favoriteDAO.isFavorite(currentUser.getId(), video.getId());
            }

            req.setAttribute("isFavorite", isFavorite);
            req.getRequestDispatcher("/page/VideoDetail.jsp").forward(req, resp);
        } else {
            req.setAttribute("message", "Không tìm thấy video!");
            req.getRequestDispatcher("/page/VideoDetail.jsp").forward(req, resp);
        }
    }

}