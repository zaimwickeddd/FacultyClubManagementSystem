package com.mycompany.facultyclubmanagementsystem.dao;

import com.mycompany.facultyclubmanagementsystem.model.Faculty;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Faculty
 * Handles all database operations for faculties
 * 
 * @author Anderson Giggs
 */
public class FacultyDAO {
    
    /**
     * Find faculty by ID
     */
    public Faculty findById(int facultyID) {
        String sql = "SELECT * FROM faculty WHERE FacultyID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, facultyID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFaculty(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get all faculties
     */
    public List<Faculty> findAll() {
        List<Faculty> faculties = new ArrayList<>();
        String sql = "SELECT * FROM faculty ORDER BY FacultyName ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                faculties.add(mapResultSetToFaculty(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faculties;
    }
    
    /**
     * Create new faculty
     */
    public boolean create(Faculty faculty) {
        String sql = "INSERT INTO faculty (FacultyName) VALUES (?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, faculty.getFacultyName());
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Faculty> getAllFaculties() {
    List<Faculty> list = new ArrayList<>();
    // Order by name so the dropdown looks organized
    String sql = "SELECT FacultyID, FacultyName FROM faculty ORDER BY FacultyName ASC";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Faculty f = new Faculty();
            f.setFacultyID(rs.getInt("FacultyID"));
            f.setFacultyName(rs.getString("FacultyName"));
            list.add(f);
        }
    } catch (Exception e) { 
        e.printStackTrace(); 
    }
    return list;
}
    
    /**
     * Update existing faculty
     */
    public boolean update(Faculty faculty) {
        String sql = "UPDATE faculty SET FacultyName = ? WHERE FacultyID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, faculty.getFacultyName());
            ps.setInt(2, faculty.getFacultyID());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Delete faculty by ID
     */
    public boolean delete(int facultyId) {
        String sql = "DELETE FROM faculty WHERE FacultyID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, facultyId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Helper method to map ResultSet to Faculty object
     */
    private Faculty mapResultSetToFaculty(ResultSet rs) throws SQLException {
        Faculty faculty = new Faculty();
        faculty.setFacultyID(rs.getInt("FacultyID"));
        faculty.setFacultyName(rs.getString("FacultyName"));
        faculty.setCreatedAt(rs.getTimestamp("created_at"));
        faculty.setUpdatedAt(rs.getTimestamp("updated_at"));
        return faculty;
    }
}