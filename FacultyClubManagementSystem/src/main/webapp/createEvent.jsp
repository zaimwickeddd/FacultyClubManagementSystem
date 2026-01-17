<%-- 
    Document   : createEvent
    Created on : 12 Jan 2026, 4:59:27 pm
    Author     : Muhamad Zulhairie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Event | Faculty Club</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <% 
   // This will print the actual value saved in your session to the console
   System.out.println("Session Role: " + session.getAttribute("userRole")); 
    %>
    <style>
        :root {
            --bg-pink: #fbc2eb;
            --header-gray: #e0e0e0;
            --accent-pink: #ff99f1;
            --form-bg: #ffffff;
            --input-gray: #d9d9d9;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-pink);
        }

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
            display: flex; align-items: center; gap: 8px;
            background: #fff; padding: 8px 20px; border-radius: 25px;
            border: 2px solid #000; text-decoration: none; color: #000; font-weight: 600;
        }
        .nav-item.active { background-color: var(--accent-pink); }

        .main-container {
            display: flex;
            justify-content: center;
            padding: 40px 20px;
        }

        .form-card {
            background: var(--form-bg);
            width: 90%;
            max-width: 1000px;
            border-radius: 30px;
            border: 1px solid #000;
            padding: 30px;
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 30px;
            position: relative;
        }

        .left-column { display: flex; flex-direction: column; gap: 15px; }
        .right-column { display: flex; flex-direction: column; gap: 20px; }

        .input-group { display: flex; align-items: center; gap: 10px; font-weight: 700; }
        .input-line {
            border: none;
            border-bottom: 2px solid #000;
            width: 100%;
            font-family: inherit;
            font-size: 1rem;
            outline: none;
            background: transparent;
        }

        .image-upload-box {
            background: var(--input-gray);
            border: 2px solid #000;
            border-radius: 20px;
            height: 250px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            cursor: pointer;
        }

        .description-box {
            background: var(--input-gray);
            border: 2px solid #000;
            border-radius: 20px;
            height: 300px;
            padding: 20px;
            width: 100%;
            box-sizing: border-box;
            resize: none;
            font-family: inherit;
        }

        .submit-btn {
            background: var(--accent-pink);
            border: 2px solid #000;
            padding: 20px;
            font-weight: 800;
            font-size: 1.1rem;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.2s;
            align-self: flex-end;
            width: 180px;
            text-align: center;
        }

        .submit-btn:hover { transform: scale(1.05); }
    </style>
</head>
<body>

    <%
        // Security Check: Only 'Member' (Members) should typically propose events
        String userRole = (String) session.getAttribute("userRole");
        String userName = (String) session.getAttribute("userName");
        if (userRole == null || !userRole.equals("Member")) {
            response.sendRedirect("homepage.jsp?error=unauthorized");
            return;
        }
    %>
    

    <header class="navbar">
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/image/UiTM-Logo-removebg-preview.png" alt="UiTM Logo">
        </div>
        <nav class="nav-links">
            <a href="homepage.jsp" class="nav-item"><i class="fas fa-home"></i> Home</a>
            <a href="createEvent.jsp" class="nav-item active"><i class="fas fa-calendar-plus"></i> Events</a>
            <a href="clubs.jsp" class="nav-item"><i class="fas fa-star"></i> Clubs</a>
        </nav>
        <div class="user-profile">
            <strong><%= userName %></strong><br>
            <small>(<%= userRole %>)</small><br>
            <a href="Logout.jsp" style="color:red; font-size:12px; font-weight:bold; text-decoration:none;">LOGOUT</a>
        </div>
    </header>

    <div class="main-container">
        <%-- Note: Using SubmitEventServlet to handle the DB logic we discussed --%>
        <form action="SubmitEventServlet" method="POST" enctype="multipart/form-data" class="form-card">
            
            <div class="left-column">
                <div class="input-group">
                    <span>EVENT TITLE :</span>
                    <input type="text" name="eventTitle" class="input-line" required>
                </div>

                <div class="image-upload-box" onclick="document.getElementById('fileInput').click();">
                    <i class="fas fa-image fa-3x"></i>
                    <p><strong>EVENT IMAGE</strong><br>MAX SIZE : 10 MB</p>
                    <input type="file" id="fileInput" name="eventImage" style="display:none;">
                </div>

                <div class="details-section" style="font-size: 0.9rem; line-height: 1.8;">
                    <p><strong>Requested by:</strong> <span style="color: #007bff;"><%= userName %> (YOU)</span></p>
                    
                    <div class="input-group">
                        Date: <input type="date" name="eventDate" class="input-line" style="width:150px;" required>
                    </div>

                    <div class="input-group" style="margin-top:10px;">
                        Time: <input type="time" name="startTime" class="input-line" style="width:100px;"> 
                        - <input type="time" name="endTime" class="input-line" style="width:100px;">
                    </div>

                    <div class="input-group" style="margin-top:10px;">
                        Venue: <input type="text" name="venue" class="input-line" required>
                    </div>

                    <p style="margin-top:10px;">
                        <strong>Category:</strong>
                        <select name="category" class="input-line">
                            <option value="Faculty">Faculty</option>
                            <option value="Open">Open</option>
                            <option value="Regional">Regional</option>
                            <option value="National">National</option>
                            <option value="International">International</option>
                        </select>
                    </p>

                    <div class="input-group">
                        Estimated Budget: RM <input type="number" step="0.01" name="budget" class="input-line" style="width:100px;">
                    </div>
                </div>
            </div>

            <div class="right-column">
                <textarea name="description" class="description-box" placeholder="FILL IN THE PROPOSED EVENT DESCRIPTION&#10;MAX 200 WORDS" required></textarea>
                
                <button type="submit" class="submit-btn">
                    CONFIRM<br>PROPOSED<br>EVENT
                </button>
            </div>

        </form>
    </div>

    <script>
        // Simple script to show filename when selected
        document.getElementById('fileInput').onchange = function() {
            if(this.files[0]) alert("File selected: " + this.files[0].name);
        };
    </script>
</body>
</html>