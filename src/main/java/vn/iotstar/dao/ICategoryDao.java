package vn.iotstar.dao;

import java.util.List;

import vn.iotstar.entity.Category;

public interface ICategoryDao {

    void insert(Category category);

    void update(Category category);

    void delete(int cateId) throws Exception;

    Category findById(int cateId);

    Category findByCateName(String cateName);

    List<Category> findAll();

    List<Category> findAll(int page, int pageSize);

    List<Category> searchByName(String cateName);

    int count();
}
