<%-- 
    Document   : clubPage
    Created on : 16 Jan 2026, 3:21:27 pm
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Report - ${club.clubName}</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --bg-pink: #fbc2eb; /* Soft pink background */
            --card-purple: #e0b0ff; /* Light purple for list items */
            --header-gray: #e0e0e0;
            --accent-pink: #ff99f1;
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
            display: flex;
            align-items: center;
            gap: 8px;
            background: #fff;
            padding: 8px 20px;
            border-radius: 25px;
            border: 2px solid #000;
            text-decoration: none;
            color: #000;
            font-weight: 600;
        }
    </style>
</head>
<body>
    
    <%
        // Clean session retrieval to prevent NullPointerExceptions
        String userName = (session.getAttribute("userName") != null) ? (String)session.getAttribute("userName") : "";
        String userRole = (session.getAttribute("userRole") != null) ? (String)session.getAttribute("userRole") : " ";
    %>

   
    <h2 style="color:gray; margin-left:10%;">CREATE REPORT: ${club.facultyName}</h2>

    <div class="container">
        <div class="box">ATTENDANCE AND <br> ENGAGEMENT DATA</div>
        <div class="box">FINANCIAL <br> REVIEW</div>
        <div class="box tall">OVERALL RATINGS <br> AND FEEDBACKS</div>
        
        <div class="box">EVENT PROPOSAL <br> DETAILS</div>
        <div class="box">OFFICIAL SIGNATURE / <br> STAMP / E-SIGN</div>
        
        <div style="display:flex; flex-direction:column; justify-content:center;">
            <button class="btn-preview">PREVIEW</button>
            <button class="btn-print">PRINT</button>
        </div>
    </div>

</body>
</html>
<%@ include file="footer.jsp" %>
