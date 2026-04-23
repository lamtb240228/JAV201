<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - YouTube Clone</title>
    
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
            min-height: 650px;
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

        .brand-stats {
            margin-top: 40px;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            width: 100%;
            max-width: 350px;
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 16px;
            backdrop-filter: blur(10px);
        }

        .stat-number {
            font-size: 28px;
            font-weight: 700;
            color: white;
            margin-bottom: 4px;
        }

        .stat-label {
            font-size: 12px;
            color: rgba(255, 255, 255, 0.8);
            text-transform: uppercase;
            letter-spacing: 0.5px;
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
            margin-bottom: 32px;
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
            margin-bottom: 20px;
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

        /* Password strength indicator */
        .password-strength {
            margin-top: 8px;
            height: 4px;
            background: #303030;
            border-radius: 2px;
            overflow: hidden;
            display: none;
        }

        .password-strength.active {
            display: block;
        }

        .strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }

        .strength-weak { width: 33%; background: #ff3b30; }
        .strength-medium { width: 66%; background: #ff9500; }
        .strength-strong { width: 100%; background: #34c759; }

        .password-hint {
            font-size: 12px;
            color: #717171;
            margin-top: 6px;
            display: none;
        }

        .password-hint.active {
            display: block;
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
            margin-top: 8px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 0, 0, 0.4);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .submit-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .terms {
            margin-top: 20px;
            font-size: 12px;
            color: #aaa;
            text-align: center;
            line-height: 1.6;
        }

        .terms a {
            color: #ff0000;
            text-decoration: none;
        }

        .terms a:hover {
            text-decoration: underline;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 24px 0;
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
            margin-bottom: 24px;
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

        .login-link {
            text-align: center;
            color: #aaa;
            font-size: 14px;
        }

        .login-link a {
            color: #ff0000;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }

        .login-link a:hover {
            color: #ff3333;
            text-decoration: underline;
        }

        /* Alert Messages */
        .alert {
            padding: 14px 16px;
            border-radius: 12px;
            margin-bottom: 20px;
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

            .brand-stats {
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
                    <h1 class="brand-title">Tham gia ngay!</h1>
                    <p class="brand-description">
                        Tạo tài khoản để khám phá, chia sẻ và kết nối với cộng đồng sáng tạo nội dung
                    </p>
                    
                    <div class="brand-stats">
                        <div class="stat-item">
                            <div class="stat-number">10M+</div>
                            <div class="stat-label">Video</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">5M+</div>
                            <div class="stat-label">Người dùng</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">100K+</div>
                            <div class="stat-label">Kênh</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">24/7</div>
                            <div class="stat-label">Hỗ trợ</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Form Panel -->
            <div class="form-panel">
                <div class="form-header">
                    <h2 class="form-title">Tạo tài khoản mới</h2>
                    <p class="form-subtitle">Điền thông tin để bắt đầu</p>
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

                <form action="${pageContext.request.contextPath}/auth/register" method="post" id="registerForm">
                    <div class="form-group">
                        <label for="fullname" class="form-label">Họ và tên</label>
                        <div class="input-wrapper">
                            <i class="fas fa-user input-icon"></i>
                            <input 
                                type="text" 
                                class="form-input" 
                                id="fullname" 
                                name="fullname" 
                                placeholder="Nguyễn Văn A"
                                required
                                autocomplete="name">
                        </div>
                    </div>

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
                                autocomplete="new-password">
                        </div>
                        <div class="password-strength" id="passwordStrength">
                            <div class="strength-bar" id="strengthBar"></div>
                        </div>
                        <div class="password-hint" id="passwordHint">
                            Mật khẩu nên có ít nhất 8 ký tự
                        </div>
                    </div>

                    <button type="submit" class="submit-btn" id="submitBtn">
                        Tạo tài khoản
                    </button>

                    <div class="terms">
                        Bằng việc đăng ký, bạn đồng ý với 
                        <a href="#">Điều khoản dịch vụ</a> và 
                        <a href="#">Chính sách bảo mật</a> của chúng tôi
                    </div>
                </form>

                <div class="divider">
                    <span>hoặc đăng ký với</span>
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

                <div class="login-link">
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/auth/Login">Đăng nhập</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Password strength checker
        const passwordInput = document.getElementById('password');
        const strengthIndicator = document.getElementById('passwordStrength');
        const strengthBar = document.getElementById('strengthBar');
        const passwordHint = document.getElementById('passwordHint');

        passwordInput.addEventListener('input', function() {
            const password = this.value;
            
            if (password.length === 0) {
                strengthIndicator.classList.remove('active');
                passwordHint.classList.remove('active');
                return;
            }

            strengthIndicator.classList.add('active');
            passwordHint.classList.add('active');

            // Calculate strength
            let strength = 0;
            if (password.length >= 8) strength++;
            if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^a-zA-Z0-9]/)) strength++;

            // Update UI
            strengthBar.className = 'strength-bar';
            if (strength <= 1) {
                strengthBar.classList.add('strength-weak');
                passwordHint.textContent = 'Mật khẩu yếu - Thêm chữ hoa, số và ký tự đặc biệt';
                passwordHint.style.color = '#ff3b30';
            } else if (strength <= 3) {
                strengthBar.classList.add('strength-medium');
                passwordHint.textContent = 'Mật khẩu trung bình - Có thể tốt hơn';
                passwordHint.style.color = '#ff9500';
            } else {
                strengthBar.classList.add('strength-strong');
                passwordHint.textContent = 'Mật khẩu mạnh!';
                passwordHint.style.color = '#34c759';
            }
        });

        // Form submission with loading state
        const form = document.getElementById('registerForm');
        const submitBtn = document.getElementById('submitBtn');

        form.addEventListener('submit', function(e) {
            const password = passwordInput.value;
            
            // Basic validation
            if (password.length < 8) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 8 ký tự');
                return;
            }

            submitBtn.classList.add('loading');
            submitBtn.textContent = 'Đang tạo tài khoản';
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
