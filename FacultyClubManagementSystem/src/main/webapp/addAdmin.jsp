<%-- 
    Document   : addAdmin
    Created on : 17 Jan 2026, 1:07:00 pm
    Author     : Anderson Giggs
--%>
<%@ include file="header.jsp" %>
<%
    String currentRole = (String) session.getAttribute("userRole");
    if (!"Member".equals(currentRole)) {
        response.sendRedirect("homepage.jsp?error=unauthorized");
        return;
    }
%>
<style>
    .main-content { 
        display: flex; 
        justify-content: center; 
        align-items: center; 
        min-height: calc(100vh - 120px); 
        padding: 20px;
    }
    .form-container { 
        background: white; 
        padding: 30px; 
        border-radius: 20px; 
        box-shadow: 0 10px 20px rgba(0,0,0,0.1); 
        width: 100%; 
        max-width: 400px; 
    }
    h2 { text-align: center; margin-bottom: 20px; }
    input, select { 
        width: 100%; 
        padding: 12px; 
        margin: 10px 0; 
        border: 1px solid #ccc; 
        border-radius: 10px; 
        box-sizing: border-box; 
    }
    .btn-submit { 
        background-color: #ff99f1; 
        border: 2px solid #000; 
        width: 100%; 
        padding: 12px; 
        border-radius: 10px; 
        font-weight: bold; 
        cursor: pointer; 
        margin-top: 10px;
    }
    .btn-submit:hover {
        background-color: #ff80eb;
    }
</style>

<div class="main-content">
    <div class="form-container">
        <h2>Register New Admin</h2>
        <form action="AddAdminServlet" method="POST">
            <input type="text" name="userId" placeholder="Admin ID/Staff ID" required>
            <input type="text" name="userName" placeholder="Full Name" required>
            <input type="email" name="userEmail" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Temporary Password" required>
            <select name="facultyId" required>
                <option value="">Select Faculty</option>
                <option value="1">Computer Science</option>
                <option value="2">Business Management</option>
            </select>
            <button type="submit" class="btn-submit">CREATE ADMIN ACCOUNT</button>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>
