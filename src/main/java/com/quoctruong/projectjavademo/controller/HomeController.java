package com.quoctruong.projectjavademo.controller;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.quoctruong.projectjavademo.model.Product;
import com.quoctruong.projectjavademo.service.FavoriteService;
import com.quoctruong.projectjavademo.service.ProductService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
    private final FavoriteService favoriteService;
    private final ProductService productService;

    public HomeController(FavoriteService favoriteService, ProductService productService) {
        this.favoriteService = favoriteService;
        this.productService = productService;
    }
    
    private String getUserId(HttpSession session) {
        Object username = session.getAttribute(LoginController.USER_SESSION_KEY);
        return username != null ? username.toString() : "guest";
    }

    @GetMapping("/")
    public String index(Model model, HttpSession session) {
        String userId = getUserId(session);
        int favoriteCount = favoriteService.getFavoritesCount(userId);
        model.addAttribute("favoriteCount", favoriteCount);
        model.addAttribute("homeProducts", getHomeProducts());
        return "home";
    }

    @GetMapping("/home")
    public String home(Model model, HttpSession session) {
        String userId = getUserId(session);
        int favoriteCount = favoriteService.getFavoritesCount(userId);
        model.addAttribute("favoriteCount", favoriteCount);
        model.addAttribute("homeProducts", getHomeProducts());
        return "home";
    }

    private List<Product> getHomeProducts() {
        long[] staticIds = {1, 12, 3, 4, 5, 6, 7, 8};
        long[] featuredIds = {2, 11, 9, 10};

        Set<Long> ids = new LinkedHashSet<>();
        for (long id : staticIds) ids.add(id);
        for (long id : featuredIds) ids.add(id);

        List<Product> products = new ArrayList<>();
        for (Long id : ids) {
            Product product = productService.getProductById(id);
            if (product != null) {
                products.add(product);
            }
        }
        return products;
    }
}
