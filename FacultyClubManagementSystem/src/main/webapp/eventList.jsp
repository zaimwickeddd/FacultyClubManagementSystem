<%-- 
    Document   : eventList
    Created on : 12 Jan 2026, 5:12:24 pm
    Author     : Muhamad Zulhairie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Managed Events | UiTM</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --bg-pink: #fbc2eb; --card-purple: #e0b0ff; --accent-pink: #ff99f1; --approve-green: #28a745; --reject-red: #dc3545; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-pink); margin: 0; padding: 20px; }
        
        .container { max-width: 900px; margin: 0 auto; background: white; padding: 30px; border-radius: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h1 { text-align: center; color: #333; margin-bottom: 30px; }
        
        .event-item {
            background-color: var(--card-purple);
            margin: 15px 0;
            padding: 20px;
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid #000;
        }
        
        .event-info h3 { margin: 0; font-size: 1.2rem; }
        .event-info p { margin: 5px 0 0; font-size: 0.9rem; color: #444; }
        
        .action-area { display: flex; flex-direction: column; align-items: flex-end; gap: 10px; }

        .status-badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.8rem;
            background: white;
            border: 1px solid #000;
            text-transform: uppercase;
        }
        
        .btn-add {
            display: inline-block;
            background: var(--accent-pink);
            padding: 10px 20px;
            text-decoration: none;
            color: black;
            font-weight: bold;
            border-radius: 10px;
            border: 2px solid #000;
            margin-bottom: 20px;
        }

        .btn-action {
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 5px;
            color: white;
            font-size: 0.8rem;
            font-weight: bold;
        }
        .btn-approve { background-color: var(--approve-green); }
        .btn-reject { background-color: var(--reject-red); }
    </style>
</head>
<body>

<div class="container">
    <%-- 1. ROLE LOGIC: Only Members see the 'Propose' button --%>
    <c:if test="${sessionScope.userRole == 'Member'}">
        <a href="createEvent.jsp" class="btn-add"><i class="fas fa-plus"></i> Propose New Event</a>
    </c:if>

    <h1>Events Handled</h1>

    <c:forEach var="event" items="${events}">
        <%-- 
            2. FILTER LOGIC: 
            - Advisors and Members see EVERYTHING.
            - Students see ONLY 'Approved' events.
        --%>
        <c:if test="${sessionScope.userRole != 'Student' || event.status == 'Approved'}">
            
            <div class="event-item">
                <div class="event-info">
                    <h3>${event.title}</h3>
                    <p><i class="fas fa-calendar"></i> ${event.date} | <i class="fas fa-map-marker-alt"></i> ${event.venue}</p>
                </div>
                
                <div class="action-area">
                    <div class="status-badge">
                        ${event.status}
                    </div>

                    <%-- 3. ADVISOR LOGIC: Only Advisors see Approve/Reject buttons --%>
                    <c:if test="${sessionScope.userRole == 'Advisor'}">
                        <div class="advisor-controls">
                            <a href="UpdateEventStatus?id=${event.id}&action=approve" class="btn-action btn-approve">Approve</a>
                            <a href="UpdateEventStatus?id=${event.id}&action=reject" class="btn-action btn-reject">Reject</a>
                        </div>
                    </c:if>
                </div>
            </div>

        </c:if>
    </c:forEach>
    
    <c:if test="${empty events}">
        <p style="text-align:center;">No events available at this time.</p>
    </c:if>
</div>

</body>
</html>