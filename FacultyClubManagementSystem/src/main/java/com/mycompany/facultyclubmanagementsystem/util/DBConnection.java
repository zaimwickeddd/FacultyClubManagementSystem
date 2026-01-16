/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.facultyclubmanagementsystem.util;

/**
 *
 * @author Muhamad Zulhairie
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    // Database credentials
    // Note: Default phpMyAdmin/XAMPP username is 'root' with no password
    private static final String URL = "jdbc:mysql://localhost:3306/fcms";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load the MySQL Driver
            Class.forName(DRIVER);
            // Establish the connection
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database Connected Successfully!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Connection Failed! Check output console.");
            e.printStackTrace();
        }
        return conn;
    }
}
