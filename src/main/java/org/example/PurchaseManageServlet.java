package org.example;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

public class PurchaseManageServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getPurchases".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getPurchases(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("getPurchaseDetails".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getPurchaseDetails(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("getSuppliers".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getSuppliers(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("getAdmins".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getAdmins(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("exportCSV".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                exportCSV(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("addPurchase".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                addPurchase(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("editPurchase".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                editPurchase(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("deletePurchase".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                deletePurchase(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }

    private void getPurchases(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
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
            sortBy = "PurchaseID";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        // filter parameters
        String productName = request.getParameter("productName");
        String supplierName = request.getParameter("supplierName");
        String adminName = request.getParameter("adminName");
        String purchaseDate = request.getParameter("purchaseDate");
        String minTotalCost = request.getParameter("minTotalCost");
        String maxTotalCost = request.getParameter("maxTotalCost");
        String minPurchasePrice = request.getParameter("minPurchasePrice");
        String maxPurchasePrice = request.getParameter("maxPurchasePrice");
        String fromPurchaseDate = request.getParameter("fromPurchaseDate");
        String toPurchaseDate = request.getParameter("toPurchaseDate");

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT p.PurchaseID, p.ProductID, pr.ProductName, p.QuantityPurchased, p.PurchasePrice, p.TotalCost, DATE(p.PurchaseDate) as PurchaseDate, p.AdminID, a.AdminName, p.SupplierID, s.SupplierName " +
                "FROM Purchase p " +
                "JOIN Product pr ON p.ProductID = pr.ProductID " +
                "JOIN Admin a ON p.AdminID = a.AdminID " +
                "JOIN Supplier s ON p.SupplierID = s.SupplierID " +
                "WHERE 1=1 ");
        StringBuilder countQueryBuilder = new StringBuilder("SELECT COUNT(*) as total " +
                "FROM Purchase p " +
                "JOIN Product pr ON p.ProductID = pr.ProductID " +
                "JOIN Admin a ON p.AdminID = a.AdminID " +
                "JOIN Supplier s ON p.SupplierID = s.SupplierID " +
                "WHERE 1=1 ");
        if (productName != null && !productName.isEmpty()) {
            queryBuilder.append("AND pr.ProductName LIKE ? ");
            countQueryBuilder.append("AND pr.ProductName LIKE ? ");
        }
        if (supplierName != null && !supplierName.isEmpty()) {
            queryBuilder.append("AND s.SupplierName LIKE ? ");
            countQueryBuilder.append("AND s.SupplierName LIKE ? ");
        }
        if (adminName != null && !adminName.isEmpty()) {
            queryBuilder.append("AND a.AdminName LIKE ? ");
            countQueryBuilder.append("AND a.AdminName LIKE ? ");
        }
        if (purchaseDate != null && !purchaseDate.isEmpty()) {
            queryBuilder.append("AND DATE(p.PurchaseDate) = ? ");
            countQueryBuilder.append("AND DATE(p.PurchaseDate) = ? ");
        }
        if (minTotalCost != null && !minTotalCost.isEmpty()) {
            queryBuilder.append("AND p.TotalCost >= ? ");
            countQueryBuilder.append("AND p.TotalCost >= ? ");
        }
        if (maxTotalCost != null && !maxTotalCost.isEmpty()) {
            queryBuilder.append("AND p.TotalCost <= ? ");
            countQueryBuilder.append("AND p.TotalCost <= ? ");
        }
        if (minPurchasePrice != null && !minPurchasePrice.isEmpty()) {
            queryBuilder.append("AND p.PurchasePrice >= ? ");
            countQueryBuilder.append("AND p.PurchasePrice >= ? ");
        }
        if (maxPurchasePrice != null && !maxPurchasePrice.isEmpty()) {
            queryBuilder.append("AND p.PurchasePrice <= ? ");
            countQueryBuilder.append("AND p.PurchasePrice <= ? ");
        }
        if (fromPurchaseDate != null && !fromPurchaseDate.isEmpty()) {
            queryBuilder.append("AND DATE(p.PurchaseDate) >= ? ");
            countQueryBuilder.append("AND DATE(p.PurchaseDate) >= ? ");
        }
        if (toPurchaseDate != null && !toPurchaseDate.isEmpty()) {
            queryBuilder.append("AND DATE(p.PurchaseDate) <= ? ");
            countQueryBuilder.append("AND DATE(p.PurchaseDate) <= ? ");
        }
        queryBuilder.append("ORDER BY ").append(sortBy).append(" ").append(sortOrder).append(" ");
        queryBuilder.append("LIMIT ? OFFSET ?");
        String query = queryBuilder.toString();
        String countQuery = countQueryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query);
             PreparedStatement countStmt = conn.prepareStatement(countQuery)) {
            int paramIndex = 1;
            if (productName != null && !productName.isEmpty()) {
                stmt.setString(paramIndex, "%" + productName + "%");
                countStmt.setString(paramIndex, "%" + productName + "%");
                paramIndex++;
            }
            if (supplierName != null && !supplierName.isEmpty()) {
                stmt.setString(paramIndex, "%" + supplierName + "%");
                countStmt.setString(paramIndex, "%" + supplierName + "%");
                paramIndex++;
            }
            if (adminName != null && !adminName.isEmpty()) {
                stmt.setString(paramIndex, "%" + adminName + "%");
                countStmt.setString(paramIndex, "%" + adminName + "%");
                paramIndex++;
            }
            if (purchaseDate != null && !purchaseDate.isEmpty()) {
                stmt.setString(paramIndex, purchaseDate);
                countStmt.setString(paramIndex, purchaseDate);
                paramIndex++;
            }
            if (minTotalCost != null && !minTotalCost.isEmpty()) {
                stmt.setBigDecimal(paramIndex, new BigDecimal(minTotalCost));
                countStmt.setBigDecimal(paramIndex, new BigDecimal(minTotalCost));
                paramIndex++;
            }
            if (maxTotalCost != null && !maxTotalCost.isEmpty()) {
                stmt.setBigDecimal(paramIndex, new BigDecimal(maxTotalCost));
                countStmt.setBigDecimal(paramIndex, new BigDecimal(maxTotalCost));
                paramIndex++;
            }
            if (minPurchasePrice != null && !minPurchasePrice.isEmpty()) {
                stmt.setBigDecimal(paramIndex, new BigDecimal(minPurchasePrice));
                countStmt.setBigDecimal(paramIndex, new BigDecimal(minPurchasePrice));
                paramIndex++;
            }
            if (maxPurchasePrice != null && !maxPurchasePrice.isEmpty()) {
                stmt.setBigDecimal(paramIndex, new BigDecimal(maxPurchasePrice));
                countStmt.setBigDecimal(paramIndex, new BigDecimal(maxPurchasePrice));
                paramIndex++;
            }
            if (fromPurchaseDate != null && !fromPurchaseDate.isEmpty()) {
                stmt.setString(paramIndex, fromPurchaseDate);
                countStmt.setString(paramIndex, fromPurchaseDate);
                paramIndex++;
            }
            if (toPurchaseDate != null && !toPurchaseDate.isEmpty()) {
                stmt.setString(paramIndex, toPurchaseDate);
                countStmt.setString(paramIndex, toPurchaseDate);
                paramIndex++;
            }
            stmt.setInt(paramIndex++, limit);
            stmt.setInt(paramIndex, offset);

            ResultSet rs = stmt.executeQuery();
            List<Purchase> purchases = new ArrayList<>();
            while (rs.next()) {
                purchases.add(new Purchase(
                        rs.getInt("PurchaseID"),
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("QuantityPurchased"),
                        rs.getDouble("PurchasePrice"),
                        rs.getDouble("TotalCost"),
                        rs.getString("PurchaseDate"),
                        rs.getInt("AdminID"),
                        rs.getString("AdminName"),
                        rs.getInt("SupplierID"),
                        rs.getString("SupplierName")
                ));
            }

            // get total count
            ResultSet countRs = countStmt.executeQuery();
            int totalPurchases = 0;
            if (countRs.next()) {
                totalPurchases = countRs.getInt("total");
            }
            int totalPages = (int) Math.ceil((double) totalPurchases / limit);

            // return result
            PurchasesResponse purchasesResponse = new PurchasesResponse(purchases, totalPages);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(purchasesResponse));
            out.flush();
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void getPurchaseDetails(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int purchaseID = Integer.parseInt(request.getParameter("purchaseID"));
        String query = "SELECT p.PurchaseID, p.ProductID, pr.ProductName, p.QuantityPurchased, p.PurchasePrice, p.TotalCost, DATE(p.PurchaseDate) as PurchaseDate, p.AdminID, a.AdminName, p.SupplierID, s.SupplierName " +
                "FROM Purchase p " +
                "JOIN Product pr ON p.ProductID = pr.ProductID " +
                "JOIN Admin a ON p.AdminID = a.AdminID " +
                "JOIN Supplier s ON p.SupplierID = s.SupplierID " +
                "WHERE p.PurchaseID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, purchaseID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Purchase purchase = new Purchase(
                        rs.getInt("PurchaseID"),
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("QuantityPurchased"),
                        rs.getDouble("PurchasePrice"),
                        rs.getDouble("TotalCost"),
                        rs.getString("PurchaseDate"),
                        rs.getInt("AdminID"),
                        rs.getString("AdminName"),
                        rs.getInt("SupplierID"),
                        rs.getString("SupplierName")
                );
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print(new Gson().toJson(purchase));
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Purchase not found");
            }
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void getSuppliers(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        String query = "SELECT DISTINCT SupplierID, SupplierName, ContactInfo FROM Supplier";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            List<Supplier> suppliers = new ArrayList<>();
            while (rs.next()) {
                suppliers.add(new Supplier(
                        rs.getInt("SupplierID"),
                        rs.getString("SupplierName"),
                        rs.getString("ContactInfo")
                ));
            }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(suppliers));
            out.flush();
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void getAdmins(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        String query = "SELECT DISTINCT AdminID, AdminName FROM Admin";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            List<Admin> admins = new ArrayList<>();
            while (rs.next()) {
                admins.add(new Admin(
                        rs.getInt("AdminID"),
                        rs.getString("AdminName"),
                        // ContactInfo, Username, Password, JoinDate, Position is not needed
                        null, null, null, null, null
                        ));
            }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(admins));
            out.flush();
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void exportCSV(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        // filter parameters
        String productName = request.getParameter("productName");
        String supplierName = request.getParameter("supplierName");
        String adminName = request.getParameter("adminName");
        String purchaseDate = request.getParameter("purchaseDate");
        String minTotalCost = request.getParameter("minTotalCost");
        String maxTotalCost = request.getParameter("maxTotalCost");
        String minPurchasePrice = request.getParameter("minPurchasePrice");
        String maxPurchasePrice = request.getParameter("maxPurchasePrice");
        String fromPurchaseDate = request.getParameter("fromPurchaseDate");
        String toPurchaseDate = request.getParameter("toPurchaseDate");

        // sort parameters
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "PurchaseID";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT p.PurchaseID, p.ProductID, pr.ProductName, p.QuantityPurchased, p.PurchasePrice, p.TotalCost, DATE(p.PurchaseDate) as PurchaseDate, p.AdminID, a.AdminName, p.SupplierID, s.SupplierName " +
                "FROM Purchase p " +
                "JOIN Product pr ON p.ProductID = pr.ProductID " +
                "JOIN Admin a ON p.AdminID = a.AdminID " +
                "JOIN Supplier s ON p.SupplierID = s.SupplierID " +
                "WHERE 1=1 ");
        if (productName != null && !productName.isEmpty()) {
            queryBuilder.append("AND pr.ProductName LIKE ? ");
        }
        if (supplierName != null && !supplierName.isEmpty()) {
            queryBuilder.append("AND s.SupplierName LIKE ? ");
        }
        if (adminName != null && !adminName.isEmpty()) {
            queryBuilder.append("AND a.AdminName LIKE ? ");
        }
        if (purchaseDate != null && !purchaseDate.isEmpty()) {
            queryBuilder.append("AND DATE(p.PurchaseDate) = ? ");
        }
        if (minTotalCost != null && !minTotalCost.isEmpty()) {
            queryBuilder.append("AND p.TotalCost >= ? ");
        }
        if (maxTotalCost != null && !maxTotalCost.isEmpty()) {
            queryBuilder.append("AND p.TotalCost <= ? ");
        }
        if (minPurchasePrice != null && !minPurchasePrice.isEmpty()) {
            queryBuilder.append("AND p.PurchasePrice >= ? ");
        }
        if (maxPurchasePrice != null && !maxPurchasePrice.isEmpty()) {
            queryBuilder.append("AND p.PurchasePrice <= ? ");
        }
        if (fromPurchaseDate != null && !fromPurchaseDate.isEmpty()) {
            queryBuilder.append("AND DATE(p.PurchaseDate) >= ? ");
        }
        if (toPurchaseDate != null && !toPurchaseDate.isEmpty()) {
            queryBuilder.append("AND DATE(p.PurchaseDate) <= ? ");
        }
        queryBuilder.append("ORDER BY ").append(sortBy).append(" ").append(sortOrder);
        String query = queryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            int paramIndex = 1;
            if (productName != null && !productName.isEmpty()) {
                stmt.setString(paramIndex, "%" + productName + "%");
                paramIndex++;
            }
            if (supplierName != null && !supplierName.isEmpty()) {
                stmt.setString(paramIndex, "%" + supplierName + "%");
                paramIndex++;
            }
            if (adminName != null && !adminName.isEmpty()) {
                stmt.setString(paramIndex, "%" + adminName + "%");
                paramIndex++;
            }
            if (purchaseDate != null && !purchaseDate.isEmpty()) {
                stmt.setString(paramIndex, purchaseDate);
                paramIndex++;
            }
            if (minTotalCost != null && !minTotalCost.isEmpty()) {
                stmt.setBigDecimal(paramIndex, new BigDecimal(minTotalCost));
                paramIndex++;
            }
            if (maxTotalCost != null && !maxTotalCost.isEmpty()) {
                stmt.setBigDecimal(paramIndex, new BigDecimal(maxTotalCost));
                paramIndex++;
            }
            if (minPurchasePrice != null && !minPurchasePrice.isEmpty()) {
                stmt.setBigDecimal(paramIndex, new BigDecimal(minPurchasePrice));
                paramIndex++;
            }
            if (maxPurchasePrice != null && !maxPurchasePrice.isEmpty()) {
                stmt.setBigDecimal(paramIndex, new BigDecimal(maxPurchasePrice));
                paramIndex++;
            }
            if (fromPurchaseDate != null && !fromPurchaseDate.isEmpty()) {
                stmt.setString(paramIndex, fromPurchaseDate);
                paramIndex++;
            }
            if (toPurchaseDate != null && !toPurchaseDate.isEmpty()) {
                stmt.setString(paramIndex, toPurchaseDate);
                paramIndex++;
            }

            ResultSet rs = stmt.executeQuery();
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"purchases.csv\"");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.println("PurchaseID,ProductID,ProductName,QuantityPurchased,PurchasePrice,TotalCost,PurchaseDate,AdminID,AdminName,SupplierID,SupplierName");
            while (rs.next()) {
                out.println(String.join(",",
                        Integer.toString(rs.getInt("PurchaseID")),
                        Integer.toString(rs.getInt("ProductID")),
                        rs.getString("ProductName"),
                        Integer.toString(rs.getInt("QuantityPurchased")),
                        rs.getBigDecimal("PurchasePrice").toPlainString(),
                        rs.getBigDecimal("TotalCost").toPlainString(),
                        rs.getString("PurchaseDate"),
                        Integer.toString(rs.getInt("AdminID")),
                        rs.getString("AdminName"),
                        Integer.toString(rs.getInt("SupplierID")),
                        rs.getString("SupplierName")
                ));
            }
            out.flush();
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void addPurchase(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int productID = Integer.parseInt(request.getParameter("productID"));
        int quantityPurchased = Integer.parseInt(request.getParameter("quantityPurchased"));
        double purchasePrice = Double.parseDouble(request.getParameter("purchasePrice"));
        String purchaseDate = request.getParameter("purchaseDate");
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        int supplierID = Integer.parseInt(request.getParameter("supplierID"));

        String query = "INSERT INTO Purchase (ProductID, QuantityPurchased, PurchasePrice, PurchaseDate, AdminID, SupplierID) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productID);
            stmt.setInt(2, quantityPurchased);
            stmt.setDouble(3, purchasePrice);
            stmt.setString(4, purchaseDate);
            stmt.setInt(5, adminID);
            stmt.setInt(6, supplierID);
            stmt.executeUpdate();
            response.setStatus(HttpServletResponse.SC_CREATED);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void editPurchase(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int purchaseID = Integer.parseInt(request.getParameter("purchaseID"));
        int productID = Integer.parseInt(request.getParameter("productID"));
        int quantityPurchased = Integer.parseInt(request.getParameter("quantityPurchased"));
        double purchasePrice = Double.parseDouble(request.getParameter("purchasePrice"));
        String purchaseDate = request.getParameter("purchaseDate");
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        int supplierID = Integer.parseInt(request.getParameter("supplierID"));

        String query = "UPDATE Purchase SET ProductID = ?, QuantityPurchased = ?, PurchasePrice = ?, PurchaseDate = ?, AdminID = ?, SupplierID = ? WHERE PurchaseID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productID);
            stmt.setInt(2, quantityPurchased);
            stmt.setDouble(3, purchasePrice);
            stmt.setString(4, purchaseDate);
            stmt.setInt(5, adminID);
            stmt.setInt(6, supplierID);
            stmt.setInt(7, purchaseID);
            stmt.executeUpdate();
            response.setStatus(HttpServletResponse.SC_CREATED);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void deletePurchase(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int purchaseID = Integer.parseInt(request.getParameter("purchaseID"));
        String query = "DELETE FROM Purchase WHERE PurchaseID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, purchaseID);
            stmt.executeUpdate();
            response.setStatus(HttpServletResponse.SC_NO_CONTENT);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static class PurchasesResponse {
        List<Purchase> purchases;
        int totalPages;

        public PurchasesResponse(List<Purchase> purchases, int totalPages) {
            this.purchases = purchases;
            this.totalPages = totalPages;
        }
    }
}
