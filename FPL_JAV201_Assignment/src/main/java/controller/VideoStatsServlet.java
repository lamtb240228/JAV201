package controller;

import dao.FavoritesDAO;
import dao.impl.FavoritesDAOImpl;
import dao.impl.VideoDAOImpl;
import entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.XJPA;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/video/stats")
public class VideoStatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VideoDAOImpl videoDao = new VideoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        FavoritesDAOImpl favoritesDAO = new FavoritesDAOImpl();
        Map<String, Long> stats = favoritesDAO.getVideoFavoriteStats();
        List<Video> videos = videoDao.findAll();

        req.setAttribute("videos", videos);
        req.setAttribute("stats", stats);

        List<Video> videosWithFavorite = favoritesDAO.findVideosWithAtLeastOneFavorite();
        req.setAttribute("videosWithFavorite", videosWithFavorite);


        String selectedVideoId = req.getParameter("videoId");
        if (selectedVideoId != null && !selectedVideoId.trim().isEmpty()) {
            List<Object[]> favoriteUsers = favoritesDAO.findUsersFavoritedVideo(selectedVideoId);
            req.setAttribute("favoriteUsers", favoriteUsers);
            req.setAttribute("selectedVideoId", selectedVideoId);  // để giữ giá trị đã chọn
        }

        // ────────────────────────────────────────────────────────────────

        req.getRequestDispatcher("/page/VideoStats.jsp").forward(req, resp);
    }
}