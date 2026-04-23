<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sách</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Danh sách sách</h2>
        <a href="books/new" class="btn btn-primary">Thêm sách mới</a>

        <form action="books/search" method="get" class="my-3">
            <input type="text" name="keyword" placeholder="Tìm theo tên sách..." />
            <button type="submit" class="btn btn-info">Tìm</button>
        </form>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tiêu đề</th>
                    <th>Tác giả</th>
                    <th>Giá</th>
                    <th>Danh mục</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${listBook}">
                    <tr>
                        <td>${book.id}</td>
                        <td>${book.title}</td>
                        <td>${book.author}</td>
                        <td>${book.price}</td>
                        <td>${book.category.name}</td>
                        <td>
                            <a href="books/edit?id=${book.id}" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="books/delete?id=${book.id}" class="btn btn-danger btn-sm"
                               onclick="return confirm('Xóa sách này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>