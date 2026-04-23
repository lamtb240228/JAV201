package dao;

import model.Category;
import util.HibernateUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class CategoryDAO {

    public List<Category> getAllCategories() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Category> query = em.createQuery("SELECT c FROM Category c", Category.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Category getCategoryById(int id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }
}