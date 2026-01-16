package com.mycompany.facultyclubmanagementsystem.model;

import java.sql.Timestamp;

/**
 * Faculty Model/Entity Class
 * Represents a faculty in UiTM
 * 
 * @author Anderson Giggs
 */
public class Faculty {
    
    private int facultyId;
    private String facultyName;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public Faculty() {
    }
    
    public Faculty(int facultyId, String facultyName) {
        this.facultyId = facultyId;
        this.facultyName = facultyName;
    }
    
    // Getters and Setters
    public int getFacultyId() {
        return facultyId;
    }
    
    public void setFacultyId(int facultyId) {
        this.facultyId = facultyId;
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
                "facultyId=" + facultyId +
                ", facultyName='" + facultyName + '\'' +
                '}';
    }
}