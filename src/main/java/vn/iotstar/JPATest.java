package vn.iotstar;

import java.util.List;

import jakarta.persistence.EntityManager;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.entity.Category;

public class JPATest {

    public static void main(String[] args) {

        EntityManager em = JPAConfig.getEntityManager();

        try {

            List<Category> categories =
                    em.createQuery(
                            "SELECT c FROM Category c ORDER BY c.cateId",
                            Category.class
                    ).getResultList();

            for (Category category : categories) {

                System.out.println(
                        category.getCateId()
                                + " - "
                                + category.getCateName()
                                + " - "
                                + category.getIcons()
                );
            }

        } finally {

            em.close();
            JPAConfig.close();
        }
    }
}
