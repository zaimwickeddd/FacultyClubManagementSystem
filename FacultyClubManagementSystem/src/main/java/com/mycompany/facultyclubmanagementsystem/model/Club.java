package com.mycompany.facultyclubmanagementsystem.model;

import java.sql.Timestamp;

/**
 * Club Model/Entity Class
 * Represents a club in the faculty
 * 
 * @author Muhamad Zulhairie
 */
public class Club {
    
    private int clubId;
    private String clubName;
    private String clubDescription;
    private Integer facultyId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // For joined queries
    private String facultyName;
    
    // Constructors
    public Club() {
    }
    
    public Club(int clubId, String clubName, String clubDescription) {
        this.clubId = clubId;
        this.clubName = clubName;
        this.clubDescription = clubDescription;
    }
    
    // Full constructor
    public Club(int clubId, String clubName, String clubDescription, Integer facultyId) {
        this.clubId = clubId;
        this.clubName = clubName;
        this.clubDescription = clubDescription;
        this.facultyId = facultyId;
    }
    
    // Getters and Setters
    public int getClubId() {
        return clubId;
    }
    
    public void setClubId(int clubId) {
        this.clubId = clubId;
    }
    
    public String getClubName() {
        return clubName;
    }
    
    public void setClubName(String clubName) {
        this.clubName = clubName;
    }
    
    public String getClubDescription() {
        return clubDescription;
    }
    
    public void setClubDescription(String clubDescription) {
        this.clubDescription = clubDescription;
    }
    
    public Integer getFacultyId() {
        return facultyId;
    }
    
    public void setFacultyId(Integer facultyId) {
        this.facultyId = facultyId;
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
    
    public String getFacultyName() {
        return facultyName;
    }
    
    public void setFacultyName(String facultyName) {
        this.facultyName = facultyName;
    }
    
    @Override
    public String toString() {
        return "Club{" +
                "clubId=" + clubId +
                ", clubName='" + clubName + '\'' +
                ", facultyId=" + facultyId +
                '}';
    }
}