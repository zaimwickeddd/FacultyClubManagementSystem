package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/authController")
public class authController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.getWriter().println("Error: conn is null. Check DBConnection.java settings.");
                return;
            }

            if ("register".equals(action)) {
                // UPDATE: Default UserRole is now 'Student' to match your latest requirement
                String sql = "INSERT INTO user (UserName, UserPassword, UserEmail, UserPhone, ClubID, FacultyID, UserRole) VALUES (?, ?, ?, ?, ?, ?, 'Student')";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("username"));
                ps.setString(2, request.getParameter("password"));
                ps.setString(3, request.getParameter("email"));
                ps.setString(4, request.getParameter("phone"));
                ps.setInt(5, Integer.parseInt(request.getParameter("club_id")));
                ps.setInt(6, Integer.parseInt(request.getParameter("faculty_id")));
                
                ps.executeUpdate();
                response.sendRedirect("login.jsp");

            } else if ("login".equals(action)) {
                // FIXED: Table name is 'user' (singular)
                String sql = "SELECT * FROM user WHERE UserName = ? AND UserPassword = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("username"));
                ps.setString(2, request.getParameter("password"));
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", rs.getString("UserName"));
                    
                    // FIXED: Fetch the role as a String to match ENUM ('Student', 'Member', 'Advisor')
                    // This resolves the "Cannot determine value type" error
                    String role = rs.getString("UserRole"); 
                    session.setAttribute("userRole", role); 
                    
                    // Optional: Keep ClubID in session for dashboard filtering
                    session.setAttribute("userClubID", rs.getInt("ClubID")); 
                    
                    response.sendRedirect("homepage.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=invalid");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("System Error: " + e.getMessage());
        }
    }
}