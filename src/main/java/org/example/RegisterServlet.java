package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String customerName = request.getParameter("customerName");
        String contactInfo = request.getParameter("contactInfo");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean isVip = "on".equals(request.getParameter("vip"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO Customer (CustomerName, ContactInfo, Username, Password, IsVIP) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, customerName);
                stmt.setString(2, contactInfo);
                stmt.setString(3, username);
                stmt.setString(4, password);
                stmt.setBoolean(5, isVip);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("index.jsp"); // Registration successful, redirect to home
                } else {
                    request.setAttribute("error", "Registration failed. Please try again.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database error occurred", e);
        }
    }
}
