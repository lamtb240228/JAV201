package dao.impl;

import dao.UserDAO;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import util.XJPA;

import java.util.List;

public class UserDAOImpl implements UserDAO {

    @Override
    public List<User> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "select u from User u";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public User findById(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public User findByEmail(String email) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "select u from User u where u.email = :email";
            List<User> list = em.createQuery(jpql, User.class)
                    .setParameter("email", email)
                    .getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(User entity) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(User entity) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            User entity = em.find(User.class, id);
            em.remove(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public User findByIdOrEmail(String input) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.id = :input OR u.email = :input";
            List<User> list = em.createQuery(jpql, User.class)
                    .setParameter("input", input)
                    .getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }
}