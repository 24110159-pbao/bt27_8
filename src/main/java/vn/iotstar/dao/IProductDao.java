package vn.iotstar.dao;

import java.util.List;

import vn.iotstar.entity.Product;

public interface IProductDao {

    // =========================
    // CRUD
    // =========================

    void insert(Product product);

    void update(Product product);

    void delete(int id) throws Exception;

    // =========================
    // FIND
    // =========================

    Product findById(int id);

    List<Product> findAll();

    List<Product> findAll(int page, int pageSize);

    List<Product> findTop10Newest();

    List<Product> findByCategory(int categoryId);

    List<Product> searchByName(String name);

    List<Product> findActive();

    // =========================
    // COUNT
    // =========================

    int count();

    int countByCategory(int categoryId);
}
