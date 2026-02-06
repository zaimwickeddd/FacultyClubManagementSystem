<%-- 
    Document modified : eventList
    Modified on : 31 Jan 2026, 11:45:00 pm
    Author     : Anderson Giggs
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>

<head>
    <title>All Events | UiTM</title>
    <style>
        :root { 
            --bg-pink: #fbc2eb; 
            --card-purple: #e0b0ff; 
            --accent-pink: #ff99f1; 
            --approve-green: #28a745; 
            --reject-red: #dc3545; 
            --disabled-gray: #6c757d; /* ADDED */
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
            
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 350px;
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

        /* ADDED FOR REGISTRATION BUTTONS */
        .btn-register {
            padding: 10px 20px;
            border: 2px solid #000;
            border-radius: 10px;
            font-weight: bold;
            width: 100%;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.3s;
        }

        .btn-register-active {
            background-color: var(--accent-pink);
            color: black;
        }

        .btn-register-active:hover {
            background-color: #ff66e0;
        }

        .btn-register-disabled {
            background-color: var(--disabled-gray);
            color: white;
            cursor: not-allowed;
            opacity: 0.7;
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

                        <%-- FILL THIS PART WITH EVENT DETAILS --%>
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

                        <%-- MODIFIED ACTION BUTTONS FOR STUDENTS --%>
                        <c:if test="${sessionScope.userRole == 'Student'}">
                            <div class="event-actions" style="margin-top: 15px; text-align: center;">
                                
                                <%-- CHECK IF ALREADY REGISTERED USING REGISTEREDEVENTIDS LIST --%>
                                <c:choose>
                                    <c:when test="${registeredEventIds.contains(event.eventId)}">
                                        <%-- Disabled Button --%>
                                        <button class="btn-register btn-register-disabled" disabled>
                                            <i class="fas fa-check"></i> Already Registered
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- Active Register Form --%>
                                        <form action="RegisterEventServlet" method="POST">
                                            <input type="hidden" name="eventId" value="${event.eventId}">
                                            <button type="submit" class="btn-register btn-register-active">
                                                Register for Event
                                            </button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
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
    
    <%-- SECTION: Approved and Rejected (Only Members and Advisors) --%>
    <%-- Updated Structure for Side-by-Side View --%>
    <c:if test="${sessionScope.userRole == 'Member' || sessionScope.userRole == 'Advisor'}">
        <hr style="margin: 50px 0;">

        <div class="row">
            <div class="col-md-6">
                <h2 style="color: var(--approve-green);"><i class="fas fa-check-circle"></i> Approved Events</h2>
                <c:choose>
                    <c:when test="${not empty approvedEvents}">
                        <div class="event-grid">
                            <c:forEach var="event" items="${approvedEvents}">
                                <div class="event-card" style="border-left: 10px solid var(--approve-green);">
                                    <div class="event-header">
                                        <h3 class="event-title">${event.eventName}</h3>
                                        <div class="status-badge" style="border-color: var(--approve-green); color: var(--approve-green);">
                                            ${event.eventStatus}
                                        </div>
                                    </div>
                                    <div class="event-details">
                                        <div class="event-detail-row"><i class="fas fa-calendar"></i> <span>${event.eventDate}</span></div>
                                        <div class="event-detail-row"><i class="fas fa-map-marker-alt"></i> <span>${event.eventVenue}</span></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise><p class="subtitle">No approved events yet.</p></c:otherwise>
                </c:choose>
            </div>

            <div class="col-md-6">
                <h2 style="color: var(--reject-red);"><i class="fas fa-times-circle"></i> Rejected Events</h2>
                <c:choose>
                    <c:when test="${not empty rejectedEvents}">
                        <div class="event-grid">
                            <c:forEach var="event" items="${rejectedEvents}">
                                <div class="event-card" style="border-left: 10px solid var(--reject-red); opacity: 0.8;">
                                    <div class="event-header">
                                        <h3 class="event-title">${event.eventName}</h3>
                                        <div class="status-badge" style="border-color: var(--reject-red); color: var(--reject-red);">
                                            ${event.eventStatus}
                                        </div>
                                    </div>
                                    <div class="event-details">
                                        <div class="event-detail-row"><i class="fas fa-calendar"></i> <span>${event.eventDate}</span></div>
                                        <div class="event-detail-row"><i class="fas fa-ban"></i> <span>This event was rejected</span></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise><p class="subtitle">No rejected events recorded.</p></c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:if>
    
</div> <%-- End of Container --%>
</div>

</body>
</html>
<%@ include file="footer.jsp" %>