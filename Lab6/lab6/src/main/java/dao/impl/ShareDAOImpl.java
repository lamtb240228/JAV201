package dao.impl;

import dao.ShareDAO;
import entity.Share;
import utils.JpaUtil;

import jakarta.persistence.EntityManager;
import java.util.List;

public class ShareDAOImpl implements ShareDAO {

    @Override
    public List<Share> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        return em.createQuery("SELECT s FROM Share s", Share.class).getResultList();
    }

    @Override
    public Share findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        return em.find(Share.class, id);
    }

    @Override
    public void create(Share s) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(s);
        em.getTransaction().commit();
    }

    @Override
    public void update(Share s) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(s);
        em.getTransaction().commit();
    }

    @Override
    public void deleteById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        Share s = em.find(Share.class, id);
        if (s != null) em.remove(s);
        em.getTransaction().commit();
    }
    // ✅ METHOD 1
    @Override
    public List<Share> findByYear(int year) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql =
                    "SELECT s FROM Share s " +
                            "WHERE YEAR(s.shareDate) = :y " +
                            "ORDER BY s.shareDate ASC";

            return em.createQuery(jpql, Share.class)
                    .setParameter("y", year)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Object[]> shareSummaryByVideo() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql =
                    "SELECT v.title, COUNT(s), MIN(s.shareDate), MAX(s.shareDate) " +
                            "FROM Share s JOIN s.video v " +
                            "GROUP BY v.title";

            return em.createQuery(jpql, Object[].class).getResultList();
        } finally {
            em.close();
        }
    }
}
