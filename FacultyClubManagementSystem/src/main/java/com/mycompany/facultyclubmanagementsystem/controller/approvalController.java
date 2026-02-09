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
 * Combined Controller to handle Approve, Reject, and Delete actions.
 * @author Muhamad Zulhairie
 */
@WebServlet(name = "approvalController", urlPatterns = {"/approvalController"})
public class approvalController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get parameters from the form in advisorListApproval.jsp
        String appIDStr = request.getParameter("appID");
        String action = request.getParameter("action"); // Can be "Approved", "Rejected", or "Delete"
        
        if (appIDStr == null || action == null) {
            response.sendRedirect("advisorListApprovalController?error=invalid_params");
            return;
        }

        int appID = Integer.parseInt(appIDStr);
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // START TRANSACTION

            if ("Delete".equals(action)) {
                // ACTION: DELETE
                // We delete from 'event' first because it likely has a Foreign Key to 'clubeventapplication'
                String sqlDelEvent = "DELETE FROM event WHERE CEAppID = ?";
                PreparedStatement psDelEvent = conn.prepareStatement(sqlDelEvent);
                psDelEvent.setInt(1, appID);
                psDelEvent.executeUpdate();

                String sqlDelApp = "DELETE FROM clubeventapplication WHERE CEAppID = ?";
                PreparedStatement psDelApp = conn.prepareStatement(sqlDelApp);
                psDelApp.setInt(1, appID);
                psDelApp.executeUpdate();

                conn.commit(); // Commit the deletion
                response.sendRedirect("advisorListApprovalController?deleteSuccess=true");

            } else {
                // ACTION: APPROVE or REJECT
                
                // STEP 1: Update 'clubeventapplication' table
                String sqlApp = "UPDATE clubeventapplication SET CEAppStatus = ? WHERE CEAppID = ?";
                PreparedStatement psApp = conn.prepareStatement(sqlApp);
                psApp.setString(1, action);
                psApp.setInt(2, appID);
                psApp.executeUpdate();

                // STEP 2: Update 'event' table status
                String eventStatus = action.equals("Approved") ? "Upcoming" : "Rejected";
                
                String sqlEvent = "UPDATE event SET EventStatus = ? WHERE CEAppID = ?";
                PreparedStatement psEvent = conn.prepareStatement(sqlEvent);
                psEvent.setString(1, eventStatus);
                psEvent.setInt(2, appID);
                psEvent.executeUpdate();

                conn.commit(); // Commit both updates
                response.sendRedirect("advisorListApprovalController?success=1");
            }

        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (Exception ex) {} // Rollback if any step fails
            e.printStackTrace();
            response.sendRedirect("advisorListApprovalController?error=databaseError");
        } finally {
            if (conn != null) try { conn.close(); } catch (Exception ex) {} // Always close connection
        }
    }
}