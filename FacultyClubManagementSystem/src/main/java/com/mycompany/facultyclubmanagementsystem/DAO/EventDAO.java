package com.mycompany.facultyclubmanagementsystem.dao;

import com.mycompany.facultyclubmanagementsystem.model.Event;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Event
 * Handles all database operations for events
 * 
 * @author Anderson Giggs
 */
public class EventDAO {
    
    /**
     * Find event by ID
     */
    public Event findById(int eventId) {
        String sql = "SELECT * FROM event WHERE EventID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, eventId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEvent(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get all events
     */
    public List<Event> findAll() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM event ORDER BY EventDate DESC, EventTime DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    
    /**
     * Get events by status
     */
    public List<Event> findByStatus(String status) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM event WHERE EventStatus = ? ORDER BY EventDate DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    events.add(mapResultSetToEvent(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    
    /**
     * Get upcoming events
     */
    public List<Event> findUpcomingEvents() {
        List<Event> events = new ArrayList<>();
        // Using the exact table name 'events' from your screenshot
        String sql = "SELECT EventName, EventDate FROM events WHERE EventDate >= CURDATE() " +
                     "AND EventStatus = 'Upcoming' ORDER BY EventDate ASC LIMIT 3";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Event event = new Event();
                // Matching your database attribute names exactly
                event.setEventName(rs.getString("EventName"));
                event.setEventDate(rs.getDate("EventDate"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    
    /**
     * Create new event
     */
    public boolean create(Event event) {
        String sql = "INSERT INTO event (EventName, EventDescription, EventDate, EventTime, " +
                     "EventVenue, EventStatus, EventAttendance, MaxParticipants, CEAppID) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, event.getEventName());
            ps.setString(2, event.getEventDescription());
            ps.setDate(3, event.getEventDate());
            ps.setTime(4, event.getEventTime());
            ps.setString(5, event.getEventVenue());
            ps.setString(6, event.getEventStatus() != null ? event.getEventStatus() : "Upcoming");
            ps.setInt(7, event.getEventAttendance());
            
            if (event.getMaxParticipants() != null) {
                ps.setInt(8, event.getMaxParticipants());
            } else {
                ps.setNull(8, Types.INTEGER);
            }
            
            if (event.getCeAppId() != null) {
                ps.setInt(9, event.getCeAppId());
            } else {
                ps.setNull(9, Types.INTEGER);
            }
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update existing event
     */
    public boolean update(Event event) {
        String sql = "UPDATE event SET EventName = ?, EventDescription = ?, EventDate = ?, " +
                     "EventTime = ?, EventVenue = ?, EventStatus = ?, EventAttendance = ?, " +
                     "MaxParticipants = ? WHERE EventID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, event.getEventName());
            ps.setString(2, event.getEventDescription());
            ps.setDate(3, event.getEventDate());
            ps.setTime(4, event.getEventTime());
            ps.setString(5, event.getEventVenue());
            ps.setString(6, event.getEventStatus());
            ps.setInt(7, event.getEventAttendance());
            
            if (event.getMaxParticipants() != null) {
                ps.setInt(8, event.getMaxParticipants());
            } else {
                ps.setNull(8, Types.INTEGER);
            }
            
            ps.setInt(9, event.getEventId());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update event status
     */
    public boolean updateStatus(int eventId, String status) {
        String sql = "UPDATE event SET EventStatus = ? WHERE EventID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, eventId);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update event attendance count
     */
    public boolean updateAttendance(int eventId, int attendance) {
        String sql = "UPDATE event SET EventAttendance = ? WHERE EventID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, attendance);
            ps.setInt(2, eventId);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Delete event by ID
     */
    public boolean delete(int eventId) {
        String sql = "DELETE FROM event WHERE EventID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, eventId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get event count by status
     */
    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM event WHERE EventStatus = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    
    
    /**
     * Helper method to map ResultSet to Event object
     */
    private Event mapResultSetToEvent(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setEventId(rs.getInt("EventID"));
        event.setEventName(rs.getString("EventName"));
        event.setEventDescription(rs.getString("EventDescription"));
        event.setEventDate(rs.getDate("EventDate"));
        event.setEventTime(rs.getTime("EventTime"));
        event.setEventVenue(rs.getString("EventVenue"));
        event.setEventStatus(rs.getString("EventStatus"));
        event.setEventAttendance(rs.getInt("EventAttendance"));
        
        int maxParticipants = rs.getInt("MaxParticipants");
        event.setMaxParticipants(rs.wasNull() ? null : maxParticipants);
        
        int ceAppId = rs.getInt("CEAppID");
        event.setCeAppId(rs.wasNull() ? null : ceAppId);
        
        event.setCreatedAt(rs.getTimestamp("created_at"));
        event.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        return event;
    }
}