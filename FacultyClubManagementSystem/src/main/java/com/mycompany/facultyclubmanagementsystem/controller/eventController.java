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
import com.mycompany.facultyclubmanagementsystem.dao.EventDAO;
import com.mycompany.facultyclubmanagementsystem.model.Event;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
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
    


// ... inside your eventController class ...

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            // Ensure user is logged in before fetching data
            if (userId != null) {
                EventDAO eventDAO = new EventDAO();

                // 1. Fetch data for the dashboard cards
                List<Event> upcoming = eventDAO.findUpcomingEvents();
                List<Map<String, String>> statuses = eventDAO.getUserEventStatuses(userId);

                // 2. Set attributes so homepage.jsp can see them
                request.setAttribute("upcomingEvents", upcoming);
                request.setAttribute("userStatuses", statuses);

                // 3. Forward to the homepage
                request.getRequestDispatcher("homepage.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Collect form data
        String title = request.getParameter("eventTitle");
        String startDate = request.getParameter("startDate");
        String startTime = request.getParameter("startTime");
        String venue = request.getParameter("venue");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            // Fixed: Using correct table name 'event' and matching database schema columns
            String sql = "INSERT INTO event (EventName, EventDate, EventTime, EventVenue, " +
                        "EventStatus, EventAttendance) " +
                        "VALUES (?, ?, ?, ?, 'Upcoming', 0)";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, title);  // EventName
            statement.setString(2, startDate);  // EventDate
            statement.setString(3, startTime);  // EventTime
            statement.setString(4, venue);  // EventVenue
            // EventStatus = 'Upcoming' and EventAttendance = 0 are set in SQL


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