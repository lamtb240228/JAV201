<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2/1/2026
  Time: 4:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê yêu thích</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Urbanist:wght@300;400;600;700;800&family=JetBrains+Mono:wght@400;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-primary: #0a0a0a;
            --bg-secondary: #111111;
            --bg-elevated: #1a1a1a;
            --accent-cyan: #00d9ff;
            --accent-purple: #b537f2;
            --accent-green: #00ff88;
            --text-primary: #ffffff;
            --text-secondary: #a0a0a0;
            --text-dim: #606060;
            --border: rgba(255, 255, 255, 0.08);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: 'Urbanist', sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated grid background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image:
                    linear-gradient(rgba(0, 217, 255, 0.03) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(0, 217, 255, 0.03) 1px, transparent 1px);
            background-size: 50px 50px;
            pointer-events: none;
            z-index: 0;
            animation: gridMove 20s linear infinite;
        }

        @keyframes gridMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(50px, 50px); }
        }

        /* Gradient orbs */
        body::after {
            content: '';
            position: fixed;
            top: -50%;
            right: -20%;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(181, 55, 242, 0.15) 0%, transparent 70%);
            pointer-events: none;
            z-index: 0;
            animation: orbFloat 15s ease-in-out infinite;
        }

        @keyframes orbFloat {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(-10%, 10%) scale(1.1); }
        }

        .container {
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 0 auto;
            padding: 80px 40px;
        }

        /* Header Section */
        .header {
            text-align: center;
            margin-bottom: 80px;
            position: relative;
        }

        .header::before {
            content: '';
            position: absolute;
            top: -40px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, var(--accent-cyan), var(--accent-purple));
            border-radius: 2px;
            animation: headerBarExpand 1s ease-out;
        }

        @keyframes headerBarExpand {
            from { width: 0; opacity: 0; }
            to { width: 100px; opacity: 1; }
        }

        h2 {
            font-size: clamp(2.5rem, 6vw, 4rem);
            font-weight: 800;
            letter-spacing: -0.03em;
            margin-bottom: 16px;
            background: linear-gradient(135deg, var(--accent-cyan) 0%, var(--accent-purple) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: titleFadeIn 0.8s ease-out;
        }

        @keyframes titleFadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header-subtitle {
            font-size: 1.125rem;
            color: var(--text-secondary);
            font-weight: 300;
            letter-spacing: 0.05em;
        }

        /* Stats Table */
        .table-wrapper {
            background: var(--bg-secondary);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
            margin-bottom: 100px;
            box-shadow:
                    0 20px 60px rgba(0, 0, 0, 0.5),
                    0 0 0 1px rgba(255, 255, 255, 0.05);
            animation: tableSlideUp 0.8s ease-out 0.2s both;
        }

        @keyframes tableSlideUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 24px 32px;
            text-align: left;
            border-bottom: 1px solid var(--border);
        }

        th {
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.1) 0%, rgba(181, 55, 242, 0.1) 100%);
            font-weight: 700;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--accent-cyan);
            position: sticky;
            top: 0;
            z-index: 10;
        }

        tbody tr {
            transition: all 0.3s ease;
            position: relative;
        }

        tbody tr::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(90deg, rgba(0, 217, 255, 0.1), transparent);
            transition: width 0.3s ease;
            pointer-events: none;
        }

        tbody tr:hover::before {
            width: 100%;
        }

        tbody tr:hover {
            background: rgba(255, 255, 255, 0.02);
            transform: translateX(8px);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        td {
            color: var(--text-primary);
            font-size: 1rem;
        }

        td:first-child {
            font-family: 'JetBrains Mono', monospace;
            color: var(--accent-cyan);
            font-weight: 600;
        }

        td:nth-child(2) {
            font-weight: 600;
        }

        td:last-child {
            font-family: 'JetBrains Mono', monospace;
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--accent-green);
        }

        /* Filter Section */
        .filter-section {
            margin-top: 100px;
            padding-top: 80px;
            border-top: 1px solid var(--border);
            position: relative;
            animation: filterFadeIn 0.8s ease-out 0.4s both;
        }

        @keyframes filterFadeIn {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .filter-section::before {
            content: '';
            position: absolute;
            top: -2px;
            left: 0;
            width: 200px;
            height: 4px;
            background: linear-gradient(90deg, var(--accent-purple), transparent);
        }

        .filter-section h2 {
            font-size: clamp(2rem, 4vw, 3rem);
            margin-bottom: 40px;
            background: linear-gradient(135deg, var(--accent-purple) 0%, var(--accent-cyan) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Form Styling */
        form {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 60px;
        }

        form label {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-secondary);
            letter-spacing: 0.02em;
        }

        select {
            flex: 1;
            min-width: 320px;
            padding: 18px 24px;
            font-family: 'Urbanist', sans-serif;
            font-size: 1rem;
            font-weight: 500;
            background: var(--bg-elevated);
            color: var(--text-primary);
            border: 2px solid var(--border);
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg width='12' height='8' viewBox='0 0 12 8' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1L6 6L11 1' stroke='%2300d9ff' stroke-width='2' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 20px center;
            padding-right: 50px;
        }

        select:hover {
            border-color: var(--accent-cyan);
            background-color: rgba(0, 217, 255, 0.05);
        }

        select:focus {
            outline: none;
            border-color: var(--accent-cyan);
            box-shadow: 0 0 0 4px rgba(0, 217, 255, 0.1);
        }

        option {
            background: var(--bg-elevated);
            color: var(--text-primary);
            padding: 12px;
        }

        /* Users Table */
        .users-table-wrapper {
            background: var(--bg-secondary);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
            margin-top: 40px;
            box-shadow:
                    0 20px 60px rgba(0, 0, 0, 0.5),
                    0 0 0 1px rgba(255, 255, 255, 0.05);
            animation: usersTableFadeIn 0.6s ease-out;
        }

        @keyframes usersTableFadeIn {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .users-table-wrapper th {
            background: linear-gradient(135deg, rgba(181, 55, 242, 0.1) 0%, rgba(0, 217, 255, 0.1) 100%);
            color: var(--accent-purple);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 40px !important;
            color: var(--text-dim) !important;
            font-size: 1.125rem !important;
            font-weight: 400 !important;
            background: rgba(255, 255, 255, 0.01) !important;
        }

        .empty-state::before {
            content: '📊';
            display: block;
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        /* Date formatting */
        td:last-child:not(:only-child) {
            font-family: 'JetBrains Mono', monospace;
            color: var(--text-secondary);
            font-size: 0.938rem;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .container {
                padding: 60px 30px;
            }

            th, td {
                padding: 20px 24px;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 40px 20px;
            }

            .header {
                margin-bottom: 60px;
            }

            h2 {
                font-size: 2.5rem;
            }

            th, td {
                padding: 16px 20px;
                font-size: 0.938rem;
            }

            th {
                font-size: 0.75rem;
            }

            form {
                flex-direction: column;
                align-items: stretch;
            }

            form label {
                font-size: 1rem;
            }

            select {
                min-width: 100%;
            }

            .table-wrapper {
                margin-bottom: 60px;
            }

            .filter-section {
                margin-top: 60px;
                padding-top: 60px;
            }

            /* Stack table cells on mobile */
            tbody tr {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 12px;
                padding: 20px;
                border-bottom: 1px solid var(--border);
            }

            tbody tr:hover {
                transform: none;
            }

            th {
                display: none;
            }

            td {
                border: none;
                padding: 0;
            }

            td::before {
                content: attr(data-label);
                display: block;
                font-size: 0.75rem;
                color: var(--text-dim);
                text-transform: uppercase;
                letter-spacing: 0.05em;
                margin-bottom: 4px;
            }

            td:first-child {
                grid-column: 1 / -1;
            }
        }

        /* Loading animation */
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.5;
            }
        }

        /* Smooth reveals */
        .reveal {
            animation: reveal 0.6s ease-out both;
        }

        @keyframes reveal {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 12px;
            height: 12px;
        }

        ::-webkit-scrollbar-track {
            background: var(--bg-primary);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--border);
            border-radius: 6px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: rgba(0, 217, 255, 0.3);
        }

        /* Selection */
        ::selection {
            background: rgba(0, 217, 255, 0.3);
            color: var(--text-primary);
        }

        /* Accessibility focus states */
        select:focus-visible {
            outline: 2px solid var(--accent-cyan);
            outline-offset: 2px;
        }
    </style>

</head>
<body>
<div class="container">
    <div class="header">
        <h2>Thống kê yêu thích</h2>
        <p class="header-subtitle">Phân tích dữ liệu người dùng và video</p>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
            <tr>
                <th>ID Video</th>
                <th>Tiêu đề</th>
                <th>Số người yêu thích</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="v" items="${videos}">
                <tr>
                    <td data-label="ID">${v.id}</td>
                    <td data-label="Tiêu đề">${v.title}</td>
                    <td data-label="Lượt thích">${stats[v.id]}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Lọc người yêu thích theo video -->
    <div class="filter-section">
        <h2>Lọc người yêu thích theo video</h2>

        <form method="get" action="${pageContext.request.contextPath}/video/stats">
            <label for="videoSelect">Chọn video:</label>
            <select name="videoId" id="videoSelect" onchange="this.form.submit()">
                <option value="">-- Chọn video để xem danh sách người yêu thích --</option>
                <c:forEach var="v" items="${videosWithFavorite}">
                    <option value="${v.id}" ${v.id == selectedVideoId ? 'selected' : ''}>
                            ${v.title}
                    </option>
                </c:forEach>
            </select>
        </form>

        <c:if test="${not empty selectedVideoId}">
            <div class="users-table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>Username</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Ngày yêu thích</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="row" items="${favoriteUsers}">
                        <tr>
                            <td data-label="Username">${row[0]}</td>
                            <td data-label="Họ tên">${row[1]}</td>
                            <td data-label="Email">${row[2]}</td>
                            <td data-label="Ngày">
                                <fmt:formatDate value="${row[3]}" pattern="dd/MM/yyyy"/>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty favoriteUsers}">
                        <tr>
                            <td colspan="4" class="empty-state">
                                Chưa có người dùng nào yêu thích video này
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</div>

</body>
</html>
