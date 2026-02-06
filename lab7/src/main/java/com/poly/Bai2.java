package com.poly;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/upload")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10MB
public class Bai2 extends HttpServlet {
    
    // GET request - chỉ để tránh lỗi 405
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("application/json");
        resp.getWriter().print("{\"message\":\"Use POST to upload file\"}");
    }
    
    // POST request - xử lý upload file
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // Thiết lập encoding
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("application/json");
        
        try {
            // Nhận file từ request
            Part filePart = req.getPart("file");
            
            if (filePart != null && filePart.getSize() > 0) {
                // Lấy thông tin file
                String fileName = filePart.getSubmittedFileName();
                long fileSize = filePart.getSize();
                String contentType = filePart.getContentType();
                
                // Lưu file vào thư mục uploads
                String uploadPath = "D:/uploads"; // Thay đổi đường dẫn phù hợp
                Files.createDirectories(Paths.get(uploadPath));
                filePart.write(uploadPath + "/" + fileName);
                
                // Tạo JSON response
                Map<String, Object> result = new HashMap<>();
                result.put("name", fileName);
                result.put("type", contentType);
                result.put("size", fileSize);
                
                // Chuyển đổi object sang JSON string
                ObjectMapper mapper = new ObjectMapper();
                String json = mapper.writeValueAsString(result);
                
                // Gửi JSON về client
                resp.getWriter().print(json);
                resp.getWriter().flush();
            } else {
                resp.getWriter().print("{\"error\":\"Không có file được upload\"}");
            }
        } catch (Exception e) {
            resp.getWriter().print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}