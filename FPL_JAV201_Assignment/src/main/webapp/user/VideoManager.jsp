<%--
  Created by IntelliJ IDEA.
  User: minhl
  Date: 2/2/2026
  Time: 1:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<html>
<head>
    <title>VideoManager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --yt-bg-primary: #0f0f0f;
            --yt-bg-secondary: #212121;
            --yt-bg-tertiary: #272727;
            --yt-text-primary: #f1f1f1;
            --yt-text-secondary: #aaaaaa;
            --yt-border-color: #3f3f3f;
            --yt-blue: #3ea6ff;
            --yt-hover: #3f3f3f;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: var(--yt-bg-primary);
            color: var(--yt-text-primary);
            font-family: "Roboto", Arial, sans-serif;
        }

        /* Header */
        .yt-header {
            background-color: var(--yt-bg-primary);
            padding: 1rem 2rem;
            border-bottom: 1px solid var(--yt-border-color);
        }

        .yt-title {
            font-size: 1.5rem;
            font-weight: 400;
            color: var(--yt-text-primary);
        }

        .btn-yt {
            background-color: transparent;
            color: var(--yt-text-primary);
            border: 1px solid var(--yt-border-color);
            border-radius: 20px;
            padding: 0.5rem 1.25rem;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.2s;
            cursor: pointer;
        }

        .btn-yt:hover {
            background-color: var(--yt-hover);
            color: var(--yt-text-primary);
        }

        .btn-yt-primary {
            background-color: var(--yt-blue);
            color: #0f0f0f;
            border: none;
        }

        .btn-yt-primary:hover {
            background-color: #4db3ff;
            color: #0f0f0f;
        }

        .main-container {
            padding: 1.5rem 2rem;
        }

        /* Tabs */
        .nav-tabs-yt {
            border: none;
            margin-bottom: 0;
        }

        .nav-tabs-yt .nav-link {
            background: var(--yt-bg-secondary);
            border: none;
            color: var(--yt-text-secondary);
            padding: 0.875rem 2rem;
            border-radius: 12px 12px 0 0;
            margin-right: 0.25rem;
            transition: all 0.2s;
            font-weight: 500;
        }

        .nav-tabs-yt .nav-link:hover {
            color: var(--yt-text-primary);
            background: var(--yt-hover);
        }

        .nav-tabs-yt .nav-link.active {
            color: var(--yt-text-primary);
            background: var(--yt-bg-secondary);
            border-bottom: 3px solid var(--yt-text-primary);
        }

        /* Tab Content Card */
        .tab-content-card {
            background-color: var(--yt-bg-secondary);
            border: 1px solid var(--yt-border-color);
            border-radius: 0 12px 12px 12px;
            padding: 2rem;
        }

        /* Form Section */
        .form-section {
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.1rem;
            font-weight: 500;
            color: var(--yt-text-primary);
            margin-bottom: 0.5rem;
        }

        .section-subtitle {
            font-size: 0.85rem;
            color: var(--yt-text-secondary);
            margin-bottom: 1rem;
        }

        .section-subtitle a {
            color: var(--yt-blue);
            text-decoration: none;
        }

        .section-subtitle a:hover {
            text-decoration: underline;
        }

        /* Form Controls */
        .form-label-yt {
            color: var(--yt-text-secondary);
            font-size: 0.8rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .form-control-yt {
            background-color: var(--yt-bg-primary);
            border: 1px solid var(--yt-border-color);
            border-radius: 8px;
            color: var(--yt-text-primary);
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            transition: all 0.2s;
            width: 100%;
        }

        .form-control-yt:focus {
            background-color: var(--yt-bg-primary);
            border-color: var(--yt-blue);
            color: var(--yt-text-primary);
            box-shadow: 0 0 0 3px rgba(62, 166, 255, 0.2);
            outline: none;
        }

        .form-control-yt::placeholder {
            color: var(--yt-text-secondary);
        }

        textarea.form-control-yt {
            resize: vertical;
            min-height: 200px;
        }

        /* Thumbnail Options */
        .thumbnail-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
        }

        .thumbnail-option {
            aspect-ratio: 16/9;
            background-color: var(--yt-bg-primary);
            border: 2px dashed var(--yt-border-color);
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            position: relative;
            overflow: hidden;
        }

        .thumbnail-option:hover {
            border-color: var(--yt-blue);
            background-color: var(--yt-hover);
        }

        .thumbnail-option i {
            font-size: 1.5rem;
            color: var(--yt-text-secondary);
            margin-bottom: 0.5rem;
        }

        .thumbnail-option span {
            font-size: 0.75rem;
            color: var(--yt-text-secondary);
            text-align: center;
        }

        .thumbnail-option.selected {
            border: 2px solid var(--yt-blue);
        }

        .thumbnail-option img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
        }

        /* Dropdown */
        .dropdown-yt {
            background-color: var(--yt-bg-primary);
            border: 1px solid var(--yt-border-color);
            border-radius: 8px;
            padding: 0.75rem 1rem;
            color: var(--yt-text-primary);
            width: 100%;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.2s;
        }

        .dropdown-yt:hover {
            background-color: var(--yt-hover);
        }

        /* Video Preview Sidebar */
        .video-preview {
            position: sticky;
            top: 20px;
        }

        .video-thumbnail {
            width: 100%;
            aspect-ratio: 16/9;
            background-color: #000;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            cursor: pointer;
            margin-bottom: 1rem;
        }

        .video-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .video-placeholder {
            color: var(--yt-text-secondary);
            font-size: 3rem;
        }

        .video-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
            padding: 1rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .video-controls {
            display: flex;
            gap: 0.75rem;
            align-items: center;
        }

        .play-btn {
            width: 40px;
            height: 40px;
            background-color: rgba(255,255,255,0.9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .play-btn:hover {
            background-color: #fff;
            transform: scale(1.05);
        }

        .video-time {
            color: #fff;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .video-info-item {
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--yt-border-color);
        }

        .video-info-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .video-info-label {
            font-size: 0.75rem;
            color: var(--yt-text-secondary);
            margin-bottom: 0.25rem;
        }

        .video-info-value {
            color: var(--yt-text-primary);
            font-size: 0.9rem;
            word-break: break-all;
        }

        .video-link {
            color: var(--yt-blue);
            text-decoration: none;
        }

        .video-link:hover {
            text-decoration: underline;
        }

        .copy-btn {
            background: transparent;
            border: none;
            color: var(--yt-text-secondary);
            padding: 0.25rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .copy-btn:hover {
            color: var(--yt-text-primary);
        }

        .badge-yt {
            background-color: var(--yt-bg-tertiary);
            color: var(--yt-text-primary);
            border-radius: 4px;
            padding: 0.25rem 0.6rem;
            font-size: 0.75rem;
            font-weight: 500;
            border: 1px solid var(--yt-border-color);
        }

        .info-card {
            background-color: var(--yt-bg-primary);
            border: 1px solid var(--yt-border-color);
            border-radius: 8px;
            padding: 1rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .info-card:hover {
            background-color: var(--yt-hover);
        }

        /* Table */
        .table-yt {
            background-color: transparent;
            color: var(--yt-text-primary);
            margin-bottom: 2rem;
        }

        .table-yt thead {
            border-bottom: 1px solid var(--yt-border-color);
        }

        .table-yt th {
            background-color: transparent;
            color: var(--yt-text-primary);
            font-weight: 500;
            font-size: 0.9rem;
            padding: 1rem 0.75rem;
        }

        .table-yt td {
            background-color: transparent;
            border: none;
            padding: 1.25rem 0.75rem;
            color: var(--yt-text-primary);
            font-size: 0.9rem;
            vertical-align: middle;
            border-bottom: 1px solid var(--yt-border-color);
        }

        .table-yt tbody tr:hover {
            background-color: var(--yt-bg-tertiary);
        }

        .badge {
            padding: 0.35rem 0.75rem;
            font-size: 0.8rem;
            font-weight: 500;
            border-radius: 4px;
        }

        /* Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--yt-bg-primary);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--yt-text-secondary);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--yt-text-primary);
        }

        @media (max-width: 992px) {
            .video-preview {
                position: static;
                margin-bottom: 2rem;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<div class="yt-header">
    <div class="d-flex justify-content-between align-items-center">
        <h1 class="yt-title">Video Management</h1>
        <div class="d-flex gap-2">
            <button class="btn-yt" type="button" onclick="location.href='/FPL_JAV201_Assignment/home'"> Home
                <i class="bi bi-three-dots-vertical"></i>
            </button>
        </div>
    </div>
</div>

<div class="main-container">
    <!-- Tabs Navigation -->
    <ul class="nav nav-tabs-yt" role="tablist">
        <li class="nav-item">
            <button  class="nav-link active" data-bs-toggle="tab" data-bs-target="#listTab">Videos List</button>
        </li>
        <li class="nav-item">
            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#editTab">Videos Editing</button>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content">
        <!-- Tab 1: Videos List -->
        <div class="tab-pane fade show active" id="listTab">
            <div class="tab-content-card ">
                <table class="table table-yt">
                    <thead>
                    <tr>
                        <th>Youtube Id</th>
                        <th>Video Title</th>
                        <th>Views</th>
                        <th>Active</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="v" items="${videos}">
                    <tr>
                        <td><span class="video-link">${v.id}</span></td>
                        <td>${v.title}</td>
                        <td>${v.views}</td>
                        <td>
                            <span class="badge ${v.active ? 'bg-success' : 'bg-secondary'}">
                                    ${v.active ? 'Công khai' : 'Riêng tư'}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/user/video/edit?title=${v.title}"
                               class="btn-yt">Edit</a>
                        </td>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination -->
                <div class="d-flex justify-content-center gap-2">
                    <button class="btn-yt px-3" title="First page">
                        <i class="bi bi-chevron-bar-left"></i>
                    </button>
                    <button class="btn-yt px-3" title="Previous page">
                        <i class="bi bi-chevron-left"></i>
                    </button>
                    <button class="btn-yt px-3" title="Next page">
                        <i class="bi bi-chevron-right"></i>
                    </button>
                    <button class="btn-yt px-3" title="Last page">
                        <i class="bi bi-chevron-bar-right"></i>
                    </button>
                </div>
            </div>
        </div>
        <!-- Tab 2: Videos Editing -->
        <div class="tab-pane fade show" id="editTab">
            <div class="tab-content-card">
                <div class="row">
                    <!-- Left Column - Form -->
                    <div class="col-lg-8">
                        <form method="post" action="${pageContext.request.contextPath}/user/video/edit">
                            <!-- Hidden input để giữ title cũ khi update -->
                            <input type="hidden" name="oldTitle" value="${video.title}">
                        <!-- Tiêu đề -->
                            <!-- Tiêu đề -->
                            <div class="form-section">
                                <div class="form-label-yt">
                                    Tiêu đề (bắt buộc) <i class="bi bi-question-circle"></i>
                                </div>
                                <input type="text" class="form-control-yt" name="title" value="${video.title}">
                            </div>

                            <!-- Mô tả -->
                            <div class="form-section">
                                <div class="form-label-yt">
                                    Mô tả <i class="bi bi-question-circle"></i>
                                </div>
                                <textarea class="form-control-yt" name="description">${video.description}</textarea>
                            </div>
                            <!-- Chế độ hiển thị (mới thêm) -->
                            <div class="form-section">
                                 <div class="section-title">Chế độ hiển thị</div>
                                 <div class="section-subtitle">
                                     Chọn "Công khai" để mọi người xem, "Riêng tư" để chỉ bạn xem được.
                                     <a href="#">Tìm hiểu thêm</a>
                                 </div>
                                 <select name="visibility" class="form-control-yt">
                                     <option value="public" ${video.active ? 'selected' : ''}>Công khai</option>
                                     <option value="private" ${!video.active ? 'selected' : ''}>Riêng tư</option>
                                 </select>
                            </div>
                        <!-- Hình thu nhỏ -->
                        <div class="form-section">
                        <!-- Hình thu nhỏ (tự động select và hiển thị poster) -->
                            <div class="section-title">Hình thu nhỏ</div>
                                <div class="section-subtitle">
                                Chọn hình thu nhỏ nổi bật để thu hút sự chú ý của người xem.
                                <a href="#">Tìm hiểu thêm</a>
                                 </div>
                                 <div class="thumbnail-grid">
                                      <div class="thumbnail-option">
                                          <i class="bi bi-file-earmark-arrow-up"></i>
                                          <span>Tải tệp lên</span>
                                          <input type="file" accept="image/*" style="display: none;" id="thumbnailUpload">
                                      </div>
                                      <div class="thumbnail-option selected">  <!-- Tự động selected và hiển thị poster -->
                                           <img src="${video.poster}" alt="Tạo tự động">
                                          </div>
                                      <div class="thumbnail-option">
                                           <i class="bi bi-clipboard-check"></i>
                                           <span>Thử nghiệm A/B</span>
                                      </div>
                                 </div>
                        </div>

                        <!-- Danh sách phát -->
                        <div class="form-section">
                            <div class="section-title">Danh sách phát</div>
                            <div class="section-subtitle">
                                Thêm video của bạn vào danh sách phát để sắp xếp nội dung cho người xem.
                                <a href="#">Tìm hiểu thêm</a>
                            </div>

                            <div class="dropdown-yt">
                                <span style="color: var(--yt-text-secondary);">Chọn</span>
                                <i class="bi bi-chevron-down"></i>
                            </div>
                        </div>
                        <button type="reset" class="btn-yt">Cancel</button>
                        <button type="submit" class="btn-yt btn-yt-primary">Save</button>
                        </form>
                    </div>
                    <!-- Right Column - Video Preview -->
                    <div class="col-lg-4">
                        <div class="video-preview">
                            <div class="video-thumbnail" id="videoPreview">
                                <c:choose>
                                    <c:when test="${fn:contains(video.poster, 'youtube.com/embed/')}">
                                        <!-- Nếu là URL embed YouTube, dùng iframe để preview video -->
                                        <iframe width="100%" height="auto" src="${video.poster}" frameborder="0" allowfullscreen></iframe>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Giả sử là image URL hoặc file path, dùng img làm placeholder -->
                                        <img src="${video.poster}" alt="Video Preview">
                                    </c:otherwise>
                                </c:choose>
                                <!-- Overlay controls (giữ nguyên, nhưng có thể ẩn nếu dùng iframe vì iframe có controls riêng) -->
                                <div class="video-overlay">
                                    <div class="video-controls">
                                        <div class="play-btn">
                                            <i class="bi bi-play-fill" style="color: #000;"></i>
                                        </div>
                                        <i class="bi bi-volume-up-fill" style="color: #fff; font-size: 1.25rem;"></i>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <i class="bi bi-gear-fill" style="color: #fff; font-size: 1.25rem;"></i>
                                        <i class="bi bi-arrows-fullscreen" style="color: #fff; font-size: 1.25rem;"></i>
                                    </div>
                                </div>
                            </div>

                            <!-- Video Info (update chế độ hiển thị) -->
                            <div class="video-info-item">
                                <div class="video-info-label">Đường liên kết của video</div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <a href="https://www.youtube.com/embed/" class="video-link video-info-value">https://www.youtube.com/embed/ENtSGP6MDMY</a>  <!-- Giả sử id là YouTube ID -->
                                    <button class="copy-btn" onclick="copyLink()" title="Sao chép">
                                        <i class="bi bi-clipboard"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="video-info-item">
                                <div class="video-info-label">Tên tệp</div>
                                <div class="video-info-value">Video_${video.id}.mp4</div>
                            </div>

                            <div class="video-info-item">
                                <div class="video-info-label">Chất lượng video</div>
                                <div class="video-info-value">
                                    <span class="badge-yt">SD</span>
                                </div>
                            </div>


                            <div class="video-info-item">
                                <div class="info-card">
                                    <div class="video-info-label mb-1">Hạn chế</div>
                                    <div class="video-info-value">Bản quyền</div>
                                    <div style="font-size: 0.75rem; color: var(--yt-text-secondary); margin-top: 0.5rem;">
                                        + 1 hạn chế khác
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Thumbnail upload
    document.querySelector('.thumbnail-option').addEventListener('click', function() {
        if (this.querySelector('input[type="file"]')) {
            document.getElementById('thumbnailUpload').click();
        }
    });

    document.getElementById('thumbnailUpload').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const thumbnailOption = event.target.closest('.thumbnail-option');
                thumbnailOption.innerHTML = `<img src="${e.target.result}" alt="Uploaded">`;
                thumbnailOption.classList.add('selected');

                // Update video preview
                const videoPreview = document.getElementById('videoPreview');
                const existingImg = videoPreview.querySelector('img');
                existingImg.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // Copy link
    function copyLink() {
        const link = 'https://youtu.be/ot1ftZCszqw';
        navigator.clipboard.writeText(link).then(() => {
            const btn = event.target.closest('.copy-btn');
            btn.innerHTML = '<i class="bi bi-check2"></i>';
            setTimeout(() => {
                btn.innerHTML = '<i class="bi bi-clipboard"></i>';
            }, 2000);
        });
    }

    // Thumbnail selection
    document.querySelectorAll('.thumbnail-option').forEach(option => {
        option.addEventListener('click', function() {
            if (!this.querySelector('input[type="file"]')) {
                document.querySelectorAll('.thumbnail-option').forEach(opt => {
                    opt.classList.remove('selected');
                });
                this.classList.add('selected');
            }
        });
    });
    document.addEventListener("DOMContentLoaded", function() {
        const activeTab = "${activeTab}";
        if (activeTab === "edit") {
            const editTabBtn = document.querySelector('[data-bs-target="#editTab"]');
            const tab = new bootstrap.Tab(editTabBtn);
            tab.show();
        }
    });
</script>
</body>
</html>
