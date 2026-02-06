package dao.impl;

import dao.FavoriteDAO;
import entity.Favorite;
import entity.Video;
import utils.JpaUtil;

import jakarta.persistence.EntityManager;
import java.util.List;

public class FavoriteDAOImpl implements FavoriteDAO {

    @Override
    public List<Favorite> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT f FROM Favorite f", Favorite.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Favorite findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Favorite.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Favorite f) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(f);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void update(Favorite f) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(f);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void deleteById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        Favorite f = em.find(Favorite.class, id);
        if (f != null) em.remove(f);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public List<Object[]> top10FavoriteVideos() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql =
                    "SELECT f.video, COUNT(f) " +
                            "FROM Favorite f " +
                            "GROUP BY f.video " +
                            "ORDER BY COUNT(f) DESC";

            return em.createQuery(jpql, Object[].class)
                    .setMaxResults(10)
                    .getResultList();
        } finally {
            em.close();
        }
    }
    @Override
    public List<Video> findVideosNotFavorited() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql =
                    "SELECT v FROM Video v " +
                            "WHERE v NOT IN (" +
                            "SELECT f.video FROM Favorite f" +
                            ")";
            return em.createQuery(jpql, Video.class).getResultList();
        } finally {
            em.close();
        }
    }
}
