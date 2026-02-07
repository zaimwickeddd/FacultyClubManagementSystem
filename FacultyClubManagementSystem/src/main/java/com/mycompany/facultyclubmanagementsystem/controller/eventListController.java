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

            // 1. Load events for club safely
            if (clubId != null) {
                List<Event> events = eventDAO.findEventsByClub(clubId);
                request.setAttribute("events", events);
            } else {
                request.setAttribute("events", new ArrayList<>());
                request.setAttribute("errorMessage", "No club assigned to this user.");
            }

            // 2. Student registration restriction
            if ("Student".equals(userRole) && userId != null) {
                List<Integer> registeredEventIds = getRegisteredEvents(userId);
                request.setAttribute("registeredEventIds", registeredEventIds);
            }

            // 3. Approved & Rejected events for Member / Advisor
            if (clubId != null &&
                ("Member".equals(userRole) || "Advisor".equals(userRole))) {

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
