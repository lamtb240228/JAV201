<%--
  Created by IntelliJ IDEA.
  User: minhl
  Date: 1/26/2026
  Time: 11:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Chỉnh sửa hồ sơ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #0f0f0f;
            color: #f1f1f1;
            font-family: "Roboto", "Arial", sans-serif;
            min-height: 100vh;
            padding: 20px 0;
        }

        .profile-container {
            max-width: 700px;
            margin: 0 auto;
            padding: 0 16px;
        }

        .card {
            background-color: #212121;
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.3), 0 2px 6px 2px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            background-color: #282828;
            border-bottom: 1px solid #3f3f3f;
            padding: 24px 24px 20px;
        }

        .card-header h3 {
            color: #f1f1f1;
            font-size: 22px;
            font-weight: 500;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card-header h3 i {
            color: #aaa;
        }

        .card-body {
            padding: 24px;
        }

        .alert {
            border-radius: 8px;
            border: none;
            padding: 12px 16px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .alert-success {
            background-color: #1e3a1e;
            color: #4caf50;
            border-left: 3px solid #4caf50;
        }

        .alert-danger {
            background-color: #3a1e1e;
            color: #f44336;
            border-left: 3px solid #f44336;
        }

        .form-label {
            color: #aaa;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 8px;
            display: block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            background-color: #121212;
            border: 1px solid #3f3f3f;
            border-radius: 8px;
            color: #f1f1f1;
            padding: 11px 12px;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            background-color: #121212;
            border-color: #065fd4;
            color: #f1f1f1;
            box-shadow: 0 0 0 2px rgba(6, 95, 212, 0.2);
            outline: none;
        }

        .form-control::placeholder {
            color: #717171;
        }

        .mb-3 {
            margin-bottom: 20px !important;
        }

        .btn {
            border: none;
            border-radius: 8px;
            padding: 10px 16px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background-color: #065fd4;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0757c7;
            color: white;
        }

        .btn-outline-secondary {
            background-color: transparent;
            border: 1px solid #3f3f3f;
            color: #aaa;
        }

        .btn-outline-secondary:hover {
            background-color: #3f3f3f;
            color: #f1f1f1;
        }

        .btn-warning {
            background-color: #cc0000;
            color: white;
        }

        .btn-warning:hover {
            background-color: #b30000;
            color: white;
        }

        .btn-secondary {
            background-color: #3f3f3f;
            color: #f1f1f1;
        }

        .btn-secondary:hover {
            background-color: #4f4f4f;
        }

        .d-grid .btn {
            width: 100%;
        }

        .d-grid {
            gap: 12px !important;
        }

        .modal-content {
            background-color: #212121;
            border: none;
            border-radius: 12px;
        }

        .modal-header {
            background-color: #282828;
            border-bottom: 1px solid #3f3f3f;
            padding: 20px 24px;
        }

        .modal-title {
            color: #f1f1f1;
            font-size: 20px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-title i {
            color: #aaa;
        }

        .modal-body {
            padding: 24px;
        }

        .modal-footer {
            background-color: #212121;
            border-top: 1px solid #3f3f3f;
            padding: 16px 24px;
        }

        .btn-close {
            background: transparent url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='%23fff'%3e%3cpath d='M.293.293a1 1 0 011.414 0L8 6.586 14.293.293a1 1 0 111.414 1.414L9.414 8l6.293 6.293a1 1 0 01-1.414 1.414L8 9.414l-6.293 6.293a1 1 0 01-1.414-1.414L6.586 8 .293 1.707a1 1 0 010-1.414z'/%3e%3c/svg%3e") center/1em auto no-repeat;
            opacity: 0.5;
        }

        .btn-close:hover {
            opacity: 1;
        }

        /* Input icons */
        .input-group-text {
            background-color: #121212;
            border: 1px solid #3f3f3f;
            border-right: none;
            color: #717171;
        }

        .input-group .form-control {
            border-left: none;
        }

        /* Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #0f0f0f;
        }

        ::-webkit-scrollbar-thumb {
            background: #3f3f3f;
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .card-body {
                padding: 20px 16px;
            }

            .card-header {
                padding: 20px 16px 16px;
            }

            .card-header h3 {
                font-size: 20px;
            }
        }

        /* Animation */
        .card {
            animation: fadeInUp 0.3s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal.show .modal-dialog {
            animation: modalSlideIn 0.3s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Focus states */
        .btn:focus {
            outline: 2px solid #065fd4;
            outline-offset: 2px;
        }

        a {
            color: #3ea6ff;
            text-decoration: none;
        }

        a:hover {
            color: #65b8ff;
        }
    </style>
</head>
<body>
<div class="container profile-container">
    <div class="row justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-user-circle"></i>
                        Chỉnh sửa hồ sơ
                    </h3>
                </div>
                <div class="card-body">

                    <c:if test="${not empty message}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i> ${message}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/user/profile" method="post">

                        <div class="mb-3">
                            <label for="fullname" class="form-label">
                                Họ và tên
                            </label>
                            <input type="text" class="form-control" id="fullname" name="fullname"
                                   value="${sessionScope.user.fullname}" required
                                   placeholder="Nhập họ và tên của bạn">
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">
                                Email
                            </label>
                            <input type="email" class="form-control" id="email" name="email"
                                   value="${sessionScope.user.email}" required
                                   placeholder="example@email.com">
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                Lưu thay đổi
                            </button>
                            <a href="/FPL_JAV201_Assignment/home" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Quay lại trang chủ
                            </a>
                        </div>
                        <div>
                            <button type="button"
                                    class="btn btn-warning w-100 mt-3"
                                    data-bs-toggle="modal"
                                    data-bs-target="#changePasswordModal">
                                <i class="fas fa-key"></i>
                                Đổi mật khẩu
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<c:if test="${not empty pwError or not empty pwMessage}">
    <script>
        window.addEventListener("DOMContentLoaded", function () {
            const modalEl = document.getElementById("changePasswordModal");
            if (modalEl) {
                const modal = new bootstrap.Modal(modalEl);
                modal.show();
            }
        });
    </script>
</c:if>
<div class="modal fade" id="changePasswordModal" tabindex="-1"
     aria-labelledby="changePasswordLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="changePasswordLabel">
                    <i class="fas fa-lock"></i>
                    Đổi mật khẩu
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="${pageContext.request.contextPath}/user/change-password"
                  method="post">

                <div class="modal-body">

                    <c:if test="${not empty pwError}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i> ${pwError}
                        </div>
                    </c:if>

                    <c:if test="${not empty pwMessage}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i> ${pwMessage}
                        </div>
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label">
                            Mật khẩu hiện tại
                        </label>
                        <input type="password" class="form-control"
                               name="currentPassword" required
                               placeholder="Nhập mật khẩu hiện tại">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            Mật khẩu mới
                        </label>
                        <input type="password" class="form-control"
                               name="newPassword" required
                               placeholder="Nhập mật khẩu mới">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            Nhập lại mật khẩu mới
                        </label>
                        <input type="password" class="form-control"
                               name="confirmPassword" required
                               placeholder="Xác nhận mật khẩu mới">
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal">
                        <i class="fas fa-times"></i>
                        Hủy
                    </button>
                    <button type="submit" class="btn btn-warning">
                        <i class="fas fa-check"></i>
                        Xác nhận đổi mật khẩu
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>
</body>
</html>
