package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CustomerRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String customerName = request.getParameter("customerName");
        String contactInfo = request.getParameter("contactInfo");
        String username = request.getParameter("username");
        String password = PasswordUtil.hashPassword(request.getParameter("password"));
        boolean isVip = "on".equals(request.getParameter("vip"));
        int VIPLevel = 0;
        if (isVip) {
            VIPLevel = 1;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            if (isUsernameTaken(conn, username)) {
                request.setAttribute("usernameTakenError", "Username is already taken.");
                request.setAttribute("customerName", customerName);
                request.setAttribute("contactInfo", contactInfo);
                request.getRequestDispatcher("register_customer.jsp").forward(request, response);
                return;
            }

            String query = "INSERT INTO Customer (CustomerName, ContactInfo, Username, Password, VIPLevel) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, customerName);
                stmt.setString(2, contactInfo);
                stmt.setString(3, username);
                stmt.setString(4, password);
                stmt.setBoolean(5, isVip);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    // 注册成功，返回成功弹窗
                    request.setAttribute("successMessage", "Registration successful! You can now log in.");
                    request.getRequestDispatcher("register_customer.jsp").forward(request, response);


                } else {
                    request.setAttribute("normalError", "Registration failed. Please try again.");
                    request.getRequestDispatcher("register_customer.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database error occurred", e);
        }
    }

    private boolean isUsernameTaken(Connection conn, String username) throws Exception {
        String query = "SELECT COUNT(*) FROM Customer WHERE Username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}
