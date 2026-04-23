<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2/4/2026
  Time: 12:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        body {
            margin: 0;
            height: 100vh;
            background: #0f0f0f;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: Arial, sans-serif;
            color: white;
        }

        .card {
            background: #1c1c1c;
            width: 360px;
            padding: 30px;
            border hookup: 8px;
            box-shadow: 0 0 25px rgba(0,0,0,0.6);
            text-align: center;
            border-radius: 10px;
        }

        .card h3 {
            margin-bottom: 20px;
        }

        .card input {
            width: 100%;
            padding: 12px;
            border-radius: 5px;
            border: none;
            outline: none;
            margin-bottom: 15px;
            font-size: 15px;
        }

        .card button {
            width: 100%;
            padding: 12px;
            background: #e50914;
            border: none;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }

        .card button:hover {
            background: #ff1f1f;
        }

        .error {
            margin-top: 15px;
            color: #ff4d4d;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="card">
<h3>Xác thực OTP</h3>

<form action="verify-otp" method="post">
    <input type="text" name="otp" placeholder="Nhập mã OTP" required>
    <button>Xác thực</button>
</form>
    </div>

<p style="color:red">${message}</p>
</body>
</html>
