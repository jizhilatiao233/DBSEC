package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CustomerLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login_customer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String username = request.getParameter("username");
        String password = PasswordUtil.hashPassword(request.getParameter("password"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM Customer WHERE Username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();

                // Username exists, check password
                if (rs.next()) {
                    String dbPassword = rs.getString("Password");
                    if (dbPassword.equals(password)) {
                        // Login successful
                        HttpSession session = request.getSession();
                        session.setAttribute("username", username);
                        session.setAttribute("role", "customer");

                        // Redirect to product list
                        response.sendRedirect("product?action=list");
                    } else {
                        request.setAttribute("error", "Invalid password.");
                        request.setAttribute("username", username);
                        request.getRequestDispatcher("login_customer.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Username does not exist.");
                    request.getRequestDispatcher("login_customer.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database error occurred", e);
        }
    }
}