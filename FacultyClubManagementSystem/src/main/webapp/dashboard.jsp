<%-- 
    Document   : dashboard
    Created on : 2 Jan 2026, 3:37:35 pm
    Author     : VICTUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Faculty Club - Dashboard</title>
        <style>
            body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 20px; }
            .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
            h1 { color: #2c3e50; }
            .status { color: green; font-weight: bold; }
        </style>
    </head>
    <body>  
        <div class="card">
            <h1>Faculty Club Management System</h1>
            <p>Welcome, <strong>Admin</strong>!</p>
            <hr>
            <h3>Quick Actions:</h3>
            <ul>
                <li>View Member List</li>
                <li>Book Faculty Lounge</li>
                <li>Club Event Calendar</li>
            </ul>
            <p>System Status: <span class="status">Online</span></p>
        </div>
    </body>
</html>