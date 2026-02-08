package com.mycompany.facultyclubmanagementsystem.dao;

import com.mycompany.facultyclubmanagementsystem.model.Club;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Club
 * Handles all database operations for clubs
 * 
 * @author Anderson Giggs
 */
public class ClubDAO {
    
    /**
     * Find club by ID
     */
    public Club findById(int clubId) {
        String sql = "SELECT c.*, f.FacultyName FROM club c " +
                     "LEFT JOIN faculty f ON c.FacultyID = f.FacultyID " +
                     "WHERE c.ClubID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, clubId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToClub(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Club> getAllClubs() {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT * FROM club"; // Based on your table image
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Club club = new Club();
                club.setClubId(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                clubs.add(club);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }
    
    /**
     * Get all clubs
     */
    public List<Club> findAll() {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT c.*, f.FacultyName FROM club c " +
                     "LEFT JOIN faculty f ON c.FacultyID = f.FacultyID " +
                     "ORDER BY c.ClubName ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                clubs.add(mapResultSetToClub(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }
    
    /**
     * Get clubs by faculty
     */
    public List<Club> findByFaculty(int facultyId) {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT c.*, f.FacultyName FROM club c " +
                     "LEFT JOIN faculty f ON c.FacultyID = f.FacultyID " +
                     "WHERE c.FacultyID = ? ORDER BY c.ClubName ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, facultyId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    clubs.add(mapResultSetToClub(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }
    
    /**
     * Create new club
     */
    public boolean create(Club club) {
        String sql = "INSERT INTO club (ClubName, ClubDescription, FacultyID) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, club.getClubName());
            ps.setString(2, club.getClubDescription());
            
            if (club.getFacultyId() != null) {
                ps.setInt(3, club.getFacultyId());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update existing club
     */
    public boolean update(Club club) {
        String sql = "UPDATE club SET ClubName = ?, ClubDescription = ?, FacultyID = ? WHERE ClubID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, club.getClubName());
            ps.setString(2, club.getClubDescription());
            
            if (club.getFacultyId() != null) {
                ps.setInt(3, club.getFacultyId());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            
            ps.setInt(4, club.getClubId());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Delete club by ID
     */
    public boolean delete(int clubId) {
        String sql = "DELETE FROM club WHERE ClubID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, clubId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get total club count
     */
    public int count() {
        String sql = "SELECT COUNT(*) FROM club";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Helper method to map ResultSet to Club object
     */
    private Club mapResultSetToClub(ResultSet rs) throws SQLException {
        Club club = new Club();
        club.setClubId(rs.getInt("ClubID"));
        club.setClubName(rs.getString("ClubName"));
        club.setClubDescription(rs.getString("ClubDescription"));
        
        int facultyId = rs.getInt("FacultyID");
        club.setFacultyId(rs.wasNull() ? null : facultyId);
        
        // For joined query
        club.setFacultyName(rs.getString("FacultyName"));
        
        //club.setCreatedAt(rs.getTimestamp("created_at"));
        //club.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        return club;
    }
}