<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách video yêu thích</title>
</head>
<body>
<div style="background:#222;color:#fff;padding:8px 12px;">
    👥 Lượt truy cập: ${applicationScope.visitors}
</div>
<h2>DANH SÁCH VIDEO ĐÃ YÊU THÍCH</h2>

<table border="1" cellpadding="8">
    <tr>
        <th>Video</th>
        <th>Người thích</th>
        <th>Ngày</th>
    </tr>

    <c:forEach var="f" items="${favorites}">
        <tr>
            <td>${f.video.title}</td>
            <td>${f.user.fullname}</td>
            <td>${f.likeDate}</td>
        </tr>
    </c:forEach>

</table>

</body>
</html>
