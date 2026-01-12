/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.controller;

import java.io.IOException;
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
@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     * This method is called when the form in logout.jsp is submitted.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Fetch the existing session, but do NOT create a new one if it doesn't exist
        HttpSession session = request.getSession(false);

        if (session != null) {
            // 2. Destroy the session (clears "userName", "memberID", "status")
            session.invalidate();
        }

        // 3. Redirect the user back to the login page
        response.sendRedirect("login.jsp");
    }

    /**
     * Optional: Handle GET requests if you ever link to logout directly
     * via a URL (e.g., <a href="LogoutServlet">) instead of a form.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}