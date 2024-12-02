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

            // Debugging
            System.out.println("Database Connected Success");
            System.out.println("ProductServlet: action = " + action);

            if ("details".equals(action)) {
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
}
