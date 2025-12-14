package com.quoctruong.projectjavademo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.quoctruong.projectjavademo.model.Order;
import com.quoctruong.projectjavademo.service.OrderService;

import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }
    
    private String getUserId(HttpSession session) {
        Object username = session.getAttribute(LoginController.USER_SESSION_KEY);
        return username != null ? username.toString() : "guest";
    }

    @GetMapping("/orders")
    public String viewOrders(Model model, HttpSession session) {
        String userId = getUserId(session);
        List<Order> orders = orderService.getOrdersByUserId(userId);
        model.addAttribute("orders", orders);
        return "orders";
    }
}
