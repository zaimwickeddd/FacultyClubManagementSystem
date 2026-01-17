package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.UserDAO;
import com.mycompany.facultyclubmanagementsystem.model.User;
import com.mycompany.facultyclubmanagementsystem.dao.EventDAO;
import com.mycompany.facultyclubmanagementsystem.model.Event;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/**
 * Authentication Controller
 * Handles user login and registration using the DAO pattern.
 * Corrected to match 'user' table and 'UserPassword' columns.
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
     * Handle user login logic
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // 1. Basic Validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=missing_credentials");
            return;
        }
        
        // 2. Find user via DAO (Matches 'UserPassword' in DB)
        User user = userDAO.findByCredentials(username, password);
        
        if (user != null) {
            // 3. Setup Session
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUserName());
            session.setAttribute("userRole", user.getUserRole()); // 'Student', 'Member', or 'Advisor'
            session.setAttribute("userClubID", user.getClubId());
            session.setAttribute("userFacultyID", user.getFacultyId());
            
            // 4. Fetch data for Dashboard visibility
            EventDAO eventDAO = new EventDAO();
            List<Event> upcoming = eventDAO.findUpcomingEvents();
            session.setAttribute("upcomingEvents", upcoming); 
            
            // 5. Successful Redirect
            response.sendRedirect("homepage.jsp");
        } else {
            // 6. Login Failed - Invalid credentials
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
    
    /**
     * Handle user registration logic
     */
    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String clubIdStr = request.getParameter("club_id");
        String facultyIdStr = request.getParameter("faculty_id");
        
        if (username == null || password == null || email == null) {
            response.sendRedirect("register.jsp?error=missing_fields");
            return;
        }
        
        // Check for existing user
        if (userDAO.findByEmail(email) != null) {
            response.sendRedirect("register.jsp?error=email_exists");
            return;
        }
        
        // Create new user object matching the 'user' table ENUM
        User newUser = new User();
        newUser.setUserName(username);
        newUser.setUserPassword(password);
        newUser.setUserEmail(email);
        newUser.setUserPhone(phone);
        newUser.setUserRole("Student"); // Default registration level
        
        try {
            if (clubIdStr != null) newUser.setClubId(Integer.parseInt(clubIdStr));
            if (facultyIdStr != null) newUser.setFacultyId(Integer.parseInt(facultyIdStr));
        } catch (NumberFormatException e) {
            // Log and ignore invalid numeric inputs
        }
        
        boolean success = userDAO.create(newUser);
        
        if (success) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            response.sendRedirect("register.jsp?error=registration_failed");
        }
    }
}