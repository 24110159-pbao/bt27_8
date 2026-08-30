package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.entity.Category;

public class CategoryDaoImpl implements ICategoryDao {

    @Override
    public void insert(Category category) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            em.persist(category);

            transaction.commit();

        } catch (Exception e) {

            if (transaction.isActive()) {
                transaction.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public void update(Category category) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            em.merge(category);

            transaction.commit();

        } catch (Exception e) {

            if (transaction.isActive()) {
                transaction.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int cateId) throws Exception {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            Category category = em.find(Category.class, cateId);

            if (category == null) {
                throw new Exception("Không tìm thấy Category");
            }

            em.remove(category);

            transaction.commit();

        } catch (Exception e) {

            if (transaction.isActive()) {
                transaction.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public Category findById(int cateId) {

        EntityManager em = JPAConfig.getEntityManager();

        try {
            return em.find(Category.class, cateId);

        } finally {
            em.close();
        }
    }

    @Override
    public Category findByCateName(String cateName) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT c FROM Category c " +
                            "WHERE c.cateName = :cateName";

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            query.setParameter("cateName", cateName);

            try {
                return query.getSingleResult();
            } catch (NoResultException e) {
                return null;
            }

        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> findAll() {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT c FROM Category c " +
                            "ORDER BY c.cateId ASC";

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT c FROM Category c " +
                            "ORDER BY c.cateId ASC";

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> searchByName(String cateName) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT c FROM Category c " +
                            "WHERE c.cateName LIKE :cateName " +
                            "ORDER BY c.cateId ASC";

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            query.setParameter("cateName", "%" + cateName + "%");

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public int count() {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(c) FROM Category c";

            Long count =
                    em.createQuery(jpql, Long.class)
                            .getSingleResult();

            return count.intValue();

        } finally {
            em.close();
        }
    }
}
