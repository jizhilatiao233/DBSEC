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

public class CustomerManageServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getCustomers".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getCustomers(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("getCustomerDetails".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getCustomerDetails(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("addCustomer".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                addCustomer(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("editCustomer".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                editCustomer(request, response, conn);
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    private void getCustomers(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException {
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
            sortBy = "CustomerID";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        // filter parameters
        String customerName = request.getParameter("customerName");
        String contactInfo = request.getParameter("contactInfo");
        String minTotalConsumption = request.getParameter("maxTotalConsumption");
        String maxTotalConsumption = request.getParameter("minTotalConsumption");
        String fromJoinDate = request.getParameter("fromJoinDate");
        String toJoinDate = request.getParameter("toJoinDate");
        String vipLevel = request.getParameter("vipLevel");

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT CustomerID, CustomerName, ContactInfo, Username, Password, Date(JoinDate) AS JoinDate, TotalConsumption, VIPLevel FROM Customer WHERE 1=1");
        StringBuilder countQueryBuilder = new StringBuilder("SELECT COUNT(*) FROM Customer WHERE 1=1");

        if (customerName != null && !customerName.isEmpty()) {
            queryBuilder.append(" AND CustomerName LIKE ?");
            countQueryBuilder.append(" AND CustomerName LIKE ?");
        }
        if (contactInfo != null && !contactInfo.isEmpty()) {
            queryBuilder.append(" AND ContactInfo LIKE ?");
            countQueryBuilder.append(" AND ContactInfo LIKE ?");
        }
        if (minTotalConsumption != null && !minTotalConsumption.isEmpty()) {
            queryBuilder.append(" AND TotalConsumption >= ?");
            countQueryBuilder.append(" AND TotalConsumption >= ?");
        }
        if (maxTotalConsumption != null && !maxTotalConsumption.isEmpty()) {
            queryBuilder.append(" AND TotalConsumption <= ?");
            countQueryBuilder.append(" AND TotalConsumption <= ?");
        }
        if (fromJoinDate != null && !fromJoinDate.isEmpty()) {
            queryBuilder.append(" AND JoinDate >= ?");
            countQueryBuilder.append(" AND JoinDate >= ?");
        }
        if (toJoinDate != null && !toJoinDate.isEmpty()) {
            queryBuilder.append(" AND JoinDate <= ?");
            countQueryBuilder.append(" AND JoinDate <= ?");
        }
        if (vipLevel != null && !vipLevel.isEmpty()) {
            queryBuilder.append(" AND VIPLevel = ?");
            countQueryBuilder.append(" AND VIPLevel = ?");
        }
        queryBuilder.append(" ORDER BY ").append(sortBy).append(" ").append(sortOrder);
        queryBuilder.append(" LIMIT ? OFFSET ?");
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
            if (contactInfo != null && !contactInfo.isEmpty()) {
                stmt.setString(paramIndex, "%" + contactInfo + "%");
                countStmt.setString(paramIndex, "%" + contactInfo + "%");
                paramIndex++;
            }
            if (minTotalConsumption != null && !minTotalConsumption.isEmpty()) {
                stmt.setDouble(paramIndex, Double.parseDouble(minTotalConsumption));
                countStmt.setDouble(paramIndex, Double.parseDouble(minTotalConsumption));
                paramIndex++;
            }
            if (maxTotalConsumption != null && !maxTotalConsumption.isEmpty()) {
                stmt.setDouble(paramIndex, Double.parseDouble(maxTotalConsumption));
                countStmt.setDouble(paramIndex, Double.parseDouble(maxTotalConsumption));
                paramIndex++;
            }
            if (fromJoinDate != null && !fromJoinDate.isEmpty()) {
                stmt.setString(paramIndex, fromJoinDate);
                countStmt.setString(paramIndex, fromJoinDate);
                paramIndex++;
            }
            if (toJoinDate != null && !toJoinDate.isEmpty()) {
                stmt.setString(paramIndex, toJoinDate);
                countStmt.setString(paramIndex, toJoinDate);
                paramIndex++;
            }
            if (vipLevel != null && !vipLevel.isEmpty()) {
                stmt.setInt(paramIndex, Integer.parseInt(vipLevel));
                countStmt.setInt(paramIndex, Integer.parseInt(vipLevel));
                paramIndex++;
            }
            stmt.setInt(paramIndex++, limit);
            stmt.setInt(paramIndex, offset);

            ResultSet rs = stmt.executeQuery();
            List<Customer> customers = new ArrayList<>();
            while (rs.next()) {
                customers.add(new Customer(
                        rs.getInt("CustomerID"),
                        rs.getString("CustomerName"),
                        rs.getString("ContactInfo"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("JoinDate"),
                        rs.getDouble("TotalConsumption"),
                        rs.getInt("VIPLevel")
                ));
            }

            ResultSet countRs = countStmt.executeQuery();
            int totalCustomers = 0;
            if (countRs.next()) {
                totalCustomers = countRs.getInt(1);
            }
            int totalPages = (int) Math.ceil((double) totalCustomers / limit);

            CustomersResponse customersResponse = new CustomersResponse(customers, totalPages);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(customersResponse));
            out.flush();
        } catch (SQLException e) {
            throw new ServletException("SQL error", e);
        }
    }

    private void getCustomerDetails(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int customerID = Integer.parseInt(request.getParameter("customerID"));
        String query = "SELECT CustomerID, CustomerName, ContactInfo, Username, Password, Date(JoinDate) AS JoinDate, TotalConsumption, VIPLevel FROM Customer WHERE CustomerID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt("CustomerID"),
                        rs.getString("CustomerName"),
                        rs.getString("ContactInfo"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("JoinDate"),
                        rs.getDouble("TotalConsumption"),
                        rs.getInt("VIPLevel")
                );
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print(new Gson().toJson(customer));
                out.flush();
            }
            else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer not found");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void addCustomer(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        String customerName = request.getParameter("customerName");
        String contactInfo = request.getParameter("contactInfo");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String joinDate = request.getParameter("joinDate");
        String _totalConsumption = request.getParameter("totalConsumption");
        String _vipLevel = request.getParameter("vipLevel");
        if (username == null || username.isEmpty()) {
            username = null;
        }
        if (password == null || password.isEmpty()) {
            password = null;
        }
        if (joinDate == null || joinDate.isEmpty()) {
            joinDate = new Date(System.currentTimeMillis()).toString();
        }
        if (_totalConsumption == null || _totalConsumption.isEmpty()) {
            _totalConsumption = "0";
        }
        if (_vipLevel == null || _vipLevel.isEmpty()) {
            _vipLevel = "0";
        }
        double totalConsumption = Double.parseDouble(_totalConsumption);
        int vipLevel = Integer.parseInt(_vipLevel);

        StringBuilder queryBuilder = new StringBuilder("INSERT INTO Customer (CustomerName, ContactInfo, Username, Password, JoinDate, TotalConsumption, VIPLevel) VALUES (?, ?, ?, ?, ?, ?, ?)");
        String query = queryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, customerName);
            stmt.setString(2, contactInfo);
            stmt.setString(3, username);
            stmt.setString(4, password);
            stmt.setString(5, joinDate);
            stmt.setDouble(6, totalConsumption);
            stmt.setInt(7, vipLevel);
            stmt.executeUpdate();
            response.setStatus(HttpServletResponse.SC_CREATED);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void editCustomer(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        String customerID = request.getParameter("customerID");
        String customerName = request.getParameter("customerName");
        String contactInfo = request.getParameter("contactInfo");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String joinDate = request.getParameter("joinDate");
        String _totalConsumption = request.getParameter("totalConsumption");
        String _vipLevel = request.getParameter("vipLevel");
        if (username == null || username.isEmpty()) {
            username = null;
        }
        if (password == null || password.isEmpty()) {
            password = null;
        }
        if (joinDate == null || joinDate.isEmpty()) {
            joinDate = new Date(System.currentTimeMillis()).toString();
        }
        if (_totalConsumption == null || _totalConsumption.isEmpty()) {
            _totalConsumption = "0";
        }
        if (_vipLevel == null || _vipLevel.isEmpty()) {
            _vipLevel = "0";
        }
        double totalConsumption = Double.parseDouble(_totalConsumption);
        int vipLevel = Integer.parseInt(_vipLevel);

        StringBuilder queryBuilder = new StringBuilder("UPDATE Customer SET CustomerName = ?, ContactInfo = ?, Username = ?, Password = ?, JoinDate = ?, TotalConsumption = ?, VIPLevel = ? WHERE CustomerID = ?");
        String query = queryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, customerName);
            stmt.setString(2, contactInfo);
            stmt.setString(3, username);
            stmt.setString(4, password);
            stmt.setString(5, joinDate);
            stmt.setDouble(6, totalConsumption);
            stmt.setInt(7, vipLevel);
            stmt.setInt(8, Integer.parseInt(customerID));
            stmt.executeUpdate();
            response.setStatus(HttpServletResponse.SC_CREATED);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void exportCSV(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        // filter parameters
        String customerName = request.getParameter("customerName");
        String contactInfo = request.getParameter("contactInfo");
        String minTotalConsumption = request.getParameter("maxTotalConsumption");
        String maxTotalConsumption = request.getParameter("minTotalConsumption");
        String fromJoinDate = request.getParameter("fromJoinDate");
        String toJoinDate = request.getParameter("toJoinDate");
        String vipLevel = request.getParameter("vipLevel");

        // sort parameters
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "CustomerID";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT CustomerID, CustomerName, ContactInfo, Username, Password, Date(JoinDate) AS JoinDate, TotalConsumption, VIPLevel FROM Customer WHERE 1=1");
        if (customerName != null && !customerName.isEmpty()) {
            queryBuilder.append(" AND CustomerName LIKE ?");
        }
        if (contactInfo != null && !contactInfo.isEmpty()) {
            queryBuilder.append(" AND ContactInfo LIKE ?");
        }
        if (minTotalConsumption != null && !minTotalConsumption.isEmpty()) {
            queryBuilder.append(" AND TotalConsumption >= ?");
        }
        if (maxTotalConsumption != null && !maxTotalConsumption.isEmpty()) {
            queryBuilder.append(" AND TotalConsumption <= ?");
        }
        if (fromJoinDate != null && !fromJoinDate.isEmpty()) {
            queryBuilder.append(" AND JoinDate >= ?");
        }
        if (toJoinDate != null && !toJoinDate.isEmpty()) {
            queryBuilder.append(" AND JoinDate <= ?");
        }
        if (vipLevel != null && !vipLevel.isEmpty()) {
            queryBuilder.append(" AND VIPLevel = ?");
        }
        queryBuilder.append(" ORDER BY ").append(sortBy).append(" ").append(sortOrder);
        String query = queryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            int paramIndex = 1;
            if (customerName != null && !customerName.isEmpty()) {
                stmt.setString(paramIndex, "%" + customerName + "%");
                paramIndex++;
            }
            if (contactInfo != null && !contactInfo.isEmpty()) {
                stmt.setString(paramIndex, "%" + contactInfo + "%");
                paramIndex++;
            }
            if (minTotalConsumption != null && !minTotalConsumption.isEmpty()) {
                stmt.setDouble(paramIndex, Double.parseDouble(minTotalConsumption));
                paramIndex++;
            }
            if (maxTotalConsumption != null && !maxTotalConsumption.isEmpty()) {
                stmt.setDouble(paramIndex, Double.parseDouble(maxTotalConsumption));
                paramIndex++;
            }
            if (fromJoinDate != null && !fromJoinDate.isEmpty()) {
                stmt.setString(paramIndex, fromJoinDate);
                paramIndex++;
            }
            if (toJoinDate != null && !toJoinDate.isEmpty()) {
                stmt.setString(paramIndex, toJoinDate);
                paramIndex++;
            }
            if (vipLevel != null && !vipLevel.isEmpty()) {
                stmt.setInt(paramIndex, Integer.parseInt(vipLevel));
                paramIndex++;
            }

            ResultSet rs = stmt.executeQuery();
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"customers.csv\"");
            PrintWriter out = response.getWriter();
            out.println("CustomerID,CustomerName,ContactInfo,Username,Password,JoinDate,TotalConsumption,VIPLevel");
            while (rs.next()) {
                out.println(String.join(",",
                        Integer.toString(rs.getInt("CustomerID")),
                        rs.getString("CustomerName"),
                        rs.getString("ContactInfo"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("JoinDate"),
                        rs.getBigDecimal("TotalConsumption").toPlainString(),
                        Integer.toString(rs.getInt("VIPLevel"))
                ));
            }
            out.flush();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static class CustomersResponse {
        private List<Customer> customers;
        private int totalPages;

        public CustomersResponse(List<Customer> customers, int totalPages) {
            this.customers = customers;
            this.totalPages = totalPages;
        }
    }
}
