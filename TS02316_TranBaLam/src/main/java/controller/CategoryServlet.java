package controller;

import dao.CategoryDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/categories")
public class CategoryServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        var categories = categoryDAO.getAllCategories();
        request.setAttribute("listCategory", categories);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/category-list.jsp");
        rd.forward(request, response);
    }

    // Có thể thêm doPost để thêm/sửa/xóa danh mục nếu cần
}