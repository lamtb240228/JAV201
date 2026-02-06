package listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.io.*;

@WebListener
public class AppListener implements ServletContextListener, HttpSessionListener {

    private int visitors = 0;

    // Khi server start
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext app = sce.getServletContext();
        String path = app.getRealPath("/WEB-INF/visitors.txt");
        File file = new File(path);

        try {
            if (!file.exists()) {
                file.createNewFile();
                try (PrintWriter pw = new PrintWriter(file)) {
                    pw.print(0);
                }
            }

            BufferedReader br = new BufferedReader(new FileReader(file));
            visitors = Integer.parseInt(br.readLine());
            br.close();

        } catch (Exception e) {
            visitors = 0;
        }

        app.setAttribute("visitors", visitors);
        System.out.println("Visitors loaded = " + visitors);
    }

    // Khi có người dùng mới
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        visitors++;
        ServletContext app = se.getSession().getServletContext();
        app.setAttribute("visitors", visitors);
        System.out.println("Visitor +1 = " + visitors);
    }

    // Khi server tắt
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext app = sce.getServletContext();
        String path = app.getRealPath("/WEB-INF/visitors.txt");

        try (PrintWriter pw = new PrintWriter(new FileWriter(path))) {
            pw.print(visitors);
        } catch (Exception ignored) {}
    }
}
