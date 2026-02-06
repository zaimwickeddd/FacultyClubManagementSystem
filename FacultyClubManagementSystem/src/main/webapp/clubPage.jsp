<%-- 
    Document changes : clubPage
    Modified on : 06 Feb 2026, 1:00 PM
    Author     : Gi995tzy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.mycompany.facultyclubmanagementsystem.util.DBConnection" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Event Report</title>
    <style>
        :root { --pink: #fbc2eb; --accent: #ff99f1; }
        body { margin: 0; font-family: Inter, sans-serif; background: var(--pink); }
        .container { max-width: 900px; margin: 30px auto; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #555; margin-bottom: 30px; }
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
    String user = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("userRole");
    if (user == null) user = "User";
    if (role == null) role = "Member";
%>

<div class="container">
    <div class="print-header">
        <h2>FACULTY CLUB EVENT REPORT</h2>
        <p><strong>Generated:</strong> <span id="printDate"></span> | <strong>By:</strong> <%= user %> (<%= role %>)</p>
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
</body>
</html>
<%@ include file="footer.jsp" %>
