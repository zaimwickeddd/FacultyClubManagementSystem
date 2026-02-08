<%-- 
    Document   : register
    Created on : 16 Jan 2026, 1:54:36 pm
    Author     : Muhamad Zulhairie
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | UiTM Club Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #fbc2eb 0%, #e0b0ff 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .register-container {
            background: white;
            padding: 40px 45px;
            border-radius: 25px;
            border: 3px solid #9c42f5;
            box-shadow: 0 15px 50px rgba(156, 66, 245, 0.3);
            width: 100%;
            max-width: 550px;
            animation: slideUp 0.4s ease-out;
        }

        @keyframes slideUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo-img {
            max-width: 120px;
            height: auto;
            margin-bottom: 15px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }

        .register-title {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .register-subtitle {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #9c42f5;
            font-size: 1.1rem;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="number"],
        select {
            width: 100%;
            padding: 14px 15px 14px 45px;
            border: 2px solid #ddd;
            border-radius: 12px;
            font-size: 0.95rem;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
            background: #fafafa;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #9c42f5;
            background: white;
            box-shadow: 0 0 0 4px rgba(156, 66, 245, 0.1);
        }

        select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%239c42f5' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 12px;
            padding-right: 40px;
        }

        .btn-register {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #9c42f5 0%, #ff99f1 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(156, 66, 245, 0.4);
        }

        .btn-register:active {
            transform: translateY(0);
        }

        .back-to-login {
            text-align: center;
            margin-top: 25px;
            font-size: 0.95rem;
        }

        .back-to-login a {
            color: #9c42f5;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .back-to-login a:hover {
            color: #7a2fcd;
            text-decoration: underline;
        }

        .error-message {
            background: #ffe0e0;
            border: 2px solid #ff4444;
            color: #cc0000;
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .success-message {
            background: #e0ffe0;
            border: 2px solid #44ff44;
            color: #008800;
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .required-mark {
            color: #ff4444;
            margin-left: 3px;
        }

        /* Grid for two-column layout */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        @media (max-width: 600px) {
            .register-container {
                padding: 30px 25px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .register-title {
                font-size: 1.6rem;
            }
        }

        /* Loading state */
        .btn-register:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <!-- Logo Section -->
        <div class="logo-section">
            <img src="image/UiTM-Logo-removebg-preview.png" alt="UiTM Logo" class="logo-img">
            <h1 class="register-title">Create Account</h1>
            <p class="register-subtitle">Join UiTM Club Management System</p>
        </div>

        <!-- Error/Success Messages -->
        <c:if test="${param.error == 'email_exists'}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                <span>Email already registered. Please use a different email.</span>
            </div>
        </c:if>
        
        <c:if test="${param.success == 'registered'}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                <span>Registration successful! Please login.</span>
            </div>
        </c:if>

        <!-- Registration Form -->
        <form action="authController" method="POST" id="registerForm">
            <input type="hidden" name="action" value="register">

            <!-- Username -->
            <div class="form-group">
                <label for="username">Username<span class="required-mark">*</span></label>
                <div class="input-wrapper">
                    <i class="fas fa-user"></i>
                    <input type="text" id="username" name="username" 
                           placeholder="Enter your username" 
                           required minlength="3" maxlength="50">
                </div>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label for="email">Email<span class="required-mark">*</span></label>
                <div class="input-wrapper">
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" 
                           placeholder="example@student.uitm.edu.my" 
                           required>
                </div>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label for="password">Password<span class="required-mark">*</span></label>
                <div class="input-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" 
                           placeholder="Enter password" 
                           required minlength="6">
                </div>
            </div>

            <!-- Phone and Semester in one row -->
            <div class="form-row">
                <div class="form-group">
                    <label for="phone">Phone Number<span class="required-mark">*</span></label>
                    <div class="input-wrapper">
                        <i class="fas fa-phone"></i>
                        <input type="text" id="phone" name="phone" 
                               placeholder="0123456789" 
                               required pattern="[0-9]{10,11}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="semester">Semester<span class="required-mark">*</span></label>
                    <div class="input-wrapper">
                        <i class="fas fa-calendar-alt"></i>
                        <input type="number" id="semester" name="semester" 
                               placeholder="1-8" 
                               required min="1" max="8">
                    </div>
                </div>
            </div>

            <!-- Club Selection -->
            <div class="form-group">
                <label for="clubID">Club<span class="required-mark">*</span></label>
                <div class="input-wrapper">
                    <i class="fas fa-users"></i>
                    <select id="clubID" name="clubID" required>
                        <option value="" disabled selected>Select your club</option>
                        <c:forEach var="c" items="${clubList}">
                            <option value="${c.clubId}">${c.clubName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- Faculty Selection -->
            <div class="form-group">
                <label for="facultyID">Faculty<span class="required-mark">*</span></label>
                <div class="input-wrapper">
                    <i class="fas fa-building"></i>
                    <select id="facultyID" name="facultyID" required>
                        <option value="" disabled selected>Select your faculty</option>
                        <c:forEach var="f" items="${facultyList}">
                            <option value="${f.facultyID}">${f.facultyName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- Register Button -->
            <button type="submit" class="btn-register">
                <i class="fas fa-user-plus"></i> Create Account
            </button>
        </form>

        <!-- Back to Login -->
        <div class="back-to-login">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>

    <script>
        // Form validation enhancement
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const phone = document.getElementById('phone').value;
            
            // Password strength check
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long.');
                return false;
            }
            
            // Phone number validation
            if (!/^[0-9]{10,11}$/.test(phone)) {
                e.preventDefault();
                alert('Please enter a valid phone number (10-11 digits).');
                return false;
            }
            
            // Disable button to prevent double submission
            const submitBtn = this.querySelector('.btn-register');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Account...';
        });

        // Real-time phone number validation
        document.getElementById('phone').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });

        // Real-time semester validation
        document.getElementById('semester').addEventListener('input', function(e) {
            if (this.value > 8) this.value = 8;
            if (this.value < 1) this.value = 1;
        });
    </script>
</body>
</html>
