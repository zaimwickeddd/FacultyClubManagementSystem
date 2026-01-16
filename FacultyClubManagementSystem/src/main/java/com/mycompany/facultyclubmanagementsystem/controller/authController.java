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
        
        // Use the connection from your DBConnection utility
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.getWriter().println("Error: conn is null. Check DBConnection.java settings.");
                return;
            }

            if ("register".equals(action)) {
                String sql = "INSERT INTO user (UserName, UserPassword, UserEmail, UserPhone, ClubID, FacultyID, UserRole) VALUES (?, ?, ?, ?, ?, ?, 'Normal')";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("username"));
                ps.setString(2, request.getParameter("password"));
                ps.setString(3, request.getParameter("email"));
                ps.setString(4, request.getParameter("phone"));
                // FIXED: Use Integer.parseInt to convert String from form to int for DB
                ps.setInt(5, Integer.parseInt(request.getParameter("club_id")));
                ps.setInt(6, Integer.parseInt(request.getParameter("faculty_id")));
                
                ps.executeUpdate();
                response.sendRedirect("login.jsp");

            } else if ("login".equals(action)) {
                String sql = "SELECT * FROM user WHERE UserName = ? AND UserPassword = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("username"));
                ps.setString(2, request.getParameter("password"));
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", rs.getString("UserName"));
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