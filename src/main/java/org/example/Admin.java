package org.example;

public class Admin {
    private int adminID;
    private String adminName;
    private String contactInfo;
    private String username;
    private String password;
    private String position;

    // Constructor
    public Admin(int adminID, String adminName, String contactInfo, String username, String password, String position) {
        this.adminID = adminID;
        this.adminName = adminName;
        this.contactInfo = contactInfo;
        this.username = username;
        this.password = password;
        this.position = position;
    }

    // Getters and Setters
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

    public String getPosition() {
        return position;
    }
    public void setPosition(String position) {
        this.position = position;
    }
}
