package com.quoctruong.projectjavademo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.quoctruong.projectjavademo.model.Product;

@Service
public class FavoriteService {
    private final JdbcTemplate jdbc;
    private final ProductService productService;

    public FavoriteService(JdbcTemplate jdbc, ProductService productService) {
        this.jdbc = jdbc;
        this.productService = productService;
    }

    public boolean addFavorite(String userId, Long productId) {
        try {
            String sql = "INSERT INTO favorites (user_id, product_id) VALUES (?, ?)";
            int rowsAffected = jdbc.update(sql, userId, productId);
            return rowsAffected > 0;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean removeFavorite(String userId, Long productId) {
        String sql = "DELETE FROM favorites WHERE user_id = ? AND product_id = ?";
        int rowsAffected = jdbc.update(sql, userId, productId);
        return rowsAffected > 0;
    }

    public boolean isFavorited(String userId, Long productId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id = ? AND product_id = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, userId, productId);
        return count != null && count > 0;
    }

    public List<Product> getFavorites(String userId) {
        String sql = "SELECT product_id FROM favorites WHERE user_id = ? ORDER BY created_at DESC";
        
        List<Long> productIds = jdbc.queryForList(sql, Long.class, userId);

        List<Product> products = new ArrayList<>();
        for (Long productId : productIds) {
            Product product = productService.getProductById(productId);
            if (product != null) {
                products.add(product);
            }
        }
        return products;
    }

    public int getFavoritesCount(String userId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, userId);
        return count != null ? count : 0;
    }
}
