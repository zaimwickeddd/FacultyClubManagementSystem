package com.mycompany.facultyclubmanagementsystem.dao;

import com.mycompany.facultyclubmanagementsystem.model.User;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    public User findByCredentials(String username, String password) {
        // SQL only has 2 parameters
        String sql = "SELECT * FROM user WHERE UserName = ? AND UserPassword = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
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

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        // Matching your DB columns exactly
        user.setUserId(rs.getInt("UserID"));
        user.setUserName(rs.getString("UserName"));
        user.setUserPassword(rs.getString("UserPassword"));
        user.setUserEmail(rs.getString("UserEmail"));
        user.setUserPhone(rs.getString("UserPhone"));
        user.setUserSemester(rs.getInt("UserSemester"));
        
        // Handle Nullable Integers
        int semester = rs.getInt("UserSemester");
        user.setUserSemester(rs.wasNull() ? null : semester);
        
        // This is the String 'Advisor', 'Member', or 'Student'
        user.setUserRole(rs.getString("UserRole"));
        
        int facultyId = rs.getInt("FacultyID");
        user.setFacultyId(rs.wasNull() ? null : facultyId);
        
        int clubId = rs.getInt("ClubID");
        user.setClubId(rs.wasNull() ? null : clubId);
        
        // REMOVED: created_at and updated_at as they aren't in your DB screenshot
        
        return user;
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM user WHERE UserEmail = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToUser(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean create(User user) {
        String sql = "INSERT INTO user (UserName, UserPassword, UserEmail, UserPhone, " +
                     "UserSemester, UserRole, FacultyID, ClubID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getUserPassword());
            ps.setString(3, user.getUserEmail());
            ps.setString(4, user.getUserPhone());
            if (user.getUserSemester() != null) ps.setInt(5, user.getUserSemester());
            else ps.setNull(5, Types.INTEGER);
            ps.setString(6, user.getUserRole());
            if (user.getFacultyId() != null) ps.setInt(7, user.getFacultyId());
            else ps.setNull(7, Types.INTEGER);
            if (user.getClubId() != null) ps.setInt(8, user.getClubId());
            else ps.setNull(8, Types.INTEGER);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
    
    // Note: Updated findAll to remove order by created_at since column is missing
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user"; 
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return users;
    }
    
    public boolean updateProfile(int userId, String email, String phone) {
        String sql = "UPDATE user SET UserEmail = ?, UserPhone = ? WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, phone);
            ps.setInt(3, userId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}