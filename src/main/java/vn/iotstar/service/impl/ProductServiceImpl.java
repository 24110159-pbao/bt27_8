package vn.iotstar.service.impl;

import java.util.List;

import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;

public class ProductServiceImpl implements IProductService {

    private final IProductDao productDao =
            new ProductDaoImpl();

    @Override
    public void insert(Product product) {

        if (product == null) {
            throw new RuntimeException(
                    "Product không được null"
            );
        }

        if (product.getName() == null
                || product.getName().trim().isEmpty()) {

            throw new RuntimeException(
                    "Tên Product không được rỗng"
            );
        }

        if (product.getPrice() == null
                || product.getPrice().doubleValue() < 0) {

            throw new RuntimeException(
                    "Giá sản phẩm không hợp lệ"
            );
        }

        if (product.getQuantity() < 0) {

            throw new RuntimeException(
                    "Số lượng không hợp lệ"
            );
        }

        productDao.insert(product);
    }

    @Override
    public void update(Product product) {

        if (product == null) {
            throw new RuntimeException(
                    "Product không được null"
            );
        }

        Product oldProduct =
                productDao.findById(product.getId());

        if (oldProduct == null) {
            throw new RuntimeException(
                    "Không tìm thấy Product"
            );
        }

        if (product.getName() == null
                || product.getName().trim().isEmpty()) {

            throw new RuntimeException(
                    "Tên Product không được rỗng"
            );
        }

        if (product.getPrice() == null
                || product.getPrice().doubleValue() < 0) {

            throw new RuntimeException(
                    "Giá sản phẩm không hợp lệ"
            );
        }

        if (product.getQuantity() < 0) {

            throw new RuntimeException(
                    "Số lượng không hợp lệ"
            );
        }

        productDao.update(product);
    }

    @Override
    public void delete(int id) throws Exception {
        productDao.delete(id);
    }

    @Override
    public Product findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {
        return productDao.findAll(page, pageSize);
    }

    @Override
    public List<Product> findByCategory(int categoryId) {
        return productDao.findByCategory(categoryId);
    }

    @Override
    public List<Product> searchByName(String name) {
        return productDao.searchByName(name);
    }

    @Override
    public List<Product> findActive() {
        return productDao.findActive();
    }

    @Override
    public int count() {
        return productDao.count();
    }

    @Override
    public int countByCategory(int categoryId) {
        return productDao.countByCategory(categoryId);
    }
}
