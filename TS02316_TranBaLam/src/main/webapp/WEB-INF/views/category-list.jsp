<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý danh mục sách</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>Danh mục sách</h2>
    <a href="#" class="btn btn-primary mb-3">Thêm danh mục mới</a> <!-- Có thể mở rộng sau -->

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên danh mục</th>
            <th>Số lượng sách</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cat" items="${listCategory}">
            <tr>
                <td>${cat.id}</td>
                <td>${cat.name}</td>
                <td>${cat.books.size()}</td>
                <td>
                    <a href="#" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="#" class="btn btn-danger btn-sm"
                       onclick="return confirm('Xóa danh mục này? (Sẽ xóa sách liên quan)')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty listCategory}">
            <tr><td colspan="4" class="text-center">Chưa có danh mục nào</td></tr>
        </c:if>
        </tbody>
    </table>

    <a href="books" class="btn btn-secondary">Quay về quản lý sách</a>
</div>
</body>
</html>