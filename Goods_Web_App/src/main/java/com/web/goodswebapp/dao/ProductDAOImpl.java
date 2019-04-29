package com.web.goodswebapp.dao;

import com.web.goodswebapp.entities.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    public Product updateProduct(Product product) {
        jdbcTemplate.update("UPDATE goods SET name=?, description=?, create_date=?, place_storage=?, reserved=? WHERE id=?",
                product.getName(),
                product.getDescription(),
                product.getCreate_date(),
                product.getPlace_storage(),
                product.isReserved(),
                product.getId());
        return findById(product.getId());
    }

    /*@Override
    public void saveProduct(Product product) {
        jdbcTemplate.update("INSERT INTO goods(name, description, create_date, place_storage, reserved) VALUES(?, ?, ?, ?, ?)",
                product.getName(),
                product.getDescription(),
                product.getCreate_date(),
                product.getPlace_storage(),
                product.isReserved());
    }*/

    @Override
    public Product saveProduct(Product product) {

        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(
                new PreparedStatementCreator() {
                    public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                        long id = -1;
                        PreparedStatement pst =
                                con.prepareStatement("INSERT INTO goods (name, description, create_date, place_storage, reserved) VALUES(?, ?, ?, ?, ?)", new String[] {"id"});
                        pst.setString(1, product.getName());
                        pst.setString(2,product.getDescription());
                        pst.setString(3, product.getCreate_date()+"");
                        pst.setString(4, product.getPlace_storage()+"");
                        pst.setString(5, product.isReserved()+"");

                        return pst;
                    }
                },
                keyHolder);
        return findById((Long)keyHolder.getKey());
    }


    @Override
    public boolean deleteProduct(long id) {
        return jdbcTemplate.update("DELETE FROM goods WHERE id=?", id) > 0;
    }
}
