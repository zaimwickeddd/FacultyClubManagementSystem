/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 *
 * @author Muhamad Zulhairie
 */
@WebServlet(name = "eventController", urlPatterns = {"/eventController"})
public class eventController extends HttpServlet {

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
        
        // 1. Collect text data from the form
        String title = request.getParameter("eventTitle");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String venue = request.getParameter("venue");
        String category = request.getParameter("category");
        String budgetStr = request.getParameter("budget");
        String description = request.getParameter("description");
        
        // 2. Handle the Image File
        Part filePart = request.getPart("eventImage");
        InputStream inputStream = null;
        if (filePart != null) {
            inputStream = filePart.getInputStream();
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO events (title, event_image, requested_by, start_date, end_date, "
                       + "start_time, end_time, venue, category, budget, description) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, title);
            
            if (inputStream != null) {
                statement.setBlob(2, inputStream);
            }
            
            statement.setString(3, "Zaim (Compass Club President)"); // Placeholder for logged-in user
            statement.setString(4, startDate);
            statement.setString(5, endDate);
            statement.setString(6, startTime);
            statement.setString(7, endTime);
            statement.setString(8, venue);
            statement.setString(9, category);
            statement.setDouble(10, Double.parseDouble(budgetStr));
            statement.setString(11, description);

            int row = statement.executeUpdate();
            if (row > 0) {
                // Success! Redirect back to dashboard
                response.sendRedirect("homepage.jsp?success=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("createEvent.jsp?error=1");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception ex) { }
            }
        }
    }
}
