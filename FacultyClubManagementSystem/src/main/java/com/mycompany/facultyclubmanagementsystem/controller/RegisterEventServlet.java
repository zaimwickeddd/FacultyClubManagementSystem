/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import java.io.IOException;
import java.sql.Connection;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.*;

/**
 *
 * @author Muhamad Zulhairie
 */
@WebServlet(name = "RegisterEventServlet", urlPatterns = {"/RegisterEventServlet"})
public class RegisterEventServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // 1. Get UserID from Session (ensure you stored this during login)
        Integer userId = (Integer) session.getAttribute("userId");
        
        // 2. Get EventID from Form
        String eventIdStr = request.getParameter("eventId");
        
        if (userId == null || eventIdStr == null) {
            response.sendRedirect("eventListController?error=RegistrationFailed");
            return;
        }
        
        int eventId = Integer.parseInt(eventIdStr);
        Connection conn = null;
        
        try {
            conn = DBConnection.getConnection();
            
            // 3. Insert into database using your table structure
            // Defaulting RegisStatus to 'PENDING'
            String sql = "INSERT INTO eventregistration (UserID, EventID, RegisDate, RegisStatus) VALUES (?, ?, NOW(), 'PENDING')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            
            ps.executeUpdate();
            
            // Redirect back to event list with success message
            response.sendRedirect("eventListController?success=Registered");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("eventListController?error=DatabaseError");
        }
    }
}
