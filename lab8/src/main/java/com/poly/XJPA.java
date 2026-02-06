package com.poly;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJPA {
    private static EntityManagerFactory factory;
    static {
        factory = Persistence.createEntityManagerFactory("Lab3");
    }

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }
}
