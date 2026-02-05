<%-- 
    Document   : advisorListApproval
    Created on : 6 Feb 2026, 1:22:58?am
    Author     : Muhamad Zulhairie
--%>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <style>
        .approval-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 20px;
        }
        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }
        .table th {
            border: none;
            color: #666;
            font-weight: 600;
            padding: 10px 20px;
        }
        .table tr {
            background-color: #f8f9fa;
            transition: transform 0.2s;
        }
        .table tr:hover {
            transform: scale(1.01);
            background-color: #f1f1f1;
        }
        .table td {
            padding: 15px 20px;
            border: none;
        }
        /* Status Badges */
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: bold;
            display: inline-block;
        }
        .bg-pending { background-color: #fff3cd; color: #856404; }
        .bg-approved { background-color: #d4edda; color: #155724; }
        .bg-rejected { background-color: #f8d7da; color: #721c24; }
        
        .btn-action {
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: 0.3s;
        }
        .btn-approve { background: #28a745; color: white; margin-right: 5px; }
        .btn-reject { background: #dc3545; color: white; }
        .btn-action:hover { opacity: 0.8; }
    </style>
</head>
<body>
    <div class="container">
        <div class="approval-card">
            <h2 style="margin-bottom: 25px; color: #333;">Event Application Approvals</h2>
            
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Event Name</th>
                        <th>Category</th>
                        <th>Budget</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${applicationList}">
                        <tr>
                            <td><strong>#${app.ceAppID}</strong></td>
                            <td>${app.eventName}</td>
                            <td>${app.eventCategory}</td>
                            <td>RM ${app.eventBudget}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${app.ceAppStatus == 'Pending'}">
                                        <span class="badge bg-pending">Pending Approval</span>
                                    </c:when>
                                    <c:when test="${app.ceAppStatus == 'Approved'}">
                                        <span class="badge bg-approved">Approved</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-rejected">Rejected</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${app.ceAppStatus == 'Pending'}">
                                    <form action="approvalController" method="POST" style="margin:0;">
                                        <input type="hidden" name="appID" value="${app.ceAppID}">
                                        <button type="submit" name="action" value="Approved" class="btn-action btn-approve">Approve</button>
                                        <button type="submit" name="action" value="Rejected" class="btn-action btn-reject">Reject</button>
                                    </form>
                                </c:if>
                                <c:if test="${app.ceAppStatus != 'Pending'}">
                                    <span style="color: #999; font-style: italic;">Processed</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>