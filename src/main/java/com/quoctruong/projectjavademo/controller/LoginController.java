package com.quoctruong.projectjavademo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.quoctruong.projectjavademo.service.CartService;
import com.quoctruong.projectjavademo.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
    private final UserService userService;
    private final CartService cartService;
    
    public static final String USER_SESSION_KEY = "USERNAME";
    public static final String USER_ROLE_KEY = "USER_ROLE";

    public LoginController(UserService userService, CartService cartService) {
        this.userService = userService;
        this.cartService = cartService;
    }

    @GetMapping({"/login"})
    public String loginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String username, 
                         @RequestParam String password, 
                         Model model,
                         HttpSession session) {
        boolean exists = false;
        try {
            exists = userService.existsByUsernameAndPassword(username, password);
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi kết nối: " + e.getMessage());
            return "login";
        }

        if (!exists) {
            model.addAttribute("error", "Tên hoặc mật khẩu không chính xác!");
            return "login";
        }

        session.setAttribute(USER_SESSION_KEY, username);
        Integer role = userService.getUserRole(username);
        session.setAttribute(USER_ROLE_KEY, role != null ? role : 0);
        
        return "redirect:/home";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        Map<Long, Integer> cartSnapshot = cartService.getCartSnapshot(session);
        Map<Long, Integer> cartCopy = new HashMap<>(cartSnapshot);
        
        session.removeAttribute(USER_SESSION_KEY);
        session.removeAttribute(USER_ROLE_KEY);
        
        if (!cartCopy.isEmpty()) {
            session.setAttribute(CartService.CART_SESSION_KEY, cartCopy);
        } else {
            session.setAttribute(CartService.CART_SESSION_KEY, new HashMap<>());
        }
        
        
        return "redirect:/home?logout=success";
    }
}
