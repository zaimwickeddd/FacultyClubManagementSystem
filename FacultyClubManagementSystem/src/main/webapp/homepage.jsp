<%-- 
    Document   : homepage
    Created on : 11 Jan 2026, 1:33:40?am
    Author     : Muhamad Zulhairie
--%>

<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
        /* Container for the event row */
        .list-item {
            background-color: #D1B3FF; /* Your requested purple */
            border-radius: 8px;
            padding: 10px 15px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 45px; /* Keeps all boxes identical height */
            cursor: help; /* Changes cursor to indicate more info is available */
            transition: background-color 0.3s ease;
        }

        .list-item:hover {
            background-color: var(--card-purple); /* Darkens slightly on hover for feedback */
        }

        /* The Event Name styling */
        .event-name {
            white-space: nowrap;      /* Keeps text on one line */
            overflow: hidden;         /* Hides the 'International' part if too long */
            text-overflow: ellipsis;  /* Adds the '...' */
            flex: 1;                  /* Takes up available space */
            margin-right: 15px;
            font-weight: 500;
            text-transform: uppercase;
        }

        /* The Date styling */
        .event-date {
            white-space: nowrap;
            font-weight: bold;
            font-size: 0.9em;
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
        String userName = (session.getAttribute("userName") != null) ? (String)session.getAttribute("userName") : "";
        String userRole = (session.getAttribute("userRole") != null) ? (String)session.getAttribute("userRole") : " ";
    %>

    

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
        <div class="card">
            <h2 class="card-title">Upcoming Events</h2>
            <c:forEach var="event" items="${upcomingEvents}">
                <div class="list-item">
                    <span class="event-name" title="${event.eventName}">${event.eventName}</span>
                    <span class="event-date">${event.eventDate}</span>
                </div>
            </c:forEach>
            <a href="eventList.jsp" class="btn-view" style="margin-top:auto;">ALL EVENTS</a>
        </div>

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
<%@ include file="footer.jsp" %>
