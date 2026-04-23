package dao.impl;


import util.XJPA;
import dao.FavoritesDAO;
import entity.Favorite;
import entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FavoritesDAOImpl implements FavoritesDAO {
    EntityManager em = XJPA.getEntityManager();

    @Override
    public void createFavorite(Favorite favorite) {
        try {
            em.getTransaction().begin();
            em.persist(favorite);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }

    }

    @Override
    public void updateFavorite(Favorite favorite) {
        try {
            em.getTransaction().begin();
            em.merge(favorite);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }

    }

    @Override
    public void deleteFavorite(Long favoriteId) {
        try {
            em.getTransaction().begin();
            Favorite favorite = em.find(Favorite.class, favoriteId);
            em.remove(favorite);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }

    }

    @Override
    public List<Favorite> getAllFavorites() {
        String jpql = "SELECT f FROM Favorite f";
        return em.createQuery(jpql, Favorite.class).getResultList();
    }

    @Override
    public List<Favorite> findByUser(int userId) {
        String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :uid";
        TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
        query.setParameter("uid", userId);
        return query.getResultList();
    }

    @Override
    public List<Favorite> findByVideo(String videoId) {
        String jpql = "SELECT f FROM Favorite f WHERE f.video.id = :vid";
        return em.createQuery(jpql, Favorite.class)
                .setParameter("vid", videoId)
                .getResultList();
    }

    @Override
    public List<Video> findFavoriteVideosByUser(int userId) {
        String jpql = "SELECT f.video FROM Favorite f WHERE f.user.id = :userId";
        return em.createQuery(jpql, Video.class)
                .setParameter("userId", userId)
                .getResultList();
    }
    // Method bổ sung rất cần cho chức năng toggle Like / Unlike
    @Override
    public boolean isFavorite(int userId, String videoId) {
        TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(f) FROM Favorite f " +
                        "WHERE f.user.id = :userId AND f.video.id = :videoId",
                Long.class
        );
        query.setParameter("userId", userId);
        query.setParameter("videoId", videoId);
        return query.getSingleResult() > 0;
    }
    public Map<String, Long> getVideoFavoriteStats() {
        EntityManager em = XJPA.getEntityManager();
        String jpql = "SELECT f.video.id, COUNT(DISTINCT f.user.id) " +
                "FROM Favorite f GROUP BY f.video.id";
        List<Object[]> results = em.createQuery(jpql, Object[].class).getResultList();

        Map<String, Long> stats = new HashMap<>();
        for (Object[] row : results) {
            String videoId = (String) row[0];
            Long count = (Long) row[1];
            stats.put(videoId, count);
        }
        return stats;
    }
    @Override
    public List<Video> findVideosWithAtLeastOneFavorite() {
        String jpql = "SELECT DISTINCT f.video FROM Favorite f ORDER BY f.video.title";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        return query.getResultList();
    }

    @Override
    public List<Object[]> findUsersFavoritedVideo(String videoId) {
        String jpql = "SELECT u.id, u.fullname, u.email, f.likeDate " +
                "FROM Favorite f JOIN f.user u " +
                "WHERE f.video.id = :videoId " +
                "ORDER BY f.likeDate DESC";
        TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
        query.setParameter("videoId", videoId);
        return query.getResultList();
    }
}

