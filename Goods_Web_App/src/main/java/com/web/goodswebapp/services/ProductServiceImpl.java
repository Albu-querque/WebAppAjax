package com.web.goodswebapp.services;

import com.web.goodswebapp.dao.ProductDAO;
import com.web.goodswebapp.entities.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    private final ProductDAO productDAO;

    @Autowired
    public ProductServiceImpl(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    @Override
    public Product findById(long id) {
        return productDAO.findById(id);
    }

    @Override
    public List<Product> getListProducts() {
        return productDAO.getListProducts();
    }

    @Override
    public Product updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }

    @Override
    public Product saveProduct(Product product) {
        return productDAO.saveProduct(product);
    }

    @Override
    public boolean deleteProduct(long id) {
        return productDAO.deleteProduct(id);
    }
}
