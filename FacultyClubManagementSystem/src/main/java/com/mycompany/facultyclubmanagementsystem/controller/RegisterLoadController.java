package com.mycompany.facultyclubmanagementsystem.controller;

import com.mycompany.facultyclubmanagementsystem.dao.FacultyDAO;
import com.mycompany.facultyclubmanagementsystem.dao.ClubDAO;
import com.mycompany.facultyclubmanagementsystem.model.Faculty;
import com.mycompany.facultyclubmanagementsystem.model.Club;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterLoadController")
public class RegisterLoadController extends HttpServlet {
    
    private FacultyDAO facultyDAO = new FacultyDAO();
    private ClubDAO clubDAO = new ClubDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Fetch data using the DAO
        List<Faculty> facultyList = facultyDAO.getAllFaculties();
        List<Club> clubList = clubDAO.getAllClubs();
        
        // 2. Pass the list to the JSP
        request.setAttribute("facultyList", facultyList);
        request.setAttribute("clubList", clubList);
        
        // 3. Forward to the registration page
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}