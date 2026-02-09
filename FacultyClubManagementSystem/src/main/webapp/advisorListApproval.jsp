<%-- 
    Document   : advisorListApproval
    Author     : Muhamad Zulhairie
--%>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Event Approvals | FCMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .approval-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 30px;
            margin: 20px auto;
            max-width: 1000px;
        }
        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }
        .table th {
            color: #666;
            font-weight: 600;
            padding: 10px 20px;
            text-align: left;
        }
        .table tr {
            background-color: #f8f9fa;
            transition: transform 0.2s;
        }
        .table tr:hover {
            transform: scale(1.005);
            background-color: #f1f1f1;
        }
        .table td { padding: 15px 20px; border: none; }
        
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
            font-weight: 600;
            transition: 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }
        .btn-approve { background: #28a745; color: white; margin-right: 5px; }
        .btn-reject { background: #dc3545; color: white; }
        
        /* Delete Button Style */
        .btn-delete { 
            background: #fff; 
            color: #dc3545; 
            border: 2px solid #dc3545; 
        }
        .btn-delete:hover { 
            background: #dc3545; 
            color: white; 
        }

        .success-alert {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 5px solid #28a745;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="approval-card">
            <h2 style="margin-bottom: 25px; color: #333;">Event Application Approvals</h2>

            <%-- Alert for successful deletion --%>
            <c:if test="${param.deleteSuccess == 'true'}">
                <div class="success-alert">
                    <i class="fas fa-trash-alt"></i> Rejected application deleted successfully.
                </div>
            </c:if>
            
            <table class="table">
                <thead>
                    <tr>
                        <th>#</th> <%-- Changed from ID to a simple sequence header --%>
                        <th>Event Name</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Added varStatus="loop" to generate 1, 2, 3 sequence --%>
                    <c:forEach var="app" items="${applicationList}" varStatus="loop">
                        <tr>
                            <%-- Displays the sequence number based on loop index --%>
                            <td><strong>#${loop.count}</strong></td>
                            
                            <td>${app.eventName}</td>
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
                                <c:choose>
                                    <%-- If Pending: Show Approve/Reject --%>
                                    <c:when test="${app.ceAppStatus == 'Pending'}">
                                        <form action="approvalController" method="POST" style="margin:0;">
                                            <%-- Real database ID is hidden here for processing --%>
                                            <input type="hidden" name="appID" value="${app.ceAppID}">
                                            <button type="submit" name="action" value="Approved" class="btn-action btn-approve">
                                                <i class="fas fa-check"></i> Approve
                                            </button>
                                            <button type="submit" name="action" value="Rejected" class="btn-action btn-reject">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </form>
                                    </c:when>

                                    <%-- If Rejected: Show Delete --%>
                                    <c:when test="${app.ceAppStatus == 'Rejected'}">
                                        <form action="DeleteApplicationServlet" method="POST" style="margin:0;" 
                                              onsubmit="return confirm('Permanently delete this application?');">
                                            <input type="hidden" name="eventId" value="${app.ceAppID}">
                                            <button type="submit" class="btn-action btn-delete">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </button>
                                        </form>
                                    </c:when>

                                    <%-- If Approved: Show Processed --%>
                                    <c:otherwise>
                                        <span style="color: #999; font-style: italic;">Processed</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <%-- Show message if list is empty --%>
                    <c:if test="${empty applicationList}">
                        <tr>
                            <td colspan="4" style="text-align: center; color: #999; padding: 30px;">
                                No event applications found.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
<%@ include file="footer.jsp" %>