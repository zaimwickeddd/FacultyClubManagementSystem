<%-- 
    Document changes : clubPage
    Modified on : 06 Feb 2026, 12:15 PM
    Author     : Gi995tzy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.mycompany.facultyclubmanagementsystem.util.DBConnection" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Report - Faculty Club</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { 
            --bg-pink: #fbc2eb; 
            --accent: #ff99f1; 
            --dark: #333; 
        }
        
        body { 
            margin: 0; 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-pink); 
        }
        
        .container { 
            max-width: 900px; 
            margin: 30px auto; 
            background: white; 
            padding: 40px; 
            border-radius: 15px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
        }
        
        h2.page-title { 
            color: #555; 
            text-align: center; 
            margin-bottom: 30px; 
        }
        
        .section-title { 
            font-size: 18px; 
            font-weight: 700; 
            color: var(--dark); 
            border-bottom: 3px solid var(--accent); 
            margin: 25px 0 15px; 
            padding-bottom: 5px; 
        }
        
        .form-row { 
            display: grid; 
            grid-template-columns: 1fr 1fr; 
            gap: 20px; 
        }
        
        .form-group { 
            margin-bottom: 15px; 
        }
        
        label { 
            display: block; 
            font-weight: 600; 
            color: #555; 
            margin-bottom: 5px; 
        }
        
        input, select, textarea { 
            width: 100%; 
            padding: 10px; 
            border: 2px solid #ddd; 
            border-radius: 6px; 
            font-family: inherit; 
            box-sizing: border-box; 
        }
        
        input:focus, textarea:focus { 
            outline: none; 
            border-color: var(--accent); 
        }
        
        textarea { 
            min-height: 80px; 
            resize: vertical; 
        }

        /* Star Rating */
        .rating-group { 
            display: flex; 
            gap: 5px; 
            flex-direction: row-reverse; 
            justify-content: flex-end; 
        }
        
        .rating-group input { 
            display: none; 
        }
        
        .rating-group label { 
            cursor: pointer; 
            color: #ccc; 
            font-size: 28px; 
            transition: 0.2s; 
        }
        
        .rating-group input:checked ~ label, 
        .rating-group label:hover, 
        .rating-group label:hover ~ label { 
            color: #ffb400; 
        }

        .btn-print { 
            display: block; 
            width: 100%; 
            padding: 15px; 
            background: #000; 
            color: white; 
            font-weight: 700; 
            border: none; 
            border-radius: 8px; 
            cursor: pointer; 
            margin-top: 20px; 
            font-size: 16px;
        }
        
        .btn-print:hover { 
            background: #333; 
        }

        /* Print Header (Hidden by default) */
        .print-header { 
            display: none; 
            text-align: center; 
            border-bottom: 2px solid #000; 
            margin-bottom: 20px; 
            padding-bottom: 10px; 
        }
        
        /* Print Styles */
        @media print {
            /* Hide everything except the report */
            body { 
                background: white !important; 
                -webkit-print-color-adjust: exact; 
            }
            
            /* Hide navigation and other elements */
            header, .navbar, .nav-links, .user-profile, 
            .page-title, .btn-print, .no-print {
                display: none !important;
            }
            
            .container { 
                box-shadow: none; 
                margin: 0; 
                padding: 20px; 
                width: 100%; 
                max-width: 100%; 
            }
            
            /* Show print header */
            .print-header { 
                display: block !important; 
            }
            
            /* Make inputs look like printed text */
            input, textarea, select { 
                border: none !important; 
                background: transparent !important; 
                padding: 2px 0 !important; 
                font-weight: 600; 
                color: #000 !important; 
                resize: none; 
                -webkit-appearance: none;
            }
            
            input[readonly] {
                font-weight: 700;
            }
            
            .section-title { 
                border-bottom: 2px solid #000; 
                margin-top: 20px; 
                page-break-after: avoid;
            }
            
            ::placeholder { 
                color: transparent; 
            }
            
            /* Fix star rating for print */
            .rating-group { 
                pointer-events: none; 
            }
            
            .rating-group input:checked ~ label { 
                color: #000 !important; 
            }
            
            /* Prevent page breaks inside sections */
            .form-section {
                page-break-inside: avoid;
            }
        }
    </style>
