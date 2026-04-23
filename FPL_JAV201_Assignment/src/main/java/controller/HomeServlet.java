package controller;

import dao.VideoDAO;
import dao.impl.VideoDAOImpl;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private VideoDAO dao = new VideoDAOImpl();
    private static final int PAGE_SIZE = 20;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            System.out.println("HomeServlet: Bắt đầu xử lý request");

            String filter = req.getParameter("filter");
            int page = 1;
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (Exception e) {
                // ignore
            }

            List<Video> videos;
            long totalVideos;

            System.out.println("Filter: " + filter + ", Page: " + page);

            if ("views".equals(filter)) {
                videos = dao.findByViewsDesc(page, PAGE_SIZE);
                totalVideos = dao.countAll();
                req.setAttribute("currentFilter", "views");
            } else if ("trending".equals(filter)) {
                videos = dao.findTrending(page, PAGE_SIZE);
                totalVideos = dao.countTrending();
                req.setAttribute("currentFilter", "trending");
            } else {
                videos = dao.findAll(page, PAGE_SIZE);
                totalVideos = dao.countAll();
                req.setAttribute("currentFilter", "default");
            }

            int totalPages = (int) Math.ceil((double) totalVideos / PAGE_SIZE);
            req.setAttribute("videos", videos);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.getRequestDispatcher("/page/Home.jsp").forward(req, resp);

        } catch (Exception e) {
            System.err.println("LỖI trong HomeServlet: " + e.getClass().getName());
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }
}