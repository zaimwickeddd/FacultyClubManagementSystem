<%-- 
    Document   : login
    Created on : 16 Jan 2026, 1:53:48 pm
    Author     : Muhamad Zulhairie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>FCMS | Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root { --bg-pink: #fbc2eb; --accent-pink: #ff99f1; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-pink); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .auth-card { background: white; padding: 40px; border-radius: 30px; border: 2px solid #000; width: 350px; text-align: center; box-shadow: 10px 10px 0px rgba(0,0,0,0.1); }
        input { width: 100%; padding: 12px; margin: 10px 0; border: 2px solid #000; border-radius: 10px; box-sizing: border-box; }
        .btn { background: var(--accent-pink); font-weight: bold; cursor: pointer; border: 2px solid #000; padding: 12px; border-radius: 10px; width: 100%; margin-top: 10px; }
        .footer-link { margin-top: 20px; display: block; font-size: 0.9rem; color: #333; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>
    <div class="auth-card">
        <h2>LOGIN</h2>
        <form action="authController" method="POST">
            <input type="hidden" name="action" value="login">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit" class="btn">LOG IN</button>
        </form>
        <a href="register.jsp" class="footer-link">No account? Create one here</a>
    </div>
</body>
</html>