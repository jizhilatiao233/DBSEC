package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import com.google.gson.Gson;
import com.opencsv.CSVWriter;

public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String action = request.getParameter("action");

        try (Connection conn = DatabaseConnection.getConnection()) {
            // getProducts action
            if ("getProducts".equals(action)) {
                // limit and offset parameters
                int offset = 0;
                int limit = 50;
                String offsetParam = request.getParameter("offset");
                String limitParam = request.getParameter("limit");
                if (offsetParam != null && !offsetParam.isEmpty()) {
                    offset = Integer.parseInt(offsetParam);
                }
                if (limitParam != null && !limitParam.isEmpty()) {
                    limit = Integer.parseInt(limitParam);
                }

                // sort parameters
                String sortBy = request.getParameter("sortBy");
                String sortOrder = request.getParameter("sortOrder");
                if (sortBy == null || sortBy.isEmpty()) {
                    sortBy = "ProductID"; // Default sort by ProductID
                }
                if (sortOrder == null || sortOrder.isEmpty()) {
                    sortOrder = "ASC"; // Default sort order
                }

                // filter parameters
                String productName = request.getParameter("productName");
                String category = request.getParameter("category");
                String minPrice = request.getParameter("minPrice");
                String maxPrice = request.getParameter("maxPrice");

                // build query
                StringBuilder queryBuilder = new StringBuilder("SELECT * FROM Product WHERE 1=1");
                StringBuilder countQueryBuilder = new StringBuilder("SELECT COUNT(*) FROM Product WHERE 1=1");
                if (productName != null && !productName.isEmpty()) {
                    queryBuilder.append(" AND ProductName LIKE ?");
                    countQueryBuilder.append(" AND ProductName LIKE ?");
                }
                if (category != null && !category.isEmpty()) {
                    queryBuilder.append(" AND Category = ?");
                    countQueryBuilder.append(" AND Category = ?");
                }
                if (minPrice != null && !minPrice.isEmpty()) {
                    queryBuilder.append(" AND SellingPrice >= ?");
                    countQueryBuilder.append(" AND SellingPrice >= ?");
                }
                if (maxPrice != null && !maxPrice.isEmpty()) {
                    queryBuilder.append(" AND SellingPrice <= ?");
                    countQueryBuilder.append(" AND SellingPrice <= ?");
                }
                queryBuilder.append(" ORDER BY ").append(sortBy).append(" ").append(sortOrder);
                queryBuilder.append(" LIMIT ? OFFSET ?");
                String query = queryBuilder.toString();
                String countQuery = countQueryBuilder.toString();

                try (PreparedStatement countStmt = conn.prepareStatement(countQuery)) {
                    int paramIndex = 1;
                    // Set filter parameters
                    if (productName != null && !productName.isEmpty()) {
                        countStmt.setString(paramIndex++, "%" + productName + "%");
                    }
                    if (category != null && !category.isEmpty()) {
                        countStmt.setString(paramIndex++, category);
                    }
                    if (minPrice != null && !minPrice.isEmpty()) {
                        countStmt.setBigDecimal(paramIndex++, new java.math.BigDecimal(minPrice));
                    }
                    if (maxPrice != null && !maxPrice.isEmpty()) {
                        countStmt.setBigDecimal(paramIndex++, new java.math.BigDecimal(maxPrice));
                    }

                    // Debugging
                    System.out.println("countQuery: " + countStmt.toString());

                    ResultSet countRs = countStmt.executeQuery();
                    countRs.next();
                    int totalProducts = countRs.getInt(1);
                    int totalPages = (int) Math.ceil((double) totalProducts / limit);

                    try (PreparedStatement stmt = conn.prepareStatement(query)) {
                        paramIndex = 1;
                        // Set filter parameters
                        if (productName != null && !productName.isEmpty()) {
                            stmt.setString(paramIndex++, "%" + productName + "%");
                        }
                        if (category != null && !category.isEmpty()) {
                            stmt.setString(paramIndex++, category);
                        }
                        if (minPrice != null && !minPrice.isEmpty()) {
                            stmt.setBigDecimal(paramIndex++, new java.math.BigDecimal(minPrice));
                        }
                        if (maxPrice != null && !maxPrice.isEmpty()) {
                            stmt.setBigDecimal(paramIndex++, new java.math.BigDecimal(maxPrice));
                        }
                        // Set pagination parameters
                        stmt.setInt(paramIndex++, limit);
                        stmt.setInt(paramIndex, offset);

                        // Debugging
                        System.out.println("query: " + stmt.toString());

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
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();
                        ProductResponse productResponse = new ProductResponse(products, totalPages);
                        out.print(new Gson().toJson(productResponse));
                        out.flush();
                    }
                }
            }
            // getProductDetails action
            else if ("getProductDetails".equals(action)) {
                String productId = request.getParameter("productId");

                String query = "SELECT * FROM Product WHERE ProductID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, Integer.parseInt(productId));
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
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();
                        out.print(new Gson().toJson(product));
                        out.flush();
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    }
                }
            }
            // getCategories action
            else if ("getCategories".equals(action)) {
                String query = "SELECT DISTINCT category FROM Product";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    ResultSet rs = stmt.executeQuery();
                    List<String> categories = new ArrayList<>();
                    while (rs.next()) {
                        categories.add(rs.getString("Category"));
                    }
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print(new Gson().toJson(categories));
                    out.flush();
                }
            }
            // exportCSV action
            // http://localhost:8080/ShopManagement_Web_exploded/product?action=exportCSV&sortBy=&sortOrder=&productName=&category=&minPrice=&maxPrice=
            else if ("exportCSV".equals(action)) {
                // filter parameters
                String productName = request.getParameter("productName");
                String category = request.getParameter("category");
                String minPrice = request.getParameter("minPrice");
                String maxPrice = request.getParameter("maxPrice");

                // sort parameters
                String sortBy = request.getParameter("sortBy");
                String sortOrder = request.getParameter("sortOrder");
                if (sortBy == null || sortBy.isEmpty()) {
                    sortBy = "ProductID"; // Default sort by ProductID
                }
                if (sortOrder == null || sortOrder.isEmpty()) {
                    sortOrder = "ASC"; // Default sort order
                }

                // build query
                StringBuilder queryBuilder = new StringBuilder("SELECT * FROM Product WHERE 1=1");
                if (productName != null && !productName.isEmpty()) {
                    queryBuilder.append(" AND ProductName LIKE ?");
                }
                if (category != null && !category.isEmpty()) {
                    queryBuilder.append(" AND Category = ?");
                }
                if (minPrice != null && !minPrice.isEmpty()) {
                    queryBuilder.append(" AND SellingPrice >= ?");
                }
                if (maxPrice != null && !maxPrice.isEmpty()) {
                    queryBuilder.append(" AND SellingPrice <= ?");
                }
                queryBuilder.append(" ORDER BY ").append(sortBy).append(" ").append(sortOrder);
                String query = queryBuilder.toString();

                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    int paramIndex = 1;
                    // Set filter parameters
                    if (productName != null && !productName.isEmpty()) {
                        stmt.setString(paramIndex++, "%" + productName + "%");
                    }
                    if (category != null && !category.isEmpty()) {
                        stmt.setString(paramIndex++, category);
                    }
                    if (minPrice != null && !minPrice.isEmpty()) {
                        stmt.setBigDecimal(paramIndex++, new java.math.BigDecimal(minPrice));
                    }
                    if (maxPrice != null && !maxPrice.isEmpty()) {
                        stmt.setBigDecimal(paramIndex++, new java.math.BigDecimal(maxPrice));
                    }

                    ResultSet rs = stmt.executeQuery();
                    List<String[]> csvData = new ArrayList<>();
                    csvData.add(new String[]{"ProductID", "ProductName", "Category", "PurchasePrice", "SellingPrice", "ShelfStock", "WarehouseStock"});
                    while (rs.next()) {
                        csvData.add(new String[]{
                                String.valueOf(rs.getInt("ProductID")),
                                rs.getString("ProductName"),
                                rs.getString("Category"),
                                rs.getBigDecimal("PurchasePrice").toString(),
                                rs.getBigDecimal("SellingPrice").toString(),
                                String.valueOf(rs.getInt("ShelfStock")),
                                String.valueOf(rs.getInt("WarehouseStock"))
                        });
                    }

                    // Debugging
                    for (String[] row : csvData) {
                        System.out.println(String.join(",", row));
                    }

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print(new Gson().toJson(csvData));
                    out.flush();
                } catch (SQLException e) {
                    throw new ServletException("Database error occurred", e);
                }
            }
            // addProduct action
            else if("addProduct".equals(action)) {
                String productName = request.getParameter("productName");
                String category = request.getParameter("category");
                String purchasePrice = request.getParameter("purchasePrice");
                String sellingPrice = request.getParameter("sellingPrice");
                String shelfStock = request.getParameter("shelfStock");
                String warehouseStock = request.getParameter("warehouseStock");

                String query = "INSERT INTO Product (ProductName, Category, PurchasePrice, SellingPrice, ShelfStock, WarehouseStock) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, productName);
                    stmt.setString(2, category);
                    stmt.setBigDecimal(3, new java.math.BigDecimal(purchasePrice));
                    stmt.setBigDecimal(4, new java.math.BigDecimal(sellingPrice));
                    stmt.setInt(5, Integer.parseInt(shelfStock));
                    stmt.setInt(6, Integer.parseInt(warehouseStock));
                    stmt.executeUpdate();
                    response.setStatus(HttpServletResponse.SC_CREATED);
                }
            }
            // editProduct action
            else if("editProduct".equals(action)) {
                String productId = request.getParameter("productId");
                String productName = request.getParameter("productName");
                String category = request.getParameter("category");
                String purchasePrice = request.getParameter("purchasePrice");
                String sellingPrice = request.getParameter("sellingPrice");
                String shelfStock = request.getParameter("shelfStock");
                String warehouseStock = request.getParameter("warehouseStock");

                String query = "UPDATE Product SET ProductName = ?, Category = ?, PurchasePrice = ?, SellingPrice = ?, ShelfStock = ?, WarehouseStock = ? WHERE ProductID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, productName);
                    stmt.setString(2, category);
                    stmt.setBigDecimal(3, new java.math.BigDecimal(purchasePrice));
                    stmt.setBigDecimal(4, new java.math.BigDecimal(sellingPrice));
                    stmt.setInt(5, Integer.parseInt(shelfStock));
                    stmt.setInt(6, Integer.parseInt(warehouseStock));
                    stmt.setInt(7, Integer.parseInt(productId));
                    stmt.executeUpdate();
                    response.setStatus(HttpServletResponse.SC_OK);
                }
            }
            // deleteProduct action
            else if("deleteProduct".equals(action)) {
                String productId = request.getParameter("productId");

                String query = "DELETE FROM Product WHERE ProductID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, Integer.parseInt(productId));
                    stmt.executeUpdate();
                    response.setStatus(HttpServletResponse.SC_OK);
                }
            }
            // Invalid action
            else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            throw new ServletException("Database error occurred", e);
        }
    }

    private class ProductResponse {
        private List<Product> products;
        private int totalPages;

        public ProductResponse(List<Product> products, int totalPages) {
            this.products = products;
            this.totalPages = totalPages;
        }
    }
}