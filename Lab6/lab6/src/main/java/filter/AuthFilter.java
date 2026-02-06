package filter;

import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter({
        "/admin/*",
        "/account/change-password",
        "/account/edit-profile",
        "/video/like/*",
        "/video/share/*"
})
public class AuthFilter implements Filter {

    public static final String SECURITY_URI = "securityUri";

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        String context = req.getContextPath();

        // ⭐ LẤY URI KHÔNG BAO GỒM CONTEXT PATH
        String uri = req.getRequestURI().substring(context.length());

        // ===== 1. CHƯA LOGIN =====
        if (user == null) {
            session.setAttribute(SECURITY_URI, uri); // lưu: /video/like/abc
            resp.sendRedirect(context + "/login");
            return;
        }

        // ===== 2. KHÔNG PHẢI ADMIN NHƯNG VÀO /admin =====
        if (uri.startsWith("/admin") && !Boolean.TRUE.equals(user.getAdmin())) {
            resp.sendRedirect(context + "/index.jsp");
            return;
        }

        // ===== 3. HỢP LỆ =====
        chain.doFilter(request, response);
    }
}
