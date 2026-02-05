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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller to display all events from the event table
 * Handles fetching and displaying event list for all user roles
 * 
 * @author Anderson Giggs
 */
@WebServlet("/eventListController")
public class eventListController extends HttpServlet {
    
    private EventDAO eventDAO = new EventDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if (userRole == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Everyone gets to see 'Upcoming' events
            List<Event> upcomingEvents = eventDAO.findByStatus("Upcoming");
            request.setAttribute("events", upcomingEvents);

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