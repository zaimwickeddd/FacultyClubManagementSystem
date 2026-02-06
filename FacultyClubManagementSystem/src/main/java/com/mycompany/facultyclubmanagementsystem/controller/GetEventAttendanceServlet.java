/*
 * Document added : getEventAttendance
 * Created on : 06 Feb 2026, 1:00 PM
 * Author     : Gi995tzy
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "getEventAttendance", urlPatterns = {"/getEventAttendance"})
public class GetEventAttendanceServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String eventId = request.getParameter("eventId");
        
        try {
            Connection conn = DBConnection.getConnection();
            
            // Get event attendance
            String sqlEvent = "SELECT EventAttendance FROM event WHERE EventID = ?";
            PreparedStatement psEvent = conn.prepareStatement(sqlEvent);
            psEvent.setInt(1, Integer.parseInt(eventId));
            ResultSet rsEvent = psEvent.executeQuery();
            
            int attendance = 0;
            if (rsEvent.next()) {
                attendance = rsEvent.getInt("EventAttendance");
            }
            rsEvent.close();
            psEvent.close();
            
            // Get total registered for this event
            String sqlReg = "SELECT COUNT(*) as total FROM eventregistration WHERE EventID = ?";
            PreparedStatement psReg = conn.prepareStatement(sqlReg);
            psReg.setInt(1, Integer.parseInt(eventId));
            ResultSet rsReg = psReg.executeQuery();
            
            int registered = 0;
            if (rsReg.next()) {
                registered = rsReg.getInt("total");
            }
            rsReg.close();
            psReg.close();
            
            conn.close();
            
            // Manual JSON creation
            String json = "{\"attendance\":" + attendance + ",\"registered\":" + registered + ",\"success\":true}";
            out.print(json);
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
        }
        
        out.flush();
    }
}