package com.mycompany.facultyclubmanagementsystem.dao;

import com.mycompany.facultyclubmanagementsystem.model.Event;
import java.sql.*;
import com.mycompany.facultyclubmanagementsystem.util.DBConnection; // To connect to your MySQL DB
import java.sql.Connection; // To manage the connection object
import java.sql.PreparedStatement; // To execute the SELECT queries
import java.sql.ResultSet; // To hold the data returned from the DB
import java.sql.SQLException; // To handle database errors
import java.util.ArrayList; // To create the list of events
import java.util.HashMap; // To store event details as key-value pairs
import java.util.List; // For the List interface
import java.util.Map; // For the Map interface
import jakarta.servlet.http.HttpServletRequest; // To accept the request object in your method
import jakarta.servlet.http.HttpSession; // To save data to the session for the homepage

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
        // Using the exact table name 'event' from your screenshot
        String sql = "SELECT EventName, EventDate FROM event WHERE EventDate >= CURDATE() " +
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
    
    public void getEventStatus(HttpServletRequest request) {
        // 1. Declare the lists (This fixes the 'cannot find symbol' error)
        List<Map<String, String>> upcomingEvents = new ArrayList<>();
        List<Map<String, String>> eventStatuses = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            // 2. Fetch Upcoming Events (Middle Card)
            // This gets the next 3 events by date
            String sqlUpcoming = "SELECT EventName, EventDate FROM event ORDER BY EventDate ASC LIMIT 3";
            PreparedStatement ps1 = conn.prepareStatement(sqlUpcoming);
            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                Map<String, String> event = new HashMap<>();
                event.put("name", rs1.getString("EventName"));
                event.put("date", rs1.getString("EventDate"));
                upcomingEvents.add(event);
            }

            // 3. Fetch Event Statuses (Right Card) 
            // This JOIN connects 'event' to 'eventregistration' to get the REAL status
            String sqlStatus = "SELECT e.EventName, r.RegisStatus " +
                               "FROM event e " +
                               "JOIN eventregistration r ON e.EventID = r.EventID " +
                               "ORDER BY r.RegisDate DESC LIMIT 3";

            PreparedStatement ps2 = conn.prepareStatement(sqlStatus);
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                Map<String, String> statusMap = new HashMap<>();
                statusMap.put("name", rs2.getString("EventName"));
                // This pulls 'APPROVED', 'REJECTED', or 'PENDING' from the DB
                statusMap.put("status", rs2.getString("RegisStatus")); 
                eventStatuses.add(statusMap);
            }

            // 4. Save to Session so the Homepage can see the data
            HttpSession session = request.getSession();
            session.setAttribute("upcomingEvents", upcomingEvents);
            session.setAttribute("userStatuses", eventStatuses);

        } catch (SQLException e) {
            e.printStackTrace();
        }
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
    
    public List<Map<String, String>> getUserEventStatuses(int userId) {
        List<Map<String, String>> statuses = new ArrayList<>();
        // JOIN matches the EventID from both tables to get Name and Status
        // Note: Using your new shortened name 'RegisStatus'
        String sql = "SELECT e.EventName, r.RegisStatus " +
                     "FROM event e JOIN eventregistration r ON e.EventID = r.EventID " +
                     "WHERE r.UserID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("name", rs.getString("EventName"));
                    map.put("status", rs.getString("RegisStatus")); // Updated here
                    statuses.add(map);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return statuses;
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
        
        // Try to get timestamps if they exist in the table
        try {
            event.setCreatedAt(rs.getTimestamp("created_at"));
            event.setUpdatedAt(rs.getTimestamp("updated_at"));
        } catch (SQLException e) {
            // Columns don't exist, skip them
        }
        
        return event;
    }
}