package com.web.goodswebapp.controllers;

import com.web.goodswebapp.entities.Product;
import com.web.goodswebapp.exceptions.NotFoundException;
import com.web.goodswebapp.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/listProducts")
public class ProductController {
    private final ProductService productService;

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public List<Product> listProducts() {
        return productService.getListProducts();
    }

    @PostMapping(value = "/create"/*, consumes = MediaType.APPLICATION_JSON_VALUE*/, produces = MediaType.APPLICATION_JSON_VALUE)
    public Product createProduct(@RequestBody Product product) {
         return productService.saveProduct(product);
    }
    @PutMapping("/updateProduct")
    public Product updateProduct(@RequestBody Product product) {
        return productService.updateProduct(product);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteProduct(@PathVariable long id) {
       productService.deleteProduct(id);
    }
}
