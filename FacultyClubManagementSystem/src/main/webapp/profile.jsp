<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile | FCMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body { 
            font-family: 'Inter', sans-serif; 
            background-color: #fbc2eb; 
            height: 100vh; /* Set to full viewport height */
            display: flex;
            flex-direction: column;
            overflow: hidden; /* Prevent scrolling on the main page */
        }

        .profile-container { 
            flex: 1;
            display: flex; 
            justify-content: center; 
            align-items: center; /* Center vertically */
            padding: 20px;
        }

        .profile-card {
            background: white; 
            width: 100%;
            max-width: 420px; 
            padding: 30px; 
            border-radius: 20px;
            border: 3px solid #000; 
            box-shadow: 10px 10px 0px #000; 
            text-align: center;
        }

        .user-avatar { font-size: 60px; color: #000; margin-bottom: 15px; }

        .info-row {
            text-align: left; 
            margin-bottom: 12px; 
            padding: 10px 15px;
            background: #f9f9f9; 
            border: 2px solid #000; 
            border-radius: 10px;
        }

        .label { font-weight: 700; font-size: 0.7rem; color: #555; text-transform: uppercase; letter-spacing: 0.5px; }
        .value { display: block; font-size: 1rem; color: #000; font-weight: 600; margin-top: 1px; }

        h2 { font-size: 1.5rem; margin-bottom: 20px; color: #000; }
    </style>
</head>
<body>
    <%@include file="header.jsp" %> 
    
    <div class="profile-container">
        <div class="profile-card">
            <div class="user-avatar"><i class="fas fa-user-circle"></i></div>
            
            <h2>
                <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "User" %>
            </h2>

            <div class="info-row">
                <span class="label">User Role</span>
                <span class="value"><%= session.getAttribute("userRole") %></span>
            </div>

            <div class="info-row">
                <span class="label">Email Address</span>
                <span class="value"><%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "Not Available" %></span>
            </div>

            <div class="info-row">
                <span class="label">Phone Number</span>
                <span class="value"><%= session.getAttribute("userPhone") != null ? session.getAttribute("userPhone") : "Not Set" %></span>
            </div>

            <%-- Role Check for Semester --%>
            <% 
                String role = (String)session.getAttribute("userRole");
                if ("Student".equals(role) || "Member".equals(role)) { 
            %>
                <div class="info-row">
                    <span class="label">Current Semester</span>
                    <span class="value">
                        <% 
                            Object sem = session.getAttribute("userSemester");
                            out.print((sem != null && !sem.toString().equals("0")) ? "Semester " + sem : "Not Assigned"); 
                        %>
                    </span>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>