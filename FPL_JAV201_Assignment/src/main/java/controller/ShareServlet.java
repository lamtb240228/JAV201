package controller;

import dao.impl.ShareDAOImpl;
import entity.Share;
import entity.User;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.EmailUtil;

import java.io.IOException;
import java.util.Date;

@WebServlet("/share")
public class ShareServlet extends HttpServlet {

    private final ShareDAOImpl shareDAO = new ShareDAOImpl();
    private final EmailUtil emailSender = new EmailUtil();  // dùng class gửi mail của bạn

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("message", "Vui lòng đăng nhập để chia sẻ video!");
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String videoId = request.getParameter("videoId");
        String toEmail = request.getParameter("toEmail");

        if (videoId == null || toEmail == null || toEmail.trim().isEmpty()) {
            session.setAttribute("message", "Thiếu thông tin video hoặc email!");
            response.sendRedirect(getRedirectUrl(request));
            return;
        }


        String videoLink = request.getScheme() + "://" + request.getServerName() + ":" +
                request.getServerPort() + request.getContextPath() +
                "/video/detail?id=" + videoId;


        String videoTitle = request.getParameter("videoTitle");
        String videoPoster = request.getParameter("videoPoster");

        try {

            emailSender.sendVideoShare(toEmail, user.getFullname(), videoLink, videoTitle, videoPoster);


            Share share = new Share();
            share.setUser(user);

            Video videoRef = new Video();
            videoRef.setId(videoId);
            share.setVideo(videoRef);

            share.setEmails(toEmail);
            share.setShareDate(new Date());

            shareDAO.create(share);

            session.setAttribute("message", "Đã gửi link video thành công!");
        } catch (Exception e) {
            session.setAttribute("message", "Gửi email thất bại: " + e.getMessage());
            e.printStackTrace();
        }


        response.sendRedirect(request.getContextPath() + "/video/detail?id=" + videoId);
    }

    private String getRedirectUrl(HttpServletRequest request) {
        String referer = request.getHeader("referer");
        return referer != null ? referer : request.getContextPath() + "/home";
    }
}