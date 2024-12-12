package org.example;

public class Customer {
    private int customerID;
    private String customerName;
    private String contactInfo;
    private String username;
    private String password;
    private String joinDate;
    private double totalConsumption;
    private int vipLevel;

    // Constructor
    public Customer(int customerID, String customerName, String contactInfo, String username, String password, String joinDate, double totalConsumption, int vipLevel) {
        this.customerID = customerID;
        this.customerName = customerName;
        this.contactInfo = contactInfo;
        this.username = username;
        this.password = password;
        this.joinDate = joinDate;
        this.totalConsumption = totalConsumption;
        this.vipLevel = vipLevel;
    }

    // Getters and Setters
    public int getCustomerID() {
        return customerID;
    }
    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
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

    public double getTotalConsumption() {
        return totalConsumption;
    }
    public void setTotalConsumption(double totalConsumption) {
        this.totalConsumption = totalConsumption;
    }

    public int getVipLevel() {
        return vipLevel;
    }
    public void setVipLevel(int vipLevel) {
        this.vipLevel = vipLevel;
    }
}
