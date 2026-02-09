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
 * Dedicated Servlet to handle the deletion of rejected applications.
 * Follows the pattern of UpdateProfileServlet.
 */
@WebServlet(name = "DeleteApplicationServlet", urlPatterns = {"/DeleteApplicationServlet"})
public class DeleteApplicationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the ID from the form
        String appIDStr = request.getParameter("eventId");
        
        if (appIDStr == null || appIDStr.trim().isEmpty()) {
            response.sendRedirect("advisorListApprovalController?error=invalid_id");
            return;
        }

        Connection conn = null;
        try {
            int appID = Integer.parseInt(appIDStr);
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start Transaction to ensure both tables are cleaned

            // 2. Delete from 'event' table first (Child table)
            String sqlEvent = "DELETE FROM event WHERE CEAppID = ?";
            try (PreparedStatement psEvent = conn.prepareStatement(sqlEvent)) {
                psEvent.setInt(1, appID);
                psEvent.executeUpdate();
            }

            // 3. Delete from 'clubeventapplication' table (Parent table)
            String sqlApp = "DELETE FROM clubeventapplication WHERE CEAppID = ?";
            try (PreparedStatement psApp = conn.prepareStatement(sqlApp)) {
                psApp.setInt(1, appID);
                int rowsDeleted = psApp.executeUpdate();

                if (rowsDeleted > 0) {
                    conn.commit(); // Success!
                    response.sendRedirect("advisorListApprovalController?deleteSuccess=true");
                } else {
                    conn.rollback();
                    response.sendRedirect("advisorListApprovalController?error=not_found");
                }
            }

        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            response.sendRedirect("advisorListApprovalController?error=databaseError");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception ex) { ex.printStackTrace(); }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Prevent direct URL access
        response.sendRedirect("advisorListApprovalController");
    }
}