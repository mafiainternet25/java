package com.quoctruong.projectjavademo.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.quoctruong.projectjavademo.controller.LoginController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AdminInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        
        String username = (String) session.getAttribute(LoginController.USER_SESSION_KEY);
        Integer role = (Integer) session.getAttribute(LoginController.USER_ROLE_KEY);
        
        if (username == null || role == null || role != 1) {
            response.sendRedirect(request.getContextPath() + "/home?error=access_denied");
            return false;
        }
        
        return true;
    }
}





