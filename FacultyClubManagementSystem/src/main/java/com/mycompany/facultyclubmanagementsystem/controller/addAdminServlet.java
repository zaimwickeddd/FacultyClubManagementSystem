/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddAdminServlet")

public class addAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("userId");
        String name = request.getParameter("userName");
        String email = request.getParameter("userEmail");
        String pass = request.getParameter("password");
        String faculty = request.getParameter("facultyId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fcms", "root", "");
            
            // Hardcoding 'Admin' role for this specific form
            String sql = "INSERT INTO `User` (UserID, UserName, UserEmail, Password, UserRole, FacultyID) VALUES (?, ?, ?, ?, 'Admin', ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, pass);
            ps.setString(5, faculty);
            
            ps.executeUpdate();
            response.sendRedirect("homepage.jsp?success=AdminAdded");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addAdmin.jsp?error=Failed");
        }
    }
}
