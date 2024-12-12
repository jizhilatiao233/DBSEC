package org.example;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

public class SalesManageServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getSales".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getSales(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("getSalesVolume".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getSalesVolume(request, response, conn);
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
        else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }

    private void getSales(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
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
            sortBy = "OrderID";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        // filter parameters
        String orderID = request.getParameter("orderID");
        String productName = request.getParameter("productName");
        String staffName = request.getParameter("staffName");
        String salesDate = request.getParameter("salesDate");

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT s.OrderID, s.ProductID, p.ProductName, s.StaffID, st.StaffName, s.QuantitySold, s.SellingPrice, s.ActualPayment, s.Profit, DATE(s.SalesDate) as SalesDate " +
                "FROM Sales s " +
                "JOIN Product p ON s.ProductID = p.ProductID " +
                "JOIN Staff st ON s.StaffID = st.StaffID " +
                "WHERE 1=1 ");
        StringBuilder countQueryBuilder = new StringBuilder("SELECT COUNT(*) as total " +
                "FROM Sales s " +
                "JOIN Product p ON s.ProductID = p.ProductID " +
                "JOIN Staff st ON s.StaffID = st.StaffID " +
                "WHERE 1=1 ");
        if (orderID != null && !orderID.isEmpty()) {
            queryBuilder.append("AND s.OrderID = ? ");
            countQueryBuilder.append("AND s.OrderID = ? ");
        }
        if (productName != null && !productName.isEmpty()) {
            queryBuilder.append("AND p.ProductName LIKE ? ");
            countQueryBuilder.append("AND p.ProductName LIKE ? ");
        }
        if (staffName != null && !staffName.isEmpty()) {
            queryBuilder.append("AND st.StaffName LIKE ? ");
            countQueryBuilder.append("AND st.StaffName LIKE ? ");
        }
        if (salesDate != null && !salesDate.isEmpty()) {
            queryBuilder.append("AND DATE(s.SalesDate) = ? ");
            countQueryBuilder.append("AND DATE(s.SalesDate) = ? ");
        }
        queryBuilder.append("ORDER BY ").append(sortBy).append(" ").append(sortOrder);
        queryBuilder.append(" LIMIT ? OFFSET ?");
        String query = queryBuilder.toString();
        String countQuery = countQueryBuilder.toString();

        try (PreparedStatement countStmt = conn.prepareStatement(countQuery);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            int paramCountIndex = 1;
            int paramIndex = 1;
            // set filter parameters
            if (orderID != null && !orderID.isEmpty()) {
                countStmt.setString(paramCountIndex++, orderID);
                stmt.setString(paramIndex++, orderID);
            }
            if (productName != null && !productName.isEmpty()) {
                countStmt.setString(paramCountIndex++, "%" + productName + "%");
                stmt.setString(paramIndex++, "%" + productName + "%");
            }
            if (staffName != null && !staffName.isEmpty()) {
                countStmt.setString(paramCountIndex++, "%" + staffName + "%");
                stmt.setString(paramIndex++, "%" + staffName + "%");
            }
            if (salesDate != null && !salesDate.isEmpty()) {
                countStmt.setString(paramCountIndex++, salesDate);
                stmt.setString(paramIndex++, salesDate);
            }

            // Debugging
            System.err.println("countQuery: " + countStmt.toString());

            ResultSet countRs = countStmt.executeQuery();
            countRs.next();
            int totalSales = countRs.getInt("total");
            int totalPages = (int) Math.ceil((double) totalSales / limit);

            // set pagination parameters
            stmt.setInt(paramIndex++, limit);
            stmt.setInt(paramIndex, offset);

            // Debugging
            System.err.println("query: " + stmt.toString());

            ResultSet rs = stmt.executeQuery();
            List<Sale> sales = new ArrayList<>();
            while (rs.next()) {
                sales.add(new Sale(
                        rs.getInt("OrderID"),
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("StaffID"),
                        rs.getString("StaffName"),
                        rs.getInt("QuantitySold"),
                        rs.getBigDecimal("SellingPrice"),
                        rs.getBigDecimal("ActualPayment"),
                        rs.getBigDecimal("Profit"),
                        rs.getString("SalesDate")
                ));
            }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            SalesResponse salesResponse = new SalesResponse(sales, totalPages);
            out.print(new Gson().toJson(salesResponse));
            out.flush();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void getSalesVolume(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        // filter parameters
        String orderID = request.getParameter("orderID");
        String productName = request.getParameter("productName");
        String staffName = request.getParameter("staffName");
        String salesDate = request.getParameter("salesDate");

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT SUM(s.ActualPayment) as SalesVolume " +
                "FROM Sales s " +
                "JOIN Product p ON s.ProductID = p.ProductID " +
                "JOIN Staff st ON s.StaffID = st.StaffID " +
                "WHERE 1=1 ");
        if (orderID != null && !orderID.isEmpty()) {
            queryBuilder.append("AND s.OrderID = ? ");
        }
        if (productName != null && !productName.isEmpty()) {
            queryBuilder.append("AND p.ProductName LIKE ? ");
        }
        if (staffName != null && !staffName.isEmpty()) {
            queryBuilder.append("AND st.StaffName LIKE ? ");
        }
        if (salesDate != null && !salesDate.isEmpty()) {
            queryBuilder.append("AND DATE(s.SalesDate) = ? ");
        }
        String query = queryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            int paramIndex = 1;
            // set filter parameters
            if (orderID != null && !orderID.isEmpty()) {
                stmt.setString(paramIndex++, orderID);
            }
            if (productName != null && !productName.isEmpty()) {
                stmt.setString(paramIndex++, "%" + productName + "%");
            }
            if (staffName != null && !staffName.isEmpty()) {
                stmt.setString(paramIndex++, "%" + staffName + "%");
            }
            if (salesDate != null && !salesDate.isEmpty()) {
                stmt.setString(paramIndex++, salesDate);
            }

            ResultSet rs = stmt.executeQuery();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            if (rs.next()) {
                out.print(new Gson().toJson(rs.getBigDecimal("SalesVolume")));
            } else {
                out.print(new Gson().toJson(0));
            }
            out.flush();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void exportCSV(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        // filter parameters
        String orderID = request.getParameter("orderID");
        String productName = request.getParameter("productName");
        String staffName = request.getParameter("staffName");
        String salesDate = request.getParameter("salesDate");

        // sort parameters
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "OrderID";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT s.OrderID, s.ProductID, p.ProductName, s.StaffID, st.StaffName, s.QuantitySold, s.SellingPrice, s.ActualPayment, s.Profit, DATE(s.SalesDate) as SalesDate " +
                "FROM Sales s " +
                "JOIN Product p ON s.ProductID = p.ProductID " +
                "JOIN Staff st ON s.StaffID = st.StaffID " +
                "WHERE 1=1 ");
        if (orderID != null && !orderID.isEmpty()) {
            queryBuilder.append("AND s.OrderID = ? ");
        }
        if (productName != null && !productName.isEmpty()) {
            queryBuilder.append("AND p.ProductName LIKE ? ");
        }
        if (staffName != null && !staffName.isEmpty()) {
            queryBuilder.append("AND st.StaffName LIKE ? ");
        }
        if (salesDate != null && !salesDate.isEmpty()) {
            queryBuilder.append("AND DATE(s.SalesDate) = ? ");
        }
        queryBuilder.append("ORDER BY ").append(sortBy).append(" ").append(sortOrder);
        String query = queryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            int paramIndex = 1;
            // set filter parameters
            if (orderID != null && !orderID.isEmpty()) {
                stmt.setString(paramIndex++, orderID);
            }
            if (productName != null && !productName.isEmpty()) {
                stmt.setString(paramIndex++, "%" + productName + "%");
            }
            if (staffName != null && !staffName.isEmpty()) {
                stmt.setString(paramIndex++, "%" + staffName + "%");
            }
            if (salesDate != null && !salesDate.isEmpty()) {
                stmt.setString(paramIndex++, salesDate);
            }

            ResultSet rs = stmt.executeQuery();
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"sales.csv\"");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.println("OrderID,ProductID,ProductName,StaffID,StaffName,QuantitySold,SellingPrice,ActualPayment,Profit,SalesDate");
            while (rs.next()) {
                out.println(String.join(",",
                        Integer.toString(rs.getInt("OrderID")),
                        Integer.toString(rs.getInt("ProductID")),
                        rs.getString("ProductName"),
                        Integer.toString(rs.getInt("StaffID")),
                        rs.getString("StaffName"),
                        Integer.toString(rs.getInt("QuantitySold")),
                        rs.getBigDecimal("SellingPrice").toPlainString(),
                        rs.getBigDecimal("ActualPayment").toPlainString(),
                        rs.getBigDecimal("Profit").toPlainString(),
                        rs.getString("SalesDate")
                ));
            }
            out.flush();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static class SalesResponse {
        private List<Sale> sales;
        private int totalPages;

        public SalesResponse(List<Sale> sales, int totalPages) {
            this.sales = sales;
            this.totalPages = totalPages;
        }
    }
}