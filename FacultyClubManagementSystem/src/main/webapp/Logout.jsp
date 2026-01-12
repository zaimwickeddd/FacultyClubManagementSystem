<%-- 
    Document   : Logout
    Created on : 12 Jan 2026, 5:34:31 pm
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty Club | Logout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            /* Matches the light purple background from your screenshot */
            background-color: #eabcf5; 
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: sans-serif;
        }

        .logout-container {
            background: white;
            padding: 40px;
            width: 100%;
            max-width: 600px;
            /* The purple border from your screenshot */
            border: 2px solid #9c42f5; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            text-align: center;
        }

        .logo-img {
            max-width: 200px;
            height: auto;
            margin-bottom: 15px;
        }

        .system-title {
            font-weight: bold;
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: #333;
        }

        .confirmation-box {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 30px;
            background-color: #fff;
            max-width: 350px;
            margin: 0 auto; /* Centers the inner box */
        }

        .confirmation-text {
            margin-bottom: 20px;
            font-weight: 500;
        }

        .btn-custom-back {
            background-color: #2c2c2c;
            color: white;
            border: none;
            padding: 8px 25px;
        }
        
        .btn-custom-back:hover {
            background-color: #000;
            color: white;
        }

        .btn-custom-logout {
            background-color: #ff0019; /* Bright red */
            color: white;
            border: none;
            padding: 8px 25px;
        }
        
        .btn-custom-logout:hover {
            background-color: #d60015;
            color: white;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="logout-container">
        
        <div class="text-center">
            <img src="images/uitm_logo.png" alt="UiTM Logo" class="logo-img">
        </div>
        
        <div class="system-title">
            UiTM Club Management System
        </div>

        <div class="confirmation-box shadow-sm">
            <p class="confirmation-text">You sure want to log out?</p>
            
            <div class="d-flex justify-content-center gap-3">
                <button onclick="history.back()" class="btn btn-custom-back rounded-3">Back</button>
                
                <form action="LogoutServlet" method="POST" style="margin:0;">
                    <button type="submit" class="btn btn-custom-logout rounded-3">Log Out</button>
                </form>
            </div>
        </div>

    </div>
</div>

</body>
</html>
