<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile | FCMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #fbc2eb; min-height: 100vh; display: flex; flex-direction: column; }
        .profile-container { flex: 1; display: flex; justify-content: center; align-items: center; padding: 40px 20px; }
        .profile-card { background: white; width: 100%; max-width: 420px; padding: 35px 30px; border-radius: 20px; border: 3px solid #000; box-shadow: 10px 10px 0px #000; position: relative; text-align: center; }
        
        .edit-icon-btn { position: absolute; top: 20px; right: 20px; background: #f0f0f0; border: 2px solid #000; width: 40px; height: 40px; border-radius: 10px; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.2s ease; box-shadow: 3px 3px 0px #000; }
        .edit-icon-btn:hover { transform: translate(-2px, -2px); box-shadow: 5px 5px 0px #000; background: #fff; }
        .edit-icon-btn:active { transform: translate(2px, 2px); box-shadow: 0px 0px 0px #000; }

        .user-avatar { font-size: 60px; color: #000; margin-bottom: 20px; }
        .info-row { text-align: left; margin-bottom: 15px; padding: 12px 18px; background: #fff; border: 2px solid #000; border-radius: 12px; box-shadow: 4px 4px 0px rgba(0,0,0,0.05); }
        .label { font-weight: 700; font-size: 0.65rem; color: #666; text-transform: uppercase; letter-spacing: 1px; }
        .value { display: block; font-size: 1.05rem; color: #000; font-weight: 600; margin-top: 2px; }

        #editFormContainer { display: none; margin-top: 10px; }
        .input-group { margin-bottom: 15px; text-align: left; }
        .input-field { width: 100%; padding: 12px; border: 2px solid #000; border-radius: 10px; font-family: inherit; font-weight: 600; margin-top: 5px; background: #fdfdfd; }
        .btn-save { width: 100%; padding: 14px; background: #000; color: #fff; border: none; border-radius: 12px; font-weight: 700; cursor: pointer; text-transform: uppercase; letter-spacing: 1px; margin-top: 10px; }
        .alert { padding: 12px; margin-bottom: 20px; border-radius: 10px; border: 2px solid #000; font-weight: 700; font-size: 0.9rem; background: #d4edda; color: #155724; }
    </style>
</head>
<body>
    <%@include file="header.jsp" %> 
    
    <div class="profile-container">
        <div class="profile-card">
            <div class="edit-icon-btn" onclick="toggleEdit()" title="Edit Profile"><i class="fas fa-pen"></i></div>

            <% if(request.getParameter("success") != null) { %><div class="alert">Profile updated successfully!</div><% } %>

            <div class="user-avatar"><i class="fas fa-user-circle"></i></div>
            
            <%-- Information View --%>
            <div id="profileDisplay">
                <div class="info-row">
                    <span class="label">Full Name</span>
                    <span class="value">
                        <% 
                            Object name = session.getAttribute("userName");
                            if (name == null) name = session.getAttribute("username"); 
                            out.print(name != null ? name : "User"); 
                        %>
                    </span>
                </div>

                <div class="info-row">
                    <span class="label">User Role</span>
                    <span class="value"><%= session.getAttribute("userRole") %></span>
                </div>

                <div class="info-row">
                    <span class="label">Email Address</span>
                    <span class="value"><%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "Not Available" %></span>
                </div>

                <div class="info-row">
                    <span class="label">Phone Number</span>
                    <span class="value"><%= session.getAttribute("userPhone") != null ? session.getAttribute("userPhone") : "Not Set" %></span>
                </div>

                <% if ("Student".equals(session.getAttribute("userRole")) || "Member".equals(session.getAttribute("userRole"))) { %>
                    <div class="info-row">
                        <span class="label">Current Semester</span>
                        <span class="value">Semester <%= session.getAttribute("userSemester") %></span>
                    </div>
                <% } %>
            </div>

            <%-- Hidden Edit Form --%>
            <div id="editFormContainer">
                <form action="UpdateProfileServlet" method="POST">
                    <div class="input-group">
                        <label class="label">Email Address</label>
                        <input type="email" name="email" class="input-field" value="<%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "" %>" required>
                    </div>
                    <div class="input-group">
                        <label class="label">Phone Number</label>
                        <input type="text" name="phone" class="input-field" value="<%= session.getAttribute("userPhone") != null ? session.getAttribute("userPhone") : "" %>" required>
                    </div>
                    <button type="submit" class="btn-save">Save Changes</button>
                    <p onclick="toggleEdit()" style="margin-top:15px; cursor:pointer; font-weight:600; font-size:0.8rem; text-decoration:underline;">Cancel</p>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleEdit() {
            const display = document.getElementById('profileDisplay');
            const form = document.getElementById('editFormContainer');
            const icon = document.querySelector('.edit-icon-btn i');
            if (form.style.display === 'none' || form.style.display === '') {
                form.style.display = 'block'; display.style.display = 'none'; icon.className = 'fas fa-times';
            } else {
                form.style.display = 'none'; display.style.display = 'block'; icon.className = 'fas fa-pen';
            }
        }
    </script>
</body>
</html>