package dao.impl;

import dao.VideoDAO;
import entity.Video;
import utils.JpaUtil;

import jakarta.persistence.EntityManager;
import java.util.List;

public class VideoDAOImpl implements VideoDAO {

    @Override
    public List<Video> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        return em.createQuery("SELECT v FROM Video v", Video.class).getResultList();
    }

    @Override
    public Video findById(String id) {
        EntityManager em = JpaUtil.getEntityManager();
        return em.find(Video.class, id);
    }

    @Override
    public void create(Video v) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(v);
        em.getTransaction().commit();
    }

    @Override
    public void update(Video v) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(v);
        em.getTransaction().commit();
    }

    @Override
    public void deleteById(String id) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        Video v = em.find(Video.class, id);
        if (v != null) em.remove(v);
        em.getTransaction().commit();
    }
    @Override
    public List<Video> findByTitleContaining(String keyword) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql =
                    "SELECT DISTINCT v FROM Video v " +
                            "LEFT JOIN FETCH v.favorites " +
                            "WHERE v.title LIKE :kw";

            return em.createQuery(jpql, Video.class)
                    .setParameter("kw", "%" + keyword + "%")
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
