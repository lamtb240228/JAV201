<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Favorite Videos</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .container {
            width: 500px;
            margin: 50px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 5px;
        }

        h3 {
            color: #555;
            margin-bottom: 15px;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        li {
            padding: 8px 10px;
            margin-bottom: 8px;
            background: #ecf0f1;
            border-radius: 6px;
        }

        li:hover {
            background: #dfe6e9;
        }
    </style>
</head>
<body>
<div style="background:#222;color:#fff;padding:8px 12px;">
    👥 Lượt truy cập: ${applicationScope.visitors}
</div>
<div class="container">

    <h2>${user.fullname}</h2>
    <h3>Các video đã yêu thích</h3>

    <c:if test="${empty user.favorites}">
        <p>Người dùng chưa yêu thích video nào.</p>
    </c:if>

    <ul>
        <c:forEach var="f" items="${user.favorites}">
            <li>✔ ${f.video.title}</li>
        </c:forEach>
    </ul>

</div>

</body>
</html>
