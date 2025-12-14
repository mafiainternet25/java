package com.quoctruong.projectjavademo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.quoctruong.projectjavademo.model.Product;

@Service
public class ChatbotService {
    private final ProductService productService;

    public ChatbotService(ProductService productService) {
        this.productService = productService;
    }

    public String processMessage(String message) {
        if (message == null || message.trim().isEmpty()) {
            return "Xin chào! Tôi có thể giúp gì cho bạn? Hãy thử các câu hỏi ví dụ: 'Có khuyến mãi gì hôm nay?', 'Theo dõi đơn hàng', 'Tôi cần size M', 'Có mã giảm giá?'";
        }
        
        return processMessageFallback(message);
    }
    
    private String processMessageFallback(String message) {
        if (message == null || message.trim().isEmpty()) {
            return "Xin chào! Tôi có thể giúp gì cho bạn?";
        }

        String lowerMessage = message.toLowerCase().trim();

        if (lowerMessage.contains("xin chào") || lowerMessage.contains("hello") || 
            lowerMessage.contains("chào") || lowerMessage.contains("hi")) {
            return "Xin chào! 👋 Tôi là trợ lý ảo của QUOCSHOP. Tôi có thể giúp bạn:\n" +
                   "• Tìm kiếm sản phẩm\n" +
                   "• Hướng dẫn sử dụng website\n" +
                   "• Thông tin về chính sách\n" +
                   "• Hỗ trợ đặt hàng\n\n" +
                   "Bạn có thể thử các câu hỏi ví dụ: \n" +
                   "• Có khuyến mãi gì hôm nay?\n" +
                   "• Theo dõi đơn hàng [mã đơn]\n" +
                   "• Tôi cần size M, làm sao chọn size phù hợp?\n" +
                   "• Có mã giảm giá hoặc voucher không?\n\n" +
                   "Bạn cần hỗ trợ gì?";
        }

        if (lowerMessage.contains("khuyến mãi") || lowerMessage.contains("ưu đãi") || lowerMessage.contains("giảm giá") || lowerMessage.contains("voucher") || lowerMessage.contains("mã giảm giá")) {
            return "🎉 **Khuyến mãi & Voucher:**\n\n" +
                   "• QUOCSHOP thường có khuyến mãi vào các dịp lễ và tuần sale.\n" +
                   "• Kiểm tra banner trên trang chủ hoặc phần Khuyến mãi.\n" +
                   "• Mã giảm giá sẽ được nhập ở bước thanh toán.\n" +
                   "• Nếu bạn có mã, nhập mã vào ô 'Mã giảm giá' khi thanh toán để áp dụng.";
        }

        if (lowerMessage.contains("theo dõi") || lowerMessage.contains("tracking") || lowerMessage.contains("mã đơn") || lowerMessage.contains("mã vận đơn") || lowerMessage.contains("mã đơn hàng")) {
            return "📦 **Theo dõi đơn hàng:**\n\n" +
                   "• Để theo dõi đơn hàng, vào trang 'Đơn mua' hoặc 'Orders' trong phần tài khoản.\n" +
                   "• Nhập mã đơn hàng (ví dụ: ORDER12345) để xem trạng thái vận chuyển.\n" +
                   "• Nếu bạn không nhớ mã đơn, liên hệ CSKH để hỗ trợ lấy lại thông tin đơn hàng.";
        }

        if (lowerMessage.contains("size") || lowerMessage.contains("kích thước") || lowerMessage.contains("kích cỡ")) {
            return "📏 **Hướng dẫn chọn size:**\n\n" +
                   "• Vui lòng tham khảo bảng size trên trang chi tiết sản phẩm.\n" +
                   "• Đo vòng ngực, vòng eo, vòng mông và so sánh với bảng size.\n" +
                   "• Nếu bạn còn băn khoăn, cho tôi biết số đo của bạn và mình sẽ gợi ý size phù hợp.";
        }

        if (lowerMessage.contains("phương thức thanh toán") || lowerMessage.contains("payment method") || lowerMessage.contains("thanh toán bằng")) {
            return "💳 **Phương thức thanh toán:**\n\n" +
                   "• Thanh toán khi nhận hàng (COD)\n" +
                   "• Thẻ tín dụng/ghi nợ (Visa, MasterCard)\n" +
                   "• Chuyển khoản ngân hàng\n" +
                   "• Ví điện tử (nếu có hỗ trợ)\n\n" +
                   "Bạn muốn thanh toán bằng phương thức nào?";
        }

        if (lowerMessage.contains("tìm") || lowerMessage.contains("search") || 
            lowerMessage.contains("có") || lowerMessage.contains("bán") ||
            lowerMessage.contains("sản phẩm")) {
            return handleProductSearch(lowerMessage);
        }

        if (lowerMessage.contains("giá") || lowerMessage.contains("price") ||
            lowerMessage.contains("bao nhiêu")) {
            return handlePriceQuery(lowerMessage);
        }

        if (lowerMessage.contains("danh mục") || lowerMessage.contains("category") ||
            lowerMessage.contains("loại") || lowerMessage.contains("mục")) {
            return handleCategoryQuery();
        }

        if (lowerMessage.contains("đặt hàng") || lowerMessage.contains("mua") ||
            lowerMessage.contains("order") || lowerMessage.contains("thanh toán")) {
            return "📦 **Hướng dẫn đặt hàng:**\n\n" +
                   "1. Tìm sản phẩm bạn muốn mua\n" +
                   "2. Nhấn vào sản phẩm để xem chi tiết\n" +
                   "3. Chọn 'Thêm vào giỏ' để thêm vào giỏ hàng\n" +
                   "4. Vào giỏ hàng và nhấn 'Thanh toán'\n" +
                   "5. Điền thông tin và xác nhận đơn hàng\n\n" +
                   "Bạn có thể tìm sản phẩm bằng cách gõ: 'Tìm [tên sản phẩm]'";
        }

        if (lowerMessage.contains("giỏ hàng") || lowerMessage.contains("cart")) {
            return "🛒 **Giỏ hàng:**\n\n" +
                   "Để xem giỏ hàng, bạn có thể:\n" +
                   "• Click vào icon giỏ hàng ở góc trên bên phải\n" +
                   "• Hoặc truy cập menu 'Giỏ hàng'\n\n" +
                   "Trong giỏ hàng bạn có thể:\n" +
                   "• Xem các sản phẩm đã thêm\n" +
                   "• Thay đổi số lượng\n" +
                   "• Xóa sản phẩm\n" +
                   "• Thanh toán";
        }

        if (lowerMessage.contains("chính sách") || lowerMessage.contains("policy") ||
            lowerMessage.contains("đổi trả") || lowerMessage.contains("bảo hành") ||
            lowerMessage.contains("giao hàng")) {
            return "📋 **Chính sách của QUOCSHOP:**\n\n" +
                   "🚚 **Giao hàng:**\n" +
                   "• Giao hàng miễn phí cho đơn hàng trên 500.000₫\n" +
                   "• Thời gian giao hàng: 2-5 ngày làm việc\n\n" +
                   "🔄 **Đổi trả:**\n" +
                   "• Đổi trả trong vòng 30 ngày\n" +
                   "• Sản phẩm phải còn nguyên tem, nhãn mác\n\n" +
                   "🛡️ **Bảo hành:**\n" +
                   "• Bảo hành chất lượng sản phẩm\n" +
                   "• Hỗ trợ khách hàng 24/7";
        }

        if (lowerMessage.contains("thông tin") || lowerMessage.contains("info") ||
            lowerMessage.contains("website") || lowerMessage.contains("shop")) {
            return "ℹ️ **Thông tin về QUOCSHOP:**\n\n" +
                   "QUOCSHOP là cửa hàng thời trang online chuyên cung cấp:\n" +
                   "• Quần áo nam, nữ\n" +
                   "• Phụ kiện thời trang\n" +
                   "• Chất lượng cao, giá cả hợp lý\n\n" +
                   "Bạn có thể:\n" +
                   "• Tìm kiếm sản phẩm theo danh mục\n" +
                   "• Lọc theo giá, loại sản phẩm\n" +
                   "• Lưu sản phẩm yêu thích\n" +
                   "• Theo dõi đơn hàng";
        }

        if (lowerMessage.contains("yêu thích") || lowerMessage.contains("favorite") ||
            lowerMessage.contains("thích")) {
            return "❤️ **Sản phẩm yêu thích:**\n\n" +
                   "Để lưu sản phẩm yêu thích:\n" +
                   "1. Xem chi tiết sản phẩm\n" +
                   "2. Nhấn nút 'Yêu thích' (icon trái tim)\n" +
                   "3. Xem danh sách yêu thích trong menu 'Đã thích'\n\n" +
                   "Bạn có thể quản lý danh sách yêu thích của mình dễ dàng!";
        }

        if (lowerMessage.contains("tài khoản") || lowerMessage.contains("account") ||
            lowerMessage.contains("đăng nhập") || lowerMessage.contains("đăng ký")) {
            return "👤 **Tài khoản:**\n\n" +
                   "• **Đăng ký:** Truy cập menu 'Đăng ký' để tạo tài khoản mới\n" +
                   "• **Đăng nhập:** Click 'Đăng nhập' ở góc trên bên phải\n" +
                   "• **Quản lý tài khoản:** Sau khi đăng nhập, vào menu 'Tài khoản'\n\n" +
                   "Tài khoản giúp bạn:\n" +
                   "• Lưu sản phẩm yêu thích\n" +
                   "• Theo dõi đơn hàng\n" +
                   "• Quản lý thông tin cá nhân";
        }

        return "Xin lỗi, tôi chưa hiểu câu hỏi của bạn. 😅\n\n" +
               "Bạn có thể hỏi tôi về:\n" +
               "• Tìm kiếm sản phẩm (ví dụ: 'Tìm áo thun')\n" +
               "• Giá sản phẩm\n" +
               "• Hướng dẫn đặt hàng\n" +
               "• Chính sách giao hàng, đổi trả\n" +
               "• Thông tin về website\n\n" +
               "Hoặc gõ 'Xin chào' để xem menu hỗ trợ!";
    }

