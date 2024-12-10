package org.example;

public class Purchase {
    private int purchaseID;
    private int productID;
    private String productName; // productID -> TABLE Product -> ProductName
    private int quantityPurchased;
    private double purchasePrice;
    private double totalCost;
    private String purchaseDate;
    private int adminID;
    private String adminName; // adminID -> TABLE Admin -> AdminName
    private int supplierID;
    private String supplierName; // supplierID -> TABLE Supplier -> SupplierName

    // Constructor
    public Purchase(int purchaseID, int productID, String productName, int quantityPurchased, double purchasePrice, double totalCost, String purchaseDate, int adminID, String adminName, int supplierID, String supplierName) {
        this.purchaseID = purchaseID;
        this.productID = productID;
        this.productName = productName;
        this.quantityPurchased = quantityPurchased;
        this.purchasePrice = purchasePrice;
        this.totalCost = totalCost;
        this.purchaseDate = purchaseDate;
        this.adminID = adminID;
        this.adminName = adminName;
        this.supplierID = supplierID;
        this.supplierName = supplierName;
    }

    // Getters and Setters
    public int getPurchaseID() {
        return purchaseID;
    }
    public void setPurchaseID(int purchaseID) {
        this.purchaseID = purchaseID;
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

    public int getQuantityPurchased() {
        return quantityPurchased;
    }
    public void setQuantityPurchased(int quantityPurchased) {
        this.quantityPurchased = quantityPurchased;
    }

    public double getPurchasePrice() {
        return purchasePrice;
    }
    public void setPurchasePrice(double purchasePrice) {
        this.purchasePrice = purchasePrice;
    }

    public double getTotalCost() {
        return totalCost;
    }
    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public String getPurchaseDate() {
        return purchaseDate;
    }
    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;
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

    public int getSupplierID() {
        return supplierID;
    }
    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public String getSupplierName() {
        return supplierName;
    }
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
}
