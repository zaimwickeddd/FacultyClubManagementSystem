<%-- 
    Document   : createEvent
    Created on : 12 Jan 2026, 4:59:27?pm
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
            margin: 0; 
            padding: 20px; 
        }
        
        .form-container { 
            max-width: 800px; 
            margin: 0 auto; 
            background: white; 
            padding: 40px; 
            border-radius: 20px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #333;
            text-transform: uppercase;
            font-size: 0.85rem;
        }

        input[type="text"], 
        input[type="date"], 
        input[type="time"], 
        input[type="number"], 
        textarea, 
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #000;
            border-radius: 10px;
            background-color: #f9f9f9;
            font-size: 1rem;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .btn-submit {
            width: 100%;
            background: var(--accent-pink);
            color: black;
            padding: 15px;
            border: 2px solid #000;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background-color: #ff66e0;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .info-box {
            background-color: var(--card-purple);
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #000;
            margin-bottom: 25px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="form-container">
    <div class="form-header">
        <h1>Propose a New Event</h1>
        <p>Fill out the details below to submit your event idea for approval.</p>
    </div>

    <div class="info-box">
        <i class="fas fa-user-edit"></i> 
        Proposing as: <strong>${sessionScope.userName} (${sessionScope.userRole})</strong>
    </div>

    <form action="${pageContext.request.contextPath}/eventController" method="POST">
        
        <div class="form-group">
            <label for="eventName">Event Title</label>
            <input type="text" id="eventName" name="eventName" placeholder="e.g., Annual Tech Summit 2026" required>
        </div>

        <div class="form-group">
            <label for="eventDescription">Event Description</label>
            <textarea id="eventDescription" name="eventDescription" placeholder="Share the purpose and agenda of the event..."></textarea>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="eventDate">Date</label>
                <input type="date" id="eventDate" name="startDate" required>
            </div>
            <div class="form-group">
                <label for="eventTime">Time</label>
                <input type="time" id="eventTime" name="startTime" required>
            </div>
        </div>

        <div class="form-group">
            <label for="eventVenue">Venue</label>
            <input type="text" id="eventVenue" name="venue" placeholder="e.g., Dewan Agong, UiTM" required>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="maxParticipants">Max Participants</label>
                <input type="number" id="maxParticipants" name="maxParticipants" placeholder="e.g., 100">
            </div>
            <div class="form-group">
                <label for="clubID">Organizing Club ID</label>
                <input type="number" id="clubID" name="clubID" placeholder="Enter Club ID" required>
            </div>
        </div>

        <button type="submit" class="btn-submit">SUBMIT EVENT PROPOSAL</button>
    </form>
</div>

</body>
<%@ include file="footer.jsp" %>