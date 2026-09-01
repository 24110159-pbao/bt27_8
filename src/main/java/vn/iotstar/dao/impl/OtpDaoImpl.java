package vn.iotstar.dao.impl;

import java.time.LocalDateTime;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.OtpDao;
import vn.iotstar.entity.OtpVerification;

public class OtpDaoImpl implements OtpDao {

    @Override
    public void invalidateOldOtp(int userId, String type) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {

            transaction.begin();

            String jpql =
                    "UPDATE OtpVerification o " +
                            "SET o.verified = true " +
                            "WHERE o.user.id = :userId " +
                            "AND o.type = :type " +
                            "AND o.verified = false";

            int updated = em.createQuery(jpql)
                    .setParameter("userId", userId)
                    .setParameter("type", type)
                    .executeUpdate();

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
    public void insert(OtpVerification otp) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {

            transaction.begin();

            em.persist(otp);

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
    public OtpVerification findValidOtp(
            int userId,
            String otp,
            String type) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT o FROM OtpVerification o " +
                            "WHERE o.user.id = :userId " +
                            "AND o.otp = :otp " +
                            "AND o.type = :type " +
                            "AND o.verified = false " +
                            "AND o.expiredAt > :now " +
                            "ORDER BY o.createdAt DESC";

            TypedQuery<OtpVerification> query =
                    em.createQuery(jpql, OtpVerification.class);

            query.setParameter("userId", userId);
            query.setParameter("otp", otp);
            query.setParameter("type", type);
            query.setParameter("now", LocalDateTime.now());

            query.setMaxResults(1);

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
    public void markVerified(int id) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {

            transaction.begin();

            OtpVerification otp =
                    em.find(OtpVerification.class, id);

            if (otp != null) {
                otp.setVerified(true);
                em.merge(otp);
            }

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
}
