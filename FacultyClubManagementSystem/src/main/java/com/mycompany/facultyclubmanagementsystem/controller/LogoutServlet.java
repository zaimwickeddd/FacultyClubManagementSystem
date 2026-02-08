package com.mycompany.facultyclubmanagementsystem.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;

/**
 * Enhanced Logout Servlet
 * Handles user logout with proper session cleanup and security
 * 
 * @author Enhanced Version - Feb 8, 2026
 * @originalAuthor Muhamad Zulhairie
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {

    /**
     * Handles the HTTP POST method for logout
     * Properly destroys session and clears all user data
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get the existing session (don't create a new one)
            HttpSession session = request.getSession(false);

            if (session != null) {
                // Log the logout action (optional - for audit trail)
                String userName = (String) session.getAttribute("userName");
                Integer userId = (Integer) session.getAttribute("userId");
                
                if (userName != null && userId != null) {
                    System.out.println("[LOGOUT] User logged out - ID: " + userId + ", Name: " + userName);
                }

                // 2. Clear all session attributes (belt and suspenders approach)
                session.removeAttribute("userId");
                session.removeAttribute("userName");
                session.removeAttribute("userEmail");
                session.removeAttribute("userRole");
                session.removeAttribute("clubId");
                session.removeAttribute("facultyId");
                session.removeAttribute("userPhone");
                session.removeAttribute("userSemester");

                // 3. Invalidate the entire session
                session.invalidate();
            }

            // 4. Clear any authentication cookies (if you use them)
            clearAuthenticationCookies(request, response);

            // 5. Prevent caching of protected pages
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            // 6. Redirect to login page with success message
            response.sendRedirect("login.jsp?logout=success");

        } catch (Exception e) {
            // Log the error
            System.err.println("[LOGOUT ERROR] Exception during logout: " + e.getMessage());
            e.printStackTrace();
            
            // Still redirect to login even if there's an error
            response.sendRedirect("login.jsp?error=logout_failed");
        }
    }

    /**
     * Handles the HTTP GET method
     * Redirects to logout confirmation page
     * This prevents accidental logouts from clicking a link
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if there's a 'confirm' parameter
        String confirm = request.getParameter("confirm");
        
        if ("yes".equals(confirm)) {
            // User confirmed logout via URL parameter
            doPost(request, response);
        } else {
            // Redirect to confirmation page
            response.sendRedirect("Logout.jsp");
        }
    }

    /**
     * Clear authentication cookies
     * Removes any cookies that might be used for authentication
     *
     * @param request servlet request
     * @param response servlet response
     */
    private void clearAuthenticationCookies(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                // Clear common authentication cookie names
                if (cookie.getName().equals("JSESSIONID") || 
                    cookie.getName().equals("sessionId") ||
                    cookie.getName().startsWith("auth")) {
                    
                    cookie.setValue("");
                    cookie.setPath("/");
                    cookie.setMaxAge(0); // Delete the cookie
                    response.addCookie(cookie);
                }
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Enhanced Logout Servlet - Handles user logout with proper session cleanup";
    }
}