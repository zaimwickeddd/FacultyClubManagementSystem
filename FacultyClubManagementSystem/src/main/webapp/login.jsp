<%-- 
    Document   : login
    Created on : 11 Jan 2026, 1:40:07 am
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty Club | Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f7f6;
            height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .login-sidebar {
            background: linear-gradient(135deg, #0d6efd, #0a4da2);
            color: white;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .form-section {
            padding: 50px;
        }
        .btn-login {
            padding: 12px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-8 login-container">
            <div class="row">
                <div class="col-md-5 login-sidebar d-none d-md-flex">
                    <h2 class="fw-bold">Welcome Back!</h2>
                    <p>Please login to access the Faculty Club member portal, book facilities, and manage your account.</p>
                    <div class="mt-4">
                        <a href="homepage.jsp" class="btn btn-outline-light btn-sm">← Back to Website</a>
                    </div>
                </div>

                <div class="col-md-7 form-section">
                    <h3 class="fw-bold mb-4">Account Login</h3>
                    <form action="LoginServlet" method="POST">
                        <div class="mb-3">
                            <label class="form-label">Faculty ID / Email</label>
                            <input type="text" name="username" class="form-control" placeholder="Enter your ID" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                        </div>
                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-login">Sign In</button>
                        </div>
                        <div class="text-center">
                            <a href="#" class="text-decoration-none small text-muted">Forgot password?</a>
                        </div>
                    </form>
                    
                    <hr class="my-4">
                    
                    <div class="text-center">
                        <p class="small mb-0">Don't have an account?</p>
                        <a href="#" class="fw-bold text-decoration-none">Contact Admin to Register</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>