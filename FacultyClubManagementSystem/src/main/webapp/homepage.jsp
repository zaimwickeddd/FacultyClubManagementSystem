<%-- 
    Document   : homepage
    Created on : 11 Jan 2026, 1:33:40 am
    Author     : Muhamad Zulhairie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard | UiTM</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --bg-pink: #fbc2eb; 
            --card-purple: #e0b0ff; 
            --header-gray: #e0e0e0;
            --accent-pink: #ff99f1;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-pink);
        }

        /* Navbar Styling */
        .navbar {
            background-color: var(--header-gray);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 30px;
            border-bottom: 1px solid #ccc;
        }

        .logo-section img { height: 60px; }
        .nav-links { display: flex; gap: 20px; }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #fff;
            padding: 8px 20px;
            border-radius: 25px;
            border: 2px solid #000;
            text-decoration: none;
            color: #000;
            font-weight: 600;
        }

        .nav-item.active { background-color: var(--accent-pink); }
        .user-profile { text-align: right; }
        .logout-link { color: red; text-decoration: none; font-weight: bold; font-size: 12px; }

        /* Main Dashboard Layout */
        .dashboard-container {
            display: flex;
            justify-content: space-around;
            padding: 50px 20px;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            border-radius: 20px;
            width: 320px;
            padding: 20px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            text-align: center;
            min-height: 400px;
            display: flex;
            flex-direction: column;
        }

        .card-title { font-size: 1.5rem; margin-bottom: 20px; font-weight: 700; }

        /* Club Card Specific */
        .club-info-box {
            background-color: var(--accent-pink);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .club-logo { width: 80px; height: 80px; background: white; border-radius: 50%; margin: 0 auto 10px; display: flex; align-items: center; justify-content: center; }
        
        /* Action Buttons */
        .btn-view, .btn-action {
            background: #b0b0b0;
            border: 2px solid #000;
            padding: 12px 20px;
            border-radius: 15px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            color: black;
            margin-top: auto;
            display: inline-block;
        }
        
        .btn-action { background-color: var(--accent-pink); }

        /* List Items */
        .list-item {
            background-color: var(--card-purple);
            margin: 10px 0;
            padding: 12px;
            border-radius: 5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .status-pill {
            background: white;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 0.75rem;
            text-transform: uppercase;
        }
    </style>
</head>
<body>

    <%
        // Clean session retrieval to prevent NullPointerExceptions
        String userName = (session.getAttribute("userName") != null) ? (String)session.getAttribute("userName") : "Guest";
        String userRole = (session.getAttribute("userRole") != null) ? (String)session.getAttribute("userRole") : "Normal";
    %>

    <header class="navbar">
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/image/UiTM-Logo-removebg-preview.png" alt="UiTM Logo">
        </div>
        
        <nav class="nav-links">
            <a href="homepage.jsp" class="nav-item active"><i class="fas fa-home"></i> Home</a>
            <a href="eventList.jsp" class="nav-item"><i class="fas fa-calendar-alt"></i> Events</a>
            <a href="clubs.jsp" class="nav-item"><i class="fas fa-star"></i> Clubs</a>
            
            <%-- Only show User Management for Member --%>
            <% if ("Member".equals(userRole)) { %>
                <a href="addAdmin.jsp" class="nav-item"><i class="fas fa-user-plus"></i> Add User</a>
            <% } %>
        </nav>

        <div class="user-profile">
            <div><i class="fas fa-user-circle fa-2x"></i></div>
            <strong><%= userName %></strong><br>
            <small>(<%= userRole %>)</small><br>
            <a href="Logout.jsp" class="logout-link">LOGOUT</a>
        </div>
    </header>

    <main class="dashboard-container">
        
        <%-- SECTION 1: ROLE-SPECIFIC ACTIONS --%>
        <section class="card">
            <% if ("Advisor".equals(userRole)) { %>
                <h2 class="card-title">Advisor Tools</h2>
                <div class="club-info-box">
                    <i class="fas fa-clipboard-check fa-3x" style="margin-bottom: 10px;"></i>
                    <p>You have pending event applications to review.</p>
                </div>
                <a href="approveEvents.jsp" class="btn-action">REVIEW APPLICATIONS</a>
            <% } else if ("Member".equals(userRole)) { %>
                <h2 class="card-title">Member Tools</h2>
                <div class="club-info-box">
                    <i class="fas fa-calendar-plus fa-3x" style="margin-bottom: 10px;"></i>
                    <p>Organize a new club activity.</p>
                </div>
                <a href="createEvent.jsp" class="btn-action">UPLOAD NEW EVENT</a>
            <% } else { %>
                <h2 class="card-title">My Club Card</h2>
                <div class="club-info-box">
                    <div class="club-logo">
                        <img src="compass_logo.png" alt="Logo" style="width: 80%;">
                    </div>
                    <h3>COMPASS</h3>
                    <p>Student Member</p>
                </div>
                <button class="btn-view">VIEW PROFILE</button>
            <% } %>
        </section>

        <%-- SECTION 2: UPCOMING EVENTS (Shared) --%>
        <section class="card">
            <h2 class="card-title">Upcoming Events</h2>
            <div class="list-item">
                <span>HACKATHON INTERNATIONAL</span>
                <span>01/12</span>
            </div>
            <div class="list-item">
                <span>COMPASS FAMILY DAY</span>
                <span>02/12</span>
            </div>
            <div class="list-item">
                <span>FEST-BAF 2025</span>
                <span>08/12</span>
            </div>
            <a href="eventList.jsp" class="btn-view" style="margin-top:auto;">ALL EVENTS</a>
        </section>

        <%-- SECTION 3: STATUS (Shared/Contextual) --%>
        <section class="card">
            <h2 class="card-title">Event Status</h2>
            <div class="list-item">
                <span>TEAM BUILDING</span>
                <span class="status-pill">APPROVED</span>
            </div>
            <div class="list-item">
                <span>CPROM</span>
                <span class="status-pill">REJECTED</span>
            </div>
            <div class="list-item">
                <span>ANNUAL GATHERING</span>
                <span class="status-pill">PENDING</span>
            </div>
            <p style="font-size: 0.8rem; margin-top: 20px;">
                <% if ("Admin".equals(userRole)) { %>
                    <em>Advisors can change these statuses in the Approval page.</em>
                <% } else { %>
                    <em>Track your club's application progress here.</em>
                <% } %>
            </p>
        </section>

    </main>

</body>
</html>