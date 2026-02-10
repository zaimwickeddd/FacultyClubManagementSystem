<%-- 
    Document   : login
    Modified on : 10 Feb 2026
    Author      : Muhamad Zulhairie / Gemini
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | UiTM Club</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --bg-pink: #fbc2eb; 
            --card-purple: #e0b0ff; 
        }

        body { 
            font-family: 'Segoe UI', sans-serif; 
            background: linear-gradient(135deg, var(--bg-pink) 0%, var(--card-purple) 100%);
            display: flex; 
            height: 100vh; 
            justify-content: center; 
            align-items: center; 
            margin: 0; 
        }

        .card { 
            background: white; 
            padding: 40px; 
            border-radius: 20px; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.15); 
            width: 100%; 
            max-width: 400px; 
            text-align: center; 
        }

        .logo { width: 100px; margin-bottom: 20px; }
        h2 { margin: 0 0 20px; color: #333; }
        
        .alert { padding: 10px; border-radius: 5px; margin-bottom: 20px; font-size: 0.9rem; text-align: left; }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
        
        .input-group { position: relative; margin-bottom: 20px; text-align: left; }
        .input-group i.icon { position: absolute; left: 15px; top: 12px; color: #888; }
        
        /* THE FIX FOR THE EYE ICON */
        .input-group i.toggle { 
            position: absolute; 
            right: 15px; 
            top: 50%; 
            transform: translateY(-50%); 
            cursor: pointer; 
            color: #888; 
            z-index: 10;
        }

        /* HIDE THE BROWSER'S DEFAULT EYE */
        input::-ms-reveal,
        input::-ms-clear {
            display: none;
        }
        
        input { 
            width: 100%; 
            padding: 12px 15px 12px 40px; 
            border: 1px solid #ddd; 
            border-radius: 12px; 
            box-sizing: border-box; 
            font-size: 16px; 
            outline: none; 
            transition: border 0.3s; 
        }
        input:focus { border-color: #9c42f5; }
        input[type="password"] { padding-right: 45px; } 
        
        button { 
            width: 100%; 
            padding: 12px; 
            background: linear-gradient(135deg, #9c42f5 0%, #ff99f1 100%); 
            color: white; 
            border: none; 
            border-radius: 12px; 
            cursor: pointer; 
            font-size: 16px; 
            font-weight: bold; 
            transition: transform 0.2s;
        }
        button:hover { transform: translateY(-2px); }
        
        .links { margin-top: 20px; font-size: 0.9rem; }
        a { color: #9c42f5; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="card">
        <img src="image/UiTM-Logo-removebg-preview.png" alt="Logo" class="logo">
        <h2>Welcome Back</h2>

        <% String err = request.getParameter("error");
           if ("success".equals(request.getParameter("logout"))) { %>
            <div class="alert success">Logged out successfully.</div>
        <% } else if (err != null) { %>
            <div class="alert error">
                <%= "invalid".equals(err) ? "Invalid credentials." : 
                    "missing_credentials".equals(err) ? "Enter user & pass." : "System error." %>
            </div>
        <% } %>

        <form action="authController" method="POST">
            <input type="hidden" name="action" value="login">
            
            <div class="input-group">
                <i class="fas fa-user icon"></i>
                <input type="text" name="username" placeholder="Username" required>
            </div>

            <div class="input-group">
                <i class="fas fa-lock icon"></i>
                <input type="password" id="pass" name="password" placeholder="Password" required>
                <i class="fas fa-eye toggle" onclick="togglePass()"></i>
            </div>  

            <div style="text-align: right; margin-bottom: 15px;">
                <a href="#" onclick="alert('Contact admin.');">Forgot Password?</a>
            </div>

            <button type="submit">LOGIN</button>
        </form>

        <div class="links">
            New here? <a href="RegisterLoadController">Create account</a>
        </div>
    </div>

    <script>
        function togglePass() {
            var input = document.getElementById("pass");
            var icon = document.querySelector(".toggle");
            if (input.type === "password") {
                input.type = "text";
                icon.classList.replace("fa-eye", "fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.replace("fa-eye-slash", "fa-eye");
            }
        }
    </script>
</body>
</html>