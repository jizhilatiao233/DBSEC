package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException{
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // employee or admin

        // Debugging
        System.out.println("Entered username: " + username + "\nEntered password: " + password + "\nEntered role: " + role);

        try (Connection conn = DatabaseConnection.getConnection()) {

            // Debugging
            System.out.println("Connected to database success");

            String query;
            if ("admin".equals(role)) {
                query = "SELECT * FROM Admin WHERE Username = ? AND Password = ?";
            } else {
                query = "SELECT * FROM Staff WHERE Username = ? AND Position = '收银员' AND Password = ?";
            }

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                // Debugging
                System.out.println("Query: " + stmt.toString());

                if (rs.next()) {
                    // Login successful
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    // Debugging
                    System.out.println("Login successful");
                    System.out.println("Username: " + rs.getString("Username") + "\nPassword: " + rs.getString("Password") + "\nRole: " + role);

                    if ("admin".equals(role)) {
                        response.sendRedirect("admin_dashboard.jsp");
                    } else {
                        response.sendRedirect("employee_dashboard.jsp");
                    }
                } else {
                    // Login failed
                    request.setAttribute("error", "Invalid username or password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);

                    // Debugging
                    System.out.println("Login failed");

                }
            }
        } catch (Exception e) {
            throw new ServletException("Database error occurred", e);
        }
    }
}
