package filter;

import jakarta.servlet.*;
import java.io.IOException;

public class Filter2 implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        System.out.println("Filter2 nhận: " + req.getAttribute("hello"));

        chain.doFilter(req, res);
    }
}
