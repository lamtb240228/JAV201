<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Yêu Thích | Premium UI</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #ff4757;
            --bg-color: #f4f7f6;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        body {
            background-color: var(--bg-color);
            font-family: 'Inter', sans-serif;
            color: #2f3542;
        }

        .header-section {
            padding: 60px 0 40px;
        }

        .page-title {
            font-weight: 800;
            letter-spacing: -1px;
            color: #2f3542;
            margin-bottom: 8px;
        }

        .page-title i {
            color: var(--primary-color);
            margin-right: 10px;
        }

        /* Card Styling */
        .video-card {
            border: none;
            border-radius: 16px;
            background: #ffffff;
            transition: var(--transition);
            box-shadow: var(--card-shadow);
            height: 100%;
        }

        .video-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .img-container {
            position: relative;
            overflow: hidden;
            border-radius: 16px 16px 0 0;
            aspect-ratio: 16 / 9; /* Chuẩn khung hình video */
        }

        .card-img-top {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .video-card:hover .card-img-top {
            transform: scale(1.08);
        }

        /* Nội dung Card */
        .card-body {
            padding: 1.25rem;
        }

        .card-title {
            font-weight: 700;
            font-size: 1.1rem;
            line-height: 1.4;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2; /* Giới hạn 2 dòng tiêu đề */
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 3rem;
        }

        .video-meta {
            font-size: 0.85rem;
            color: #747d8c;
            margin-bottom: 15px;
        }

        /* Nút Like/Unlike */
        .btn-unlike {
            border-radius: 10px;
            padding: 10px;
            font-weight: 600;
            border: 2px solid #f1f2f6;
            background: #f1f2f6;
            color: #57606f;
            transition: var(--transition);
        }

        .btn-unlike:hover {
            background: #ffeef0;
            border-color: #ffeef0;
            color: var(--primary-color);
        }

        /* Trạng thái trống */
        .empty-state {
            padding: 80px 0;
            text-align: center;
        }
        .empty-state i {
            font-size: 4rem;
            color: #dfe4ea;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <header class="header-section text-center">
        <h1 class="page-title"><i class="fa-solid fa-bolt"></i> My Collection</h1>
        <p class="text-muted">Bạn có <span class="badge bg-danger rounded-pill">${favorites.size()}</span> video yêu thích</p>
    </header>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <c:choose>
            <c:when test="${not empty favorites}">
                <c:forEach var="fav" items="${favorites}">
                    <div class="col">
                        <article class="card video-card">
                            <div class="img-container">
                                <img src="${fav.video.poster}" class="card-img-top" alt="${fav.video.title}">
                            </div>

                            <div class="card-body">
                                <h5 class="card-title" title="${fav.video.title}">${fav.video.title}</h5>

                                <div class="video-meta">
                                    <span><i class="fa-regular fa-calendar-check me-1"></i> ${fav.likeDate}</span>
                                </div>

                                <form action="FavoriteServlet" method="post">
                                    <input type="hidden" name="action" value="unlike">
                                    <input type="hidden" name="videoId" value="${fav.video.id}">
                                    <button type="submit" class="btn btn-unlike w-100">
                                        <i class="fa-solid fa-heart-crack me-2"></i> Bỏ yêu thích
                                    </button>
                                </form>
                            </div>
                        </article>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 empty-state">
                    <i class="fa-solid fa-clapperboard"></i>
                    <h3>Chưa có video nào</h3>
                    <p class="text-muted">Hãy khám phá và thêm những video bạn yêu thích vào đây nhé!</p>
                    <a href="HomeServlet" class="btn btn-primary px-4 py-2 mt-3 rounded-pill">Khám phá ngay</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<footer class="mt-5 mb-4 text-center text-muted small">
    &copy; 2024 Video Entertainment Center
</footer>

</body>
</html>