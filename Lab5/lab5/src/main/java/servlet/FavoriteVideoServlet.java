package servlet;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/favorite-videos")
public class FavoriteVideoServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String userId = req.getParameter("id");

        User user = userDAO.findById(userId);

        req.setAttribute("user", user);

        req.getRequestDispatcher("/favorite.jsp").forward(req, resp);
    }
}

