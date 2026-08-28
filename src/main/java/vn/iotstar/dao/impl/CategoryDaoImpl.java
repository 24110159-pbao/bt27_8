package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.entity.Category;

import java.util.List;

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
    public void delete(int categoryid) throws Exception {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {

            transaction.begin();

            Category category =
                    em.find(Category.class, categoryid);

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
    public Category findById(int categoryid) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            return em.find(Category.class, categoryid);

        } finally {

            em.close();
        }
    }


    @Override
    public Category findByCategoryname(String categoryname) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT c FROM Category c " +
                            "WHERE c.categoryname = :categoryname";

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            query.setParameter("categoryname", categoryname);

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
                    "SELECT c FROM Category c";

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            return query.getResultList();

        } finally {

            em.close();
        }
    }


    @Override
    public List<Category> searchByName(String categoryname) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT c FROM Category c " +
                            "WHERE c.categoryname LIKE :categoryname";

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            query.setParameter(
                    "categoryname",
                    "%" + categoryname + "%"
            );

            return query.getResultList();

        } finally {

            em.close();
        }
    }


    @Override
    public List<Category> findAll(int page, int pagesize) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT c FROM Category c";

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            query.setFirstResult(page * pagesize);
            query.setMaxResults(pagesize);

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
