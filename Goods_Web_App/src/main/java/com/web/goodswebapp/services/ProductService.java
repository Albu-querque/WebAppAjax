package com.web.goodswebapp.services;

import com.web.goodswebapp.entities.Product;

import java.util.List;

public interface ProductService {
    Product findById(long id);
    List<Product> getListProducts();
    boolean updateProduct(long id);
    Product saveProduct(Product product);
    boolean deleteProduct(long id);
}
