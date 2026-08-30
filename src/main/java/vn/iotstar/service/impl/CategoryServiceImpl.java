package vn.iotstar.service.impl;

import java.util.List;

import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;

public class CategoryServiceImpl implements ICategoryService {

    private final ICategoryDao categoryDao =
            new CategoryDaoImpl();

    @Override
    public void insert(Category category) {

        Category exists =
                categoryDao.findByCateName(category.getCateName());

        if (exists != null) {
            throw new RuntimeException(
                    "Tên Category đã tồn tại"
            );
        }

        categoryDao.insert(category);
    }

    @Override
    public void update(Category category) {

        Category exists =
                categoryDao.findById(category.getCateId());

        if (exists == null) {
            throw new RuntimeException(
                    "Không tìm thấy Category"
            );
        }

        categoryDao.update(category);
    }

    @Override
    public void delete(int cateId) throws Exception {
        categoryDao.delete(cateId);
    }

    @Override
    public Category findById(int cateId) {
        return categoryDao.findById(cateId);
    }

    @Override
    public Category findByCateName(String cateName) {
        return categoryDao.findByCateName(cateName);
    }

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {
        return categoryDao.findAll(page, pageSize);
    }

    @Override
    public List<Category> searchByName(String cateName) {
        return categoryDao.searchByName(cateName);
    }

    @Override
    public int count() {
        return categoryDao.count();
    }
}
