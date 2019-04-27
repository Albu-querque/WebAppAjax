package com.web.goodswebapp.dao;

import com.web.goodswebapp.entities.Product;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.List;

public interface ProductDAO {
    RowMapper<Product> MAPPER = (ResultSet rs, int rowNum) -> {
        return new Product(rs.getLong("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getObject("create_date", LocalDate.class),
                rs.getLong("place_storage"),
                rs.getBoolean("reserved"));
    };

    Product findById(long id);
    List<Product> getListProducts();
    boolean updateProduct(Product product);
    Product saveProduct(Product product);
    boolean deleteProduct(long id);
}
