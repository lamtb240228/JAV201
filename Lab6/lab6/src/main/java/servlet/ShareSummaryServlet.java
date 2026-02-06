package servlet;

import dao.ShareDAO;
import dao.impl.ShareDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/share-summary")
public class ShareSummaryServlet extends HttpServlet {

    private final ShareDAO dao = new ShareDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("list", dao.shareSummaryByVideo());
        req.getRequestDispatcher("/share-summary.jsp").forward(req, resp);
    }
}
