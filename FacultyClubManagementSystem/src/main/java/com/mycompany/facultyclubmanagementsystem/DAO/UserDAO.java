package com.mycompany.facultyclubmanagementsystem.dao;

import com.mycompany.facultyclubmanagementsystem.model.User;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for User
 * Handles all database operations for users
 * 
 * @author Anderson Giggs
 */
public class UserDAO {
    
    /**
     * Find user by username or email and password (for login)
     */
    public User findByCredentials(String usernameOrEmail, String password) {
        String sql = "SELECT * FROM user WHERE (UserName = ? OR UserEmail = ?) AND UserPassword = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);
            ps.setString(3, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Find user by ID
     */
    public User findById(int userId) {
        String sql = "SELECT * FROM user WHERE UserID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Find user by email
     */
    public User findByEmail(String email) {
        String sql = "SELECT * FROM user WHERE UserEmail = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Create new user (registration)
     */
    public boolean create(User user) {
        String sql = "INSERT INTO user (UserName, UserPassword, UserEmail, UserPhone, " +
                     "UserSemester, UserRole, FacultyID, ClubID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getUserPassword());
            ps.setString(3, user.getUserEmail());
            ps.setString(4, user.getUserPhone());
            
            if (user.getUserSemester() != null) {
                ps.setInt(5, user.getUserSemester());
            } else {
                ps.setNull(5, Types.INTEGER);
            }
            
            ps.setString(6, user.getUserRole() != null ? user.getUserRole() : "Student");
            
            if (user.getFacultyId() != null) {
                ps.setInt(7, user.getFacultyId());
            } else {
                ps.setNull(7, Types.INTEGER);
            }
            
            if (user.getClubId() != null) {
                ps.setInt(8, user.getClubId());
            } else {
                ps.setNull(8, Types.INTEGER);
            }
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update existing user
     */
    public boolean update(User user) {
        String sql = "UPDATE user SET UserName = ?, UserEmail = ?, UserPhone = ?, " +
                     "UserSemester = ?, UserRole = ?, FacultyID = ?, ClubID = ? WHERE UserID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getUserEmail());
            ps.setString(3, user.getUserPhone());
            
            if (user.getUserSemester() != null) {
                ps.setInt(4, user.getUserSemester());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            
            ps.setString(5, user.getUserRole());
            
            if (user.getFacultyId() != null) {
                ps.setInt(6, user.getFacultyId());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            
            if (user.getClubId() != null) {
                ps.setInt(7, user.getClubId());
            } else {
                ps.setNull(7, Types.INTEGER);
            }
            
            ps.setInt(8, user.getUserId());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Delete user by ID
     */
    public boolean delete(int userId) {
        String sql = "DELETE FROM user WHERE UserID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get all users
     */
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    /**
     * Get users by role
     */
    public List<User> findByRole(String role) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE UserRole = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, role);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    /**
     * Get users by club
     */
    public List<User> findByClub(int clubId) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE ClubID = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, clubId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    /**
     * Helper method to map ResultSet to User object
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("UserID"));
        user.setUserName(rs.getString("UserName"));
        user.setUserPassword(rs.getString("UserPassword"));
        user.setUserEmail(rs.getString("UserEmail"));
        user.setUserPhone(rs.getString("UserPhone"));
        
        int semester = rs.getInt("UserSemester");
        user.setUserSemester(rs.wasNull() ? null : semester);
        
        user.setUserRole(rs.getString("UserRole"));
        
        int facultyId = rs.getInt("FacultyID");
        user.setFacultyId(rs.wasNull() ? null : facultyId);
        
        int clubId = rs.getInt("ClubID");
        user.setClubId(rs.wasNull() ? null : clubId);
        
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        return user;
    }
}