package servlet;

import dao.VideoDAO;
import dao.FavoriteDAO;
import dao.ShareDAO;
import dao.impl.VideoDAOImpl;
import dao.impl.FavoriteDAOImpl;
import dao.impl.ShareDAOImpl;
import entity.User;
import entity.Video;
import entity.Favorite;
import entity.Share;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({
        "/video/list",
        "/video/detail/*",
        "/video/like/*",
        "/video/share/*"
})
public class VideoServlet extends HttpServlet {

    private VideoDAO videoDAO = new VideoDAOImpl();
    private FavoriteDAO favoriteDAO = new FavoriteDAOImpl();
    private ShareDAO shareDAO = new ShareDAOImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("list")) {
            listVideo(req, resp);
        } else if (uri.contains("detail")) {
            detailVideo(req, resp);
        } else if (uri.contains("like")) {
            likeVideo(req, resp);
        } else if (uri.contains("share")) {
            shareVideo(req, resp);
        }
    }

    // ================= DANH SÁCH VIDEO =================
    private void listVideo(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("videos", videoDAO.findAll());
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }

    // ================= CHI TIẾT VIDEO =================
    private void detailVideo(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getPathInfo().substring(1); // /detail/ID
        Video video = videoDAO.findById(id);

        req.setAttribute("video", video);
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }

    // ================= LIKE VIDEO =================
    private void likeVideo(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String videoId = req.getPathInfo().substring(1);
        Video video = videoDAO.findById(videoId);

        Favorite fav = new Favorite();
        fav.setUser(user);
        fav.setVideo(video);

        favoriteDAO.create(fav);

        req.setAttribute("message", "Đã like video!");
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }

    // ================= SHARE VIDEO =================
    private void shareVideo(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String videoId = req.getPathInfo().substring(1);
        String email = req.getParameter("email");

        Video video = videoDAO.findById(videoId);

        Share share = new Share();
        share.setUser(user);
        share.setVideo(video);
        share.setEmails(email);
        share.setShareDate(new java.util.Date());

        shareDAO.create(share);

        req.setAttribute("message", "Đã share video!");
        req.getRequestDispatcher("/page.jsp").forward(req, resp);
    }
}
