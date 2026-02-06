package servlet;

import dao.FavoriteDAO;
import dao.impl.FavoriteDAOImpl;
import entity.Favorite;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/favorite-list")
public class FavoriteListServlet extends HttpServlet {

    private FavoriteDAO dao = new FavoriteDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Favorite> favorites = dao.findAll();

        req.setAttribute("favorites", favorites);

        req.getRequestDispatcher("/favorite-list.jsp").forward(req, resp);
    }
}
