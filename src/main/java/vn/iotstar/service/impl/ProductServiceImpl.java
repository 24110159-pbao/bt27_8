package vn.iotstar.service.impl;

import java.math.BigDecimal;
import java.util.List;

import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;

public class ProductServiceImpl
        implements IProductService {

    private final IProductDao productDao =
            new ProductDaoImpl();

    // =====================================================
    // INSERT
    // =====================================================

    @Override
    public void insert(Product product) {

        validateProduct(product);

        productDao.insert(product);
    }

    // =====================================================
    // UPDATE
    // =====================================================

    @Override
    public void update(Product product) {

        if (product == null) {

            throw new RuntimeException(
                    "Product không được null"
            );
        }

        Product oldProduct =
                productDao.findById(
                        product.getId()
                );

        if (oldProduct == null) {

            throw new RuntimeException(
                    "Không tìm thấy Product"
            );
        }

        validateProduct(product);

        productDao.update(product);
    }

    // =====================================================
    // DELETE
    // =====================================================

    @Override
    public void delete(int id)
            throws Exception {

        productDao.delete(id);
    }

    // =====================================================
    // FIND BY ID
    // =====================================================

    @Override
    public Product findById(int id) {

        return productDao.findById(id);
    }

    // =====================================================
    // FIND ALL
    // =====================================================

    @Override
    public List<Product> findAll() {

        return productDao.findAll();
    }

    // =====================================================
    // FIND ALL PAGINATION
    // =====================================================

    @Override
    public List<Product> findAll(
            int page,
            int pageSize) {

        return productDao.findAll(
                page,
                pageSize
        );
    }

    // =====================================================
    // TOP 10 NEWEST
    // =====================================================

    @Override
    public List<Product> findTop10Newest() {

        return productDao.findTop10Newest();
    }

    // =====================================================
    // FIND BY CATEGORY
    // =====================================================

    @Override
    public List<Product> findByCategory(
            int categoryId) {

        return productDao.findByCategory(
                categoryId
        );
    }

    // =====================================================
    // SEARCH
    // =====================================================

    @Override
    public List<Product> searchByName(
            String name) {

        return productDao.searchByName(
                name
        );
    }

    // =====================================================
    // FIND ACTIVE
    // =====================================================

    @Override
    public List<Product> findActive() {

        return productDao.findActive();
    }

    // =====================================================
    // COUNT
    // =====================================================

    @Override
    public int count() {

        return productDao.count();
    }

    // =====================================================
    // COUNT CATEGORY
    // =====================================================

    @Override
    public int countByCategory(
            int categoryId) {

        return productDao.countByCategory(
                categoryId
        );
    }

    // =====================================================
    // VALIDATE
    // =====================================================

    private void validateProduct(
            Product product) {

        if (product == null) {

            throw new RuntimeException(
                    "Product không được null"
            );
        }

        if (product.getName() == null
                || product.getName()
                .trim()
                .isEmpty()) {

            throw new RuntimeException(
                    "Tên Product không được rỗng"
            );
        }

        if (product.getPrice() == null
                || product.getPrice()
                .compareTo(BigDecimal.ZERO) < 0) {

            throw new RuntimeException(
                    "Giá sản phẩm không hợp lệ"
            );
        }

        if (product.getQuantity() < 0) {

            throw new RuntimeException(
                    "Số lượng không hợp lệ"
            );
        }

        if (product.getCategory() == null) {

            throw new RuntimeException(
                    "Category không được null"
            );
        }
    }
}
