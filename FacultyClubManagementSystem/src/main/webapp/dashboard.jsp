<%-- 
    Document   : dashboard
    Created on : 2 Jan 2026, 3:37:35 pm
    Author     : VICTUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty Dashboard | Member Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --sidebar-width: 250px;
        }
        body {
            background-color: #f8f9fa;
        }
        /* Sidebar Styling */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            background: #212529;
            color: white;
            padding-top: 20px;
        }
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
        }
        .nav-link {
            color: #adb5bd;
            padding: 15px 20px;
        }
        .nav-link:hover, .nav-link.active {
            color: white;
            background: rgba(255,255,255,0.1);
        }
        .stat-card {
            border: none;
            border-radius: 10px;
            transition: 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="px-4 mb-4">
            <h4 class="fw-bold text-white">Faculty Club</h4>
            <small class="text-muted">Member Portal</small>
        </div>
        <nav class="nav flex-column">
            <a class="nav-link active" href="#">🏠 Dashboard</a>
            <a class="nav-link" href="#">📅 My Bookings</a>
            <a class="nav-link" href="#">💳 Payments</a>
            <a class="nav-link" href="#">👤 Profile Settings</a>
            <hr class="mx-3 border-secondary">
            <a class="nav-link text-danger" href="homepage.jsp">🚪 Logout</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold">Welcome back, Prof. Anderson</h2>
                <p class="text-muted">Here is what's happening at the club today.</p>
            </div>
            <span class="badge bg-success p-2 px-3">Active Member</span>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3">
                    <div class="card-body">
                        <h6 class="text-muted">Current Balance</h6>
                        <h3 class="fw-bold text-primary">$50.00</h3>
                        <small class="text-success">Due in 15 days</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3">
                    <div class="card-body">
                        <h6 class="text-muted">Upcoming Bookings</h6>
                        <h3 class="fw-bold text-dark">2</h3>
                        <small><a href="#" class="text-decoration-none text-primary">View details</a></small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3">
                    <div class="card-body">
                        <h6 class="text-muted">Recent Notifications</h6>
                        <h3 class="fw-bold text-warning">5</h3>
                        <small>Unread alerts</small>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold">My Recent Bookings</h5>
                    </div>
                    <div class="card-body p-0">
                        <table class="table mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-4">Facility</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="ps-4">Main Dining Hall</td>
                                    <td>Oct 15, 2026</td>
                                    <td><span class="badge bg-info">Pending</span></td>
                                    <td><button class="btn btn-sm btn-outline-danger">Cancel</button></td>
                                </tr>
                                <tr>
                                    <td class="ps-4">Tennis Court A</td>
                                    <td>Oct 12, 2026</td>
                                    <td><span class="badge bg-success">Confirmed</span></td>
                                    <td><button class="btn btn-sm btn-outline-secondary">Details</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-3 bg-primary text-white p-4">
                    <h5 class="fw-bold mb-3">Club Membership Card</h5>
                    <div class="mb-4">
                        <small class="d-block opacity-75">Member Name</small>
                        <span class="fs-5">Dr. James Anderson</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <div>
                            <small class="d-block opacity-75">ID Number</small>
                            <span>#FC-99281</span>
                        </div>
                        <div>
                            <small class="d-block opacity-75">Expires</small>
                            <span>Dec 2026</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>