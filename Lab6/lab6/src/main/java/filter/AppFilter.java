package filter;

import dao.LogDAO;
import dao.impl.LogDAOImpl;
import entity.Log;
import entity.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

@WebFilter("/*") // lọc tất cả request
public class AppFilter implements Filter {

    private LogDAO logDAO = new LogDAOImpl();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // ===== 1. LẤY USER TỪ SESSION =====
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // ===== 2. CÁC URL KHÔNG CẦN LOGIN =====
        boolean publicPage = uri.contains("login")
                || uri.contains("sign-up")
                || uri.contains("page.jsp")
                || uri.contains("/css/")
                || uri.contains("/js/")
                || uri.contains("/images/");

        // ===== 3. CHẶN CHƯA LOGIN =====
        if (user == null && !publicPage) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // ===== 4. PHÂN QUYỀN ADMIN =====
        if (uri.startsWith(req.getContextPath() + "/admin")) {
            if (user == null || !user.getAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/page.jsp");
                return;
            }
        }

        // ===== 5. GHI LOG =====
        String username = (user != null) ? user.getId() : "Guest";

        Log log = new Log(
                req.getRequestURI(),
                new Date(),
                username
        );

        logDAO.create(log);

        // ===== 6. CHO ĐI TIẾP =====
        chain.doFilter(request, response);
    }

}
