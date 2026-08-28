package vn.iotstar.service.impl;

import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;

import java.util.List;

public class CategoryServiceImpl implements ICategoryService {

    private final ICategoryDao categoryDao =
            new CategoryDaoImpl();


    @Override
    public void insert(Category category) {

        Category existing =
                categoryDao.findByCategoryname(
                        category.getCategoryname()
                );

        if (existing != null) {

            throw new IllegalArgumentException(
                    "Tên Category đã tồn tại"
            );
        }

        categoryDao.insert(category);
    }


    @Override
    public void update(Category category) {

        Category existing =
                categoryDao.findById(
                        category.getCategoryid()
                );

        if (existing == null) {

            throw new IllegalArgumentException(
                    "Category không tồn tại"
            );
        }

        categoryDao.update(category);
    }


    @Override
    public void delete(int categoryid)
            throws Exception {

        categoryDao.delete(categoryid);
    }


    @Override
    public Category findById(int categoryid) {

        return categoryDao.findById(categoryid);
    }


    @Override
    public Category findByCategoryname(
            String categoryname) {

        return categoryDao.findByCategoryname(
                categoryname
        );
    }


    @Override
    public List<Category> findAll() {

        return categoryDao.findAll();
    }


    @Override
    public List<Category> searchByName(
            String categoryname) {

        return categoryDao.searchByName(
                categoryname
        );
    }


    @Override
    public List<Category> findAll(
            int page,
            int pagesize) {

        return categoryDao.findAll(
                page,
                pagesize
        );
    }


    @Override
    public int count() {

        return categoryDao.count();
    }
}