package controller;

import dao.impl.FavoritesDAOImpl;
import entity.Favorite;
import entity.User;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

@WebServlet({"/favorite/like", "/favorite/unlike"})
public class FavoriteServlet extends HttpServlet {

    private final FavoritesDAOImpl favoriteDAO = new FavoritesDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("message", "Vui lòng đăng nhập để thực hiện thao tác này!");
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String videoId = request.getParameter("videoId");
        if (videoId == null || videoId.trim().isEmpty()) {
            session.setAttribute("message", "Không tìm thấy video!");
            response.sendRedirect(getRedirectUrl(request));
            return;
        }

        String uri = request.getRequestURI();
        boolean isUnlike = uri.endsWith("/unlike");

        try {
            if (isUnlike) {
                // Unlike
                for (Favorite fav : favoriteDAO.findByUser(user.getId())) {
                    if (fav.getVideo() != null && videoId.equals(fav.getVideo().getId())) {
                        favoriteDAO.deleteFavorite(fav.getId());
                        session.setAttribute("message", "Đã gỡ khỏi danh sách yêu thích!");
                        break;
                    }
                }
            } else {
                // Like
                if (!favoriteDAO.isFavorite(user.getId(), videoId)) {
                    Favorite fav = new Favorite();
                    fav.setUser(user);

                    Video videoRef = new Video();
                    videoRef.setId(videoId);
                    fav.setVideo(videoRef);

                    fav.setLikeDate(new Date());
                    favoriteDAO.createFavorite(fav);

                    session.setAttribute("message", "Đã thêm vào danh sách yêu thích!");
                } else {
                    session.setAttribute("message", "Bạn đã thích video này rồi!");
                }
            }
        } catch (Exception e) {
            session.setAttribute("message", "Có lỗi xảy ra, vui lòng thử lại!");
        }

        // Quay về trang chi tiết video
        response.sendRedirect(request.getContextPath() + "/video/detail?id=" + videoId);
    }

    private String getRedirectUrl(HttpServletRequest request) {
        String referer = request.getHeader("referer");
        return referer != null ? referer : request.getContextPath() + "/home";
    }
}