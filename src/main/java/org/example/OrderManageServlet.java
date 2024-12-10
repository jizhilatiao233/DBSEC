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

public class OrderManageServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getOrders".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getOrders(request, response, conn);
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

    private void getOrders(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
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
        String customerName = request.getParameter("customerName");
        String staffName = request.getParameter("staffName");
        String orderDate = request.getParameter("orderDate");

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT o.OrderID, o.CustomerID, c.CustomerName, o.StaffID, s.StaffName, o.TotalAmount, o.ActualPayment, DATE(o.OrderDate) as OrderDate " +
                "FROM Orders o " +
                "JOIN Customer c ON o.CustomerID = c.CustomerID " +
                "JOIN Staff s ON o.StaffID = s.StaffID " +
                "WHERE 1=1 ");
        StringBuilder countQueryBuilder = new StringBuilder("SELECT COUNT(*) as total " +
                "FROM Orders o " +
                "JOIN Customer c ON o.CustomerID = c.CustomerID " +
                "JOIN Staff s ON o.StaffID = s.StaffID " +
                "WHERE 1=1 ");
        if (customerName != null && !customerName.isEmpty()) {
            queryBuilder.append("AND c.CustomerName LIKE ? ");
            countQueryBuilder.append("AND c.CustomerName LIKE ? ");
        }
        if (staffName != null && !staffName.isEmpty()) {
            queryBuilder.append("AND s.StaffName LIKE ? ");
            countQueryBuilder.append("AND s.StaffName LIKE ? ");
        }
        if (orderDate != null && !orderDate.isEmpty()) {
            queryBuilder.append("AND DATE(o.OrderDate) = ? ");
            countQueryBuilder.append("AND DATE(o.OrderDate) = ? ");
        }
        queryBuilder.append("ORDER BY ").append(sortBy).append(" ").append(sortOrder).append(" ");
        queryBuilder.append("LIMIT ? OFFSET ?");
        String query = queryBuilder.toString();
        String countQuery = countQueryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query);
             PreparedStatement countStmt = conn.prepareStatement(countQuery)) {
            int paramIndex = 1;
            if (customerName != null && !customerName.isEmpty()) {
                stmt.setString(paramIndex, "%" + customerName + "%");
                countStmt.setString(paramIndex, "%" + customerName + "%");
                paramIndex++;
            }
            if (staffName != null && !staffName.isEmpty()) {
                stmt.setString(paramIndex, "%" + staffName + "%");
                countStmt.setString(paramIndex, "%" + staffName + "%");
                paramIndex++;
            }
            if (orderDate != null && !orderDate.isEmpty()) {
                stmt.setString(paramIndex, orderDate);
                countStmt.setString(paramIndex, orderDate);
                paramIndex++;
            }
            stmt.setInt(paramIndex++, limit);
            stmt.setInt(paramIndex, offset);

            ResultSet rs = stmt.executeQuery();
            List<Order> orders = new ArrayList<>();
            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getString("CustomerName"),
                        rs.getInt("StaffID"),
                        rs.getString("StaffName"),
                        rs.getBigDecimal("TotalAmount"),
                        rs.getBigDecimal("ActualPayment"),
                        rs.getString("OrderDate")
                ));
            }

            // get total count
            ResultSet countRs = countStmt.executeQuery();
            int totalOrders = 0;
            if (countRs.next()) {
                totalOrders = countRs.getInt("total");
            }
            int totalPages = (int) Math.ceil((double) totalOrders / limit);

            // return result
            OrdersResponse ordersResponse = new OrdersResponse(orders, totalPages);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(ordersResponse));
            out.flush();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    
    private static class OrdersResponse {
        private List<Order> orders;
        private int totalPages;

        public OrdersResponse(List<Order> orders, int totalPages) {
            this.orders = orders;
            this.totalPages = totalPages;
        }
    }
}
