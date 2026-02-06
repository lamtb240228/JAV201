package com.poly;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.poly.Employee;
import com.poly.RestIO;

@WebServlet("/employees/*")
public class Bai3 extends HttpServlet {
    
    // Dữ liệu lưu trữ nhân viên (thay vì database)
    private Map<String, Employee> map = new HashMap<>();
    
    // Constructor - khởi tạo dữ liệu mẫu
    public Bai3() {
        map.put("NV01", new Employee("NV01", "Nhân viên 01", true, 500));
        map.put("NV02", new Employee("NV02", "Nhân viên 02", false, 1500));
        map.put("NV03", new Employee("NV03", "Nhân viên 03", true, 5000));
        map.put("NV04", new Employee("NV04", "Nhân viên 04", false, 2500));
        map.put("NV05", new Employee("NV05", "Nhân viên 05", true, 3500));
    }

    // GET:/employees hoặc GET:/employees/ID
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String info = req.getPathInfo();
        
        if (info == null || info.length() == 0) {
            // GET:/employees - lấy tất cả
            RestIO.writeObject(resp, map.values());
        } else {
            // GET:/employees/ID - lấy theo ID
            String id = info.substring(1).trim();
            RestIO.writeObject(resp, map.get(id));
        }
    }

    // POST:/employees - thêm nhân viên mới
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Employee employee = RestIO.readObject(req, Employee.class);
        map.put(employee.getId(), employee);
        RestIO.writeObject(resp, employee);
    }

    // PUT:/employees/ID - cập nhật nhân viên
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getPathInfo().substring(1).trim();
        Employee employee = RestIO.readObject(req, Employee.class);
        map.put(id, employee);
        RestIO.writeEmptyObject(resp);
    }

    // DELETE:/employees/ID - xóa nhân viên
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getPathInfo().substring(1).trim();
        map.remove(id);
        RestIO.writeEmptyObject(resp);
    }
}