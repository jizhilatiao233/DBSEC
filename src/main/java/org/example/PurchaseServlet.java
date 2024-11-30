package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class PurchaseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productID = request.getParameter("ProductID");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM Product WHERE ProductID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(productID));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                out.println("<h3>Product Details</h3>");
                out.println("<p>Name: " + rs.getString("ProductName") + "</p>");
                out.println("<p>Price: " + rs.getDouble("SellingPrice") + " USD</p>");
                out.println("<form action='purchase' method='POST'>");
                out.println("<input type='number' name='quantity' min='1' max='" + rs.getInt("ShelfStock") + "' required>");
                out.println("<input type='submit' value='Buy'>");
                out.println("</form>");
            } else {
                out.println("<p>Product not found.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String quantity = request.getParameter("quantity");
        String productID = request.getParameter("ProductID");
        String customerName = request.getParameter("customerName");
        String contactInfo = request.getParameter("contactInfo");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String updateStockQuery = "UPDATE Product SET ShelfStock = ShelfStock - ? WHERE ProductID = ?";
            PreparedStatement stmt = conn.prepareStatement(updateStockQuery);
            stmt.setInt(1, Integer.parseInt(quantity));
            stmt.setInt(2, Integer.parseInt(productID));
            stmt.executeUpdate();

            String insertSaleQuery = "INSERT INTO Sales (ProductID, CustomerID, QuantitySold, SellingPrice) VALUES (?, ?, ?, ?)";
            // Insert sale logic here (assume customer ID is obtained from session)
            PreparedStatement insertStmt = conn.prepareStatement(insertSaleQuery);
            insertStmt.setInt(1, Integer.parseInt(productID));
            // You need to add logic to handle the customerID based on session
            insertStmt.setInt(2, 1);  // Assume customerID is 1 for now
            insertStmt.setInt(3, Integer.parseInt(quantity));
            insertStmt.setDouble(4, 20.0);  // Assume SellingPrice is 20 for now
            insertStmt.executeUpdate();

            response.sendRedirect("product_list");  // Redirect to product list page after purchase
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