    private String handleProductSearch(String message) {
        String keyword = extractKeyword(message);
        
        if (keyword.isEmpty()) {
            List<String> categories = productService.getAllCategories();
            return "🔍 **Tìm kiếm sản phẩm:**\n\n" +
                   "Bạn có thể tìm sản phẩm bằng cách:\n" +
                   "• Gõ 'Tìm [tên sản phẩm]' (ví dụ: 'Tìm áo thun')\n" +
                   "• Hoặc sử dụng thanh tìm kiếm ở header\n\n" +
                   "**Danh mục sản phẩm hiện có:**\n" +
                   String.join(", ", categories) + "\n\n" +
                   "Bạn muốn tìm sản phẩm gì?";
        }

        List<Product> products = productService.searchProducts(keyword, null, null, null);
        
        if (products.isEmpty()) {
            return "😔 Không tìm thấy sản phẩm nào với từ khóa '" + keyword + "'.\n\n" +
                   "Bạn có thể thử:\n" +
                   "• Tìm kiếm với từ khóa khác\n" +
                   "• Xem các danh mục sản phẩm\n" +
                   "• Hoặc sử dụng thanh tìm kiếm nâng cao trên website";
        }

        StringBuilder response = new StringBuilder();
        response.append("🔍 Tìm thấy ").append(products.size()).append(" sản phẩm:\n\n");
        
        int count = Math.min(products.size(), 5); 
        for (int i = 0; i < count; i++) {
            Product p = products.get(i);
            response.append("• **").append(p.getName()).append("**\n");
            response.append("  Giá: ").append(formatPrice(p.getPrice())).append("\n");
            response.append("  Danh mục: ").append(p.getCategory()).append("\n\n");
        }
        
        if (products.size() > 5) {
            response.append("... và ").append(products.size() - 5).append(" sản phẩm khác.\n\n");
        }
        
        response.append("👉 Bạn có thể xem chi tiết và đặt hàng trên website!");
        
        return response.toString();
    }

