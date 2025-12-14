package com.quoctruong.projectjavademo.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.quoctruong.projectjavademo.service.CartService;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalControllerAdvice {
    private final CartService cartService;

    public GlobalControllerAdvice(CartService cartService) {
        this.cartService = cartService;
    }

    @ModelAttribute("cartCount")
    public int cartCount(HttpSession session) {
        return cartService.getTotalQuantity(session);
    }
    
    @ModelAttribute("username")
    public String username(HttpSession session) {
        Object username = session.getAttribute(LoginController.USER_SESSION_KEY);
        return username != null ? username.toString() : null;
    }
    
    @ModelAttribute("isLoggedIn")
    public boolean isLoggedIn(HttpSession session) {
        return session.getAttribute(LoginController.USER_SESSION_KEY) != null;
    }
    
    @ModelAttribute("userRole")
    public Integer userRole(HttpSession session) {
        Object role = session.getAttribute(LoginController.USER_ROLE_KEY);
        return role != null ? (Integer) role : 0;
    }
    
    @ModelAttribute("isAdmin")
    public boolean isAdmin(HttpSession session) {
        Integer role = userRole(session);
        return role != null && role == 1;
    }
}
