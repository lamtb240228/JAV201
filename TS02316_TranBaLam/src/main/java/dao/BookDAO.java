package dao;

import model.Book;
import util.HibernateUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class BookDAO {

    public List<Book> getAllBooks() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Book> query = em.createQuery("SELECT b FROM Book b JOIN FETCH b.category", Book.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Book getBookById(int id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(Book.class, id);
        } finally {
            em.close();
        }
    }

    public void saveOrUpdate(Book book) {
        EntityManager em = HibernateUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            if (book.getId() == 0) {
                em.persist(book);
            } else {
                em.merge(book);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void deleteById(int id) {
        EntityManager em = HibernateUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            Book book = em.find(Book.class, id);
            if (book != null) {
                em.remove(book);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public List<Book> searchByTitle(String keyword) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Book> query = em.createQuery(
                    "SELECT b FROM Book b JOIN FETCH b.category WHERE b.title LIKE :kw", Book.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}