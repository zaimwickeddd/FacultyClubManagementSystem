<%-- 
    Document   : approveEvents
    Created on : 29 Jan 2026, 3:22:50?pm
    Author     : VICTUS
--%>

<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.facultyclubmanagementsystem.model.User" %>
<%
    // Security Check: Only Advisor or Member can view this
    String currentRole = (String) session.getAttribute("userRole");
    if (currentRole == null || (!currentRole.equals("Advisor") && !currentRole.equals("Member"))) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>FCMS | Approve Events</title>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #fbc2eb; margin: 0; }
        .container { padding: 40px; display: flex; flex-direction: column; align-items: center; }
        
        .table-card {
            background: white;
            padding: 30px;
            border-radius: 20px;
            border: 3px solid #000; /* Bold border */
            box-shadow: 10px 10px 0px rgba(0,0,0,1);
            width: 90%;
            max-width: 1000px;
        }

        h2 { text-transform: uppercase; font-weight: 900; margin-bottom: 25px; }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #ff99f1; padding: 15px; border: 2px solid #000; text-align: left; }
        td { padding: 15px; border: 2px solid #000; background: #fff; }

        .btn-approve {
            background: #90ee90;
            border: 2px solid #000;
            padding: 8px 15px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
        }

        .btn-reject {
            background: #ff6b6b;
            border: 2px solid #000;
            padding: 8px 15px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
            color: white;
        }

        .btn-approve:hover, .btn-reject:hover { transform: translate(-2px, -2px); box-shadow: 3px 3px 0px #000; }
    </style>
</head>
<body>
    <div class="container">
        <div class="table-card">
            <h2>Pending Event Approvals</h2>
            <table>
                <thead>
                    <tr>
                        <th>Event Name</th>
                        <th>Organizer</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Annual Club Dinner</td>
                        <td>Computer Science Club</td>
                        <td>2024-05-20</td>
                        <td><strong>PENDING</strong></td>
                        <td>
                            <button class="btn-approve">Approve</button>
                            <button class="btn-reject">Reject</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
<%@ include file="footer.jsp" %>