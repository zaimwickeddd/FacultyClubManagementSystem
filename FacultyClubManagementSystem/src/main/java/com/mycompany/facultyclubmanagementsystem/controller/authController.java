package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.UserDAO;
import com.mycompany.facultyclubmanagementsystem.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/**
 * Authentication Controller - Refactored to use DAO pattern
 * Handles user login and registration
 * 
 * @author Anderson Giggs
 */
@WebServlet("/authController")
public class authController extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("register".equals(action)) {
                handleRegistration(request, response);
            } else if ("login".equals(action)) {
                handleLogin(request, response);
            } else {
                response.sendRedirect("login.jsp?error=invalid_action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=system_error");
        }
    }
    
    /**
     * Handle user registration
     */
    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String clubIdStr = request.getParameter("club_id");
        String facultyIdStr = request.getParameter("faculty_id");
        
        // Validate required fields
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=missing_fields");
            return;
        }
        
        // Check if email already exists
        User existingUser = userDAO.findByEmail(email);
        if (existingUser != null) {
            response.sendRedirect("register.jsp?error=email_exists");
            return;
        }
        
        // Create new user object
        User newUser = new User();
        newUser.setUserName(username);
        newUser.setUserPassword(password); // TODO: Hash password in production!
        newUser.setUserEmail(email);
        newUser.setUserPhone(phone);
        newUser.setUserRole("Student"); // Default role
        
        // Parse optional fields
        if (clubIdStr != null && !clubIdStr.trim().isEmpty()) {
            try {
                newUser.setClubId(Integer.parseInt(clubIdStr));
            } catch (NumberFormatException e) {
                // Invalid club ID, ignore
            }
        }
        
        if (facultyIdStr != null && !facultyIdStr.trim().isEmpty()) {
            try {
                newUser.setFacultyId(Integer.parseInt(facultyIdStr));
            } catch (NumberFormatException e) {
                // Invalid faculty ID, ignore
            }
        }
        
        // Save to database
        boolean success = userDAO.create(newUser);
        
        if (success) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            response.sendRedirect("register.jsp?error=registration_failed");
        }
    }
    
    /**
     * Handle user login
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=missing_credentials");
            return;
        }
        
        // Find user by credentials
        User user = userDAO.findByCredentials(username, password);
        
        if (user != null) {
            // Login successful - Create session
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUserName());
            session.setAttribute("userEmail", user.getUserEmail());
            session.setAttribute("userRole", user.getUserRole());
            session.setAttribute("userClubID", user.getClubId());
            session.setAttribute("userFacultyID", user.getFacultyId());
            
            // Redirect to homepage
            response.sendRedirect("homepage.jsp");
        } else {
            // Login failed
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}