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

public class AdminInformationServlet extends HttpServlet {
    @Override
    protected  void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getUserInformation".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                getUserInformation(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("editPassword".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                editPassword(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("editInformation".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                editInformation(request, response, conn);
            } catch (Exception e) {
                throw new ServletException("Database access error", e);
            }
        }
        else if ("deleteAdmin".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                deleteAdmin(request, response, conn);
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

    private void getUserInformation(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        String query = "SELECT * FROM Admin WHERE adminID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, adminID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Admin admin = new Admin(
                        rs.getInt("AdminID"),
                        rs.getString("AdminName"),
                        rs.getString("ContactInfo"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("JoinDate"),
                        rs.getString("Position")
                );
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print(new Gson().toJson(admin));
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Staff not found");
            }
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void editPassword(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        String newPassword = PasswordUtil.hashPassword(request.getParameter("newPassword"));
        String query = "UPDATE Admin SET Password = ? WHERE AdminID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, newPassword);
            stmt.setInt(2, adminID);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("userInformation.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Admin not found");
            }
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    private void editInformation(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        String username = request.getParameter("username");
        String contactInfo = request.getParameter("contactInfo");
        String query = "UPDATE Admin SET Username = ?, ContactInfo = ? WHERE AdminID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, contactInfo);
            stmt.setInt(3, adminID);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("userInformation.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Admin not found");
            }
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }

    // 注销账号：逻辑注销，不从数据库中删除，方法为设置Position为“已注销”
    private void deleteAdmin(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException {
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        String query = "UPDATE Admin SET Position = '已注销' WHERE AdminID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, adminID);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("Index.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Admin not found");
            }
        } catch (SQLException e) {
            throw new IOException("Database access error", e);
        }
    }
}
