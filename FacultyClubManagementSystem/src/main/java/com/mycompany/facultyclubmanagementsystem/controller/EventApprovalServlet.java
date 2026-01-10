/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Muhamad Zulhairie
 */
@WebServlet("/EventApprovalServlet")
public class EventApprovalServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get the data from the hidden input and the button clicked
        String eventId = request.getParameter("eventId");
        String action = request.getParameter("action");

        // 2. Process the decision
        if (action.equals("approve")) {
            System.out.println("Event ID " + eventId + " has been APPROVED.");
            // Logic: Update status to 'Approved' in Database here
        } else if (action.equals("reject")) {
            System.out.println("Event ID " + eventId + " has been REJECTED.");
            // Logic: Update status to 'Rejected' in Database here
        }

        // 3. Send the admin back to the list with a success message
        response.sendRedirect("eventApproval.jsp?status=updated");
    }
}
