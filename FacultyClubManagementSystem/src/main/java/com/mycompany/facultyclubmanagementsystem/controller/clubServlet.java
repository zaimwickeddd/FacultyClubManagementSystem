package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.ClubDAO;
import com.mycompany.facultyclubmanagementsystem.model.Club;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/**
 * Club Servlet - Refactored to use DAO pattern
 * Handles displaying club information
 * 
 * @author Anderson Giggs
 */
@WebServlet(name = "clubServlet", urlPatterns = {"/clubServlet"})
public class clubServlet extends HttpServlet {
    
    private ClubDAO clubDAO = new ClubDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get club ID from parameter (default to 1 if not provided)
        String clubIdParam = request.getParameter("clubId");
        int clubId = 1; // Default club ID
        
        if (clubIdParam != null && !clubIdParam.trim().isEmpty()) {
            try {
                clubId = Integer.parseInt(clubIdParam);
            } catch (NumberFormatException e) {
                // Invalid club ID, use default
            }
        }
        
        try {
            // Fetch club data using DAO
            Club club = clubDAO.findById(clubId);
            
            if (club != null) {
                // Club found - set attribute and forward
                request.setAttribute("clubData", club);
                request.getRequestDispatcher("clubPage.jsp").forward(request, response);
            } else {
                // Club not found
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Club not found");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "System Error");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle club creation/update if needed
        doGet(request, response);
    }
}