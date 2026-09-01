package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;

public class UserDaoImpl implements UserDao {

    @Override
    public void insert(User user) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            em.persist(user);

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
    public void update(User user) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            em.merge(user);

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

            User user = em.find(User.class, id);

            if (user == null) {
                throw new Exception("Không tìm thấy User");
            }

            em.remove(user);

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
    public User findById(int id) {

        EntityManager em = JPAConfig.getEntityManager();

        try {
            return em.find(User.class, id);

        } finally {
            em.close();
        }
    }

    @Override
    public User findByUsername(String username) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.username = :username",
                    User.class
            );

            query.setParameter("username", username);

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
    public User findByEmail(String email) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :email",
                    User.class
            );

            query.setParameter("email", email);

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
    public User findByPhone(String phone) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.phone = :phone",
                    User.class
            );

            query.setParameter("phone", phone);

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
    public User login(String username, String password) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u " +
                            "WHERE u.username = :username " +
                            "AND u.password = :password " +
                            "AND u.active = true",
                    User.class
            );

            query.setParameter("username", username);
            query.setParameter("password", password);

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
    public List<User> findAll() {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u ORDER BY u.id ASC",
                    User.class
            );

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<User> findAll(int page, int pageSize) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u ORDER BY u.id ASC",
                    User.class
            );

            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<User> searchByName(String fullname) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u " +
                            "WHERE u.fullname LIKE :fullname " +
                            "ORDER BY u.id ASC",
                    User.class
            );

            query.setParameter(
                    "fullname",
                    "%" + fullname + "%"
            );

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public int count() {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            Long count = em.createQuery(
                    "SELECT COUNT(u) FROM User u",
                    Long.class
            ).getSingleResult();

            return count.intValue();

        } finally {
            em.close();
        }
    }
}
