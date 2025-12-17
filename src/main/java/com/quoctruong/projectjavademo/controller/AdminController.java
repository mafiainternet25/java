package com.quoctruong.projectjavademo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctruong.projectjavademo.model.Product;
import com.quoctruong.projectjavademo.service.ProductService;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private final ProductService productService;

    public AdminController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/products")
    public String listProducts(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        return "admin/products";
    }

    @GetMapping("/products/new")
    public String showCreateForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", productService.getAllCategories());
        return "admin/product-form";
    }

    @PostMapping("/products/new")
    public String createProduct(@ModelAttribute Product product, 
                                @RequestParam(required = false) String categoryNew,
                                RedirectAttributes redirectAttributes) {
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Tên sản phẩm không được để trống");
            return "redirect:/admin/products/new";
        }
        
        if (product.getPrice() <= 0) {
            redirectAttributes.addFlashAttribute("error", "Giá sản phẩm phải lớn hơn 0");
            return "redirect:/admin/products/new";
        }
        
        if (categoryNew != null && !categoryNew.trim().isEmpty()) {
            product.setCategory(categoryNew.trim());
        }
        
        boolean success = productService.createProduct(product);
        if (success) {
            redirectAttributes.addFlashAttribute("success", "Thêm sản phẩm thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Thêm sản phẩm thất bại!");
        }
        return "redirect:/admin/products";
    }

    @GetMapping("/products/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Product product = productService.getProductById(id);
        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm");
            return "redirect:/admin/products";
        }
        model.addAttribute("product", product);
        model.addAttribute("categories", productService.getAllCategories());
        return "admin/product-form";
    }

    @PostMapping("/products/{id}/edit")
    public String updateProduct(@PathVariable Long id, 
                                @ModelAttribute Product product,
                                @RequestParam(required = false) String categoryNew,
                                RedirectAttributes redirectAttributes) {
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Tên sản phẩm không được để trống");
            return "redirect:/admin/products/" + id + "/edit";
        }
        
        if (product.getPrice() <= 0) {
            redirectAttributes.addFlashAttribute("error", "Giá sản phẩm phải lớn hơn 0");
            return "redirect:/admin/products/" + id + "/edit";
        }
        
        if (categoryNew != null && !categoryNew.trim().isEmpty()) {
            product.setCategory(categoryNew.trim());
        } else if (product.getCategory() == null || product.getCategory().trim().isEmpty()) {
            Product existingProduct = productService.getProductById(id);
            if (existingProduct != null) {
                product.setCategory(existingProduct.getCategory());
            }
        }
        
        product.setId(id);
        boolean success = productService.updateProduct(product);
        if (success) {
            redirectAttributes.addFlashAttribute("success", "Cập nhật sản phẩm thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Cập nhật sản phẩm thất bại!");
        }
        return "redirect:/admin/products";
    }

    @PostMapping("/products/{id}/delete")
    public String deleteProduct(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        boolean success = productService.deleteProduct(id);
        if (success) {
            redirectAttributes.addFlashAttribute("success", "Xóa sản phẩm thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Xóa sản phẩm thất bại!");
        }
        return "redirect:/admin/products";
    }
}

