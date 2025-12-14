package com.quoctruong.projectjavademo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.quoctruong.projectjavademo.model.Product;

@Service
public class ProductService {
    private final JdbcTemplate jdbc;
    
    private final RowMapper<Product> productMapper = (rs, rowNum) -> {
        Product product = new Product();
        product.setId(rs.getLong("id"));
        product.setName(rs.getString("name"));
        product.setPrice(rs.getDouble("price"));
        product.setDescription(rs.getString("description"));
        product.setImageUrl(rs.getString("image_url"));
        product.setCategory(rs.getString("category"));
        return product;
    };

    public ProductService(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<Product> searchProducts(String keyword, String category, Double minPrice, Double maxPrice) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (LOWER(name) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?))");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND LOWER(category) = LOWER(?)");
            params.add(category.trim());
        }

        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }

        sql.append(" ORDER BY name ASC");

        return jdbc.query(sql.toString(), productMapper, params.toArray());
    }

    public List<String> getAllCategories() {
        return jdbc.queryForList("SELECT DISTINCT category FROM products ORDER BY category", String.class);
    }

    public Product getProductById(Long id) {
        List<Product> products = jdbc.query(
            "SELECT * FROM products WHERE id = ?",
            productMapper,
            id
        );
        return products.isEmpty() ? null : products.get(0);
    }

    public List<Product> getProductsByCategory(String category, int limit) {
        String sql = "SELECT * FROM products WHERE LOWER(category) = LOWER(?) ORDER BY id DESC LIMIT ?";
        return jdbc.query(sql, productMapper, category, limit);
    }

    public List<Product> getProductsByGender(String genderPattern) {
        if (genderPattern == null || genderPattern.trim().isEmpty()) {
            return new ArrayList<>();
        }
        String sql = "SELECT * FROM products WHERE LOWER(category) LIKE ? ORDER BY name ASC";
        String pattern = "%" + genderPattern.toLowerCase().trim() + "%";
        return jdbc.query(sql, productMapper, pattern);
    }

    public List<Product> getProductsByCategoryKeywords(List<String> keywords) {
        if (keywords == null || keywords.isEmpty()) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE (");
        List<Object> params = new ArrayList<>();

        for (int i = 0; i < keywords.size(); i++) {
            if (i > 0) sql.append(" OR ");
            sql.append("LOWER(category) LIKE ?");
            params.add("%" + keywords.get(i).toLowerCase().trim() + "%");
        }

        sql.append(") ORDER BY name ASC");

        return jdbc.query(sql.toString(), productMapper, params.toArray());
    }
    
    public List<Product> getAllProducts() {
        return jdbc.query("SELECT * FROM products ORDER BY id DESC", productMapper);
    }
    
    public boolean createProduct(Product product) {
        try {
            int rows = jdbc.update(
                "INSERT INTO products (name, price, description, image_url, category) VALUES (?, ?, ?, ?, ?)",
                product.getName(),
                product.getPrice(),
                product.getDescription(),
                product.getImageUrl(),
                product.getCategory()
            );
            return rows > 0;
        } catch (Exception e) {
            return false;
        }
    }
    
    public boolean updateProduct(Product product) {
        try {
            int rows = jdbc.update(
                "UPDATE products SET name = ?, price = ?, description = ?, image_url = ?, category = ? WHERE id = ?",
                product.getName(),
                product.getPrice(),
                product.getDescription(),
                product.getImageUrl(),
                product.getCategory(),
                product.getId()
            );
            return rows > 0;
        } catch (Exception e) {
            return false;
        }
    }
    
    public boolean deleteProduct(Long id) {
        try {
            int rows = jdbc.update("DELETE FROM products WHERE id = ?", id);
            return rows > 0;
        } catch (Exception e) {
            return false;
        }
    }
}