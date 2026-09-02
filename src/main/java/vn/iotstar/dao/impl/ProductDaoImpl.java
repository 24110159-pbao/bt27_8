package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDaoImpl implements IProductDao {

    @Override
    public void insert(Product product) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            em.persist(product);

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
    public void update(Product product) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            em.merge(product);

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
    public void delete(int id) throws Exception {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            Product product = em.find(Product.class, id);

            if (product == null) {
                throw new Exception("Không tìm thấy Product");
            }

            em.remove(product);

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
    public Product findById(int id) {

        EntityManager em = JPAConfig.getEntityManager();

        try {
            return em.find(Product.class, id);

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAll() {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "ORDER BY p.id ASC";

            TypedQuery<Product> query =
                    em.createQuery(jpql, Product.class);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "ORDER BY p.id ASC";

            TypedQuery<Product> query =
                    em.createQuery(jpql, Product.class);

            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findByCategory(int categoryId) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "WHERE p.category.cateId = :categoryId " +
                            "ORDER BY p.id ASC";

            TypedQuery<Product> query =
                    em.createQuery(jpql, Product.class);

            query.setParameter("categoryId", categoryId);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> searchByName(String name) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "WHERE LOWER(p.name) LIKE LOWER(:name) " +
                            "ORDER BY p.id ASC";

            TypedQuery<Product> query =
                    em.createQuery(jpql, Product.class);

            query.setParameter("name", "%" + name + "%");

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findActive() {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "WHERE p.active = true " +
                            "ORDER BY p.createdAt DESC";

            TypedQuery<Product> query =
                    em.createQuery(jpql, Product.class);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public int count() {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            Long count =
                    em.createQuery(
                            "SELECT COUNT(p) FROM Product p",
                            Long.class
                    ).getSingleResult();

            return count.intValue();

        } finally {
            em.close();
        }
    }

    @Override
    public int countByCategory(int categoryId) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            Long count =
                    em.createQuery(
                                    "SELECT COUNT(p) " +
                                            "FROM Product p " +
                                            "WHERE p.category.cateId = :categoryId",
                                    Long.class
                            )
                            .setParameter("categoryId", categoryId)
                            .getSingleResult();

            return count.intValue();

        } finally {
            em.close();
        }
    }
}
