<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thành viên | Admin Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary: #6366f1;
            --danger-soft: #fff1f2;
            --warning-soft: #fffbeb;
            --text-main: #1e293b;
        }

        body {
            background-color: #f8fafc;
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: var(--text-main);
        }

        .main-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
            background: #ffffff;
            overflow: hidden; /* Đảm bảo nội dung không tràn khỏi border radius */
        }

        .card-header {
            background: transparent !important;
            border-bottom: 1px solid #f1f5f9;
            padding: 24px;
        }

        .page-icon {
            width: 42px;
            height: 42px;
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .table thead th {
            background: #f8fafc;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-weight: 700;
            color: #64748b;
            border-top: none;
            padding: 16px 20px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            object-fit: cover;
            background: #eee;
        }

        .btn-action {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease-in-out;
            border: 1px solid transparent;
        }

        .btn-edit { background: var(--warning-soft); color: #b45309; }
        .btn-edit:hover { background: #fef3c7; border-color: #fcd34d; transform: scale(1.05); }

        .btn-delete { background: var(--danger-soft); color: #e11d48; }
        .btn-delete:hover { background: #ffe4e6; border-color: #fecdd3; transform: scale(1.05); }

        .modal-content { border-radius: 20px; border: none; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.1); }
        .form-control { border-radius: 10px; padding: 12px 16px; border: 1px solid #e2e8f0; }
        .form-control:focus { box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1); border-color: var(--primary); }
    </style>
</head>
<body class="py-5">

<div class="container">
    <div class="main-card card">
        <div class="card-header d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center">
                <div class="page-icon me-3">
                    <i class="fa-solid fa-user-group"></i>
                </div>
                <div>
                    <h5 class="mb-0 fw-bold">Danh sách thành viên</h5>
                    <p class="text-muted small mb-0">Quản lý và phân quyền người dùng hệ thống</p>
                </div>
            </div>
            <button class="btn btn-primary rounded-pill px-4 fw-600 shadow-sm" style="background: var(--primary); border:none">
                <i class="fa fa-plus me-2"></i> Thêm mới
            </button>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead>
                <tr>
                    <th>Người dùng</th>
                    <th>Email Liên hệ</th>
                    <th>Vai trò</th>
                    <th class="text-end">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <img src="https://ui-avatars.com/api/?name=${u.fullname}&background=random&color=fff"
                                     class="user-avatar me-3" alt="Avatar">
                                <div>
                                    <div class="fw-bold text-dark">${u.fullname}</div>
                                    <div class="text-muted small">ID: #${u.id}</div> </div>
                            </div>
                        </td>
                        <td><span class="text-muted">${u.email}</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${u.admin}">
                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-2 rounded-pill fw-600">
                                        <i class="fa-solid fa-user-shield me-1"></i> Quản trị viên
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-light text-dark border px-3 py-2 rounded-pill fw-500">
                                        <i class="fa-solid fa-user me-1"></i> Người dùng
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-end">
                            <button type="button" class="btn btn-action btn-edit me-2"
                                    data-bs-toggle="modal" data-bs-target="#editModal${u.id}" title="Chỉnh sửa">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </button>

                            <form action="user" method="post" class="d-inline">
                                <input type="hidden" name="id" value="${u.id}"> <button type="submit" name="action" value="delete"
                                                                                        class="btn btn-action btn-delete"
                                                                                        onclick="return confirm('Bạn có chắc chắn muốn xóa thành viên này?')" title="Xóa">
                                <i class="fa-solid fa-trash-can"></i>
                            </button>
                            </form>
                        </td>
                    </tr>

                    <div class="modal fade" id="editModal${u.id}" tabindex="-1" aria-hidden="true"> <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <form action="user" method="post">
                                <div class="modal-header border-0 pb-0">
                                    <h5 class="modal-title fw-bold">Cập nhật thông tin</h5>
                                    <button type="button" class="btn-close" data-bs-modal="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body p-4">
                                    <input type="hidden" name="id" value="${u.id}"> <div class="mb-4 text-center">
                                    <img src="https://ui-avatars.com/api/?name=${u.fullname}&size=80&background=random"
                                         class="rounded-circle shadow-sm border border-4 border-white">
                                </div>

                                    <div class="mb-3">
                                        <label class="form-label fw-600">Họ và tên</label>
                                        <input type="text" class="form-control" name="fullname" value="${u.fullname}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label fw-600">Địa chỉ Email</label>
                                        <input type="email" class="form-control" name="email" value="${u.email}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label fw-600 d-block">Vai trò hệ thống</label>
                                        <div class="btn-group w-100" role="group">
                                            <input type="radio" class="btn-check" name="admin" id="roleUser${u.id}" value="false" ${!u.admin ? 'checked' : ''}>
                                            <label class="btn btn-outline-secondary" for="roleUser${u.id}">Người dùng</label>

                                            <input type="radio" class="btn-check" name="admin" id="roleAdmin${u.id}" value="true" ${u.admin ? 'checked' : ''}>
                                            <label class="btn btn-outline-danger" for="roleAdmin${u.id}">Quản trị viên</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer bg-light p-3 border-0">
                                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Hủy bỏ</button>
                                    <button type="submit" name="action" value="update" class="btn btn-primary rounded-pill px-4 shadow-sm">
                                        Lưu thay đổi
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    </div>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="card-footer bg-transparent border-top p-4 text-center text-md-start">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-3">
                <span class="text-muted small">Hiển thị ${users.size()} người dùng</span>
                <nav>
                    <ul class="pagination pagination-sm m-0">
                        <li class="page-item disabled"><a class="page-link border-0 rounded-circle mx-1" href="#"><i class="fa fa-chevron-left"></i></a></li>
                        <li class="page-item active"><a class="page-link border-0 rounded-circle mx-1" href="#">1</a></li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1" href="#"><i class="fa fa-chevron-right"></i></a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>