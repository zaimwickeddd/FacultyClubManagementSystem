<%-- 
    Document   : Logout Confirmation
    Created on : 12 Jan 2026, 5:34:31 pm
    Updated on : 8 Feb 2026
    Author     : Gi995tzy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Session check - redirect to login if no session exists
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    if (userName == null) userName = "User";
    if (userRole == null) userRole = "Member";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout Confirmation | UiTM Club Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #fbc2eb 0%, #e0b0ff 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            margin: 0;
            padding: 20px;
        }

        .logout-container {
            background: white;
            padding: 45px 40px;
            width: 100%;
            max-width: 520px;
            border: 3px solid #9c42f5;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(156, 66, 245, 0.3);
            text-align: center;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .logo-img {
            max-width: 180px;
            height: auto;
            margin-bottom: 20px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }

        .system-title {
            font-weight: 700;
            font-size: 1.4rem;
            margin-bottom: 10px;
            color: #333;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 30px;
        }

        .user-info-card {
            background: linear-gradient(135deg, #f5f5f5 0%, #e8e8e8 100%);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            border: 2px solid #d0d0d0;
        }

        .user-icon {
            font-size: 3rem;
            color: #9c42f5;
            margin-bottom: 10px;
        }

        .user-name {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .user-role {
            display: inline-block;
            background: #9c42f5;
            color: white;
            padding: 4px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .confirmation-box {
            background-color: #fff8f8;
            border: 2px solid #ffe0e0;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
        }

        .warning-icon {
            font-size: 2.5rem;
            color: #ff4444;
            margin-bottom: 15px;
        }

        .confirmation-text {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .confirmation-subtext {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0;
        }

        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-custom {
            padding: 12px 35px;
            border-radius: 10px;
            font-weight: 600;
            border: 2px solid transparent;
            font-size: 1rem;
            transition: all 0.3s ease;
            cursor: pointer;
            min-width: 140px;
        }

        .btn-custom-back {
            background-color: #6c757d;
            color: white;
            border-color: #6c757d;
        }
        
        .btn-custom-back:hover {
            background-color: #5a6268;
            border-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
        }

        .btn-custom-logout {
            background-color: #ff0019;
            color: white;
            border-color: #ff0019;
        }
        
        .btn-custom-logout:hover {
            background-color: #cc0014;
            border-color: #cc0014;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 0, 25, 0.4);
        }

        .btn-custom:active {
            transform: translateY(0);
        }

        @media (max-width: 576px) {
            .logout-container {
                padding: 30px 25px;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .btn-custom {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="logout-container">
    <!-- Logo -->
    <div class="text-center">
        <img src="image/UiTM-Logo-removebg-preview.png" alt="UiTM Logo" class="logo-img">
    </div>
    
    <!-- System Title -->
    <div class="system-title">
        UiTM Club Management System
    </div>
    <div class="subtitle">
        Faculty Club Management Portal
    </div>

    <!-- User Info Card -->
    <div class="user-info-card">
        <i class="fas fa-user-circle user-icon"></i>
        <div class="user-name"><%= userName %></div>
        <span class="user-role"><%= userRole %></span>
    </div>

    <!-- Logout Confirmation -->
    <div class="confirmation-box">
        <i class="fas fa-sign-out-alt warning-icon"></i>
        <p class="confirmation-text">Are you sure you want to logout?</p>
        <p class="confirmation-subtext">You will need to login again to access the system.</p>
    </div>
    
    <!-- Action Buttons -->
    <div class="button-group">
        <button onclick="goBack()" class="btn btn-custom btn-custom-back">
            <i class="fas fa-arrow-left"></i> Go Back
        </button>
        
        <form action="LogoutServlet" method="POST" style="margin: 0; display: inline-block;">
            <button type="submit" class="btn btn-custom btn-custom-logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </form>
    </div>
</div>

<script>
    function goBack() {
        // Try to go back to the previous page
        if (document.referrer && document.referrer !== window.location.href) {
            window.history.back();
        } else {
            // If no referrer, redirect to homepage
            window.location.href = 'homepage.jsp';
        }
    }
    
    // Prevent caching of this page
    window.onpageshow = function(event) {
        if (event.persisted) {
            window.location.reload();
        }
    };
</script>

</body>
</html>
