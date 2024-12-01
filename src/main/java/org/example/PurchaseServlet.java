package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PurchaseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int customerId;
        // Retrieve customer ID from session
        // TODO: CustomerLoginServlet.java; CustomerLogin.jsp -> store customer ID in session
        HttpSession session = request.getSession();
        if (session.getAttribute("customerId") != null) {
            customerId = (int) session.getAttribute("customerId");
        } else {
            throw new ServletException("Customer not logged in");
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Update stock
            String updateStockQuery = "UPDATE Product SET ShelfStock = ShelfStock - ? WHERE ProductID = ?";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateStockQuery)) {
                updateStmt.setInt(1, quantity);
                updateStmt.setInt(2, productId);
                updateStmt.executeUpdate();
            }

            // Insert sale record
            String insertSalesQuery = "INSERT INTO Sales (ProductID, CustomerID, QuantitySold, SellingPrice, Profit) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSalesQuery)) {
                BigDecimal sellingPrice = getSellingPrice(conn, productId);
                BigDecimal profit = calculateProfit(conn, productId, quantity);

                insertStmt.setInt(1, productId);
                insertStmt.setInt(2, customerId);
                insertStmt.setInt(3, quantity);
                insertStmt.setBigDecimal(4, sellingPrice);
                insertStmt.setBigDecimal(5, profit);
                insertStmt.executeUpdate();
            }

            // Send success message to the user
            request.setAttribute("message", "Purchase successful!");
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error processing purchase", e);
        }
    }

    private BigDecimal getSellingPrice(Connection conn, int productId) throws Exception {
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

    private BigDecimal calculateProfit(Connection conn, int productId, int quantity) throws Exception {
        String query = "SELECT SellingPrice, PurchasePrice FROM Product WHERE ProductID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                BigDecimal sellingPrice = rs.getBigDecimal("SellingPrice");
                BigDecimal purchasePrice = rs.getBigDecimal("PurchasePrice");
                return sellingPrice.subtract(purchasePrice).multiply(new BigDecimal(quantity));
            } else {
                throw new Exception("Product not found for profit calculation");
            }
        }
    }
}
