<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm video</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f8f9fa;
        }

        h2 {
            text-align: center;
        }

        .search-box {
            text-align: center;
            margin-bottom: 20px;
        }

        .search-box input[type="text"] {
            width: 250px;
            padding: 6px;
        }

        .search-box button {
            padding: 6px 12px;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ccc;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .empty {
            text-align: center;
            margin-top: 15px;
            font-style: italic;
            color: #777;
        }
    </style>
</head>

<body>
<div style="background:#222;color:#fff;padding:8px 12px;">
    👥 Lượt truy cập: ${applicationScope.visitors}
</div>
<h2>🔍 Tìm kiếm video</h2>

<div class="search-box">
    <form action="search-video" method="get">
        Từ khóa:
        <input type="text" name="keyword" value="${keyword}">
        <button type="submit">Tìm</button>
    </form>
</div>

<table>
    <tr>
        <th>Tiêu đề video</th>
        <th>Số lượt thích</th>
        <th>Còn hiệu lực</th>
    </tr>

    <c:forEach var="v" items="${videos}">
        <tr>
            <td>${v.title}</td>

            <!-- LIKE = số Favorite -->
            <td>
                    ${empty v.favorites ? 0 : v.favorites.size()}
            </td>

            <td>
                <c:choose>
                    <c:when test="${v.active}">✅ Có</c:when>
                    <c:otherwise>❌ Không</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>

<c:if test="${empty videos}">
    <p class="empty">Không có video nào</p>
</c:if>

</body>
</html>
