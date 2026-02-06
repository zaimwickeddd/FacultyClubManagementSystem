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

@WebServlet("/eventListController")
public class eventListController extends HttpServlet {
    
    private EventDAO eventDAO = new EventDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        Integer userId = (Integer) session.getAttribute("userId");
        // 1. Get ClubID from session (Ensure this is set during login)
        Integer clubId = (Integer) session.getAttribute("clubId"); 

        if (userRole == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Event> filteredEvents = new ArrayList<>();
            
            // 2. Filter events by ClubID
            if (clubId != null) {
                // Assuming you update EventDAO to have a method: findByClub(int clubId)
                // For now, using a hypothetical method to demonstrate logic
                filteredEvents = eventDAO.findEventsByClub(clubId);
            }
            
            request.setAttribute("events", filteredEvents);

            // --- Logic for student registration restriction (unchanged) ---
            List<Integer> registeredEventIds = new ArrayList<>();
            if ("Student".equals(userRole) && userId != null) {
                // ... (rest of registration logic) ...
            }
            request.setAttribute("registeredEventIds", registeredEventIds);

            // Members and Advisors might need to see only their club's status
            if ("Member".equals(userRole) || "Advisor".equals(userRole)) {
                // Assuming similar filtering for approved/rejected
                List<Event> approvedEvents = eventDAO.findApprovedByClub(clubId);
                List<Event> rejectedEvents = eventDAO.findRejectedByClub(clubId);

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