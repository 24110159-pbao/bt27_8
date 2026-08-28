package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAConfig {

    private static final EntityManagerFactory factory =
            Persistence.createEntityManagerFactory("ShoppingServiceMVCPU");

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }

    public static void close() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
