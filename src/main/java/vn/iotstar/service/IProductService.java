package vn.iotstar.service;

import java.util.List;

import vn.iotstar.entity.Product;

public interface IProductService {

    void insert(Product product);

    void update(Product product);

    void delete(int id) throws Exception;

    Product findById(int id);

    List<Product> findAll();

    List<Product> findAll(int page, int pageSize);

    List<Product> findByCategory(int categoryId);

    List<Product> searchByName(String name);

    List<Product> findActive();

    int count();

    int countByCategory(int categoryId);
}
