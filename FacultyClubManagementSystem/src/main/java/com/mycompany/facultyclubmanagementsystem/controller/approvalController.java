package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.EventDAO;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Added for session management

/**
 * Combined Controller to handle Approve, Reject, Delete, and Dashboard Stats.
 */
@WebServlet(name = "approvalController", urlPatterns = {"/approvalController"})
public class approvalController extends HttpServlet {

    /**
     * Handles GET requests: Fetches counts for the Advisor Dashboard
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        Integer facultyId = (Integer) session.getAttribute("facultyId");

        // If user is an Advisor, calculate the fresh stats
        if ("Advisor".equalsIgnoreCase(userRole) && facultyId != null) {
            EventDAO dao = new EventDAO();
            
            // Use the DAO methods to fetch data based on the Faculty ID
            int approved = dao.countApprovedByFaculty(facultyId); 
            int rejected = dao.countRejectedByFaculty(facultyId); 
            
            // Store counts in session so clubPage.jsp can display them
            session.setAttribute("approvedCount", approved);
            session.setAttribute("rejectedCount", rejected);
        }

        // Redirect to the dashboard view
        response.sendRedirect("clubPage.jsp");
    }

    /**
     * Handles POST requests: Approve, Reject, and Delete actions from the list
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appIDStr = request.getParameter("appID");
        String action = request.getParameter("action"); 
        
        if (appIDStr == null || action == null) {
            response.sendRedirect("advisorListApprovalController?error=invalid_params");
            return;
        }

        int appID = Integer.parseInt(appIDStr);
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); 

            if ("Delete".equals(action)) {
                // ACTION: DELETE
                String sqlDelEvent = "DELETE FROM event WHERE CEAppID = ?";
                try (PreparedStatement psDelEvent = conn.prepareStatement(sqlDelEvent)) {
                    psDelEvent.setInt(1, appID);
                    psDelEvent.executeUpdate();
                }

                String sqlDelApp = "DELETE FROM clubeventapplication WHERE CEAppID = ?";
                try (PreparedStatement psDelApp = conn.prepareStatement(sqlDelApp)) {
                    psDelApp.setInt(1, appID);
                    psDelApp.executeUpdate();
                }

                conn.commit();
                response.sendRedirect("advisorListApprovalController?deleteSuccess=true");

            } else {
                // ACTION: APPROVE or REJECT
                String sqlApp = "UPDATE clubeventapplication SET CEAppStatus = ? WHERE CEAppID = ?";
                try (PreparedStatement psApp = conn.prepareStatement(sqlApp)) {
                    psApp.setString(1, action);
                    psApp.setInt(2, appID);
                    psApp.executeUpdate();
                }

                String eventStatus = action.equals("Approved") ? "Upcoming" : "Rejected";
                
                String sqlEvent = "UPDATE event SET EventStatus = ? WHERE CEAppID = ?";
                try (PreparedStatement psEvent = conn.prepareStatement(sqlEvent)) {
                    psEvent.setString(1, eventStatus);
                    psEvent.setInt(2, appID);
                    psEvent.executeUpdate();
                }

                conn.commit();
                response.sendRedirect("advisorListApprovalController?success=1");
            }

        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
            response.sendRedirect("advisorListApprovalController?error=databaseError");
        } finally {
            if (conn != null) try { conn.close(); } catch (Exception ex) {}
        }
    }
}