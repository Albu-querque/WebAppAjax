package com.web.goodswebapp.controllers;

import com.web.goodswebapp.entities.Product;
import com.web.goodswebapp.exceptions.NotFoundException;
import com.web.goodswebapp.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/listProducts")
public class ProductController {
    private final ProductService productService;

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }
    /*produces = {MediaType.APPLICATION_JSON_VALUE}*/
    @GetMapping
    public List<Product> listProducts() {
        return productService.getListProducts();
    }

    @PostMapping("/create")
    public void createProduct(@RequestBody Product product) {
         productService.saveProduct(product);
    }
    @PutMapping("/updateProduct")
    public Product updateProduct(@RequestBody Product product) {
        return updateProduct(product);
    }

    @GetMapping(value = "/edit/{id}")
    public Product edit(@PathVariable long id) {
        Optional<Product> product = Optional.of(productService.findById(id));
        return product.orElseThrow(NotFoundException::new);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteProduct(@PathVariable long id) {
       productService.deleteProduct(id);
    }
}
