/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Muhamad Zulhairie
 */
@WebServlet(name = "eventController", urlPatterns = {"/eventController"})
public class eventController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Collect data from mockup fields
        String title = request.getParameter("eventName");
        String startDate = request.getParameter("startDate");
        String startTime = request.getParameter("startTime");
        String venue = request.getParameter("venue");
        
        // NEW: Collect these to match your mockup design
        String description = request.getParameter("eventDescription");
        String category = request.getParameter("category");
        String budgetStr = request.getParameter("budget");
        double budget = (budgetStr != null && !budgetStr.isEmpty()) ? Double.parseDouble(budgetStr) : 0.0;

        // Session check: Always safer to get clubID from session than a hidden field
        Integer clubId = (Integer) request.getSession().getAttribute("clubID");
        if (clubId == null) clubId = 1; // Fallback for testing

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); 

            // STEP A: Insert into 'clubeventapplication'
            // Added EventDescription, EventCategory, and EventBudget columns
            String sqlApp = "INSERT INTO clubeventapplication (CEAppStatus, ClubID, EventDescription, EventCategory, EventBudget) VALUES ('Pending', ?, ?, ?, ?)";
            PreparedStatement psApp = conn.prepareStatement(sqlApp, PreparedStatement.RETURN_GENERATED_KEYS);
            psApp.setInt(1, clubId);
            psApp.setString(2, description);
            psApp.setString(3, category);
            psApp.setDouble(4, budget);
            psApp.executeUpdate();

            var rs = psApp.getGeneratedKeys();
            int generatedAppID = rs.next() ? rs.getInt(1) : 0;

            // STEP B: Insert into 'event' table
            // Linking the two tables using the generatedAppID
            String sqlEvent = "INSERT INTO event (EventName, EventDate, EventTime, EventVenue, " +
                              "EventStatus, EventAttendance, ClubID, CEAppID) " +
                              "VALUES (?, ?, ?, ?, 'Pending', 0, ?, ?)";

            PreparedStatement psEvent = conn.prepareStatement(sqlEvent);
            psEvent.setString(1, title);
            psEvent.setString(2, startDate);
            psEvent.setString(3, startTime);
            psEvent.setString(4, venue);
            psEvent.setInt(5, clubId);
            psEvent.setInt(6, generatedAppID); 
            psEvent.executeUpdate();

            conn.commit(); 
            response.sendRedirect("eventListController?success=1");

        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
            response.sendRedirect("createEvent.jsp?error=1");
        } finally {
            if (conn != null) try { conn.close(); } catch (Exception ex) {}
        }
    }
}