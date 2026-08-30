package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.IVideoDao;
import vn.iotstar.entity.Video;

public class VideoDaoImpl implements IVideoDao {

    @Override
    public void insert(Video video) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();
            em.persist(video);
            trans.commit();

        } catch (Exception e) {

            if (trans.isActive()) {
                trans.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public void update(Video video) {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();
            em.merge(video);
            trans.commit();

        } catch (Exception e) {

            if (trans.isActive()) {
                trans.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String videoId) throws Exception {

        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();

            Video video = em.find(Video.class, videoId);

            if (video == null) {
                throw new Exception("Không tìm thấy Video");
            }

            em.remove(video);

            trans.commit();

        } catch (Exception e) {

            if (trans.isActive()) {
                trans.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public Video findById(String videoId) {

        EntityManager em = JPAConfig.getEntityManager();

        try {
            return em.find(Video.class, videoId);

        } finally {
            em.close();
        }
    }

    @Override
    public List<Video> findAll() {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT v FROM Video v " +
                            "ORDER BY v.videoId ASC";

            TypedQuery<Video> query =
                    em.createQuery(jpql, Video.class);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Video> findAll(int page, int pageSize) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT v FROM Video v " +
                            "ORDER BY v.videoId ASC";

            TypedQuery<Video> query =
                    em.createQuery(jpql, Video.class);

            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Video> searchByTitle(String title) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT v FROM Video v " +
                            "WHERE v.title LIKE :title " +
                            "ORDER BY v.videoId ASC";

            TypedQuery<Video> query =
                    em.createQuery(jpql, Video.class);

            query.setParameter("title", "%" + title + "%");

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Video> findByCategory(int categoryId) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT v FROM Video v " +
                            "WHERE v.category.categoryId = :categoryId " +
                            "ORDER BY v.videoId ASC";

            TypedQuery<Video> query =
                    em.createQuery(jpql, Video.class);

            query.setParameter("categoryId", categoryId);

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
                    "SELECT COUNT(v) FROM Video v";

            Long count =
                    em.createQuery(jpql, Long.class)
                            .getSingleResult();

            return count.intValue();

        } finally {
            em.close();
        }
    }
}
