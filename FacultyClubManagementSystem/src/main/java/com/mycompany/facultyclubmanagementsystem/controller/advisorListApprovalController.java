/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

/**
 *
 * @author Muhamad Zulhairie
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "advisorListApprovalController", urlPatterns = {"/advisorListApprovalController"})
public class advisorListApprovalController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Map<String, Object>> applicationList = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection()) {
            // SQL JOIN: Get app details + the name of the event it belongs to
            String sql = "SELECT a.CEAppID, e.EventName, a.EventCategory, a.EventBudget, " +
                         "a.CEAppStatus, a.ClubID " +
                         "FROM clubeventapplication a " +
                         "JOIN event e ON a.CEAppID = e.CEAppID " +
                         "ORDER BY a.CEAppID DESC";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("ceAppID", rs.getInt("CEAppID"));
                row.put("eventName", rs.getString("EventName"));
                row.put("eventCategory", rs.getString("EventCategory"));
                row.put("eventBudget", rs.getDouble("EventBudget"));
                row.put("ceAppStatus", rs.getString("CEAppStatus"));
                row.put("clubID", rs.getInt("ClubID"));
                applicationList.add(row);
            }
            
            // Pass the list to the JSP
            request.setAttribute("applicationList", applicationList);
            request.getRequestDispatcher("advisorListApproval.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=database");
        }
    }
}