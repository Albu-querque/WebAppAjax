package com.web.goodswebapp.dao;

import com.web.goodswebapp.entities.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

//MAPPER определил в интерфейсе с default'ным доступом
@Repository
public class ProductDAOImpl implements ProductDAO {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public ProductDAOImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Product> getListProducts() {
        return jdbcTemplate.query("SELECT * FROM goods", MAPPER);
    }

    @Override
    public Product findById(long id) {
        Product product = null;
        product = jdbcTemplate.queryForObject("SELECT * FROM goods WHERE id=?", new Object[]{id}, MAPPER);
        return product;
    }

    @Override
    public boolean updateProduct(Product product) {
        return jdbcTemplate.update("UPDATE goods SET name=?, description=?, create_date=?, place_storage=?, reserved=? WHERE id=?",
                product.getName(),
                product.getDescription(),
                product.getCreate_date(),
                product.getPlace_storage(),
                product.isReserved(),
                product.getId()) > 0;
    }

    @Override
    public Product saveProduct(Product product) {
        assert jdbcTemplate.update("INSERT INTO goods(name, description, create_date, place_storage, reserved) VALUES(?, ?, ?, ?)",
                product.getName(),
                product.getDescription(),
                product.getCreate_date(),
                product.getPlace_storage(),
                product.isReserved()) > 0;
        return findById(product.getId());
    }

    @Override
    public boolean deleteProduct(long id) {
        return jdbcTemplate.update("DELETE FROM goods WHERE id=?", id) > 0;
    }
}
