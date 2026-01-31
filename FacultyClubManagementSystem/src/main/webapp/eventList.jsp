<%-- 
    Document modified : eventList
    Modified on : 31 Jan 2026, 11:45:00 pm
    Author     : Anderson Giggs
--%>

<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Events | UiTM</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { 
            --bg-pink: #fbc2eb; 
            --card-purple: #e0b0ff; 
            --accent-pink: #ff99f1; 
            --approve-green: #28a745; 
            --reject-red: #dc3545; 
        }
        
        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-pink); 
            margin: 0; 
            padding: 20px; 
        }
        
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            background: white; 
            padding: 40px; 
            border-radius: 20px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
        }
        
        h1 { 
            text-align: center; 
            color: #333; 
            margin-bottom: 10px;
            font-size: 2rem;
        }
        
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 1rem;
        }
        
        .event-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .event-card {
            background-color: var(--card-purple);
            padding: 25px;
            border-radius: 15px;
            border: 2px solid #000;
            transition: transform 0.2s;
        }
        
        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        
        .event-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }
        
        .event-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #000;
            margin: 0;
        }
        
        .status-badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.75rem;
            background: white;
            border: 1px solid #000;
            text-transform: uppercase;
        }
        
        .event-details {
            margin-top: 15px;
        }
        
        .event-detail-row {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            font-size: 0.95rem;
        }
        
        .event-detail-row i {
            width: 25px;
            color: #333;
        }
        
        .event-description {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 2px solid rgba(0,0,0,0.1);
            color: #444;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .btn-add {
            display: inline-block;
            background: var(--accent-pink);
            padding: 12px 25px;
            text-decoration: none;
            color: black;
            font-weight: bold;
            border-radius: 10px;
            border: 2px solid #000;
            margin-bottom: 20px;
            transition: background-color 0.3s;
        }
        
        .btn-add:hover {
            background-color: #ff66e0;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 20px;
        }
        
        .event-count {
            text-align: center;
            color: #666;
            margin-bottom: 20px;
            font-size: 0.95rem;
        }
    </style>
</head>
<body>

<div class="container">
    <%-- Only Members can create events --%>
    <c:if test="${sessionScope.userRole == 'Member'}">
        <a href="createEvent.jsp" class="btn-add">
            <i class="fas fa-plus"></i> Create New Event
        </a>
    </c:if>

    <h1>All Events</h1>
    <p class="subtitle">Browse all events organized by faculty clubs</p>
    
    <%-- Display event count --%>
    <c:if test="${not empty events}">
        <p class="event-count">
            <i class="fas fa-calendar-check"></i> 
            Showing ${events.size()} event(s)
        </p>
    </c:if>
    
    <%-- Error message display --%>
    <c:if test="${not empty errorMessage}">
        <div style="background: #dc3545; color: white; padding: 15px; border-radius: 10px; margin-bottom: 20px;">
            <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
        </div>
    </c:if>

    <%-- Event Grid Display --%>
    <c:choose>
        <c:when test="${not empty events}">
            <div class="event-grid">
                <c:forEach var="event" items="${events}">
                    <div class="event-card">
                        <div class="event-header">
                            <h3 class="event-title">${event.eventName}</h3>
                            <div class="status-badge">${event.eventStatus}</div>
                        </div>
                        
                        <div class="event-details">
                            <div class="event-detail-row">
                                <i class="fas fa-calendar"></i>
                                <span>${event.eventDate}</span>
                            </div>
                            
                            <div class="event-detail-row">
                                <i class="fas fa-clock"></i>
                                <span>${event.eventTime}</span>
                            </div>
                            
                            <div class="event-detail-row">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>${event.eventVenue}</span>
                            </div>
                            
                            <c:if test="${not empty event.maxParticipants}">
                                <div class="event-detail-row">
                                    <i class="fas fa-users"></i>
                                    <span>Max: ${event.maxParticipants} participants</span>
                                </div>
                            </c:if>
                            
                            <div class="event-detail-row">
                                <i class="fas fa-user-check"></i>
                                <span>Attendance: ${event.eventAttendance}</span>
                            </div>
                        </div>
                        
                        <c:if test="${not empty event.eventDescription}">
                            <div class="event-description">
                                <strong>Description:</strong><br>
                                ${event.eventDescription}
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-calendar-times"></i>
                <h2>No Events Found</h2>
                <p>There are currently no events in the system.</p>
                <c:if test="${sessionScope.userRole == 'Member'}">
                    <p>Be the first to create one!</p>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
