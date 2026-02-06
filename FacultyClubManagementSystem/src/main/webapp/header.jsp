<%-- 
    Document   : header
    Created on : 17 Jan 2026, 1:15:00 pm
    Author     : Anderson Giggs
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Inter', sans-serif;
            background-color: #fbc2eb;
            min-height: 100vh;
        }

        /* Navbar Styling */
        .navbar {
            background-color: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 30px;
            border-bottom: 3px solid #000;
        }

        .logo-section img { 
            height: 60px; 
        }

        .nav-links { 
            display: flex; 
            gap: 20px; 
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #fff;
            padding: 10px 25px;
            border-radius: 25px;
            border: 2px solid #000;
            text-decoration: none;
            color: #000;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .nav-item:hover {
            background-color: #ff99f1;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            border-left: 2px solid #000;
            padding-left: 15px;
        }

        .user-info {
            text-align: right;
        }

        .user-info strong {
            display: block;
            font-size: 0.95rem;
        }

        .user-info small {
            color: #666;
            font-size: 0.85rem;
        }

        .logout-link {
            color: #ff0000;
            font-weight: bold;
            text-decoration: none;
            font-size: 0.8rem;
        }

        .logout-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<header class="navbar">
    <div class="logo-section">
        <img src="${pageContext.request.contextPath}/image/UiTM-Logo-removebg-preview.png" alt="UiTM Logo">
    </div>

    <nav class="nav-links">
        <a href="homepage.jsp" class="nav-item">
            <i class="fas fa-home"></i> Home
        </a>
        <a href="eventListController" class="nav-item">
            <i class="fas fa-calendar-alt"></i> Events
        </a>
        <a href="clubPage.jsp" class="nav-item">
            <i class="fas fa-star"></i> Clubs
        </a>

        <%-- Role-based navigation for Member --%>
        <% if ("Member".equals(session.getAttribute("userRole"))) { %>
            <a href="addAdmin.jsp" class="nav-item">
                <i class="fas fa-user-plus"></i> Add User
            </a>
        <% } %>
        
        <% if ("Advisor".equals(session.getAttribute("userRole"))) { %>
            <a class="nav-item" href="advisorListApprovalController">
                <i class="fas fa-clipboard-check"></i> Approval List
            </a>
        <% } %>
        
    </nav>

    <div class="user-profile">
    <a href="profile.jsp" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
        <i class="fas fa-user-circle fa-2x"></i>
        
        <div style="display: flex; flex-direction: column; text-align: left;">
            <strong style="font-size: 1rem; line-height: 1.1;">
                <%= session.getAttribute("username") %>
            </strong>
            <small style="color: #666; font-size: 0.85rem; line-height: 1.1;">
                (<%= session.getAttribute("userRole") %>)
            </small>
            
            <a href="LogoutServlet" class="logout-link" style="margin-top: 5px;">LOGOUT</a>
        </div>
    </a>
</div>
</header>
