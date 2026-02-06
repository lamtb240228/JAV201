<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f4f7;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-box {
            width: 350px;
            padding: 25px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .login-box h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .login-box input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .login-box button {
            width: 100%;
            padding: 10px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .login-box button:hover {
            background: #43a047;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>Đăng nhập</h2>

    <form action="login" method="post">
        <!-- Tên này phải trùng với servlet -->
        <input type="text" name="username"
               placeholder="Username hoặc Email" required>

        <input type="password" name="password"
               placeholder="Mật khẩu" required>

        <button type="submit">Đăng nhập</button>
    </form>

    <!-- Hiển thị lỗi -->
    <c:if test="${not empty message}">
        <div class="error">${message}</div>
    </c:if>
</div>

</body>
</html>
