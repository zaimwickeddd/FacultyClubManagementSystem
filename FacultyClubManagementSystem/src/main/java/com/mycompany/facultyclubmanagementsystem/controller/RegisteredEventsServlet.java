/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import java.text.SimpleDateFormat; 
import java.util.Date; 
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import com.mycompany.facultyclubmanagementsystem.model.Event;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Muhamad Zulhairie
 */
@WebServlet(name = "RegisteredEventsServlet", urlPatterns = {"/RegisteredEventsServlet"})
public class RegisteredEventsServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Ensure user is logged in
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<Event> registeredEvents = new ArrayList<>();
        Connection conn = null;
        
        try {
            conn = DBConnection.getConnection();
            
            // Query to join eventregistration and event table
            String sql = "SELECT e.*, er.RegisStatus FROM event e " +
                         "JOIN eventregistration er ON e.EventID = er.EventID " +
                         "WHERE er.UserID = ?";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("EventID"));
                event.setEventName(rs.getString("EventName"));
                
                String dateString = rs.getString("EventDate");
                if (dateString != null) {
                    try {
                        // Adjust the format "yyyy-MM-dd" to match your DB date format
                        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date utilDate = formatter.parse(dateString);
                        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                        event.setEventDate(sqlDate);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                
                event.setEventVenue(rs.getString("EventVenue"));
                // Store registration status in a custom field if available in Event model
                // or just display it directly in JSP
                registeredEvents.add(event);
            }
            
            // Set data and forward to JSP
            request.setAttribute("registeredEvents", registeredEvents);
            request.getRequestDispatcher("registeredEvents.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Handle error appropriately
        }
    }
}
