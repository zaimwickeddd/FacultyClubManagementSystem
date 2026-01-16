/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import com.mycompany.facultyclubmanagementsystem.model.Club;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
/**
 *
 * @author Muhamad Zulhairie
 */
@WebServlet(name = "clubServlet", urlPatterns = {"/clubServlet"})
public class clubServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Club club = null;
        // Using ClubID 1 (Compass) as requested
        int searchID = 1; 

        try (Connection conn = DBConnection.getConnection()) { // Using your existing class
            String sql = "SELECT c.clubName, c.ClubDescription, f.facultyName " +
                         "FROM clubs c " +
                         "JOIN faculty f ON c.facultyId = f.facultyId " +
                         "WHERE c.clubID = ?";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, searchID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                club = new Club();
                club.setClubName(rs.getString("clubName"));
                club.setClubDescription(rs.getString("ClubDescription"));
                club.setFacultyName(rs.getString("facultyName"));
            }

            request.setAttribute("clubData", club);
            request.getRequestDispatcher("clubPage.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        }
    }
}
