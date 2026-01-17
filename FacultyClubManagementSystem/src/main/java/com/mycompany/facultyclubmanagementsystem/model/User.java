package com.mycompany.facultyclubmanagementsystem.model;

import java.sql.Timestamp;

/**
 * User Model/Entity Class
 * Represents a user in the system (Student/Member/Advisor/Admin)
 * 
 * @author Anderson Giggs 
 */
public class User {
    
    private int userId;
    private String userName;
    private String userPassword;
    private String userEmail;
    private String userPhone;
    private Integer userSemester;
    private String userRole; // Student, Member, Advisor
    private Integer facultyId;
    private Integer clubId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public User() {
    }
    
    public User(int userId, String userName, String userEmail, String userRole) {
        this.userId = userId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userRole = userRole;
    }
    
    // Full constructor
    public User(int userId, String userName, String userPassword, String userEmail, 
                String userPhone, Integer userSemester, String userRole, 
                Integer facultyId, Integer clubId) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userPhone = userPhone;
        this.userSemester = userSemester;
        this.userRole = userRole;
        this.facultyId = facultyId;
        this.clubId = clubId;
    }
    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getUserPassword() {
        return userPassword;
    }
    
    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    
    public String getUserPhone() {
        return userPhone;
    }
    
    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }
    
    public Integer getUserSemester() {
        return userSemester;
    }
    
    public void setUserSemester(Integer userSemester) {
        this.userSemester = userSemester;
    }
    
    public String getUserRole() {
        return userRole;
    }
    
    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }
    
    public Integer getFacultyId() {
        return facultyId;
    }
    
    public void setFacultyId(Integer facultyId) {
        this.facultyId = facultyId;
    }
    
    public Integer getClubId() {
        return clubId;
    }
    
    public void setClubId(Integer clubId) {
        this.clubId = clubId;
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
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userRole='" + userRole + '\'' +
                '}';
    }
}