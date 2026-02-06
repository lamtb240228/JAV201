package dao.impl;

import dao.UserDAO;
import entity.User;
import utils.JpaUtil;

import jakarta.persistence.EntityManager;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    @Override
    public List<User> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    public User findById(String id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql =
                    "SELECT DISTINCT u FROM User u " +
                            "LEFT JOIN FETCH u.favorites f " +
                            "LEFT JOIN FETCH f.video " +
                            "WHERE u.id = :id";

            List<User> list = em.createQuery(jpql, User.class)
                    .setParameter("id", id)
                    .getResultList();

            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(User user) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
    }

    @Override
    public void update(User user) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(user);
        em.getTransaction().commit();
    }

    @Override
    public void deleteById(String id) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        User u = em.find(User.class, id);
        if (u != null) em.remove(u);
        em.getTransaction().commit();
    }
    @Override
    public User findByIdOrEmail(String keyword) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.id = :kw OR u.email = :kw";
            return em.createQuery(jpql, User.class)
                    .setParameter("kw", keyword)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            em.close();
        }
    }
}
