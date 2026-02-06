package dao;

import entity.Favorite;
import entity.Video;

import java.util.List;

public interface FavoriteDAO extends GenericDAO<Favorite, Long> {
    List<Object[]> top10FavoriteVideos();
    List<Video> findVideosNotFavorited();

}
