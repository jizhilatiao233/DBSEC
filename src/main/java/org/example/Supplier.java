package org.example;

public class Supplier {
    private int supplierID;
    private String supplierName;
    private String contactInfo;

    // Constructor
    public Supplier(int supplierID, String supplierName, String contactInfo) {
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.contactInfo = contactInfo;
    }

    // Getters and Setters
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

    public String getContactInfo() {
        return contactInfo;
    }
    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }
}
