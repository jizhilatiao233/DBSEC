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

public class StaffManageServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getStaffs".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getStaffs(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("getStaffDetails".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getStaffDetails(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("getPositions".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getPositions(request, response, conn);
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

    private void getStaffs(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
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
            sortBy = "StaffID";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        // filter parameters
        String staffID = request.getParameter("staffID");
        String staffName = request.getParameter("staffName");
        String contactInfo = request.getParameter("contactInfo");
        String fromJoinDate = request.getParameter("fromJoinDate");
        String toJoinDate = request.getParameter("toJoinDate");
        String position = request.getParameter("position");
        String adminID = request.getParameter("adminID");
        String adminName = request.getParameter("adminName");

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT s.StaffID, s.StaffName, s.ContactInfo, s.Username, s.Password, s.JoinDate, s.Position, s.AdminID, a.AdminName " +
                "FROM Staff s " +
                "JOIN Admin a ON s.AdminID = a.AdminID " +
                "WHERE 1=1 ");
        StringBuilder countQueryBuilder = new StringBuilder("SELECT COUNT(*) as total " +
                "FROM Staff s " +
                "JOIN Admin a ON s.AdminID = a.AdminID " +
                "WHERE 1=1 ");
        if (staffID != null && !staffID.isEmpty()) {
            queryBuilder.append("AND s.StaffID = ? ");
            countQueryBuilder.append("AND s.StaffID = ? ");
        }
        if (staffName != null && !staffName.isEmpty()) {
            queryBuilder.append("AND s.StaffName LIKE ? ");
            countQueryBuilder.append("AND s.StaffName LIKE ? ");
        }
        if (contactInfo != null && !contactInfo.isEmpty()) {
            queryBuilder.append("AND s.ContactInfo LIKE ? ");
            countQueryBuilder.append("AND s.ContactInfo LIKE ? ");
        }
        if (fromJoinDate != null && !fromJoinDate.isEmpty()) {
            queryBuilder.append("AND s.JoinDate >= ? ");
            countQueryBuilder.append("AND s.JoinDate >= ? ");
        }
        if (toJoinDate != null && !toJoinDate.isEmpty()) {
            queryBuilder.append("AND s.JoinDate <= ? ");
            countQueryBuilder.append("AND s.JoinDate <= ? ");
        }
        if (position != null && !position.isEmpty()) {
            queryBuilder.append("AND s.Position LIKE ? ");
            countQueryBuilder.append("AND s.Position LIKE ? ");
        }
        if (adminID != null && !adminID.isEmpty()) {
            queryBuilder.append("AND s.AdminID = ? ");
            countQueryBuilder.append("AND s.AdminID = ? ");
        }
        if (adminName != null && !adminName.isEmpty()) {
            queryBuilder.append("AND a.AdminName LIKE ? ");
            countQueryBuilder.append("AND a.AdminName LIKE ? ");
        }
        queryBuilder.append("ORDER BY ").append(sortBy).append(" ").append(sortOrder).append(" ");
        queryBuilder.append("LIMIT ? OFFSET ?");
        String query = queryBuilder.toString();
        String countQuery = countQueryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query);
             PreparedStatement countStmt = conn.prepareStatement(countQuery)) {
            int paramIndex = 1;
            if (staffID != null && !staffID.isEmpty()) {
                stmt.setInt(paramIndex, Integer.parseInt(staffID));
                countStmt.setInt(paramIndex, Integer.parseInt(staffID));
                paramIndex++;
            }
            if (staffName != null && !staffName.isEmpty()) {
                stmt.setString(paramIndex, "%" + staffName + "%");
                countStmt.setString(paramIndex, "%" + staffName + "%");
                paramIndex++;
            }
            if (contactInfo != null && !contactInfo.isEmpty()) {
                stmt.setString(paramIndex, "%" + contactInfo + "%");
                countStmt.setString(paramIndex, "%" + contactInfo + "%");
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
            if (position != null && !position.isEmpty()) {
                stmt.setString(paramIndex, "%" + position + "%");
                countStmt.setString(paramIndex, "%" + position + "%");
                paramIndex++;
            }
            if (adminID != null && !adminID.isEmpty()) {
                stmt.setInt(paramIndex, Integer.parseInt(adminID));
                countStmt.setInt(paramIndex, Integer.parseInt(adminID));
                paramIndex++;
            }
            if (adminName != null && !adminName.isEmpty()) {
                stmt.setString(paramIndex, "%" + adminName + "%");
                countStmt.setString(paramIndex, "%" + adminName + "%");
                paramIndex++;
            }
            stmt.setInt(paramIndex++, limit);
            stmt.setInt(paramIndex, offset);

            ResultSet rs = stmt.executeQuery();
            List<Staff> staffs = new ArrayList<>();
            while (rs.next()) {
                staffs.add(new Staff(
                        rs.getInt("StaffID"),
                        rs.getString("StaffName"),
                        rs.getString("ContactInfo"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("JoinDate"),
                        rs.getString("Position"),
                        rs.getInt("AdminID"),
                        rs.getString("AdminName")
                ));
            }

            // get total count
            ResultSet countRs = countStmt.executeQuery();
            int totalStaffs = 0;
            if (countRs.next()) {
                totalStaffs = countRs.getInt("total");
            }
            int totalPages = (int) Math.ceil((double) totalStaffs / limit);

            // return result
            StaffsResponse staffsResponse = new StaffsResponse(staffs, totalPages);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(staffsResponse));
            out.flush();
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void getStaffDetails(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int staffID = Integer.parseInt(request.getParameter("staffID"));
        String query = "SELECT s.StaffID, s.StaffName, s.ContactInfo, s.Username, s.Password, s.JoinDate, s.Position, s.AdminID, a.AdminName " +
                "FROM Staff s " +
                "JOIN Admin a ON s.AdminID = a.AdminID " +
                "WHERE s.StaffID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, staffID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Staff staff = new Staff(
                        rs.getInt("StaffID"),
                        rs.getString("StaffName"),
                        rs.getString("ContactInfo"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("JoinDate"),
                        rs.getString("Position"),
                        rs.getInt("AdminID"),
                        rs.getString("AdminName")
                );
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print(new Gson().toJson(staff));
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Staff not found");
            }
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void getPositions(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        String query = "SELECT DISTINCT Position FROM Staff";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            List<String> positions = new ArrayList<>();
            while (rs.next()) {
                positions.add(rs.getString("Position"));
            }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(positions));
            out.flush();
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void exportCSV(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        // filter parameters
        String staffID = request.getParameter("staffID");
        String staffName = request.getParameter("staffName");
        String contactInfo = request.getParameter("contactInfo");
        String fromJoinDate = request.getParameter("fromJoinDate");
        String toJoinDate = request.getParameter("toJoinDate");
        String position = request.getParameter("position");
        String adminID = request.getParameter("adminID");
        String adminName = request.getParameter("adminName");

        // sort parameters
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "StaffID";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        // build query
        StringBuilder queryBuilder = new StringBuilder("SELECT s.StaffID, s.StaffName, s.ContactInfo, s.Username, s.Password, s.JoinDate, s.Position, s.AdminID, a.AdminName " +
                "FROM Staff s " +
                "JOIN Admin a ON s.AdminID = a.AdminID " +
                "WHERE 1=1 ");
        if (staffID != null && !staffID.isEmpty()) {
            queryBuilder.append("AND s.StaffID = ? ");
        }
        if (staffName != null && !staffName.isEmpty()) {
            queryBuilder.append("AND s.StaffName LIKE ? ");
        }
        if (contactInfo != null && !contactInfo.isEmpty()) {
            queryBuilder.append("AND s.ContactInfo LIKE ? ");
        }
        if (fromJoinDate != null && !fromJoinDate.isEmpty()) {
            queryBuilder.append("AND s.JoinDate >= ? ");
        }
        if (toJoinDate != null && !toJoinDate.isEmpty()) {
            queryBuilder.append("AND s.JoinDate <= ? ");
        }
        if (position != null && !position.isEmpty()) {
            queryBuilder.append("AND s.Position LIKE ? ");
        }
        if (adminID != null && !adminID.isEmpty()) {
            queryBuilder.append("AND s.AdminID = ? ");
        }
        if (adminName != null && !adminName.isEmpty()) {
            queryBuilder.append("AND a.AdminName LIKE ? ");
        }
        queryBuilder.append("ORDER BY ").append(sortBy).append(" ").append(sortOrder);
        String query = queryBuilder.toString();

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            int paramIndex = 1;
            if (staffID != null && !staffID.isEmpty()) {
                stmt.setInt(paramIndex, Integer.parseInt(staffID));
                paramIndex++;
            }
            if (staffName != null && !staffName.isEmpty()) {
                stmt.setString(paramIndex, "%" + staffName + "%");
                paramIndex++;
            }
            if (contactInfo != null && !contactInfo.isEmpty()) {
                stmt.setString(paramIndex, "%" + contactInfo + "%");
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
            if (position != null && !position.isEmpty()) {
                stmt.setString(paramIndex, "%" + position + "%");
                paramIndex++;
            }
            if (adminID != null && !adminID.isEmpty()) {
                stmt.setInt(paramIndex, Integer.parseInt(adminID));
                paramIndex++;
            }
            if (adminName != null && !adminName.isEmpty()) {
                stmt.setString(paramIndex, "%" + adminName + "%");
                paramIndex++;
            }

            ResultSet rs = stmt.executeQuery();
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"staffs.csv\"");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.println("StaffID,StaffName,ContactInfo,Username,Password,JoinDate,Position,AdminID,AdminName");
            while (rs.next()) {
                out.println(String.join(",",
                        Integer.toString(rs.getInt("StaffID")),
                        rs.getString("StaffName"),
                        rs.getString("ContactInfo"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("JoinDate"),
                        rs.getString("Position"),
                        Integer.toString(rs.getInt("AdminID")),
                        rs.getString("AdminName")
                ));
            }
            out.flush();
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private static class StaffsResponse {
        List<Staff> staffs;
        int totalPages;

        public StaffsResponse(List<Staff> staffs, int totalPages) {
            this.staffs = staffs;
            this.totalPages = totalPages;
        }
    }
}
