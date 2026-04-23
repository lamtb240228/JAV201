package controller;

import dao.BookDAO;
import dao.CategoryDAO;
import model.Book;
import model.Category;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BookServlet", urlPatterns = {"/books", "/books/*"})
public class BookServlet extends HttpServlet {

    private final BookDAO bookDAO = new BookDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        String action = (pathInfo == null || pathInfo.equals("/")) ? "" : pathInfo.substring(1);

        switch (action) {
            case "":
            case "list":
                listBooks(request, response);
                break;
            case "new":
                showNewBookForm(request, response);
                break;
            case "edit":
                showEditBookForm(request, response);
                break;
            case "delete":
                deleteBook(request, response);
                break;
            case "search":
                searchBooks(request, response);
                break;
            default:
                listBooks(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("save".equals(action)) {
            saveBook(request, response);
        } else {
            response.sendRedirect("books");
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> list = bookDAO.getAllBooks();
        request.setAttribute("listBook", list);
        forwardTo(request, response, "/WEB-INF/views/book-list.jsp");
    }

    private void showNewBookForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        forwardTo(request, response, "/WEB-INF/views/book-form.jsp");
    }

    private void showEditBookForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            Book book = bookDAO.getBookById(id);
            if (book != null) {
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("book", book);
                request.setAttribute("categories", categories);
                forwardTo(request, response, "/WEB-INF/views/book-form.jsp");
                return;
            }
        }
        response.sendRedirect("books");
    }

    private void saveBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String idStr = request.getParameter("id");
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String priceStr = request.getParameter("price");
            String catIdStr = request.getParameter("categoryId");

            int categoryId = Integer.parseInt(catIdStr);
            double price = Double.parseDouble(priceStr);

            Category category = categoryDAO.getCategoryById(categoryId);

            Book book = new Book();
            if (idStr != null && !idStr.trim().isEmpty()) {
                book.setId(Integer.parseInt(idStr));
            }
            book.setTitle(title);
            book.setAuthor(author);
            book.setPrice(price);
            book.setCategory(category);

            bookDAO.saveOrUpdate(book);
        } catch (Exception e) {
            e.printStackTrace();
            // Có thể thêm thông báo lỗi nếu muốn
        }
        response.sendRedirect("books");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            bookDAO.deleteById(id);
        }
        response.sendRedirect("books");
    }

    private void searchBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";
        List<Book> list = bookDAO.searchByTitle(keyword);
        request.setAttribute("listBook", list);
        request.setAttribute("keyword", keyword); // để giữ giá trị ô tìm kiếm
        forwardTo(request, response, "/WEB-INF/views/book-list.jsp");
    }

    private void forwardTo(HttpServletRequest req, HttpServletResponse resp, String path)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher(path);
        dispatcher.forward(req, resp);
    }
}