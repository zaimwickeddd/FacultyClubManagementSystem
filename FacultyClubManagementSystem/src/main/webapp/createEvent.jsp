<%-- 
    Document   : createEvent
    Author     : Muhamad Zulhairie
--%>

<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
    <title>Propose New Event | UiTM</title>
    <style>
        :root { 
            --bg-pink: #fbc2eb; 
            --card-purple: #e0b0ff; 
            --accent-pink: #ff99f1; 
        }
        
        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-pink); 
        }
        
        .form-container { 
            max-width: 800px; 
            margin: 40px auto; 
            background: white; 
            padding: 40px; 
            border-radius: 20px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
            border: 2px solid #000;
        }

        /* The Success Display - Matches Profile Update Style */
        .status-display {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 12px;
            border: 2px solid #28a745;
            margin-bottom: 25px;
            text-align: center;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .form-header { text-align: center; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-weight: bold; margin-bottom: 8px; text-transform: uppercase; font-size: 0.85rem; }
        
        input, textarea, select {
            width: 100%; padding: 12px; border: 2px solid #000; border-radius: 10px;
            background-color: #f9f9f9; font-size: 1rem; box-sizing: border-box;
        }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }

        .btn-submit {
            width: 100%; background: var(--accent-pink); color: black; padding: 15px;
            border: 2px solid #000; border-radius: 12px; font-size: 1.1rem;
            font-weight: bold; cursor: pointer; transition: 0.3s;
        }

        .btn-submit:hover { background-color: #ff66e0; transform: translateY(-2px); }

        .info-box {
            background-color: var(--card-purple); padding: 15px; border-radius: 10px;
            border: 1px solid #000; margin-bottom: 25px; font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="form-container">

    <%-- DISPLAY ON PAGE: Shows after submission --%>
    <c:if test="${param.success == 'true'}">
        <div class="status-display">
            <i class="fas fa-check-circle fa-lg"></i> 
            Event proposal has been successfully submitted to the Advisor!
        </div>
    </c:if>

    <div class="form-header">
        <h1>Propose a New Event</h1>
        <p>Your proposal will be reviewed by the club advisor.</p>
    </div>

    <div class="info-box">
        <i class="fas fa-user-edit"></i> 
        Proposing as: <strong>${sessionScope.userName} (${sessionScope.userRole})</strong>
    </div>

    <form action="${pageContext.request.contextPath}/eventController" method="POST">
        
        <div class="form-group">
            <label for="eventName">Event Title</label>
            <input type="text" id="eventName" name="eventName" placeholder="Enter event title..." required>
        </div>

        <div class="form-group">
            <label for="eventDescription">Event Description</label>
            <textarea id="eventDescription" name="eventDescription" placeholder="What is this event about?"></textarea>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Date</label>
                <input type="date" name="startDate" required>
            </div>
            <div class="form-group">
                <label>Time</label>
                <input type="time" name="startTime" required>
            </div>
        </div>

        <div class="form-group">
            <label>Venue</label>
            <input type="text" name="venue" required>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Max Participants</label>
                <input type="number" name="maxParticipants">
            </div>
            <div class="form-group">
                <label>Organizing Club ID</label>
                <input type="number" name="clubID" required>
            </div>
        </div>

        <button type="submit" class="btn-submit">SUBMIT PROPOSAL</button>
    </form>
</div>

</body>
<%@ include file="footer.jsp" %>