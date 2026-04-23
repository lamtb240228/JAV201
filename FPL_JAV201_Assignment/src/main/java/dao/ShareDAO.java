package dao;

import entity.Share;
import java.util.List;

public interface ShareDAO {
    void create(Share share);
    List<Share> findByUser(int userId);
    List<Share> findByVideo(String videoId);
}