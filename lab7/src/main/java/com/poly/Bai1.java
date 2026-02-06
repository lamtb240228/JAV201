package com.poly;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/api/employee")
public class Bai1 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("application/json");
        
        // Tạo chuỗi JSON
        String json = "{\"manv\":\"TeoNV\",\"hoTen\":\"Nguyễn Văn Tèo\",\"gioiTinh\":true,\"luong\":950.5}";
        
        resp.getWriter().print(json);
    }
}