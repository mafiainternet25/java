package com.quoctruong.projectjavademo.service;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final JdbcTemplate jdbc;

    public UserService(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public boolean existsByUsername(String username) {
        Integer count = jdbc.queryForObject(
                "SELECT COUNT(*) FROM users WHERE username = ?",
                Integer.class,
                username);
        return count != null && count > 0;
    }

    public boolean existsByUsernameAndPassword(String username, String password) {
        Integer count = jdbc.queryForObject(
                "SELECT COUNT(*) FROM users WHERE username = ? AND password = ?",
                Integer.class,
                username, password);
        return count != null && count > 0;
    }

    public int createUser(String username, String password) {
        return jdbc.update(
                "INSERT INTO users (username, password) VALUES (?, ?)",
                username, password);
    }

    public boolean updateUsernameAndPassword(String currentUsername, String currentPassword,
                                             String newUsername, String newPassword) {
        int updated = jdbc.update(
                "UPDATE users SET username = ?, password = ? WHERE username = ? AND password = ?",
                newUsername, newPassword, currentUsername, currentPassword);
        return updated > 0;
    }
    
    public boolean updateUsername(String currentUsername, String currentPassword, String newUsername) {
        if (existsByUsername(newUsername) && !newUsername.equals(currentUsername)) {
            return false;
        }
        int updated = jdbc.update(
                "UPDATE users SET username = ? WHERE username = ? AND password = ?",
                newUsername, currentUsername, currentPassword);
        return updated > 0;
    }
    
    public boolean updatePassword(String currentUsername, String currentPassword, String newPassword) {
        int updated = jdbc.update(
                "UPDATE users SET password = ? WHERE username = ? AND password = ?",
                newPassword, currentUsername, currentPassword);
        return updated > 0;
    }
    
    public Integer getUserRole(String username) {
        try {
            Integer role = jdbc.queryForObject(
                    "SELECT role FROM users WHERE username = ?",
                    Integer.class,
                    username);
            return role != null ? role : 0;
        } catch (Exception e) {
            return 0;
        }
    }
}
