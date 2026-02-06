package filter;

import dao.LogDAO;
import dao.impl.LogDAOImpl;
import entity.Log;
import entity.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.util.Date;

@WebFilter("/*") // lọc tất cả request
public class AppFilter implements Filter {

    private LogDAO logDAO = new LogDAOImpl();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // 1. UTF-8 cho toàn hệ thống
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpServletRequest req = (HttpServletRequest) request;

        // 2. Lấy user trong session (nếu đã đăng nhập)
        User user = (User) req.getSession().getAttribute("user");
        String username = (user != null) ? user.getId() : null;

        // 3. Tạo log
        Log log = new Log(
                req.getRequestURI(),
                new Date(),
                username
        );

        // 4. Lưu vào DB
        logDAO.create(log);

        // 5. Cho request đi tiếp
        chain.doFilter(request, response);
    }
}
