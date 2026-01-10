<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin | Event Approvals</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <span class="navbar-brand">Club Admin Panel</span>
            <a href="dashboard.jsp" class="btn btn-outline-light btn-sm">Back to Dashboard</a>
        </div>
    </nav>

    <div class="container">
        <h2 class="fw-bold mb-4">Pending Event Requests</h2>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <table class="table table-hover mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Member Name</th>
                            <th>Event Name</th>
                            <th>Date</th>
                            <th>Venue</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Dr. Sarah Jenkins</td>
                            <td>Science Dept Mixer</td>
                            <td>Jan 25, 2026</td>
                            <td>Main Lounge</td>
                            <td>
                                <form action="EventApprovalServlet" method="POST" style="display:inline;">
                                    <input type="hidden" name="eventId" value="101">
                                    <button type="submit" name="action" value="approve" class="btn btn-success btn-sm">Approve</button>
                                    <button type="submit" name="action" value="reject" class="btn btn-danger btn-sm">Reject</button>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td>Prof. Robert Lee</td>
                            <td>Book Launch</td>
                            <td>Feb 02, 2026</td>
                            <td>Conference Hall B</td>
                            <td>
                                <form action="EventApprovalServlet" method="POST" style="display:inline;">
                                    <input type="hidden" name="eventId" value="102">
                                    <button type="submit" name="action" value="approve" class="btn btn-success btn-sm">Approve</button>
                                    <button type="submit" name="action" value="reject" class="btn btn-danger btn-sm">Reject</button>
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>