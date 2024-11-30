package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String action = request.getParameter("action");

        try (Connection conn = DatabaseConnection.getConnection()) {
            if ("details".equals(action)) {
                // View product details
                int productId = Integer.parseInt(request.getParameter("productId"));
                String query = "SELECT * FROM Product WHERE ProductID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, productId);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        Product product = new Product(
                                rs.getInt("ProductID"),
                                rs.getString("ProductName"),
                                rs.getString("Category"),
                                rs.getBigDecimal("PurchasePrice"),
                                rs.getBigDecimal("SellingPrice"),
                                rs.getInt("ShelfStock"),
                                rs.getInt("WarehouseStock")
                        );
                        request.setAttribute("product", product);
                        request.getRequestDispatcher("product_details.jsp").forward(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    }
                }
            } else {
                // Default action: list all products
                String query = "SELECT * FROM Product";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    ResultSet rs = stmt.executeQuery();
                    List<Product> products = new ArrayList<>();
                    while (rs.next()) {
                        products.add(new Product(
                                rs.getInt("ProductID"),
                                rs.getString("ProductName"),
                                rs.getString("Category"),
                                rs.getBigDecimal("PurchasePrice"),
                                rs.getBigDecimal("SellingPrice"),
                                rs.getInt("ShelfStock"),
                                rs.getInt("WarehouseStock")
                        ));
                    }
                    request.setAttribute("products", products);
                    request.getRequestDispatcher("product_list.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database error occurred", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String action = request.getParameter("action");

        try (Connection conn = DatabaseConnection.getConnection()) {
            if ("purchase".equals(action)) {
                // Handle product purchase
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String customerName = request.getParameter("customerName");
                String contactInfo = request.getParameter("contactInfo");

                // Decrease stock and log purchase
                String updateStockQuery = "UPDATE Product SET ShelfStock = ShelfStock - ? WHERE ProductID = ?";
                String insertSalesQuery = "INSERT INTO Sales (ProductID, CustomerID, QuantitySold, SellingPrice, Profit) VALUES (?, ?, ?, ?, ?)";

                try (PreparedStatement updateStmt = conn.prepareStatement(updateStockQuery);
                     PreparedStatement insertStmt = conn.prepareStatement(insertSalesQuery)) {
                    updateStmt.setInt(1, quantity);
                    updateStmt.setInt(2, productId);
                    updateStmt.executeUpdate();

                    // Assuming customerID is auto-generated or provided
                    insertStmt.setInt(1, productId);
                    insertStmt.setNull(2, java.sql.Types.INTEGER); // Update with actual customer ID if logged in
                    insertStmt.setInt(3, quantity);
                    insertStmt.setBigDecimal(4, getSellingPrice(conn, productId));
                    insertStmt.setBigDecimal(5, calculateProfit(conn, productId, quantity));
                    insertStmt.executeUpdate();

                    request.setAttribute("message", "Purchase successful!");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error processing request", e);
        }
    }

    private java.math.BigDecimal getSellingPrice(Connection conn, int productId) throws Exception {
        String query = "SELECT SellingPrice FROM Product WHERE ProductID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("SellingPrice");
            } else {
                throw new Exception("Product not found for SellingPrice");
            }
        }
    }

    private java.math.BigDecimal calculateProfit(Connection conn, int productId, int quantity) throws Exception {
        String query = "SELECT SellingPrice, PurchasePrice FROM Product WHERE ProductID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                java.math.BigDecimal sellingPrice = rs.getBigDecimal("SellingPrice");
                java.math.BigDecimal purchasePrice = rs.getBigDecimal("PurchasePrice");
                return sellingPrice.subtract(purchasePrice).multiply(new java.math.BigDecimal(quantity));
            } else {
                throw new Exception("Product not found for profit calculation");
            }
        }
    }
}
