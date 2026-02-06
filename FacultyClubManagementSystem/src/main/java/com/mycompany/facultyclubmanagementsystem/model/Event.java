package com.mycompany.facultyclubmanagementsystem.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

/**
 * Event Model/Entity Class
 * Represents an event organized by clubs
 * 
 * @author Anderson Giggs
 */
public class Event {
    
    private int eventId;
    private String eventName;
    private String eventDescription;
    private Date eventDate;
    private Time eventTime;
    private String eventVenue;
    private String eventStatus; // Upcoming, Ongoing, Completed, Cancelled
    private int eventAttendance;
    private Integer maxParticipants;
    private Integer ceAppId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private int clubId; 

    // Constructors
    public Event() {
    }
    
    public Event(int eventId, String eventName, Date eventDate, String eventVenue, String eventStatus) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.eventDate = eventDate;
        this.eventVenue = eventVenue;
        this.eventStatus = eventStatus;
    }
    
    // --- UPDATED FULL CONSTRUCTOR ---
    public Event(int eventId, String eventName, String eventDescription, Date eventDate, 
                 Time eventTime, String eventVenue, String eventStatus, int eventAttendance, 
                 Integer maxParticipants, Integer ceAppId, int clubId) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.eventDescription = eventDescription;
        this.eventDate = eventDate;
        this.eventTime = eventTime;
        this.eventVenue = eventVenue;
        this.eventStatus = eventStatus;
        this.eventAttendance = eventAttendance;
        this.maxParticipants = maxParticipants;
        this.ceAppId = ceAppId;
        this.clubId = clubId; // Set clubId
    }
    
    // Getters and Setters
    public int getEventId() {
        return eventId;
    }
    
    public void setEventId(int eventId) {
        this.eventId = eventId;
    }
    
    public String getEventName() {
        return eventName;
    }
    
    public void setEventName(String eventName) {
        this.eventName = eventName;
    }
    
    public String getEventDescription() {
        return eventDescription;
    }
    
    public void setEventDescription(String eventDescription) {
        this.eventDescription = eventDescription;
    }
    
    public Date getEventDate() {
        return eventDate;
    }
    
    public void setEventDate(Date eventDate) {
        this.eventDate = eventDate;
    }
    
    public Time getEventTime() {
        return eventTime;
    }
    
    public void setEventTime(Time eventTime) {
        this.eventTime = eventTime;
    }
    
    public String getEventVenue() {
        return eventVenue;
    }
    
    public void setEventVenue(String eventVenue) {
        this.eventVenue = eventVenue;
    }
    
    public String getEventStatus() {
        return eventStatus;
    }
    
    public void setEventStatus(String eventStatus) {
        this.eventStatus = eventStatus;
    }
    
    public int getEventAttendance() {
        return eventAttendance;
    }
    
    public void setEventAttendance(int eventAttendance) {
        this.eventAttendance = eventAttendance;
    }
    
    public Integer getMaxParticipants() {
        return maxParticipants;
    }
    
    public void setMaxParticipants(Integer maxParticipants) {
        this.maxParticipants = maxParticipants;
    }
    
    public Integer getCeAppId() {
        return ceAppId;
    }
    
    public void setCeAppId(Integer ceAppId) {
        this.ceAppId = ceAppId;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public int getClubId() {
        return clubId;
    }
    
    public void setClubId(int clubId) {
        this.clubId = clubId;
    }
    
    @Override
    public String toString() {
        return "Event{" +
                "eventId=" + eventId +
                ", eventName='" + eventName + '\'' +
                ", eventDate=" + eventDate +
                ", eventVenue='" + eventVenue + '\'' +
                ", eventStatus='" + eventStatus + '\'' +
                '}';
    }
}