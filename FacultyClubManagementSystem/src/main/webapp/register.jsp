<%-- 
    Document   : register
    Created on : 16 Jan 2026, 1:54:36 pm
    Author     : Muhamad Zulhairie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>FCMS | Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root { --bg-pink: #fbc2eb; --accent-pink: #ff99f1; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-pink); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .auth-card { background: white; padding: 30px; border-radius: 30px; border: 2px solid #000; width: 400px; text-align: center; }
        input, select { width: 100%; padding: 10px; margin: 8px 0; border: 2px solid #000; border-radius: 10px; box-sizing: border-box; }
        .btn { background: var(--accent-pink); font-weight: bold; cursor: pointer; border: 2px solid #000; padding: 12px; border-radius: 10px; width: 100%; }
        .grid-inputs { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
    </style>
</head>
<body>
    <div class="card">
        <h2>REGISTER</h2>
        <form action="authController" method="POST">
            <input type="hidden" name="action" value="register">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="text" name="phone" placeholder="Phone Number" required>
            <input type="number" name="club_id" placeholder="Club ID" required>
            <input type="number" name="faculty_id" placeholder="Faculty ID" required>
            <button type="submit">REGISTER</button>
        </form>
        <p><a href="login.jsp" style="font-size: 0.8rem;">Back to Login</a></p>
    </div>
</body>
</html>