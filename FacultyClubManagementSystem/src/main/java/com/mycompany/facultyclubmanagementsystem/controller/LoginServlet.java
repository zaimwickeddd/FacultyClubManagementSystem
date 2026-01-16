package com.mycompany.facultyclubmanagementsystem.controller;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get data from form (Ensure your login.jsp names match these)
        String userIdInput = request.getParameter("username"); 
        String passwordInput = request.getParameter("password");

        // Database credentials
        String dbUrl = "jdbc:mysql://localhost:3306/fcms";
        String dbUser = "root";
        String dbPass = "";

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            // 2. Query to check UserID/Email and Role
            // We use backticks `User` because it is a reserved keyword
            String sql = "SELECT * FROM `User` WHERE (UserID = ? OR UserEmail = ?) AND Password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userIdInput);
            ps.setString(2, userIdInput);
            ps.setString(3, passwordInput);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // 3. User Found - Create Session
                HttpSession session = request.getSession();
                
                // Store database values into the session
                session.setAttribute("userId", rs.getInt("UserID"));
                session.setAttribute("userName", rs.getString("UserName"));
                session.setAttribute("userRole", rs.getString("UserRole")); // 'Normal', 'Staff', or 'Admin'
                session.setAttribute("clubId", rs.getInt("ClubID")); 
                session.setAttribute("facultyId", rs.getInt("FacultyID"));
                
                // 4. Redirect based on role or to a general dashboard
                // Since your homepage.jsp uses logic to show/hide items, send everyone there
                response.sendRedirect("homepage.jsp");
                
            } else {
                // No user found
                response.sendRedirect("login.jsp?error=invalid");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db_error");
        }
    }
}