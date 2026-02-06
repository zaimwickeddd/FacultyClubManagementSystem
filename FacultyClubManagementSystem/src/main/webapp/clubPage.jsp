<%-- 
    Document changes  : clubPage
    Modified on : 07 Feb 2026, 10:30 AM
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
        .container { max-width: 900px; margin: 30px auto; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: var(--dark); border-bottom: 3px solid var(--accent); padding-bottom: 10px; }
        
        /* Stats Cards */
        .stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
        .stat-card { padding: 20px; border-radius: 10px; text-align: center; color: white; }
        .approved { background: #28a745; }
        .rejected { background: #dc3545; }
        .joined { background: #007bff; grid-column: span 2; }
        .stat-number { font-size: 3em; font-weight: bold; margin: 10px 0; }
        
        /* Club Info */
        .club-info { text-align: center; padding: 20px; }
        .club-name { font-size: 2em; color: var(--accent); font-weight: 800; text-transform: uppercase; }
        .club-desc { font-size: 1.1em; color: #666; line-height: 1.6; margin-top: 15px; }
        
        /* Report Form Styles */
        .section { border-bottom: 3px solid var(--accent); font-weight: 700; margin: 25px 0 15px; padding-bottom: 5px; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .group { margin-bottom: 15px; }
        label { display: block; font-weight: 600; color: #555; margin-bottom: 5px; }
        input, select, textarea { width: 100%; padding: 10px; border: 2px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        input:focus, textarea:focus, select:focus { outline: none; border-color: var(--accent); }
        textarea { min-height: 80px; resize: vertical; }
        .rating { display: flex; gap: 5px; flex-direction: row-reverse; justify-content: flex-end; }
        .rating input { display: none; }
        .rating label { cursor: pointer; color: #ccc; font-size: 28px; }
        .rating input:checked ~ label, .rating label:hover, .rating label:hover ~ label { color: #ffb400; }
        .signature-preview { max-width: 200px; max-height: 100px; margin-top: 10px; border: 1px solid #ddd; display: none; }
        .btn { width: 100%; padding: 15px; background: #000; color: white; font-weight: 700; border: none; border-radius: 8px; cursor: pointer; margin-top: 20px; font-size: 16px; }
        .btn:hover { background: #333; }
        .print-header { display: none; text-align: center; border-bottom: 2px solid #000; margin-bottom: 20px; padding-bottom: 10px; }
        
        @media print {
            body { background: white !important; }
            header, .navbar, h2, .btn, .no-print { display: none !important; }
            .container { box-shadow: none; margin: 0; padding: 20px; max-width: 100%; }
            .print-header { display: block !important; }
            input, textarea, select { border: none !important; background: transparent !important; padding: 2px 0 !important; font-weight: 600; color: #000 !important; }
            input[readonly] { font-weight: 700; }
            .section { border-bottom: 2px solid #000; page-break-after: avoid; }
            ::placeholder { color: transparent; }
            .rating { pointer-events: none; }
            .rating input:checked ~ label { color: #000 !important; }
            .signature-preview { display: block !important; }
        }
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

            // 2. Logic Split by Role
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
                
            } else if ("Student".equalsIgnoreCase(userRole)) {
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

<!-- ADVISOR VIEW: Event Stats -->
<% if ("Advisor".equalsIgnoreCase(userRole)) { %>
<div class="dashboard-container">
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
</div>

<!-- STUDENT VIEW: Club Details -->
<% } else if ("Student".equalsIgnoreCase(userRole)) { %>
<div class="dashboard-container">
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
</div>

<!-- MEMBER VIEW: Event Report Form -->
<% } else { %>
<div class="container">
    <div class="print-header">
        <h2>FACULTY CLUB EVENT REPORT</h2>
        <p><strong>Generated:</strong> <span id="printDate"></span> | <strong>By:</strong> <%= currentUser %> (<%= userRole %>)</p>
    </div>
    
    <h2>CREATE EVENT REPORT</h2>
    
    <form id="reportForm" enctype="multipart/form-data">
        <!-- Event Selection -->
        <div class="section no-print">SELECT EVENT</div>
        <div class="group">
            <label>Event:</label>
            <select id="eventSelect" name="eventId" required onchange="loadEventData()">
                <option value="">-- Select Event --</option>
                <%
                try {
                    Connection conn = DBConnection.getConnection();
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
                    rs.close(); ps.close(); conn.close();
                } catch (Exception e) { e.printStackTrace(); }
                %>
            </select>
        </div>
        
        <!-- Event Details -->
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
        
        <!-- Attendance & Engagement -->
        <div class="section">ATTENDANCE & ENGAGEMENT</div>
        <div class="row">
            <div class="group">
                <label>Total Registered:</label>
                <input type="number" id="totalRegistered" name="totalRegistered" value="0" required>
            </div>
            <div class="group">
                <label>Total Attendance:</label>
                <input type="number" id="totalAttendance" name="totalAttendance" value="0" required>
            </div>
        </div>
        <div class="group">
            <label>Engagement Summary:</label>
            <textarea name="engagement" placeholder="Member participation details..."></textarea>
        </div>
        
        <!-- Financial Review -->
        <div class="section">FINANCIAL REVIEW</div>
        <div class="row">
            <div class="group">
                <label>Budget (RM):</label>
                <input type="number" id="budget" name="budget" step="0.01" required oninput="calcBalance()">
            </div>
            <div class="group">
                <label>Expenses (RM):</label>
                <input type="number" id="expenses" name="expenses" step="0.01" required oninput="calcBalance()">
            </div>
        </div>
        <div class="group">
            <label>Balance (RM):</label>
            <input type="number" id="balance" readonly style="background: #f4f4f4; font-weight: 700;">
        </div>
        <div class="group">
            <label>Financial Notes:</label>
            <textarea name="financeNotes" placeholder="Expense breakdown..."></textarea>
        </div>
        
        <!-- Feedback -->
        <div class="section">RATINGS & FEEDBACK</div>
        <div class="group">
            <label>Performance Rating:</label>
            <div class="rating">
                <input type="radio" id="r5" name="rating" value="5" required><label for="r5">★</label>
                <input type="radio" id="r4" name="rating" value="4"><label for="r4">★</label>
                <input type="radio" id="r3" name="rating" value="3"><label for="r3">★</label>
                <input type="radio" id="r2" name="rating" value="2"><label for="r2">★</label>
                <input type="radio" id="r1" name="rating" value="1"><label for="r1">★</label>
            </div>
        </div>
        <div class="row">
            <div class="group">
                <label>Positive Feedback:</label>
                <textarea name="positive" placeholder="Achievements..."></textarea>
            </div>
            <div class="group">
                <label>Improvements:</label>
                <textarea name="improvements" placeholder="Areas to improve..."></textarea>
            </div>
        </div>
        
        <!-- E-Signature -->
        <div class="section">E-SIGNATURE</div>
        <div class="group">
            <label>Upload Signature Image: <span class="no-print">(PNG/JPG)</span></label>
            <input type="file" id="signatureFile" accept="image/*" onchange="previewSignature()" class="no-print">
            <img id="signaturePreview" class="signature-preview" alt="Signature">
        </div>
        
        <button type="button" class="btn" onclick="printReport()">
            <i class="fas fa-print"></i> PRINT REPORT
        </button>
    </form>
</div>

<script>
function loadEventData() {
    const select = document.getElementById('eventSelect');
    const option = select.options[select.selectedIndex];
    
    if (option.value) {
        document.getElementById('eventName').value = option.dataset.name || '';
        document.getElementById('eventDate').value = option.dataset.date || '';
        document.getElementById('eventVenue').value = option.dataset.venue || '';
        
        // Fetch attendance from database
        fetch('getEventAttendance?eventId=' + option.value)
            .then(r => r.json())
            .then(data => {
                document.getElementById('totalRegistered').value = data.registered || 0;
                document.getElementById('totalAttendance').value = data.attendance || 0;
            })
            .catch(() => console.log('Using manual input'));
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
    const form = document.getElementById('reportForm');
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
    const eventSelect = document.getElementById('eventSelect');
    if (!eventSelect.value) {
        alert('Please select an event first!');
        return;
    }
    
    const signature = document.getElementById('signaturePreview');
    if (!signature.src || signature.src === window.location.href) {
        alert('Please upload your signature!');
        return;
    }
    
    document.getElementById('printDate').textContent = new Date().toLocaleDateString('en-MY', { 
        year: 'numeric', month: 'long', day: 'numeric' 
    });
    
    window.print();
}
</script>
<% } %>

</body>
</html>
<%@ include file="footer.jsp" %>