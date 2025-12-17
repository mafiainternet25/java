package com.quoctruong.projectjavademo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.quoctruong.projectjavademo.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AccountController {
    private final UserService userService;

    public AccountController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/account")
    public String accountForm() {
        return "account";
    }

    @PostMapping("/account")
    public String updateAccount(@RequestParam String currentUsername,
                                @RequestParam String currentPassword,
                                @RequestParam(required = false) String newUsername,
                                @RequestParam(required = false) String newPassword,
                                @RequestParam(required = false) String confirmPassword,
                                Model model,
                                HttpSession session) {
        boolean updateUsername = newUsername != null && !newUsername.isBlank();
        boolean updatePassword = newPassword != null && !newPassword.isBlank();
        
        if (!updateUsername && !updatePassword) {
            model.addAttribute("error", "Vui lòng nhập ít nhất username mới hoặc mật khẩu mới.");
            return "account";
        }
        
        if (updatePassword) {
            if (confirmPassword == null || confirmPassword.isBlank()) {
                model.addAttribute("error", "Vui lòng xác nhận mật khẩu mới.");
                return "account";
            }
            if (!newPassword.equals(confirmPassword)) {
                model.addAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
                return "account";
            }
        }
        
        if (updateUsername && newUsername.equals(currentUsername)) {
            updateUsername = false; 
        }
        
        boolean ok = false;
        String successMessage = "";
        
        try {
            if (updateUsername && updatePassword) {
                ok = userService.updateUsernameAndPassword(currentUsername, currentPassword, newUsername, newPassword);
                if (ok) {
                    session.setAttribute(LoginController.USER_SESSION_KEY, newUsername);
                    successMessage = "Cập nhật tài khoản thành công. Username và mật khẩu đã được thay đổi.";
                }
            } else if (updateUsername) {
                ok = userService.updateUsername(currentUsername, currentPassword, newUsername);
                if (ok) {
                    session.setAttribute(LoginController.USER_SESSION_KEY, newUsername);
                    successMessage = "Cập nhật username thành công.";
                }
            } else if (updatePassword) {
                ok = userService.updatePassword(currentUsername, currentPassword, newPassword);
                if (ok) {
                    successMessage = "Cập nhật mật khẩu thành công.";
                }
            }
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi cập nhật: " + e.getMessage());
            return "account";
        }

        if (!ok) {
            if (updateUsername && userService.existsByUsername(newUsername)) {
                model.addAttribute("error", "Username mới đã tồn tại. Vui lòng chọn username khác.");
            } else {
                model.addAttribute("error", "Thông tin hiện tại không đúng hoặc cập nhật thất bại.");
            }
            return "account";
        }

        model.addAttribute("success", successMessage);
        return "account";
    }
}
