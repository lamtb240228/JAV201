package dao.impl;

import dao.ShareDAO;
import entity.Share;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import util.XJPA;

import java.util.List;

public class ShareDAOImpl implements ShareDAO {

    private EntityManager em = XJPA.getEntityManager();

    @Override
    public void create(Share share) {
        try {
            em.getTransaction().begin();
            em.persist(share);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public List<Share> findByUser(int userId) {
        TypedQuery<Share> query = em.createQuery(
                "SELECT s FROM Share s WHERE s.user.id = :userId", Share.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    @Override
    public List<Share> findByVideo(String videoId) {
        TypedQuery<Share> query = em.createQuery(
                "SELECT s FROM Share s WHERE s.video.id = :videoId", Share.class);
        query.setParameter("videoId", videoId);
        return query.getResultList();
    }
}