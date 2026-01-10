<%-- 
    Document   : homepage
    Created on : 11 Jan 2026, 1:33:40 am
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Club Management System</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        /* Custom Styles */
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), 
                        url('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1500&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 120px 0;
        }
        .stat-bar {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        .card {
            transition: transform 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        footer {
            background-color: #212529;
            color: #ccc;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="homepage.jsp">FACULTY CLUB</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="homepage.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Facilities</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Events</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Gallery</a></li>
                    <li class="nav-item"><a class="btn btn-primary ms-lg-3" href="login.jsp">Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero-section text-center">
        <div class="container">
            <h1 class="display-3 fw-bold">Academic Excellence & Leisure</h1>
            <p class="lead mb-4">The premier hub for university faculty members to connect, dine, and collaborate.</p>
            <a href="#explore" class="btn btn-primary btn-lg px-5">Explore Club</a>
        </div>
    </header>

    <div class="stat-bar py-4">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-4">
                    <h3 class="fw-bold mb-0">850+</h3>
                    <small class="text-muted text-uppercase">Active Members</small>
                </div>
                <div class="col-md-4 border-start border-end">
                    <h3 class="fw-bold mb-0">12</h3>
                    <small class="text-muted text-uppercase">Premium Venues</small>
                </div>
                <div class="col-md-4">
                    <h3 class="fw-bold mb-0">24/7</h3>
                    <small class="text-muted text-uppercase">Member Support</small>
                </div>
            </div>
        </div>
    </div>

    <section id="explore" class="container my-5 py-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Club Services</h2>
            <div class="mx-auto bg-primary" style="height: 3px; width: 60px;"></div>
        </div>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body p-4 text-center">
                        <div class="fs-1 text-primary mb-3">📅</div>
                        <h4 class="card-title">Facility Booking</h4>
                        <p class="card-text text-muted">Reserve VIP lounges, conference halls, or dining tables for your events.</p>
                        <a href="#" class="btn btn-outline-primary stretched-link">Book Now</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body p-4 text-center">
                        <div class="fs-1 text-success mb-3">💳</div>
                        <h4 class="card-title">Membership</h4>
                        <p class="card-text text-muted">Manage your profile, check your subscription status, and pay dues online.</p>
                        <a href="#" class="btn btn-outline-success stretched-link">Manage Account</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body p-4 text-center">
                        <div class="fs-1 text-warning mb-3">🔔</div>
                        <h4 class="card-title">Notices</h4>
                        <p class="card-text text-muted">Stay updated with the latest faculty news, meeting minutes, and alerts.</p>
                        <a href="#" class="btn btn-outline-warning stretched-link">View Notices</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="bg-light py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <h3 class="fw-bold mb-4">Latest Announcements</h3>
                    <div class="bg-white p-4 rounded shadow-sm mb-3">
                        <span class="badge bg-primary mb-2">General</span>
                        <h5>New Faculty Lounge Wing Opening</h5>
                        <p class="text-muted mb-2">We are excited to announce that the West Wing expansion is now complete, offering 20 new quiet workspaces...</p>
                        <small class="text-secondary">Jan 11, 2026</small>
                    </div>
                    <div class="bg-white p-4 rounded shadow-sm">
                        <span class="badge bg-success mb-2">Menu</span>
                        <h5>Organic Sunday Brunch Starts This Weekend</h5>
                        <p class="text-muted mb-2">Join us every Sunday for a farm-to-table dining experience exclusively for faculty members and guests...</p>
                        <small class="text-secondary">Jan 09, 2026</small>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <h3 class="fw-bold mb-4">Upcoming Events</h3>
                    <div class="list-group shadow-sm">
                        <div class="list-group-item p-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1 fw-bold text-primary">Faculty Gala 2026</h6>
                            </div>
                            <p class="mb-1 small">Grand Ballroom | 7:00 PM</p>
                        </div>
                        <div class="list-group-item p-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1 fw-bold text-primary">IT Workshop</h6>
                            </div>
                            <p class="mb-1 small">Seminar Room B | 10:00 AM</p>
                        </div>
                        <div class="list-group-item p-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1 fw-bold text-primary">Monthly Board Meeting</h6>
                            </div>
                            <p class="mb-1 small">Conference Room 1 | 2:00 PM</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="py-5">
        <div class="container text-center">
            <p class="mb-2 fw-bold text-white">Faculty Club Management System</p>
            <p class="small mb-0">University Campus, Building 4A, Third Floor</p>
            <p class="small">Contact: (555) 123-4567 | support@facultyclub.edu</p>
            <hr class="my-4 border-secondary">
            <p class="small">&copy; 2026 All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>