package filter;

import jakarta.servlet.*;
import java.io.IOException;

public class Filter1 implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        req.setAttribute("hello", "Tôi là filter 1");
        System.out.println("Filter1 chạy");

        chain.doFilter(req, res);
    }
}
