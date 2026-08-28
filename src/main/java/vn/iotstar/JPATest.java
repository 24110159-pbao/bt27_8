package vn.iotstar;

import jakarta.persistence.EntityManager;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.entity.Category;

import java.util.List;

public class JPATest {

    public static void main(String[] args) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            String jpql = "SELECT c FROM Category c";

            List<Category> categories =
                    em.createQuery(jpql, Category.class)
                            .getResultList();

            for (Category category : categories) {

                System.out.println(
                        category.getCategoryid()
                                + " - "
                                + category.getCategoryname()
                                + " - "
                                + category.getImages()
                );
            }

        } finally {

            em.close();
            JPAConfig.close();
        }
    }
}
