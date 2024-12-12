package org.example;

import java.math.BigDecimal;

public class Product {
    private int productID;
    private String productName;
    private String category;
    private BigDecimal purchasePrice;
    private BigDecimal sellingPrice;
    private int shelfStock;
    private int warehouseStock;

    // Constructor
    public Product(int productID, String productName, String category, BigDecimal purchasePrice, BigDecimal sellingPrice, int shelfStock, int warehouseStock) {
        this.productID = productID;
        this.productName = productName;
        this.category = category;
        this.purchasePrice = purchasePrice;
        this.sellingPrice = sellingPrice;
        this.shelfStock = shelfStock;
        this.warehouseStock = warehouseStock;
    }

    // Getters and Setters
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

    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getPurchasePrice() {
        return purchasePrice;
    }
    public void setPurchasePrice(BigDecimal purchasePrice) {
        this.purchasePrice = purchasePrice;
    }

    public BigDecimal getSellingPrice() {
        return sellingPrice;
    }
    public void setSellingPrice(BigDecimal sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public int getShelfStock() {
        return shelfStock;
    }
    public void setShelfStock(int shelfStock) {
        this.shelfStock = shelfStock;
    }

    public int getWarehouseStock() {
        return warehouseStock;
    }
    public void setWarehouseStock(int warehouseStock) {
        this.warehouseStock = warehouseStock;
    }
}