    private String handlePriceQuery(String message) {
        String keyword = extractKeyword(message);
        
        if (keyword.isEmpty()) {
            return "💰 **Tìm kiếm giá sản phẩm:**\n\n" +
                   "Bạn có thể hỏi giá bằng cách:\n" +
                   "• 'Giá [tên sản phẩm]' (ví dụ: 'Giá áo thun')\n" +
                   "• Hoặc tìm sản phẩm và xem giá trên website";
        }

        List<Product> products = productService.searchProducts(keyword, null, null, null);
        
        if (products.isEmpty()) {
            return "Không tìm thấy sản phẩm '" + keyword + "' để xem giá.";
        }

        Product product = products.get(0);
        return "💰 **" + product.getName() + "**\n\n" +
               "Giá: **" + formatPrice(product.getPrice()) + "**\n" +
               "Danh mục: " + product.getCategory() + "\n\n" +
               "👉 Xem chi tiết sản phẩm trên website để đặt hàng!";
    }

    private String handleCategoryQuery() {
        List<String> categories = productService.getAllCategories();
        
        if (categories.isEmpty()) {
            return "Hiện tại chưa có danh mục sản phẩm nào.";
        }

        StringBuilder response = new StringBuilder();
        response.append("📂 **Danh mục sản phẩm:**\n\n");
        
        for (String category : categories) {
            List<Product> products = productService.getProductsByCategory(category, 1);
            response.append("• **").append(category).append("**");
            if (!products.isEmpty()) {
                response.append(" - ").append(formatPrice(products.get(0).getPrice()));
            }
            response.append("\n");
        }
        
        response.append("\n👉 Bạn có thể tìm sản phẩm theo danh mục trên website!");
        
        return response.toString();
    }

    private String extractKeyword(String message) {
        String[] stopWords = {"tìm", "search", "có", "bán", "sản phẩm", "giá", "price", 
                             "bao nhiêu", "cho tôi", "tôi muốn", "muốn", "cần"};
        
        String keyword = message;
        for (String stopWord : stopWords) {
            keyword = keyword.replace(stopWord, "").trim();
        }
        
        return keyword;
    }

    private String formatPrice(double price) {
        return String.format("%,.0f₫", price);
    }

    public List<String> getPredefinedQuestions() {
        return List.of(
            "Có khuyến mãi gì hôm nay?",
            "Theo dõi đơn hàng [mã đơn]",
            "Tôi cần size M, làm sao chọn?",
            "Có mã giảm giá hoặc voucher không?",
            "Các phương thức thanh toán nào được hỗ trợ?"
        );
    }
}

