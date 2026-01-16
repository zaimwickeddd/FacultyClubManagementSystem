<%-- 
    Document   : header
    Created on : 16 Jan 2026, 4:39:24 pm
    Author     : VICTUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header class="navbar" style="border-bottom: 3px solid #000; background: white; padding: 10px 40px; display: flex; justify-content: space-between; align-items: center;">
    <div class="logo-section">
        <img src="${pageContext.request.contextPath}/image/UiTM-Logo-removebg-preview.png" alt="UiTM Logo" style="height: 60px;">
    </div>

    <nav class="nav-links" style="display: flex; gap: 20px;">
        <a href="homepage.jsp" class="nav-item"><i class="fas fa-home"></i> Home</a>
        <a href="eventList.jsp" class="nav-item"><i class="fas fa-calendar-alt"></i> Events</a>
        <a href="clubs.jsp" class="nav-item"><i class="fas fa-star"></i> Clubs</a>

        <%-- Role-based logic for Member --%>
        <% if ("Member".equals(session.getAttribute("userRole"))) { %>
            <a href="addAdmin.jsp" class="nav-item"><i class="fas fa-user-plus"></i> Add User</a>
        <% } %>
    </nav>

    <div class="user-profile" style="text-align: right; border-left: 2px solid #000; padding-left: 15px;">
        <i class="fas fa-user-circle fa-2x"></i>
        <div style="display: inline-block; vertical-align: top; margin-left: 8px;">
            <strong style="display: block;"><%= session.getAttribute("username") %></strong>
            <small style="color: #666;">(<%= session.getAttribute("userRole") %>)</small><br>
            <a href="LogoutServlet" style="color: #ff0000; font-weight: bold; text-decoration: none; font-size: 0.8rem;">LOGOUT</a>
        </div>
    </div>
</header>
