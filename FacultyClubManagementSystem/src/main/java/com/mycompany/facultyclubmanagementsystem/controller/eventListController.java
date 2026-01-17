/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.EventDAO;
import com.mycompany.facultyclubmanagementsystem.model.Event;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Muhamad Zulhairie
 */


@WebServlet("/eventListController")
public class eventListController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        // Retrieve the club name from the session
        String userClub = (String) session.getAttribute("userClub");

        // Redirect to login if no session exists
        if (userClub == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, String>> eventList = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection()) {
            // Filter query by the user's club
            String sql = "SELECT * FROM events WHERE club_name = ? ORDER BY start_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userClub);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, String> event = new HashMap<>();
                event.put("title", rs.getString("title"));
                event.put("date", rs.getString("start_date"));
                event.put("venue", rs.getString("venue"));
                event.put("status", rs.getString("status"));
                eventList.add(event);
            }
            
            request.setAttribute("events", eventList);
            request.setAttribute("clubName", userClub);
            request.getRequestDispatcher("eventList.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
