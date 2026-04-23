<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${videoDetail.title} | FPL Video</title>

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap"
                rel="stylesheet">
            <!-- Lucide Icons -->
            <script src="https://unpkg.com/lucide@latest"></script>

            <style>
                :root {
                    --bg-dark: #050505;
                    --card-bg: rgba(255, 255, 255, 0.05);
                    --accent: #3B82F6;
                    --accent-hover: #2563EB;
                    --cta: #F97316;
                    --text-main: #F8FAFC;
                    --text-muted: #94A3B8;
                    --glass-border: rgba(255, 255, 255, 0.1);
                }

                body {
                    background-color: var(--bg-dark);
                    color: var(--text-main);
                    font-family: 'DM Sans', sans-serif;
                    margin: 0;
                    padding: 0;
                    min-height: 100vh;
                }

                .navbar-brand {
                    font-weight: 700;
                    letter-spacing: -1px;
                    color: var(--accent) !important;
                }

                /* Video Section */
                .video-container {
                    max-width: 1200px;
                    margin: 20px auto;
                    border-radius: 16px;
                    overflow: hidden;
                    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5), 0 0 20px rgba(59, 130, 246, 0.1);
                    background: #000;
                    position: relative;
                    aspect-ratio: 16 / 9;
                }

                iframe {
                    width: 100%;
                    height: 100%;
                    border: none;
                }

                /* Content Section */
                .main-content {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 20px;
                    display: grid;
                    grid-template-columns: 1fr 350px;
                    gap: 30px;
                }

                @media (max-width: 992px) {
                    .main-content {
                        grid-template-columns: 1fr;
                    }
                }

                .video-info {
                    background: var(--card-bg);
                    border: 1px solid var(--glass-border);
                    padding: 30px;
                    border-radius: 20px;
                    backdrop-filter: blur(10px);
                }

                .video-title {
                    font-size: 2.5rem;
                    font-weight: 700;
                    margin-bottom: 10px;
                    background: linear-gradient(to right, #fff, #94A3B8);
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                .video-meta {
                    color: var(--text-muted);
                    font-size: 0.9rem;
                    margin-bottom: 20px;
                    display: flex;
                    align-items: center;
                    gap: 15px;
                }

                .description {
                    color: var(--text-muted);
                    line-height: 1.6;
                    font-size: 1.1rem;
                }

                /* Action Buttons */
                .actions {
                    display: flex;
                    gap: 12px;
                    margin-top: 25px;
                }

                .btn-action {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    padding: 10px 24px;
                    border-radius: 12px;
                    font-weight: 600;
                    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                    border: 1px solid var(--glass-border);
                    cursor: pointer;
                }

                .btn-like {
                    background: var(--accent);
                    color: white;
                    border: none;
                }

                .btn-like.active {
                    background: transparent;
                    border: 1px solid var(--accent);
                    color: var(--accent);
                }

                .btn-like:hover {
                    transform: translateY(-2px);
                    background: var(--accent-hover);
                    box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
                }

                .btn-share {
                    background: rgba(255, 255, 255, 0.1);
                    color: white;
                }

                .btn-share:hover {
                    background: rgba(255, 255, 255, 0.2);
                    transform: translateY(-2px);
                }

                /* Sidebar / Watched List */
                .sidebar {
                    display: flex;
                    flex-direction: column;
                    gap: 20px;
                }

                .section-title {
                    font-size: 1.25rem;
                    font-weight: 700;
                    margin-bottom: 15px;
                    padding-left: 5px;
                    border-left: 4px solid var(--accent);
                }

                .video-card {
                    background: var(--card-bg);
                    border: 1px solid var(--glass-border);
                    padding: 12px;
                    border-radius: 12px;
                    display: flex;
                    gap: 15px;
                    transition: all 0.2s;
                    text-decoration: none;
                    color: inherit;
                }

                .video-card:hover {
                    background: rgba(255, 255, 255, 0.1);
                    transform: translateX(5px);
                    color: var(--accent);
                }

                .video-card-thumb {
                    width: 120px;
                    height: 68px;
                    background: #1a1a1a;
                    border-radius: 8px;
                    overflow: hidden;
                    flex-shrink: 0;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .video-card-info h4 {
                    font-size: 0.95rem;
                    font-weight: 600;
                    margin: 0;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                }

                /* Modal Styling */
                .modal-content {
                    background: #111;
                    border: 1px solid var(--glass-border);
                    color: white;
                    border-radius: 20px;
                }

                .modal-header {
                    border-bottom: 1px solid var(--glass-border);
                }

                .modal-footer {
                    border-top: 1px solid var(--glass-border);
                }

                .form-control {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid var(--glass-border);
                    color: white;
                    border-radius: 12px;
                    padding: 12px;
                }

                .form-control:focus {
                    background: rgba(255, 255, 255, 0.1);
                    border-color: var(--accent);
                    color: white;
                    box-shadow: none;
                }

                .alert {
                    max-width: 1200px;
                    margin: 20px auto;
                    border-radius: 12px;
                    background: rgba(16, 185, 129, 0.1);
                    border: 1px solid rgba(16, 185, 129, 0.2);
                    color: #10b981;
                }
            </style>
        </head>

        <body>
            <!-- Navbar placeholder for context -->
            <nav class="navbar navbar-expand-lg navbar-dark pt-4 container">
                <a class="navbar-brand fs-3" href="${pageContext.request.contextPath}/">FPL FLIX</a>
            </nav>

            <!-- Notifications -->
            <c:if test="${not empty sessionScope.shareMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i data-lucide="check-circle" class="me-2"></i> ${sessionScope.shareMessage}
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="shareMessage" scope="session" />
            </c:if>

            <c:if test="${not empty videoDetail}">
                <!-- Video Player -->
                <div class="container">
                    <div class="video-container">
                        <iframe src="${videoDetail.poster}" allowfullscreen></iframe>
                    </div>
                </div>

                <main class="main-content">
                    <!-- Left: Video Info -->
                    <section class="video-info">
                        <h1 class="video-title">${videoDetail.title}</h1>
                        <div class="video-meta">
                            <span><i data-lucide="eye" style="width:16px; margin-bottom:2px"></i> 1,234 views</span>
                            <span><i data-lucide="calendar" style="width:16px; margin-bottom:2px"></i> Oct 24,
                                2024</span>
                        </div>

                        <p class="description">${videoDetail.description}</p>

                        <div class="actions">
                            <form method="post"
                                action="${pageContext.request.contextPath}${isFavorite ? '/favorite/unlike' : '/favorite/like'}">
                                <input type="hidden" name="videoId" value="${videoDetail.id}">
                                <button type="submit" class="btn-action btn-like ${isFavorite ? 'active' : ''}">
                                    <i data-lucide="${isFavorite ? 'star' : 'heart'}"></i>
                                    ${isFavorite ? 'Bỏ thích' : 'Thích video'}
                                </button>
                            </form>

                            <button class="btn-action btn-share" data-bs-toggle="modal" data-bs-target="#shareModal">
                                <i data-lucide="share-2"></i> Chia sẻ
                            </button>
                        </div>

                        <c:if test="${not empty sessionScope.message}">
                            <div class="alert alert-info mt-4 py-2 border-0 bg-primary bg-opacity-10 text-primary">
                                ${sessionScope.message}
                            </div>
                            <% session.removeAttribute("message"); %>
                        </c:if>
                    </section>

                    <!-- Right: Sidebar -->
                    <aside class="sidebar">
                        <h3 class="section-title">Vừa xem gần đây</h3>
                        <c:forEach var="v" items="${sessionScope.watchedVideos}">
                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.id}" class="video-card">
                                <div class="video-card-thumb">
                                    <i data-lucide="play-circle" class="text-white-50"></i>
                                </div>
                                <div class="video-card-info">
                                    <h4>${v.title}</h4>
                                    <p class="text-muted small mb-0">Tiếp tục xem</p>
                                </div>
                            </a>
                        </c:forEach>
                    </aside>
                </main>
            </c:if>

            <c:if test="${not empty message}">
                <div class="container mt-5 text-center">
                    <h2 class="text-danger">${message}</h2>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-light mt-3">Quay lại trang
                        chủ</a>
                </div>
            </c:if>

            <!-- Share Modal -->
            <div class="modal fade" id="shareModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form method="post" action="${pageContext.request.contextPath}/share">
                            <div class="modal-header">
                                <h5 class="modal-title">Chia sẻ niềm vui</h5>
                                <button type="button" class="btn-close btn-close-white"
                                    data-bs-dismiss="modal"></button>
                            </div>

                            <div class="modal-body">
                                <input type="hidden" name="videoId" value="${videoDetail.id}">
                                <input type="hidden" name="videoTitle" value="${videoDetail.title}">
                                <input type="hidden" name="videoPoster" value="${videoDetail.poster}">

                                <div class="mb-4">
                                    <label class="form-label text-muted small text-uppercase fw-bold">Email người
                                        nhận</label>
                                    <input class="form-control" name="toEmail" type="email" required
                                        placeholder="example@gmail.com">
                                </div>

                                <div class="p-3 rounded bg-white bg-opacity-5 border border-white border-opacity-10">
                                    <p class="small text-muted mb-0">Người nhận sẽ nhận được một email mời xem video này
                                        cùng bạn.</p>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-link text-white text-decoration-none"
                                    data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-action btn-like px-4">Gửi ngay</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Initialize Lucide icons
                lucide.createIcons();
            </script>
        </body>

        </html>