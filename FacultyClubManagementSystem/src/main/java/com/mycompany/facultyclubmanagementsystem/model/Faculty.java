package com.mycompany.facultyclubmanagementsystem.model;

import java.sql.Timestamp;

/**
 * Faculty Model/Entity Class
 * Represents a faculty in UiTM
 * 
 * @author Anderson Giggs
 */
public class Faculty {
    
    private int facultyID;
    private String facultyName;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public Faculty() {
    }
    
    public Faculty(int facultyID, String facultyName) {
        this.facultyID = facultyID;
        this.facultyName = facultyName;
    }
    
    // Getters and Setters
    public int getFacultyID() {
        return facultyID;
    }
    
    public void setFacultyID(int facultyID) {
        this.facultyID = facultyID;
    }
    
    public String getFacultyName() {
        return facultyName;
    }
    
    public void setFacultyName(String facultyName) {
        this.facultyName = facultyName;
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
    
    @Override
    public String toString() {
        return "Faculty{" +
                "facultyId=" + facultyID +
                ", facultyName='" + facultyName + '\'' +
                '}';
    }
}