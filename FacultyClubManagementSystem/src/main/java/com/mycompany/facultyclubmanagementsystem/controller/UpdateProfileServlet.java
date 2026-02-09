package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet to handle profile updates for Email and Phone.
 */
@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/UpdateProfileServlet"})
public class UpdateProfileServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get the current session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // 2. Retrieve new data from the form
        String newEmail = request.getParameter("email");
        String newPhone = request.getParameter("phone");

        // 3. Basic Validation
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (newEmail == null || newEmail.trim().isEmpty() || 
            newPhone == null || newPhone.trim().isEmpty()) {
            response.sendRedirect("profile.jsp?error=empty_fields");
            return;
        }

        try {
            // 4. Update the database via DAO
            boolean isUpdated = userDAO.updateProfile(userId, newEmail, newPhone);

            if (isUpdated) {
                // 5. IMPORTANT: Update the session attributes immediately
                // This ensures the JSP shows the new data without needing a logout
                session.setAttribute("userEmail", newEmail);
                session.setAttribute("userPhone", newPhone);

                // 6. Redirect back to profile with a success message
                response.sendRedirect("profile.jsp?success=updated");
            } else {
                response.sendRedirect("profile.jsp?error=update_failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=system_error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to profile page if someone tries to access this via URL
        response.sendRedirect("profile.jsp");
    }
}