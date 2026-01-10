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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Muhamad Zulhairie
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // 1. Get the data from the login form
    String user = request.getParameter("username");
    String pass = request.getParameter("password");

    // 2. Simple logic (In a real app, you check the DB here)
    if ("admin".equals(user) && "1234".equals(pass)) {
        
        // 3. CREATE A SESSION and store the user's name
        HttpSession session = request.getSession();
        session.setAttribute("userName", "Dr. James Anderson");
        session.setAttribute("memberID", "#FC-99281");
        session.setAttribute("status", "Active Member");

        // 4. Send them to the dashboard
        response.sendRedirect("dashboard.jsp");
    } else {
        // If wrong, send back to login with an error
        response.sendRedirect("login.jsp?error=invalid");
    }
}
}
