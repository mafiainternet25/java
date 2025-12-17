package com.quoctruong.projectjavademo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quoctruong.projectjavademo.model.Product;
import com.quoctruong.projectjavademo.service.FavoriteService;

import jakarta.servlet.http.HttpSession;

@Controller
public class FavoriteController {
    private final FavoriteService favoriteService;

    public FavoriteController(FavoriteService favoriteService) {
        this.favoriteService = favoriteService;
    }
    
    private String getUserId(HttpSession session) {
        Object username = session.getAttribute(LoginController.USER_SESSION_KEY);
        return username != null ? username.toString() : "guest";
    }

    @GetMapping("/favorites")
    public String viewFavorites(Model model, HttpSession session) {
        String userId = getUserId(session);
        
        List<Product> favorites = favoriteService.getFavorites(userId);
        int favoriteCount = favoriteService.getFavoritesCount(userId);
        
        model.addAttribute("products", favorites);
        model.addAttribute("totalFavorites", favoriteCount);
        model.addAttribute("pageTitle", "Sản Phẩm Đã Thích");
        
        return "favorites";
    }

    @PostMapping("/favorites/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addFavorite(@RequestParam Long productId, HttpSession session) {
        String userId = getUserId(session);
        
        boolean success = favoriteService.addFavorite(userId, productId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        response.put("message", success ? "Added to favorites" : "Already in favorites");
        response.put("isFavorited", success);
        
        return ResponseEntity.ok(response);
    }

    @PostMapping("/favorites/remove")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeFavorite(@RequestParam Long productId, HttpSession session) {
        String userId = getUserId(session);
        
        boolean success = favoriteService.removeFavorite(userId, productId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        response.put("message", success ? "Removed from favorites" : "Not in favorites");
        response.put("isFavorited", false);
        
        return ResponseEntity.ok(response);
    }

    @GetMapping("/favorites/check")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkFavorite(@RequestParam Long productId, HttpSession session) {
        String userId = getUserId(session);
        
        boolean isFavorited = favoriteService.isFavorited(userId, productId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("productId", productId);
        response.put("isFavorited", isFavorited);
        
        return ResponseEntity.ok(response);
    }
}
