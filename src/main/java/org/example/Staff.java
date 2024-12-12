package org.example;

public class Staff {
    private int staffID;
    private String staffName;
    private String contactInfo;
    private String username;
    private String password;
    private String joinDate;
    private String position;
    private int adminID;
    private String adminName; // adminID -> TABLE Admin -> adminName

    // Constructor
    public Staff(int staffID, String staffName, String contactInfo, String username, String password, String joinDate, String position, int adminID, String adminName) {
        this.staffID = staffID;
        this.staffName = staffName;
        this.contactInfo = contactInfo;
        this.username = username;
        this.password = password;
        this.joinDate = joinDate;
        this.position = position;
        this.adminID = adminID;
        this.adminName = adminName;
    }

    // Getters and Setters
    public int getStaffID() {
        return staffID;
    }
    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getStaffName() {
        return staffName;
    }
    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getContactInfo() {
        return contactInfo;
    }
    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getJoinDate() {
        return joinDate;
    }
    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
    }

    public String getPosition() {
        return position;
    }
    public void setPosition(String position) {
        this.position = position;
    }

    public int getAdminID() {
        return adminID;
    }
    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }

    public String getAdminName() {
        return adminName;
    }
    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }
}
