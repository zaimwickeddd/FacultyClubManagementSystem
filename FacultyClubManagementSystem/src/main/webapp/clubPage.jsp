<%-- 
    Document changes  : clubPage
    Modified on : 06 Feb 2026, 2:55 PM
    Author      : Gi995tzy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.mycompany.facultyclubmanagementsystem.util.DBConnection" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Club Dashboard</title>
    <style>
        :root { --pink: #fbc2eb; --accent: #ff99f1; --dark: #555; }
        body { font-family: Inter, sans-serif; background: var(--pink); margin: 0; }
        .dashboard-container { max-width: 800px; margin: 40px auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: var(--dark); border-bottom: 3px solid var(--accent); padding-bottom: 10px; }
        
        /* Stats Cards */
        .stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
        .stat-card { padding: 20px; border-radius: 10px; text-align: center; color: white; }
        .approved { background: #28a745; }
        .rejected { background: #dc3545; }
        .joined { background: #007bff; grid-column: span 2; } /* Full width for student stat */
        .stat-number { font-size: 3em; font-weight: bold; margin: 10px 0; }
        
        /* Club Info */
        .club-info { text-align: center; padding: 20px; }
        .club-name { font-size: 2em; color: var(--accent); font-weight: 800; text-transform: uppercase; }
        .club-desc { font-size: 1.1em; color: #666; line-height: 1.6; margin-top: 15px; }
    </style>
</head>
<body>

<%
    String currentUser = (String) session.getAttribute("username");
    String userRole = "";
    int userId = 0;
    int clubId = 0;
    
    // Stats
    int approvedCount = 0;
    int rejectedCount = 0;
    int eventsJoined = 0;
    String clubName = "";
    String clubDesc = "";

    if (currentUser != null) {
        try {
            Connection conn = DBConnection.getConnection();
            
            // 1. Get User Details (ID, Role, Club)
            String userSql = "SELECT UserID, UserRole, ClubID FROM user WHERE UserName = ?";
            PreparedStatement psUser = conn.prepareStatement(userSql);
            psUser.setString(1, currentUser);
            ResultSet rsUser = psUser.executeQuery();
            
            if (rsUser.next()) {
                userId = rsUser.getInt("UserID");
                userRole = rsUser.getString("UserRole");
                clubId = rsUser.getInt("ClubID");
            }
            rsUser.close(); psUser.close();

            // 2. Logic Split
            if ("Advisor".equalsIgnoreCase(userRole)) {
                // ADVISOR: Count Approved/Rejected for Faculty Clubs
                String statsSql = "SELECT " +
                    "SUM(CASE WHEN cea.CEAppStatus = 'Approved' THEN 1 ELSE 0 END) as AppCount, " +
                    "SUM(CASE WHEN cea.CEAppStatus = 'Rejected' THEN 1 ELSE 0 END) as RejCount " +
                    "FROM clubeventapplication cea " +
                    "JOIN club c ON cea.ClubID = c.ClubID " +
                    "WHERE c.FacultyID = (SELECT FacultyID FROM user WHERE UserID = ?)";
                
                PreparedStatement psStats = conn.prepareStatement(statsSql);
                psStats.setInt(1, userId);
                ResultSet rsStats = psStats.executeQuery();
                
                if (rsStats.next()) {
                    approvedCount = rsStats.getInt("AppCount");
                    rejectedCount = rsStats.getInt("RejCount");
                }
                rsStats.close(); psStats.close();
                
            } else {
                // STUDENT: Club Info + Events Joined Count
                if (clubId > 0) {
                    // Get Club Info
                    String clubSql = "SELECT ClubName, ClubDescription FROM club WHERE ClubID = ?";
                    PreparedStatement psClub = conn.prepareStatement(clubSql);
                    psClub.setInt(1, clubId);
                    ResultSet rsClub = psClub.executeQuery();
                    if (rsClub.next()) {
                        clubName = rsClub.getString("ClubName");
                        clubDesc = rsClub.getString("ClubDescription");
                    }
                    rsClub.close(); psClub.close();
                    
                    // Get Events Joined Count
                    String joinSql = "SELECT COUNT(*) as JoinCount FROM eventregistration WHERE UserID = ?";
                    PreparedStatement psJoin = conn.prepareStatement(joinSql);
                    psJoin.setInt(1, userId);
                    ResultSet rsJoin = psJoin.executeQuery();
                    if (rsJoin.next()) {
                        eventsJoined = rsJoin.getInt("JoinCount");
                    }
                    rsJoin.close(); psJoin.close();
                }
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<div class="dashboard-container">
    <% if ("Advisor".equalsIgnoreCase(userRole)) { %>
        <h2>EVENT APPLICATION STATUS</h2>
        <div class="stats-grid">
            <div class="stat-card approved">
                <div>APPROVED EVENTS</div>
                <div class="stat-number"><%= approvedCount %></div>
            </div>
            <div class="stat-card rejected">
                <div>REJECTED EVENTS</div>
                <div class="stat-number"><%= rejectedCount %></div>
            </div>
        </div>
    <% } else { %>
        <h2>MY CLUB DETAILS</h2>
        <div class="club-info">
            <div class="club-name"><%= (clubName != null && !clubName.isEmpty()) ? clubName : "No Club Assigned" %></div>
            <div class="club-desc"><%= (clubDesc != null && !clubDesc.isEmpty()) ? clubDesc : "Contact your admin to be assigned to a club." %></div>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card joined">
                <div>EVENTS JOINED</div>
                <div class="stat-number"><%= eventsJoined %></div>
            </div>
        </div>
    <% } %>
</div>

</body>
</html>
<%@ include file="footer.jsp" %>