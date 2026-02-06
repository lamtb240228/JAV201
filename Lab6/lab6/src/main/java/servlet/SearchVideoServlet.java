package servlet;

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

@WebServlet("/search-video")
public class SearchVideoServlet extends HttpServlet {

    private VideoDAO videoDAO = new VideoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String keyword = req.getParameter("keyword");

        List<Video> list = videoDAO.findByTitleContaining(keyword);

        req.setAttribute("videos", list);
        req.setAttribute("keyword", keyword);

        req.getRequestDispatcher("/search.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
