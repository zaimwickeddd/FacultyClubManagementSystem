<%-- 
    Document   : clubPage
    Modified   : 10 Feb 2026
    Author     : Gi995tzy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.mycompany.facultyclubmanagementsystem.util.DBConnection" %>
<%@ include file="header.jsp" %>

<%
    // 1. Retrieve user identity and role from session
    String currentUser = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    Integer userId = (Integer) session.getAttribute("userId");
    Integer facultyId = (Integer) session.getAttribute("facultyId");
    Integer clubId = (Integer) session.getAttribute("clubId");
    String clubNameFromSession = (String) session.getAttribute("currentClubName");

    // 2. Security Check: Redirect if not logged in
    if (currentUser == null || userRole == null) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    // 3. Retrieve Dashboard Stats (Calculated by approvalController for Advisors)
    int approvedCount = (session.getAttribute("approvedCount") != null) ? (Integer) session.getAttribute("approvedCount") : 0;
    int rejectedCount = (session.getAttribute("rejectedCount") != null) ? (Integer) session.getAttribute("rejectedCount") : 0;
    
    // 4. Student-specific variables
    int eventsJoined = 0;
    String clubDesc = "";

    // Fetch Student counts if role is Student
    if ("Student".equalsIgnoreCase(userRole)) {
        try (Connection conn = DBConnection.getConnection()) {
            String joinSql = "SELECT COUNT(*) FROM eventregistration WHERE UserID = ?";
            try (PreparedStatement ps = conn.prepareStatement(joinSql)) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) eventsJoined = rs.getInt(1);
            }
            
            if (clubId != null && clubId > 0) {
                String descSql = "SELECT ClubDescription FROM club WHERE ClubID = ?";
                try (PreparedStatement ps = conn.prepareStatement(descSql)) {
                    ps.setInt(1, clubId);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) clubDesc = rs.getString("ClubDescription");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Dashboard | FCMS</title>
    <style>
        :root { --pink: #fbc2eb; --accent: #ff99f1; --dark: #333; }
        body { font-family: 'Inter', sans-serif; background: var(--pink); margin: 0; padding-bottom: 50px; }
        .dashboard-container { max-width: 850px; margin: 40px auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 8px 20px rgba(0,0,0,0.15); border: 2px solid #000; }
        .container { max-width: 900px; margin: 30px auto; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: var(--dark); border-bottom: 3px solid var(--accent); padding-bottom: 10px; text-transform: uppercase; }
        
        /* Stats Styling */
        .stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 25px; }
        .stat-card { padding: 30px; border-radius: 12px; text-align: center; color: white; border: 2px solid #000; }
        .approved { background: #28a745; }
        .rejected { background: #dc3545; }
        .joined { background: #007bff; grid-column: span 2; }
        .stat-number { font-size: 3.5em; font-weight: 900; }
        
        /* Report Form Styles (Restored) */
        .section { border-bottom: 3px solid var(--accent); font-weight: 700; margin: 25px 0 15px; padding-bottom: 5px; color: var(--dark); }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .group { margin-bottom: 15px; }
        label { display: block; font-weight: 600; margin-bottom: 5px; }
        input, select, textarea { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 8px; font-size: 14px; box-sizing: border-box; }
        .rating { display: flex; gap: 5px; flex-direction: row-reverse; justify-content: flex-end; }
        .rating input { display: none; }
        .rating label { cursor: pointer; color: #ccc; font-size: 28px; }
        .rating input:checked ~ label { color: #ffb400; }
        .btn { width: 100%; padding: 15px; background: #000; color: white; font-weight: 700; border: none; border-radius: 8px; cursor: pointer; margin-top: 20px; transition: 0.3s; }
        .btn:hover { background: #333; transform: translateY(-2px); }
        .signature-preview { max-width: 200px; margin-top: 10px; border: 1px solid #ddd; display: none; }
        .print-header { display: none; text-align: center; border-bottom: 2px solid #000; margin-bottom: 20px; padding-bottom: 10px; }

        @media print {
            .no-print, header, .btn, h2:not(.print-header h2) { display: none !important; }
            .dashboard-container, .container { box-shadow: none; border: none; margin: 0; width: 100%; }
            .print-header { display: block !important; }
            input, textarea, select { border: none !important; background: transparent !important; }
            .signature-preview { display: block !important; }
        }
    </style>
</head>
<body>

<%-- ADVISOR VIEW --%>
<% if ("Advisor".equalsIgnoreCase(userRole)) { %>
<div class="dashboard-container">
    <h2>Advisor Dashboard</h2>
    <p style="text-align: center;">Welcome, <strong><%= currentUser %></strong>. Monitoring Faculty ID: <%= facultyId %></p>
    <div class="stats-grid">
        <div class="stat-card approved">
            <div>APPROVED APPLICATIONS</div>
            <div class="stat-number"><%= approvedCount %></div>
        </div>
        <div class="stat-card rejected">
            <div>REJECTED APPLICATIONS</div>
            <div class="stat-number"><%= rejectedCount %></div>
        </div>
    </div>
</div>

<%-- STUDENT VIEW --%>
<% } else if ("Student".equalsIgnoreCase(userRole)) { %>
<div class="dashboard-container">
    <h2>Student Club Portal</h2>
    <div style="text-align: center; padding: 20px;">
        <h1 style="color: var(--accent); margin-bottom: 5px;"><%= (clubNameFromSession != null) ? clubNameFromSession : "General Member" %></h1>
        <p style="color: #666;"><%= (clubDesc != null && !clubDesc.isEmpty()) ? clubDesc : "Welcome to your student dashboard." %></p>
    </div>
    <div class="stats-grid">
        <div class="stat-card joined">
            <div>REGISTERED EVENTS</div>
            <div class="stat-number"><%= eventsJoined %></div>
        </div>
    </div>
</div>

<%-- MEMBER VIEW (Report Form Restored) --%>
<% } else if ("Member".equalsIgnoreCase(userRole)) { %>
<div class="container">
    <div class="print-header">
        <h2>FACULTY CLUB EVENT REPORT</h2>
        <p><strong>Generated:</strong> <span id="printDate"></span> | <strong>By:</strong> <%= currentUser %></p>
    </div>
    
    <h2>CREATE EVENT REPORT</h2>
    
    <form id="reportForm">
        <div class="section no-print">SELECT EVENT</div>
        <div class="group">
            <label>Event:</label>
            <select id="eventSelect" name="eventId" required onchange="loadEventData()">
                <option value="">-- Select Event --</option>
                <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT EventID, EventName, EventDate, EventVenue FROM event ORDER BY EventDate DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        out.println("<option value='" + rs.getInt("EventID") + "' " +
                                   "data-name='" + rs.getString("EventName") + "' " +
                                   "data-date='" + rs.getDate("EventDate") + "' " +
                                   "data-venue='" + rs.getString("EventVenue") + "'>" +
                                   rs.getString("EventName") + " - " + rs.getDate("EventDate") + "</option>");
                    }
                } catch (Exception e) { e.printStackTrace(); }
                %>
            </select>
        </div>
        
        <div class="section">EVENT DETAILS</div>
        <div class="row">
            <div class="group">
                <label>Event Name:</label>
                <input type="text" id="eventName" readonly>
            </div>
            <div class="group">
                <label>Event Date:</label>
                <input type="text" id="eventDate" readonly>
            </div>
        </div>
        <div class="group">
            <label>Venue:</label>
            <input type="text" id="eventVenue" readonly>
        </div>
        
        <div class="section">ATTENDANCE & ENGAGEMENT</div>
        <div class="row">
            <div class="group">
                <label>Total Registered:</label>
                <input type="number" id="totalRegistered" value="0" required>
            </div>
            <div class="group">
                <label>Total Attendance:</label>
                <input type="number" id="totalAttendance" value="0" required>
            </div>
        </div>
        
        <div class="section">FINANCIAL REVIEW</div>
        <div class="row">
            <div class="group">
                <label>Budget (RM):</label>
                <input type="number" id="budget" step="0.01" required oninput="calcBalance()">
            </div>
            <div class="group">
                <label>Expenses (RM):</label>
                <input type="number" id="expenses" step="0.01" required oninput="calcBalance()">
            </div>
        </div>
        <div class="group">
            <label>Balance (RM):</label>
            <input type="number" id="balance" readonly style="background: #f4f4f4; font-weight: 700;">
        </div>

        <div class="section">RATINGS & FEEDBACK</div>
        <div class="group">
            <label>Performance Rating:</label>
            <div class="rating">
                <input type="radio" id="r5" name="rating" value="5"><label for="r5">★</label>
                <input type="radio" id="r4" name="rating" value="4"><label for="r4">★</label>
                <input type="radio" id="r3" name="rating" value="3"><label for="r3">★</label>
                <input type="radio" id="r2" name="rating" value="2"><label for="r2">★</label>
                <input type="radio" id="r1" name="rating" value="1"><label for="r1">★</label>
            </div>
        </div>
        
        <div class="section">E-SIGNATURE</div>
        <div class="group">
            <label>Upload Signature Image:</label>
            <input type="file" id="signatureFile" accept="image/*" onchange="previewSignature()" class="no-print">
            <img id="signaturePreview" class="signature-preview" alt="Signature">
        </div>
        
        <button type="button" class="btn" onclick="printReport()">PRINT REPORT</button>
    </form>
</div>
<% } %>

<script>
function loadEventData() {
    const select = document.getElementById('eventSelect');
    const option = select.options[select.selectedIndex];
    if (option.value) {
        document.getElementById('eventName').value = option.dataset.name || '';
        document.getElementById('eventDate').value = option.dataset.date || '';
        document.getElementById('eventVenue').value = option.dataset.venue || '';
    }
}

function calcBalance() {
    const budget = parseFloat(document.getElementById('budget').value) || 0;
    const expenses = parseFloat(document.getElementById('expenses').value) || 0;
    document.getElementById('balance').value = (budget - expenses).toFixed(2);
}

function previewSignature() {
    const file = document.getElementById('signatureFile').files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.getElementById('signaturePreview');
            preview.src = e.target.result;
            preview.style.display = 'block';
        };
        reader.readAsDataURL(file);
    }
}

function printReport() {
    document.getElementById('printDate').textContent = new Date().toLocaleDateString();
    window.print();
}
</script>

</body>
</html>
<%@ include file="footer.jsp" %>