package vn.iotstar.dao;

import vn.iotstar.entity.Category;

import java.util.List;

public interface ICategoryDao {

    void insert(Category category);

    void update(Category category);

    void delete(int categoryid) throws Exception;

    Category findById(int categoryid);

    Category findByCategoryname(String categoryname);

    List<Category> findAll();

    List<Category> searchByName(String categoryname);

    List<Category> findAll(int page, int pagesize);

    int count();
}
