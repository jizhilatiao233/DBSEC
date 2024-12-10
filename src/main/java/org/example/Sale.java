package org.example;

import java.math.BigDecimal;

public class Sale {
    private int orderID;
    private int productID;
    private String productName; // productID -> TABLE Product -> ProductName
    private int staffID;
    private String staffName; // staffID -> TABLE Staff -> StaffName
    private int quantitySold;
    private BigDecimal sellingPrice;
    private BigDecimal actualPayment;
    private BigDecimal profit;
    private String salesDate;

    // Constructor
    public Sale(int orderID, int productID, String productName, int staffID, String staffName, int quantitySold, BigDecimal sellingPrice, BigDecimal actualPayment, BigDecimal profit, String salesDate) {
        this.orderID = orderID;
        this.productID = productID;
        this.productName = productName;
        this.staffID = staffID;
        this.staffName = staffName;
        this.quantitySold = quantitySold;
        this.sellingPrice = sellingPrice;
        this.actualPayment = actualPayment;
        this.profit = profit;
        this.salesDate = salesDate;
    }

    // Getters and Setters
    public int getOrderID() {
        return orderID;
    }
    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }
    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
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

    public int getQuantitySold() {
        return quantitySold;
    }
    public void setQuantitySold(int quantitySold) {
        this.quantitySold = quantitySold;
    }

    public BigDecimal getSellingPrice() {
        return sellingPrice;
    }
    public void setSellingPrice(BigDecimal sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public BigDecimal getActualPayment() {
        return actualPayment;
    }
    public void setActualPayment(BigDecimal actualPayment) {
        this.actualPayment = actualPayment;
    }

    public BigDecimal getProfit() {
        return profit;
    }
    public void setProfit(BigDecimal profit) {
        this.profit = profit;
    }

    public String getSalesDate() {
        return salesDate;
    }
    public void setSalesDate(String salesDate) {
        this.salesDate = salesDate;
    }
}