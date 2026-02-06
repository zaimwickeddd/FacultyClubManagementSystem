/*
 * Document modified : eventListController
 * Modified on : 31 Jan 2026, 11:43:00 pm
 * Author     : Anderson Giggs
 */
/*
 * Document modified : eventListController
 * Modified on : 31 Jan 2026, 11:43:00 pm
 * Author     : Anderson Giggs
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.EventDAO;
import com.mycompany.facultyclubmanagementsystem.model.Event;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList; 
import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import com.mycompany.facultyclubmanagementsystem.util.DBConnection; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller to display all events from the event table
 * Handles fetching and displaying event list for all user roles
 * * @author Anderson Giggs
 */
@WebServlet("/eventListController")
public class eventListController extends HttpServlet {
    
    private EventDAO eventDAO = new EventDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        Integer userId = (Integer) session.getAttribute("userId"); // Get UserID from session

        if (userRole == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Everyone gets to see 'Upcoming' events
            List<Event> upcomingEvents = eventDAO.findByStatus("Upcoming");
            request.setAttribute("events", upcomingEvents);

            // --- ADDED: Logic for student registration restriction ---
            List<Integer> registeredEventIds = new ArrayList<>();
            if ("Student".equals(userRole) && userId != null) {
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    // Fetch IDs of events the student already registered for
                    String sql = "SELECT EventID FROM eventregistration WHERE UserID = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, userId);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        registeredEventIds.add(rs.getInt("EventID"));
                    }
                } catch (Exception dbEx) {
                    dbEx.printStackTrace();
                } finally {
                    // Close resources here if not using a DAO method
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                }
            }
            // Pass the list of registered IDs to the JSP
            request.setAttribute("registeredEventIds", registeredEventIds);
            // ---------------------------------------------------------

            // Members and Advisors get extra categories
            if ("Member".equals(userRole) || "Advisor".equals(userRole)) {
                List<Event> approvedEvents = eventDAO.findByStatus("Approved");
                List<Event> rejectedEvents = eventDAO.findByStatus("Rejected");

                request.setAttribute("approvedEvents", approvedEvents);
                request.setAttribute("rejectedEvents", rejectedEvents);
            }

            request.getRequestDispatcher("eventList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading events: " + e.getMessage());
            request.getRequestDispatcher("eventList.jsp").forward(request, response);
        }
    }
}