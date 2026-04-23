<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 1/30/2026
  Time: 2:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Quên mật khẩu</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .left {
            flex: 1;
            background-color: #e63946; /* đỏ */
            color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }
        .left h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }
        .left p {
            font-size: 18px;
            line-height: 1.6;
        }
        .right {
            flex: 1;
            background-color: #121212; /* đen */
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .form-box {
            width: 300px;
            background-color: #1e1e1e;
            padding: 30px;
            border-radius: 8px;
        }
        .form-box h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        .form-box label {
            display: block;
            margin-bottom: 8px;
        }
        .form-box input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: none;
            border-radius: 4px;
        }
        .form-box button {
            width: 100%;
            padding: 10px;
            background-color: #fb0505; /* xanh */
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }
        .form-box button:hover {
            background-color: #fb0505;
        }
        .message {
            color: #ffcc00;
            text-align: center;
            margin-bottom: 10px;
        }


    </style>


</head>
<body>
<div class="container">
<div class="right">
    <div class="form-box">
<h2>Quên mật khẩu</h2>
<form action="${pageContext.request.contextPath}/forgot-password" method="post">
    <label for="email">Email</label>
    <input type="email" id="email" name="email" required><br><br>
    <h3>Xác thực email</h3>
    <p>Nhấn nút bên dưới để xác thực email của bạn</p>

    <form action="verify-email" method="post">
        <button>Xác thực email</button>
    </form>
</form>


<!-- Hiển thị thông báo bằng JSTL -->
<c:if test="${not empty message}">
    <p style="color:red">${message}</p>
</c:if>
    </div>
</div>
</div>

</body>
</html>
