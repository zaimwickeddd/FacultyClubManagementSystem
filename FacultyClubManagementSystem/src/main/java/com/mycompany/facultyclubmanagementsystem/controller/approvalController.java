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

/**
 *
 * @author Muhamad Zulhairie
 */
@WebServlet(name = "approvalController", urlPatterns = {"/approvalController"})
public class approvalController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get parameters from the form in advisorListApproval.jsp
        String appIDStr = request.getParameter("appID");
        String action = request.getParameter("action"); // "Approved" or "Rejected"
        
        if (appIDStr == null || action == null) {
            response.sendRedirect("advisorListApproval.jsp?error=invalid_params");
            return;
        }

        int appID = Integer.parseInt(appIDStr);
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // START TRANSACTION

            // STEP 1: Update 'clubeventapplication' table
            String sqlApp = "UPDATE clubeventapplication SET CEAppStatus = ? WHERE CEAppID = ?";
            PreparedStatement psApp = conn.prepareStatement(sqlApp);
            psApp.setString(1, action);
            psApp.setInt(2, appID);
            psApp.executeUpdate();

            // STEP 2: Update 'event' table status
            // --- MODIFIED: If Approved -> "Approved", If Rejected -> "Rejected" ---
            String eventStatus = action.equals("Approved") ? "Approved" : "Rejected";
            // ----------------------------------------------------------------------
            
            String sqlEvent = "UPDATE event SET EventStatus = ? WHERE CEAppID = ?";
            PreparedStatement psEvent = conn.prepareStatement(sqlEvent);
            psEvent.setString(1, eventStatus);
            psEvent.setInt(2, appID);
            psEvent.executeUpdate();

            // STEP 3: Commit both updates
            conn.commit(); 
            response.sendRedirect("advisorListApprovalController?success=1");

        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
            response.sendRedirect("advisorListApprovalController?error=1");
        } finally {
            if (conn != null) try { conn.close(); } catch (Exception ex) {}
        }
    }
}