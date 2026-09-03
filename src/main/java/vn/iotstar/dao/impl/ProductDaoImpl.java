package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDaoImpl implements IProductDao {

    // =====================================================
    // INSERT
    // =====================================================

    @Override
    public void insert(Product product) {

        EntityManager em =
                JPAConfig.getEntityManager();

        EntityTransaction transaction =
                em.getTransaction();

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

    // =====================================================
    // UPDATE
    // =====================================================

    @Override
    public void update(Product product) {

        EntityManager em =
                JPAConfig.getEntityManager();

        EntityTransaction transaction =
                em.getTransaction();

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

    // =====================================================
    // DELETE
    // =====================================================

    @Override
    public void delete(int id) throws Exception {

        EntityManager em =
                JPAConfig.getEntityManager();

        EntityTransaction transaction =
                em.getTransaction();

        try {

            transaction.begin();

            Product product =
                    em.find(Product.class, id);

            if (product == null) {

                throw new Exception(
                        "Không tìm thấy Product"
                );
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

    // =====================================================
    // FIND BY ID
    // =====================================================

    @Override
    public Product findById(int id) {

        EntityManager em =
                JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "WHERE p.id = :id";

            TypedQuery<Product> query =
                    em.createQuery(
                            jpql,
                            Product.class
                    );

            query.setParameter("id", id);

            return query
                    .getResultStream()
                    .findFirst()
                    .orElse(null);

        } finally {

            em.close();
        }
    }

    // =====================================================
    // FIND ALL
    // Dùng cho ADMIN
    // =====================================================

    @Override
    public List<Product> findAll() {

        EntityManager em =
                JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "ORDER BY p.createdAt DESC";

            TypedQuery<Product> query =
                    em.createQuery(
                            jpql,
                            Product.class
                    );

            return query.getResultList();

        } finally {

            em.close();
        }
    }

    // =====================================================
    // FIND ALL - PAGINATION
    // Dùng cho CLIENT /product
    // 6 sản phẩm / trang
    // =====================================================

    @Override
    public List<Product> findAll(
            int page,
            int pageSize) {

        EntityManager em =
                JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "WHERE p.active = true " +
                            "ORDER BY p.createdAt DESC";

            TypedQuery<Product> query =
                    em.createQuery(
                            jpql,
                            Product.class
                    );

            // page bắt đầu từ 1
            int offset =
                    (page - 1) * pageSize;

            query.setFirstResult(offset);

            query.setMaxResults(pageSize);

            return query.getResultList();

        } finally {

            em.close();
        }
    }

    // =====================================================
    // TOP 10 NEWEST
    // Dùng cho trang chủ
    // =====================================================

    @Override
    public List<Product> findTop10Newest() {

        EntityManager em =
                JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "WHERE p.active = true " +
                            "ORDER BY p.createdAt DESC";

            TypedQuery<Product> query =
                    em.createQuery(
                            jpql,
                            Product.class
                    );

            query.setMaxResults(10);

            return query.getResultList();

        } finally {

            em.close();
        }
    }

    // =====================================================
    // FIND BY CATEGORY
    // =====================================================

    @Override
    public List<Product> findByCategory(
            int categoryId) {

        EntityManager em =
                JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "WHERE p.category.cateId = :categoryId " +
                            "AND p.active = true " +
                            "ORDER BY p.createdAt DESC";

            TypedQuery<Product> query =
                    em.createQuery(
                            jpql,
                            Product.class
                    );

            query.setParameter(
                    "categoryId",
                    categoryId
            );

            return query.getResultList();

        } finally {

            em.close();
        }
    }

    // =====================================================
    // SEARCH BY NAME
    // =====================================================

    @Override
    public List<Product> searchByName(
            String name) {

        EntityManager em =
                JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "WHERE LOWER(p.name) " +
                            "LIKE LOWER(:name) " +
                            "ORDER BY p.createdAt DESC";

            TypedQuery<Product> query =
                    em.createQuery(
                            jpql,
                            Product.class
                    );

            query.setParameter(
                    "name",
                    "%" + name + "%"
            );

            return query.getResultList();

        } finally {

            em.close();
        }
    }

    // =====================================================
    // FIND ACTIVE
    // =====================================================

    @Override
    public List<Product> findActive() {

        EntityManager em =
                JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT p FROM Product p " +
                            "JOIN FETCH p.category " +
                            "WHERE p.active = true " +
                            "ORDER BY p.createdAt DESC";

            TypedQuery<Product> query =
                    em.createQuery(
                            jpql,
                            Product.class
                    );

            return query.getResultList();

        } finally {

            em.close();
        }
    }

    // =====================================================
    // COUNT
    // Dùng cho pagination CLIENT
    // =====================================================

    @Override
    public int count() {

        EntityManager em =
                JPAConfig.getEntityManager();

        try {

            Long count =
                    em.createQuery(
                                    "SELECT COUNT(p) " +
                                            "FROM Product p " +
                                            "WHERE p.active = true",
                                    Long.class
                            )
                            .getSingleResult();

            return count.intValue();

        } finally {

            em.close();
        }
    }

    // =====================================================
    // COUNT BY CATEGORY
    // =====================================================

    @Override
    public int countByCategory(
            int categoryId) {

        EntityManager em =
                JPAConfig.getEntityManager();

        try {

            Long count =
                    em.createQuery(
                                    "SELECT COUNT(p) " +
                                            "FROM Product p " +
                                            "WHERE p.category.cateId = :categoryId " +
                                            "AND p.active = true",
                                    Long.class
                            )
                            .setParameter(
                                    "categoryId",
                                    categoryId
                            )
                            .getSingleResult();

            return count.intValue();

        } finally {

            em.close();
        }
    }
}
