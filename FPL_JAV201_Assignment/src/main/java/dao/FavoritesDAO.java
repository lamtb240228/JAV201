package dao;

import entity.Favorite;
import entity.Video;

import java.util.List;

public interface FavoritesDAO {
    void createFavorite(Favorite favorite);
    void updateFavorite(Favorite favorite);
    void deleteFavorite(Long favoriteId);
    List<Favorite> getAllFavorites();

    List<Video> findVideosWithAtLeastOneFavorite();

    List<Object[]> findUsersFavoritedVideo(String videoId);

    List<Favorite> findByUser(int userId);
    List<Favorite> findByVideo(String videoId);
    List<Video> findFavoriteVideosByUser(int userId);

    boolean isFavorite(int userId, String videoId);

}
