<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Focus</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', Arial, sans-serif;
            background: linear-gradient(135deg, #0f0f0f 0%, #1a1a1a 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        /* Animated background particles */
        body::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background-image: 
                radial-gradient(circle at 20% 50%, rgba(255, 0, 0, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(255, 0, 0, 0.05) 0%, transparent 50%);
            animation: float 20s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(30px, -30px) rotate(120deg); }
            66% { transform: translate(-20px, 20px) rotate(240deg); }
        }

        .container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 1000px;
            background: rgba(24, 24, 24, 0.95);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        .auth-wrapper {
            display: grid;
            grid-template-columns: 1fr 1fr;
            min-height: 600px;
        }

        /* Left Panel - Brand Side */
        .brand-panel {
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .brand-panel::before {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            top: -100px;
            right: -100px;
        }

        .brand-panel::after {
            content: '';
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
            bottom: -50px;
            left: -50px;
        }

        .brand-content {
            position: relative;
            z-index: 1;
        }

        .brand-logo {
            font-size: 48px;
            color: white;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .brand-logo i {
            font-size: 56px;
        }

        .brand-title {
            font-size: 32px;
            font-weight: 700;
            color: white;
            margin-bottom: 16px;
            letter-spacing: -1px;
        }

        .brand-description {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.9);
            line-height: 1.6;
            max-width: 350px;
        }

        .brand-features {
            margin-top: 40px;
            display: flex;
            flex-direction: column;
            gap: 16px;
            align-items: flex-start;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 12px;
            color: white;
            font-size: 14px;
        }

        .feature-item i {
            width: 24px;
            height: 24px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }

        /* Right Panel - Form Side */
        .form-panel {
            padding: 60px 50px;
            background: #181818;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header {
            margin-bottom: 40px;
        }

        .form-title {
            font-size: 28px;
            font-weight: 700;
            color: #f1f1f1;
            margin-bottom: 8px;
        }

        .form-subtitle {
            font-size: 14px;
            color: #aaa;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #f1f1f1;
            margin-bottom: 8px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #717171;
            font-size: 16px;
        }

        .form-input {
            width: 100%;
            padding: 14px 16px 14px 48px;
            background: #0f0f0f;
            border: 1px solid #303030;
            border-radius: 12px;
            color: #f1f1f1;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: #ff0000;
            background: #121212;
            box-shadow: 0 0 0 3px rgba(255, 0, 0, 0.1);
        }

        .form-input::placeholder {
            color: #717171;
        }

        .forgot-password {
            text-align: right;
            margin-top: -16px;
            margin-bottom: 24px;
        }

        .forgot-password a {
            color: #ff0000;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .forgot-password a:hover {
            color: #ff3333;
            text-decoration: underline;
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(255, 0, 0, 0.3);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 0, 0, 0.4);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 32px 0;
            color: #717171;
            font-size: 13px;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #303030;
        }

        .divider span {
            padding: 0 16px;
        }

        .social-login {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 32px;
        }

        .social-btn {
            padding: 12px;
            background: #0f0f0f;
            border: 1px solid #303030;
            border-radius: 12px;
            color: #f1f1f1;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .social-btn:hover {
            background: #1a1a1a;
            border-color: #404040;
        }

        .social-btn i {
            font-size: 18px;
        }

        .register-link {
            text-align: center;
            color: #aaa;
            font-size: 14px;
        }

        .register-link a {
            color: #ff0000;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }

        .register-link a:hover {
            color: #ff3333;
            text-decoration: underline;
        }

        /* Alert Messages */
        .alert {
            padding: 14px 16px;
            border-radius: 12px;
            margin-bottom: 24px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-danger {
            background: rgba(255, 59, 48, 0.1);
            border: 1px solid rgba(255, 59, 48, 0.3);
            color: #ff3b30;
        }

        .alert-success {
            background: rgba(52, 199, 89, 0.1);
            border: 1px solid rgba(52, 199, 89, 0.3);
            color: #34c759;
        }

        .alert i {
            font-size: 18px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .auth-wrapper {
                grid-template-columns: 1fr;
            }

            .brand-panel {
                padding: 40px 30px;
                min-height: 300px;
            }

            .brand-logo {
                font-size: 36px;
            }

            .brand-logo i {
                font-size: 42px;
            }

            .brand-title {
                font-size: 24px;
            }

            .brand-features {
                display: none;
            }

            .form-panel {
                padding: 40px 30px;
            }

            .form-title {
                font-size: 24px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 0;
            }

            .container {
                border-radius: 0;
                min-height: 100vh;
            }

            .form-panel {
                padding: 30px 20px;
            }

            .social-login {
                grid-template-columns: 1fr;
            }
        }

        /* Loading State */
        .submit-btn.loading {
            pointer-events: none;
            opacity: 0.7;
        }

        .submit-btn.loading::after {
            content: '';
            width: 16px;
            height: 16px;
            border: 2px solid white;
            border-top-color: transparent;
            border-radius: 50%;
            display: inline-block;
            margin-left: 8px;
            animation: spin 0.6s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="auth-wrapper">
            <!-- Brand Panel -->
            <div class="brand-panel">
                <div class="brand-content">
                    <div class="brand-logo">
                        <i class="fab fa-youtube"></i>
                    </div>
                    <h1 class="brand-title">Focus</h1>
                    <p class="brand-description">
                        Khám phá hàng triệu video từ những người sáng tạo trên toàn thế giới
                    </p>
                    
                    <div class="brand-features">
                        <div class="feature-item">
                            <i class="fas fa-check"></i>
                            <span>Xem video không giới hạn</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-check"></i>
                            <span>Tạo danh sách phát cá nhân</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-check"></i>
                            <span>Theo dõi kênh yêu thích</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-check"></i>
                            <span>Bình luận và tương tác</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Form Panel -->
            <div class="form-panel">
                <div class="form-header">
                    <h2 class="form-title">Chào mừng trở lại!</h2>
                    <p class="form-subtitle">Đăng nhập để tiếp tục trải nghiệm</p>
                </div>

                <!-- Alert Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span>${message}</span>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/auth/login" method="post" id="loginForm">
                    <div class="form-group">
                        <label for="email" class="form-label">Email</label>
                        <div class="input-wrapper">
                            <i class="fas fa-envelope input-icon"></i>
                            <input 
                                type="email" 
                                class="form-input" 
                                id="email" 
                                name="email" 
                                placeholder="example@email.com"
                                required
                                autocomplete="email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <div class="input-wrapper">
                            <i class="fas fa-lock input-icon"></i>
                            <input 
                                type="password" 
                                class="form-input" 
                                id="password" 
                                name="password" 
                                placeholder="••••••••"
                                required
                                autocomplete="current-password">
                        </div>
                    </div>

                    <div class="forgot-password">
                        <a href="${pageContext.request.contextPath}/auth/ForgotPassword.jsp">Quên mật khẩu?</a>
                    </div>

                    <button type="submit" class="submit-btn" id="submitBtn">
                        Đăng nhập
                    </button>
                </form>

                <div class="divider">
                    <span>hoặc tiếp tục với</span>
                </div>

                <div class="social-login">
                    <button class="social-btn" type="button">
                        <i class="fab fa-google"></i>
                        <span>Google</span>
                    </button>
                    <button class="social-btn" type="button">
                        <i class="fab fa-facebook-f"></i>
                        <span>Facebook</span>
                    </button>
                </div>

                <div class="register-link">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/auth/Register">Đăng ký ngay</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Form submission with loading state
        const form = document.getElementById('loginForm');
        const submitBtn = document.getElementById('submitBtn');

        form.addEventListener('submit', function() {
            submitBtn.classList.add('loading');
            submitBtn.textContent = 'Đang đăng nhập';
        });

        // Auto-hide alerts after 5 seconds
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.animation = 'slideIn 0.3s ease reverse';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
        });
    </script>
</body>
</html>