</head>
<body>
    <%
        // Get user info from session
        String currentUser = (String) session.getAttribute("username");
        String currentRole = (String) session.getAttribute("userRole");
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Set defaults if null
        if (currentUser == null) currentUser = "User";
        if (currentRole == null) currentRole = "Member";
        
        // Initialize database stats
        int totalRegistered = 0;
        int totalAttendance = 0;
        
        // Fetch data from database
        try {
            Connection conn = DBConnection.getConnection();
            
            // Get total registered users (members in club)
            String sqlUsers = "SELECT COUNT(*) as total FROM user WHERE ClubID IS NOT NULL";
            PreparedStatement psUsers = conn.prepareStatement(sqlUsers);
            ResultSet rsUsers = psUsers.executeQuery();
            if (rsUsers.next()) {
                totalRegistered = rsUsers.getInt("total");
            }
            rsUsers.close();
            psUsers.close();
            
            // Get total attendance across all events
            String sqlAttendance = "SELECT SUM(EventAttendance) as total FROM event WHERE EventAttendance IS NOT NULL";
            PreparedStatement psAttendance = conn.prepareStatement(sqlAttendance);
            ResultSet rsAttendance = psAttendance.executeQuery();
            if (rsAttendance.next()) {
                totalAttendance = rsAttendance.getInt("total");
            }
            rsAttendance.close();
            psAttendance.close();
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="container">
        <!-- Print Header (Only visible when printing) -->
        <div class="print-header">
            <h2>FACULTY CLUB MANAGEMENT SYSTEM</h2>
            <h3>CLUB PERFORMANCE REPORT</h3>
            <p><strong>Generated on:</strong> <span id="printDate"></span></p>
            <p><strong>Prepared by:</strong> <%= currentUser %> (<%= currentRole %>)</p>
        </div>

        <h2 class="page-title">CREATE REPORT</h2>

        <form id="reportForm">
            <!-- Attendance & Engagement Section -->
            <div class="section-title">
                <i class="fas fa-users no-print"></i> ATTENDANCE AND ENGAGEMENT DATA
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Total Registered:</label>
                    <input type="number" name="totalRegistered" id="totalRegistered" value="<%= totalRegistered %>" required>
                </div>
                <div class="form-group">
                    <label>Total Attendance:</label>
                    <input type="number" name="totalAttendance" id="totalAttendance" value="<%= totalAttendance %>" required>
                </div>
            </div>
            
            <div class="form-group">
                <label>Engagement Summary:</label>
                <textarea name="engagementSummary" placeholder="Describe member participation, activities, and engagement levels..."></textarea>
            </div>

            <!-- Financial Review Section -->
            <div class="section-title">
                <i class="fas fa-dollar-sign no-print"></i> FINANCIAL REVIEW
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Total Budget (RM):</label>
                    <input type="number" id="totalBudget" name="totalBudget" step="0.01" required>
                </div>
                <div class="form-group">
                    <label>Total Expenses (RM):</label>
                    <input type="number" id="totalExpenses" name="totalExpenses" step="0.01" required>
                </div>
            </div>
            
            <div class="form-group">
                <label>Remaining Balance (RM):</label>
                <input type="number" id="remainingBalance" name="remainingBalance" readonly style="background: #f4f4f4; font-weight: 700;">
            </div>
            
            <div class="form-group">
                <label>Financial Notes:</label>
                <textarea name="financialNotes" placeholder="Additional financial details, expenses breakdown, funding sources..."></textarea>
            </div>

            <!-- Overall Ratings and Feedback Section -->
            <div class="section-title">
                <i class="fas fa-star no-print"></i> OVERALL RATINGS AND FEEDBACK
            </div>
            
            <div class="form-group">
                <label>Performance Rating:</label>
                <div class="rating-group">
                    <input type="radio" id="r5" name="rating" value="5" required>
                    <label for="r5" title="Excellent">★</label>
                    <input type="radio" id="r4" name="rating" value="4">
                    <label for="r4" title="Good">★</label>
                    <input type="radio" id="r3" name="rating" value="3">
                    <label for="r3" title="Average">★</label>
                    <input type="radio" id="r2" name="rating" value="2">
                    <label for="r2" title="Below Average">★</label>
                    <input type="radio" id="r1" name="rating" value="1">
                    <label for="r1" title="Poor">★</label>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Positive Feedback:</label>
                    <textarea name="positiveFeedback" placeholder="What went well? Achievements and successes..."></textarea>
                </div>
                <div class="form-group">
                    <label>Areas for Improvement:</label>
                    <textarea name="improvements" placeholder="What can be improved? Challenges faced..."></textarea>
                </div>
            </div>

            <button type="button" class="btn-print" onclick="handlePrint()">
                <i class="fas fa-print"></i> PRINT REPORT
            </button>
        </form>
    </div>

    <script>
        // Auto-calculate Remaining Balance
        function calculateBalance() {
            const budget = parseFloat(document.getElementById('totalBudget').value) || 0;
            const expenses = parseFloat(document.getElementById('totalExpenses').value) || 0;
            document.getElementById('remainingBalance').value = (budget - expenses).toFixed(2);
        }
        
        document.getElementById('totalBudget').addEventListener('input', calculateBalance);
        document.getElementById('totalExpenses').addEventListener('input', calculateBalance);

        // Handle Print
        function handlePrint() {
            const form = document.getElementById('reportForm');
            
            if (form.checkValidity()) {
                // Set current date for print
                const dateOptions = { year: 'numeric', month: 'long', day: 'numeric' };
                const currentDate = new Date().toLocaleDateString('en-MY', dateOptions);
                document.getElementById('printDate').textContent = currentDate;
                
                // Trigger print dialog
                window.print();
            } else {
                form.reportValidity();
            }
        }
        
        // Optional: Add print event listeners
        window.addEventListener('beforeprint', function() {
            console.log('Preparing to print...');
        });
        
        window.addEventListener('afterprint', function() {
            console.log('Print dialog closed');
        });
    </script>
</body>
</html>
<%@ include file="footer.jsp" %>
