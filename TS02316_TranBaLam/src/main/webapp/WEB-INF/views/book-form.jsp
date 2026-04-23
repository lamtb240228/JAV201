<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${book != null ? 'Sửa sách' : 'Thêm sách mới'}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>${book != null ? 'Sửa thông tin sách' : 'Thêm sách mới'}</h2>
        <form action="books" method="post">
            <input type="hidden" name="action" value="save">
            <c:if test="${book != null}">
                <input type="hidden" name="id" value="${book.id}">
            </c:if>

            <div class="mb-3">
                <label>Tiêu đề:</label>
                <input type="text" name="title" class="form-control" value="${book.title}" required>
            </div>
            <div class="mb-3">
                <label>Tác giả:</label>
                <input type="text" name="author" class="form-control" value="${book.author}" required>
            </div>
            <div class="mb-3">
                <label>Giá:</label>
                <input type="number" step="0.01" name="price" class="form-control" value="${book.price}" required>
            </div>
            <div class="mb-3">
                <label>Danh mục:</label>
                <select name="categoryId" class="form-select" required>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}" ${book.category.id == cat.id ? 'selected' : ''}>
                            ${cat.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-success">Lưu</button>
            <a href="books" class="btn btn-secondary">Quay lại</a>
        </form>
    </div>
</body>
</html>
