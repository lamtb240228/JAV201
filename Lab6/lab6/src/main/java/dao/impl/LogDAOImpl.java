package dao.impl;

import dao.LogDAO;
import entity.Log;
import utils.JpaUtil;

import jakarta.persistence.EntityManager;

public class LogDAOImpl implements LogDAO {

    @Override
    public void create(Log log) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(log);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
