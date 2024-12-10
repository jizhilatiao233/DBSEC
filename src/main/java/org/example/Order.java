package org.example;

import java.math.BigDecimal;

public class Order {
    private int orderID;
    private int customerID;
    private String customerName; // customerID -> TABLE Customer -> customerName
    private int staffID;
    private String staffName; // staffID -> TABLE Staff -> staffName
    private BigDecimal totalAmount;
    private BigDecimal actualPayment;
    private String orderDate;

    // Constructor
    public Order(int orderID, int customerID, String customerName, int staffID, String staffName, BigDecimal totalAmount, BigDecimal actualPayment, String orderDate) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.customerName = customerName;
        this.staffID = staffID;
        this.staffName = staffName;
        this.totalAmount = totalAmount;
        this.actualPayment = actualPayment;
        this.orderDate = orderDate;
    }

    // Getters and Setters
    public int getOrderID() {
        return orderID;
    }
    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

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

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getActualPayment() {
        return actualPayment;
    }
    public void setActualPayment(BigDecimal actualPayment) {
        this.actualPayment = actualPayment;
    }

    public String getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }
}
