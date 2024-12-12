package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Objects;

@MultipartConfig
public class ProductManageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String action = getFormValue(request, "action");
            // addProduct action
            if ("addProduct".equals(action)) {
                String productID = getFormValue(request, "productID");
                String productName = getFormValue(request, "productName");
                String category = getFormValue(request, "category");
                double purchasePrice = Double.parseDouble(getFormValue(request, "purchasePrice"));
                double sellingPrice = Double.parseDouble(getFormValue(request, "sellingPrice"));
                int shelfStock = Integer.parseInt(getFormValue(request, "shelfStock"));
                int warehouseStock = Integer.parseInt(getFormValue(request, "warehouseStock"));

                String query = "INSERT INTO Product (ProductName, Category, PurchasePrice, SellingPrice, ShelfStock, WarehouseStock) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, productName);
                    stmt.setString(2, category);
                    stmt.setBigDecimal(3, new java.math.BigDecimal(purchasePrice));
                    stmt.setBigDecimal(4, new java.math.BigDecimal(sellingPrice));
                    stmt.setInt(5, shelfStock);
                    stmt.setInt(6, warehouseStock);
                    stmt.executeUpdate();
                    response.setStatus(HttpServletResponse.SC_CREATED);
                }
            }
            // editProduct action
            else if ("editProduct".equals(action)) {
                String productID = getFormValue(request, "productID");
                String productName = getFormValue(request, "productName");
                String category = getFormValue(request, "category");
                double purchasePrice = Double.parseDouble(getFormValue(request, "purchasePrice"));
                double sellingPrice = Double.parseDouble(getFormValue(request, "sellingPrice"));
                int shelfStock = Integer.parseInt(getFormValue(request, "shelfStock"));
                int warehouseStock = Integer.parseInt(getFormValue(request, "warehouseStock"));
                String query = "UPDATE Product SET ProductName = ?, Category = ?, PurchasePrice = ?, SellingPrice = ?, ShelfStock = ?, WarehouseStock = ? WHERE ProductID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, productName);
                    stmt.setString(2, category);
                    stmt.setBigDecimal(3, new java.math.BigDecimal(purchasePrice));
                    stmt.setBigDecimal(4, new java.math.BigDecimal(sellingPrice));
                    stmt.setInt(5, shelfStock);
                    stmt.setInt(6, warehouseStock);
                    stmt.setInt(7, Integer.parseInt(productID));
                    stmt.executeUpdate();
                    response.setStatus(HttpServletResponse.SC_OK);
                }
            }
            // deleteProduct action
            else if ("deleteProduct".equals(action)) {
                String productID = getFormValue(request, "productID");
                String query = "DELETE FROM Product WHERE ProductID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, Integer.parseInt(productID));
                    stmt.executeUpdate();
                    response.setStatus(HttpServletResponse.SC_OK);
                }
            }
            // Invalid action
            else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            throw new ServletException("Database error occurred", e);
        }
    }

    private String getFormValue(HttpServletRequest request, String fieldName) throws IOException, ServletException {
        Part part = request.getPart(fieldName);
        if (part != null) {
            // 使用 InputStream 和 ByteArrayOutputStream 手动读取数据
            try (InputStream inputStream = part.getInputStream();
                 ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                return new String(outputStream.toByteArray(), "UTF-8");
            }
        }
        return null; // 如果没有对应的表单字段
    }
}