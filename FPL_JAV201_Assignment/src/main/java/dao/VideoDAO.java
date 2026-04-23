package dao;

import entity.Video;
import java.util.List;

public interface VideoDAO {
    List<Video> findAll();
    List<Video> findAll(int page, int pageSize);

    List<Video> findByViewsDesc(int page, int pageSize);

    List<Video> findTrending(int page, int pageSize);

    Video findById(String id);

    Video findByTitle(String title);

    void create(Video entity);

    void update(Video entity);

    void delete(String id);

    long countAll();

    long countTrending();

    // Lấy danh sách video của 1 user
    List<Video> findByUser(int userId);

    // Lấy danh sách video của user (phân trang)
    List<Video> findByUser(int userId, int page, int pageSize);

    // Tìm video theo title + user (dùng cho Edit)
    Video findByTitleAndUser(String title, int userId);

    // Đếm tổng video của user
    long countByUser(int userId);

    Video findByIdforUser(String id, int userId);
    // Thêm vào VideoDAO.java
    List<Video> findTopViews(int limit);
}
