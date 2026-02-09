package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.EventDAO;
import com.mycompany.facultyclubmanagementsystem.model.Event;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors; // Added for filtering

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

        HttpSession session = request.getSession(false);

        // Safety check: user not logged in
        if (session == null || session.getAttribute("userRole") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");
        Integer userId = (Integer) session.getAttribute("userId");
        Integer clubId = (Integer) session.getAttribute("clubId");

        try {
        // 1. Load events safely
        List<Event> allEvents;

        if ("Student".equals(userRole)) {
            // STUDENTS see ALL events from EVERY club
            allEvents = eventDAO.findAll(); 

            // Filter out 'Rejected' events for Students
            List<Event> filteredEvents = allEvents.stream()
                    .filter(e -> !"Rejected".equals(e.getEventStatus()))
                    .collect(Collectors.toList());

            request.setAttribute("events", filteredEvents);
        } else {
            // MEMBERS and ADVISORS still only see their OWN club events
            if (clubId != null) {
                allEvents = eventDAO.findEventsByClub(clubId);
                request.setAttribute("events", allEvents);

                // 3. Approved & Rejected events for Member / Advisor ONLY
                List<Event> approvedEvents = eventDAO.findApprovedByClub(clubId);
                List<Event> rejectedEvents = eventDAO.findRejectedByClub(clubId);
                request.setAttribute("approvedEvents", approvedEvents);
                request.setAttribute("rejectedEvents", rejectedEvents);
            } else {
                request.setAttribute("events", new ArrayList<>());
            }
        }

        // 2. Student registration restriction (Keep this as is)
        if ("Student".equals(userRole) && userId != null) {
            List<Integer> registeredEventIds = getRegisteredEvents(userId);
            request.setAttribute("registeredEventIds", registeredEventIds);
        }

        request.getRequestDispatcher("eventList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading events: " + e.getMessage());
            request.getRequestDispatcher("eventList.jsp").forward(request, response);
        }
    }

    // Helper method (cleaner separation of DB logic)
    private List<Integer> getRegisteredEvents(Integer userId) {
        List<Integer> registeredEventIds = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT EventID FROM eventregistration WHERE UserID = ?")) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                registeredEventIds.add(rs.getInt("EventID"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return registeredEventIds;
    }
}