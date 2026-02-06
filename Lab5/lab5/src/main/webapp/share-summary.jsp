<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê chia sẻ video</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #ffffff;        /* nền trắng */
            color: #000000;             /* chữ đen */
            padding: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background: #ffffff;
        }

        th, td {
            border: 1px solid #333;
            padding: 8px 12px;
            text-align: center;
            color: #000000;             /* ép chữ đen */
        }

        th {
            background: #e0e0e0;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        tr:hover {
            background: #dff0ff;
        }
    </style>
</head>

<body>
<div style="background:#222;color:#fff;padding:8px 12px;">
    👥 Lượt truy cập: ${applicationScope.visitors}
</div>
<h2>THỐNG KÊ CHIA SẺ VIDEO</h2>

<table>
    <tr>
        <th>Tiêu đề video</th>
        <th>Số lượt chia sẻ</th>
        <th>Ngày chia sẻ đầu tiên</th>
        <th>Ngày chia sẻ cuối cùng</th>
    </tr>

    <c:forEach var="row" items="${list}">
        <tr>
            <td>${row[0]}</td>
            <td>${row[1]}</td>
            <td>${row[2]}</td>
            <td>${row[3]}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
