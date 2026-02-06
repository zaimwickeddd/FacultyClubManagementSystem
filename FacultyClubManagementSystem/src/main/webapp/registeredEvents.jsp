<%-- 
    Document   : registeredEvents
    Created on : 6 Feb 2026, 9:49:02 am
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Registered Events | UiTM</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body {
            background-color: #fbc2eb; /* Match header background */
            font-family: 'Inter', sans-serif;
        }
        .main-container {
            margin-top: 30px;
            margin-bottom: 30px;
        }
        .page-header {
            background: white;
            padding: 30px;
            border-radius: 20px;
            border: 2px solid #000;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .event-card {
            border: 2px solid #000;
            border-radius: 15px;
            background-color: white;
            transition: transform 0.2s, box-shadow 0.2s;
            height: 100%;
        }
        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }
        .card-header {
            background-color: #e0b0ff; /* Match card color */
            border-bottom: 2px solid #000;
            border-radius: 13px 13px 0 0 !important;
            font-weight: bold;
        }
        .detail-item {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }
        .detail-item i {
            width: 25px;
            color: #666;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 20px;
            border: 2px solid #000;
        }
    </style>
</head>
<body>
<div class="container main-container">
    
    <div class="page-header">
        <h1 class="display-5 fw-bold text-dark">
            <i class="fas fa-bookmark text-primary"></i> My Registered Events
        </h1>
        <p class="lead text-muted">Events you have signed up for</p>
    </div>

    <c:choose>
        <c:when test="${not empty registeredEvents}">
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:forEach var="event" items="${registeredEvents}">
                    <div class="col">
                        <div class="card event-card h-100">
                            <div class="card-header text-dark">
                                ${event.eventName}
                            </div>
                            <div class="card-body">
                                <div class="detail-item">
                                    <i class="fas fa-calendar-alt"></i>
                                    <span><strong>Date:</strong> ${event.eventDate}</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span><strong>Venue:</strong> ${event.eventVenue}</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-info-circle"></i>
                                    <span><strong>Status:</strong> 
                                        <span class="badge bg-warning text-dark">Registered</span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-calendar-times fa-4x text-muted mb-3"></i>
                <h2>No Registrations Found</h2>
                <p class="text-muted">You haven't registered for any events yet.</p>
                <a href="eventListController" class="btn btn-dark mt-3">Browse Events</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
<%@ include file="footer.jsp" %>