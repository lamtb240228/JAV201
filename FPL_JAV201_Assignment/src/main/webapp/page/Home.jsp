<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoCus - Trang chủ</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #0f0f0f;
            color: #f1f1f1;
            font-family: 'Roboto', Arial, sans-serif;
            overflow-x: hidden;
        }

        /* ============================================
           HEADER STYLES
        ============================================ */
        .header {
            background-color: #0f0f0f;
            height: 56px;
            display: flex;
            align-items: center;
            padding: 0 16px;
            border-bottom: 1px solid #272727;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 2000;
        }

        .header-left {
            display: flex;
            align-items: center;
            flex: 0 0 200px;
        }

        .header-center {
            display: flex;
            justify-content: center;
            align-items: center;
            flex: 1;
            max-width: 732px;
            margin: 0 auto;
        }

        .header-right {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 8px;
            flex: 0 0 200px;
        }

        .icon-btn {
            background: none;
            border: none;
            color: #f1f1f1;
            cursor: pointer;
            padding: 8px;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.2s;
        }

        .icon-btn:hover {
            background-color: #272727;
        }

        .logo {
            color: #f1f1f1;
            font-size: 20px;
            font-weight: 700;
            text-decoration: none;
            display: flex;
            align-items: center;
            margin-left: 8px;
            letter-spacing: -1.5px;
        }

        .logo i {
            color: #ff0000;
            font-size: 28px;
            margin-right: 2px;
        }

        .search-container {
            display: flex;
            align-items: center;
            width: 100%;
            max-width: 600px;
        }

        .search-box {
            display: flex;
            flex: 1;
            height: 40px;
        }

        .search-input {
            flex: 1;
            background: #121212;
            border: 1px solid #303030;
            color: #f1f1f1;
            padding: 0 16px;
            border-radius: 40px 0 0 40px;
            font-size: 16px;
            outline: none;
        }

        .search-input:focus {
            border-color: #1c62b9;
            background: #0f0f0f;
        }

        .search-input::placeholder {
            color: #888;
        }

        .search-btn {
            background: #222222;
            border: 1px solid #303030;
            border-left: none;
            color: #f1f1f1;
            padding: 0 24px;
            border-radius: 0 40px 40px 0;
            cursor: pointer;
            transition: background-color 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .search-btn:hover {
            background: #303030;
        }

        .voice-search-btn {
            background: #181818;
            margin-left: 8px;
        }

        .voice-search-btn:hover {
            background: #272727;
        }

        .user-avatar {
            background: #065fd4;
            color: white;
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            cursor: pointer;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            transition: background-color 0.2s;
            text-transform: uppercase;
        }

        .user-avatar:hover {
            background: #0a4eab;
        }

        .user-dropdown {
            position: relative;
        }

        .dropdown-menu {
            position: absolute;
            top: 48px;
            right: 0;
            background: #282828;
            border-radius: 12px;
            min-width: 300px;
            display: none;
            box-shadow: 0 4px 32px rgba(0,0,0,0.7);
            z-index: 2001;
            overflow: hidden;
        }

        .dropdown-menu.show {
            display: block;
            animation: fadeIn 0.15s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .dropdown-header {
            padding: 16px;
            border-bottom: 1px solid #3f3f3f;
        }

        .dropdown-user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .dropdown-user-avatar {
            background: #065fd4;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 500;
            font-size: 16px;
        }

        .dropdown-user-name {
            font-weight: 500;
            font-size: 16px;
        }

        .dropdown-item {
            color: #f1f1f1;
            padding: 12px 16px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 16px;
            cursor: pointer;
            transition: background-color 0.2s;
            font-size: 14px;
        }

        .dropdown-item:hover {
            background: #3f3f3f;
        }

        .dropdown-item i {
            width: 24px;
            text-align: center;
            font-size: 18px;
        }

        .dropdown-divider {
            height: 1px;
            background: #3f3f3f;
            margin: 8px 0;
        }

        /* ============================================
           SIDEBAR STYLES
        ============================================ */
        .sidebar {
            position: fixed;
            top: 56px;
            left: 0;
            bottom: 0;
            width: 240px;
            background: #0f0f0f;
            overflow-y: auto;
            overflow-x: hidden;
            z-index: 1999;
            transition: transform 0.2s ease;
            scrollbar-width: thin;
            scrollbar-color: #717171 transparent;
        }

        .sidebar::-webkit-scrollbar {
            width: 8px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: transparent;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: #717171;
            border-radius: 4px;
        }

        .sidebar::-webkit-scrollbar-thumb:hover {
            background: #909090;
        }

        .sidebar.hidden {
            transform: translateX(-240px);
        }

        .sidebar-section {
            padding: 12px 0;
            border-bottom: 1px solid #272727;
        }

        .sidebar-item {
            color: #f1f1f1;
            text-decoration: none;
            padding: 10px 24px;
            display: flex;
            align-items: center;
            gap: 24px;
            cursor: pointer;
            transition: background-color 0.2s;
            font-size: 14px;
            font-weight: 400;
        }

        .sidebar-item:hover {
            background: #272727;
        }

        .sidebar-item.active {
            background: #272727;
            font-weight: 500;
        }

        .sidebar-item i {
            width: 24px;
            text-align: center;
            font-size: 20px;
        }

        .sidebar-section-title {
            padding: 8px 24px;
            font-size: 14px;
            font-weight: 500;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* ============================================
           MAIN CONTENT STYLES
        ============================================ */
        .main-content {
            margin-left: 240px;
            margin-top: 56px;
            padding: 24px 24px 0;
            transition: margin-left 0.2s ease;
            min-height: calc(100vh - 56px);
        }

        .main-content.expanded {
            margin-left: 0;
        }

        /* ============================================
           FILTER CHIPS BAR
        ============================================ */
        .filter-bar-container {
            position: sticky;
            top: 56px;
            background: #0f0f0f;
            z-index: 1000;
            margin: -24px -24px 0;
            padding: 12px 24px;
            border-bottom: 1px solid #272727;
        }

        .filter-bar {
            display: flex;
            gap: 12px;
            overflow-x: auto;
            overflow-y: hidden;
            scrollbar-width: none;
            -ms-overflow-style: none;
        }

        .filter-bar::-webkit-scrollbar {
            display: none;
        }

        .filter-chip {
            background: #272727;
            color: #f1f1f1;
            border: none;
            padding: 8px 12px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            white-space: nowrap;
            transition: background-color 0.2s;
            flex-shrink: 0;
        }

        .filter-chip:hover {
            background: #3f3f3f;
        }

        .filter-chip.active {
            background: #f1f1f1;
            color: #0f0f0f;
        }

        /* ============================================
           VIDEO GRID STYLES
        ============================================ */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 16px 16px;
            padding: 24px 0;
        }

        .video-card {
            cursor: pointer;
            transition: transform 0.2s;
        }

        .video-card:hover {
            transform: translateY(-2px);
        }

        .thumbnail-container {
            position: relative;
            width: 100%;
            aspect-ratio: 16/9;
            border-radius: 12px;
            overflow: hidden;
            background: #181818;
            margin-bottom: 12px;
        }

        .thumbnail {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .video-card:hover .thumbnail {
            transform: scale(1.05);
        }

        .duration-badge {
            position: absolute;
            bottom: 8px;
            right: 8px;
            background: rgba(0, 0, 0, 0.85);
            color: white;
            padding: 3px 6px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        .video-info {
            display: flex;
            gap: 12px;
        }

        .channel-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 500;
            font-size: 14px;
            flex-shrink: 0;
            text-transform: uppercase;
        }

        .video-details {
            flex: 1;
            min-width: 0;
        }

        .video-title {
            font-size: 14px;
            font-weight: 500;
            line-height: 1.4;
            margin-bottom: 4px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            color: #f1f1f1;
        }

        .video-card:hover .video-title {
            color: #fff;
        }

        .channel-name {
            font-size: 12px;
            color: #aaa;
            margin-bottom: 2px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .channel-name:hover {
            color: #f1f1f1;
        }

        .verified-badge {
            font-size: 10px;
            color: #aaa;
        }

        .video-meta {
            font-size: 12px;
            color: #aaa;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .meta-separator {
            width: 3px;
            height: 3px;
            background: #aaa;
            border-radius: 50%;
        }

        /* ============================================
           PAGINATION STYLES
        ============================================ */
        .pagination-container {
            display: flex;
            justify-content: center;
            padding: 40px 0;
            border-top: 1px solid #272727;
            margin-top: 40px;
        }

        .pagination {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .page-btn {
            background: #272727;
            color: #f1f1f1;
            border: none;
            min-width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.2s;
            padding: 0 12px;
        }

        .page-btn:hover:not(.disabled) {
            background: #3f3f3f;
        }

        .page-btn.active {
            background: #f1f1f1;
            color: #0f0f0f;
        }

        .page-btn.disabled {
            opacity: 0.3;
            cursor: not-allowed;
        }

        .page-ellipsis {
            color: #aaa;
            padding: 0 8px;
        }

        /* ============================================
           EMPTY STATE
        ============================================ */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
        }

        .empty-state i {
            font-size: 64px;
            color: #3f3f3f;
            margin-bottom: 16px;
        }

        .empty-state h3 {
            font-size: 20px;
            font-weight: 400;
            color: #aaa;
        }

        /* ============================================
           RESPONSIVE DESIGN
        ============================================ */
        @media (max-width: 1024px) {
            .video-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .header {
                padding: 0 8px;
            }

            .header-left,
            .header-right {
                flex: 0 0 auto;
            }

            .header-center {
                display: none;
            }

            .logo {
                font-size: 18px;
            }

            .sidebar {
                transform: translateX(-240px);
            }

            .sidebar.show {
                transform: translateX(0);
                box-shadow: 4px 0 16px rgba(0,0,0,0.5);
            }

            .main-content {
                margin-left: 0;
                padding: 16px 8px 0;
            }

            .filter-bar-container {
                margin: -16px -8px 0;
                padding: 12px 8px;
            }

            .video-grid {
                grid-template-columns: 1fr;
                gap: 24px;
            }

            .video-info {
                gap: 8px;
            }

            .channel-avatar {
                width: 32px;
                height: 32px;
                font-size: 12px;
            }
        }

        @media (max-width: 480px) {
            .header-right .icon-btn:not(.user-dropdown) {
                display: none;
            }
        }

        /* ============================================
           LOADING ANIMATION
        ============================================ */
        .skeleton {
            background: linear-gradient(90deg, #1a1a1a 25%, #2a2a2a 50%, #1a1a1a 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
        }

        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
    </style>
</head>

<body>
<!-- ============================================
     HEADER
============================================ -->
<div class="header">
    <div class="header-left">
        <button class="icon-btn" id="menuToggle" aria-label="Menu">
            <i class="fas fa-bars"></i>
        </button>

        <a href="home" class="logo">
            <i class="fab fa-youtube"></i>FoCus
        </a>
    </div>

    <div class="header-center">
        <div class="search-container">
            <div class="search-box">
                <input type="text" class="search-input" placeholder="Tìm kiếm" aria-label="Tìm kiếm">
                <button class="search-btn" aria-label="Tìm kiếm">
                    <i class="fas fa-search"></i>
                </button>
            </div>
            <button class="icon-btn voice-search-btn" aria-label="Tìm kiếm bằng giọng nói">
                <i class="fas fa-microphone"></i>
            </button>
        </div>
    </div>

    <div class="header-right">
        <button class="icon-btn" aria-label="Tạo">
            <i class="fas fa-video"></i>
        </button>
        <button class="icon-btn" aria-label="Thông báo">
            <i class="fas fa-bell"></i>
        </button>
        <div class="user-dropdown">
            <button class="user-avatar" id="userBtn" aria-label="Tài khoản">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        ${fn:substring(sessionScope.user.fullname, 0, 1)}
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-user"></i>
                    </c:otherwise>
                </c:choose>
            </button>
            <div class="dropdown-menu" id="userMenu">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="auth/login" class="dropdown-item">
                            <i class="fas fa-sign-in-alt"></i>
                            <span>Đăng nhập</span>
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="auth/register" class="dropdown-item">
                            <i class="fas fa-user-plus"></i>
                            <span>Đăng ký</span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <div class="dropdown-header">
                            <div class="dropdown-user-info">
                                <div class="dropdown-user-avatar">
                                        ${fn:substring(sessionScope.user.fullname, 0, 1)}
                                </div>
                                <div>
                                    <div class="dropdown-user-name">${sessionScope.user.fullname}</div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${sessionScope.user.admin}">
                            <a href="${pageContext.request.contextPath}/admin/admin" class="dropdown-item" style="color: #ff4e4e;">
                                <i class="fas fa-user-shield"></i>
                                <span class="fw-bold">Quản trị hệ thống</span>
                            </a>
                            <div class="dropdown-divider"></div>
                        </c:if>

                        <a href="edit-profile" class="dropdown-item">
                        <a href="user/video" class="dropdown-item">
                            <i class="fas fa-user-circle"></i>
                            <span>Kênh của bạn</span>
                        </a>
                        <a href="user/profile" class="dropdown-item">
                            <i class="fas fa-lock"></i>
                            <span>Đổi mật khẩu</span>
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="logout" class="dropdown-item">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- ============================================
     SIDEBAR
============================================ -->
<div class="sidebar" id="sidebar">
    <!-- Main Navigation -->
    <div class="sidebar-section">
        <a href="home" class="sidebar-item active">
            <i class="fas fa-home"></i>
            <span>Trang chủ</span>
        </a>
        <a href="shorts" class="sidebar-item">
            <i class="fas fa-bolt"></i>
            <span>Shorts</span>
        </a>
        <a href="subscriptions" class="sidebar-item">
            <i class="fas fa-play-circle"></i>
            <span>Kênh đăng ký</span>
        </a>
    </div>

    <!-- You Section -->
    <div class="sidebar-section">
        <div class="sidebar-section-title">Bạn</div>
        <a href="history" class="sidebar-item">
            <i class="fas fa-history"></i>
            <span>Lịch sử</span>
        </a>
        <a href="playlists" class="sidebar-item">
            <i class="fas fa-list"></i>
            <span>Danh sách phát</span>
        </a>
        <a href="my-videos" class="sidebar-item">
            <i class="fas fa-video"></i>
            <span>Video của bạn</span>
        </a>
        <a href="watch-later" class="sidebar-item">
            <i class="fas fa-clock"></i>
            <span>Xem sau</span>
        </a>
        <a href="user/favorite" class="sidebar-item">
            <i class="fas fa-thumbs-up"></i>
            <span>Video đã thích</span>
        </a>
    </div>

    <!-- Explore -->
    <div class="sidebar-section">
        <div class="sidebar-section-title">Khám phá</div>
        <a href="trending" class="sidebar-item">
            <i class="fas fa-fire"></i>
            <span>Thịnh hành</span>
        </a>
        <a href="music" class="sidebar-item">
            <i class="fas fa-music"></i>
            <span>Âm nhạc</span>
        </a>
        <a href="gaming" class="sidebar-item">
            <i class="fas fa-gamepad"></i>
            <span>Trò chơi</span>
        </a>
        <a href="news" class="sidebar-item">
            <i class="fas fa-newspaper"></i>
            <span>Tin tức</span>
        </a>
        <a href="sports" class="sidebar-item">
            <i class="fas fa-trophy"></i>
            <span>Thể thao</span>
        </a>
    </div>

    <!-- Settings -->
    <div class="sidebar-section">
        <a href="settings" class="sidebar-item">
            <i class="fas fa-cog"></i>
            <span>Cài đặt</span>
        </a>
        <a href="help" class="sidebar-item">
            <i class="fas fa-question-circle"></i>
            <span>Trợ giúp</span>
        </a>
        <a href="feedback" class="sidebar-item">
            <i class="fas fa-comment"></i>
            <span>Gửi phản hồi</span>
        </a>
    </div>
</div>

<!-- ============================================
     MAIN CONTENT
============================================ -->
<div class="main-content" id="mainContent">
    <!-- Filter Chips Bar -->
    <div class="filter-bar-container">
        <div class="filter-bar">
            <a href="home" class="filter-chip ${currentFilter == null || currentFilter == 'default' ? 'active' : ''}">
                Tất cả
            </a>
            <a href="home?filter=trending" class="filter-chip ${currentFilter == 'trending' ? 'active' : ''}">
                Thịnh hành
            </a>
            <a href="home?filter=music" class="filter-chip">
                Âm nhạc
            </a>
            <a href="home?filter=gaming" class="filter-chip">
                Trò chơi
            </a>
            <a href="home?filter=news" class="filter-chip">
                Tin tức
            </a>
            <a href="home?filter=sports" class="filter-chip">
                Thể thao
            </a>
            <a href="home?filter=entertainment" class="filter-chip">
                Giải trí
            </a>
            <a href="home?filter=education" class="filter-chip">
                Giáo dục
            </a>
            <a href="home?filter=tech" class="filter-chip">
                Công nghệ
            </a>
            <a href="home?filter=cooking" class="filter-chip">
                Nấu ăn
            </a>
        </div>
    </div>

    <!-- Video Grid -->
    <div class="video-grid">
        <c:choose>
            <c:when test="${not empty videos}">
                <c:forEach var="v" items="${videos}">
                    <div class="video-card" onclick="location.href='video/detail?id=${v.id}'">
                        <div class="thumbnail-container">
                            <img src="${v.poster}"
                                 class="thumbnail"
                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/img/not-image.jpg'"
                                 alt="${v.title}">
                            <div class="duration-badge">10:24</div>
                        </div>
                        <div class="video-info">
                            <div class="channel-avatar">
                                ${fn:substring(v.title, 0, 1)}
                            </div>
                            <div class="video-details">
                                <h3 class="video-title">${v.title}</h3>
                                <div class="channel-name">
                                    <span>Channel Name</span>
                                    <i class="fas fa-check-circle verified-badge"></i>
                                </div>
                                <div class="video-meta">
                                    <span>
                                        ${v.viewsFormatted} lượt xem
                                    </span>
                                    <span class="meta-separator"></span>
                                    <span>2 ngày trước</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-video-slash"></i>
                    <h3>Không có video nào</h3>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Pagination -->
    <c:if test="${not empty totalPages && totalPages > 1}">
        <div class="pagination-container">
            <div class="pagination">
                <c:set var="filterParam" value="${currentFilter != 'default' ? '&filter='.concat(currentFilter) : ''}" />

                <!-- First page -->
                <a href="home?page=1${filterParam}"
                   class="page-btn ${currentPage == 1 ? 'disabled' : ''}"
                   aria-label="Trang đầu">
                    <i class="fas fa-angle-double-left"></i>
                </a>

                <!-- Previous page -->
                <a href="home?page=${currentPage - 1}${filterParam}"
                   class="page-btn ${currentPage == 1 ? 'disabled' : ''}"
                   aria-label="Trang trước">
                    <i class="fas fa-angle-left"></i>
                </a>

                <!-- Page numbers -->
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:if test="${i <= 3 || i == totalPages || (i >= currentPage - 1 && i <= currentPage + 1)}">
                        <c:if test="${i == totalPages && totalPages > 5 && currentPage < totalPages - 2}">
                            <span class="page-ellipsis">...</span>
                        </c:if>

                        <a href="home?page=${i}${filterParam}"
                           class="page-btn ${i == currentPage ? 'active' : ''}"
                           aria-label="Trang ${i}">
                            ${i}
                        </a>

                        <c:if test="${i == 1 && totalPages > 5 && currentPage > 4}">
                            <span class="page-ellipsis">...</span>
                        </c:if>
                    </c:if>
                </c:forEach>

                <!-- Next page -->
                <a href="home?page=${currentPage + 1}${filterParam}"
                   class="page-btn ${currentPage == totalPages ? 'disabled' : ''}"
                   aria-label="Trang sau">
                    <i class="fas fa-angle-right"></i>
                </a>

                <!-- Last page -->
                <a href="home?page=${totalPages}${filterParam}"
                   class="page-btn ${currentPage == totalPages ? 'disabled' : ''}"
                   aria-label="Trang cuối">
                    <i class="fas fa-angle-double-right"></i>
                </a>
            </div>
        </div>
    </c:if>
</div>

<!-- ============================================
     JAVASCRIPT
============================================ -->
<script>
    // ============================================
    // DOM Elements
    // ============================================
    const menuToggle = document.getElementById('menuToggle');
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('mainContent');
    const userBtn = document.getElementById('userBtn');
    const userMenu = document.getElementById('userMenu');

    // ============================================
    // Sidebar Toggle
    // ============================================
    let sidebarVisible = true;

    menuToggle.addEventListener('click', function(e) {
        e.stopPropagation();
        
        if (window.innerWidth <= 768) {
            // Mobile: Toggle sidebar with overlay
            sidebar.classList.toggle('show');
        } else {
            // Desktop: Toggle sidebar visibility
            sidebarVisible = !sidebarVisible;
            sidebar.classList.toggle('hidden', !sidebarVisible);
            mainContent.classList.toggle('expanded', !sidebarVisible);
        }
    });

    // ============================================
    // User Dropdown
    // ============================================
    userBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        userMenu.classList.toggle('show');
    });

    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
        if (!userBtn.contains(e.target) && !userMenu.contains(e.target)) {
            userMenu.classList.remove('show');
        }

        // Close mobile sidebar when clicking outside
        if (window.innerWidth <= 768 && 
            !menuToggle.contains(e.target) && 
            !sidebar.contains(e.target)) {
            sidebar.classList.remove('show');
        }
    });

    // ============================================
    // Responsive Handling
    // ============================================
    function handleResize() {
        if (window.innerWidth <= 768) {
            // Mobile view
            sidebar.classList.remove('hidden');
            sidebar.classList.remove('show');
            mainContent.classList.remove('expanded');
        } else {
            // Desktop view
            sidebar.classList.remove('show');
            
            // Restore sidebar state
            if (!sidebarVisible) {
                sidebar.classList.add('hidden');
                mainContent.classList.add('expanded');
            } else {
                sidebar.classList.remove('hidden');
                mainContent.classList.remove('expanded');
            }
        }
    }

    // Initial setup
    handleResize();

    // Listen for resize events
    let resizeTimer;
    window.addEventListener('resize', function() {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(handleResize, 100);
    });

    // ============================================
    // Close sidebar on mobile when clicking items
    // ============================================
    document.querySelectorAll('.sidebar-item').forEach(item => {
        item.addEventListener('click', function() {
            if (window.innerWidth <= 768) {
                sidebar.classList.remove('show');
            }
        });
    });

    // ============================================
    // Smooth scroll for filter bar
    // ============================================
    const filterBar = document.querySelector('.filter-bar');
    let isDown = false;
    let startX;
    let scrollLeft;

    if (filterBar) {
        filterBar.addEventListener('mousedown', (e) => {
            isDown = true;
            filterBar.style.cursor = 'grabbing';
            startX = e.pageX - filterBar.offsetLeft;
            scrollLeft = filterBar.scrollLeft;
        });

        filterBar.addEventListener('mouseleave', () => {
            isDown = false;
            filterBar.style.cursor = 'grab';
        });

        filterBar.addEventListener('mouseup', () => {
            isDown = false;
            filterBar.style.cursor = 'grab';
        });

        filterBar.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - filterBar.offsetLeft;
            const walk = (x - startX) * 2;
            filterBar.scrollLeft = scrollLeft - walk;
        });
    }

    // ============================================
    // Format view counts (client-side backup)
    // ============================================
    function formatViews(views) {
        if (views >= 1000000) {
            return (views / 1000000).toFixed(1) + 'M';
        } else if (views >= 1000) {
            return (views / 1000).toFixed(1) + 'K';
        }
        return views.toString();
    }

    // ============================================
    // Prevent disabled pagination clicks
    // ============================================
    document.querySelectorAll('.page-btn.disabled').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
        });
    });

    // ============================================
    // Accessibility: Keyboard navigation
    // ============================================
    document.addEventListener('keydown', function(e) {
        // Escape key closes dropdown and mobile sidebar
        if (e.key === 'Escape') {
            userMenu.classList.remove('show');
            if (window.innerWidth <= 768) {
                sidebar.classList.remove('show');
            }
        }
    });

    // ============================================
    // Performance: Lazy load thumbnails
    // ============================================
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    if (img.dataset.src) {
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                        observer.unobserve(img);
                    }
                }
            });
        });

        document.querySelectorAll('img[data-src]').forEach(img => {
            imageObserver.observe(img);
        });
    }
</script>
</body>
</html>
