<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Thống kê hệ thống</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <style>
        :root { --primary: #6366f1; --sidebar-bg: #ffffff; --main-bg: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--main-bg); color: #1e293b; }

        /* Sidebar */
        .sidebar { width: 280px; height: 100vh; position: fixed; background: var(--sidebar-bg); border-right: 1px solid #e2e8f0; padding: 1.5rem; }
        .nav-link { color: #64748b; font-weight: 500; padding: 12px 15px; border-radius: 10px; margin-bottom: 5px; transition: 0.2s; }
        .nav-link.active { background: rgba(99, 102, 241, 0.1); color: var(--primary); }
        .nav-link:hover:not(.active) { background: #f1f5f9; color: #0f172a; }

        /* Content Area */
        .main-content { margin-left: 280px; padding: 2rem; }

        /* Stats Cards */
        .stat-card { border: none; border-radius: 20px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); }
        .icon-shape { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.25rem; }

        .table-custom { background: #fff; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); }
        .table-custom thead { background: #f8fafc; font-size: 0.75rem; text-transform: uppercase; color: #64748b; }
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="d-flex align-items-center mb-5 px-2">
        <div class="bg-primary p-2 rounded-3 me-3"><i class="fa-solid fa-bolt text-white"></i></div>
        <h5 class="fw-bold mb-0">VideoHub <small class="text-muted d-block" style="font-size: 10px;">ADMIN PANEL</small></h5>
    </div>

    <ul class="nav nav-pills flex-column">
        <li class="nav-item"><a href="admin-stats" class="nav-link active"><i class="fa-solid fa-chart-line me-2"></i> Tổng quan</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath}/home" class="nav-link"><i class="fa-solid fa-video me-2"></i>Home</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/user" class="nav-link"><i class="fa-solid fa-user-group me-2"></i> Người dùng</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath}/user/video" class="nav-link"><i class="fa-solid fa-share-nodes me-2"></i> Video</a></li>
        <li class="nav-item mt-4"><a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger"><i class="fa-solid fa-right-from-bracket me-2"></i> Thoát</a></li>
    </ul>
</aside>

<main class="main-content">
    <header class="mb-4 d-flex justify-content-between align-items-center">
        <h4 class="fw-bold">Bảng điều khiển thống kê</h4>
        <div class="dropdown">
            <img src="https://ui-avatars.com/api/?name=Admin&background=6366f1&color=fff" class="rounded-3" width="40">
        </div>
    </header>

    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="card stat-card p-3">
                <div class="d-flex align-items-center">
                    <div class="icon-shape bg-primary-subtle text-primary me-3"><i class="fa-solid fa-video"></i></div>
                    <div><p class="text-muted small mb-0">Tổng Video</p><h4 class="fw-bold mb-0">${totalVideos}</h4></div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card p-3">
                <div class="d-flex align-items-center">
                    <div class="icon-shape bg-success-subtle text-success me-3"><i class="fa-solid fa-users"></i></div>
                    <div><p class="text-muted small mb-0">Thành viên</p><h4 class="fw-bold mb-0">${totalUsers}</h4></div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card p-3">
                <div class="d-flex align-items-center">
                    <div class="icon-shape bg-danger-subtle text-danger me-3"><i class="fa-solid fa-heart"></i></div>
                    <div><p class="text-muted small mb-0">Lượt Yêu thích</p><h4 class="fw-bold mb-0">${totalLikes}</h4></div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card p-3">
                <div class="d-flex align-items-center">
                    <div class="icon-shape bg-warning-subtle text-warning me-3"><i class="fa-solid fa-share"></i></div>
                    <div><p class="text-muted small mb-0">Lượt Chia sẻ</p><h4 class="fw-bold mb-0">${totalShares}</h4></div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card stat-card p-4 h-100">
                <h6 class="fw-bold mb-4">Xu hướng lượt xem (Views)</h6>
                <canvas id="viewChart" style="max-height: 300px;"></canvas>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card stat-card p-4 h-100">
                <h6 class="fw-bold mb-4">Top Video nhiều View nhất</h6>
                <c:forEach var="v" items="${topVideos}">
                    <div class="d-flex align-items-center mb-3">
                        <img src="${v.poster}" class="rounded me-3" width="60" height="35" style="object-fit: cover;">
                        <div class="flex-grow-1">
                            <p class="mb-0 small fw-bold text-truncate" style="max-width: 150px;">${v.title}</p>
                            <span class="text-muted extra-small">${v.views} lượt xem</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('viewChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'],
            datasets: [{
                label: 'Lượt xem',
                data: [5000, 12000, 8000, 18000, 15000, 25000],
                borderColor: '#6366f1',
                tension: 0.4,
                fill: true,
                backgroundColor: 'rgba(99, 102, 241, 0.1)'
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true, grid: { display: false } } }
        }
    });
</script>
</body>
</html>