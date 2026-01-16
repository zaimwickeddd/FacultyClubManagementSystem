<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null || !"Admin".equals(role)) {
        response.sendRedirect("homepage.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Admin | UiTM</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #fbc2eb; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .form-container { background: white; padding: 30px; border-radius: 20px; box-shadow: 0 10px 20px rgba(0,0,0,0.1); width: 350px; }
        h2 { text-align: center; }
        input, select { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ccc; border-radius: 10px; box-sizing: border-box; }
        .btn-submit { background-color: #ff99f1; border: 2px solid #000; width: 100%; padding: 12px; border-radius: 10px; font-weight: bold; cursor: pointer; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Register New Admin</h2>
        <form action="AddAdminServlet" method="POST">
            <input type="text" name="userId" placeholder="Admin ID/Staff ID" required>
            <input type="text" name="userName" placeholder="Full Name" required>
            <input type="email" name="userEmail" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Temporary Password" required>
            <select name="facultyId">
                <option value="1">Computer Science</option>
                <option value="2">Business Management</option>
            </select>
            <button type="submit" class="btn-submit">CREATE ADMIN ACCOUNT</button>
        </form>
    </div>
</body>
</html>