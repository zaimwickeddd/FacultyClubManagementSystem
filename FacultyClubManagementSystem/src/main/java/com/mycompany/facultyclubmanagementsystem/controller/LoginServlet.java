package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.UserDAO;
import com.mycompany.facultyclubmanagementsystem.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Login Servlet - Refactored to use DAO pattern
 * Alternative login endpoint (use authController instead for consistency)
 * 
 * @author Anderson Giggs
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form data
        String usernameOrEmail = request.getParameter("username"); 
        String password = request.getParameter("password");
        
        // Validate input
        if (usernameOrEmail == null || usernameOrEmail.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=missing_credentials");
            return;
        }

        try {
            // Find user by username or email
            User user = userDAO.findByCredentials(usernameOrEmail, password);
            
            if (user != null) {
                // User found - Create session
                HttpSession session = request.getSession();
                
                // Store user info in session
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userName", user.getUserName());
                session.setAttribute("userEmail", user.getUserEmail());
                session.setAttribute("userRole", user.getUserRole());
                session.setAttribute("clubId", user.getClubId());
                session.setAttribute("facultyId", user.getFacultyId());
                
                // Redirect to homepage
                response.sendRedirect("homepage.jsp");
                
            } else {
                // No user found
                response.sendRedirect("login.jsp?error=invalid");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=system_error");
        }
    }
}