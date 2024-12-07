package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login_staff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException{
        String username = request.getParameter("username");
        String password = PasswordUtil.hashPassword(request.getParameter("password"));
        String role = request.getParameter("role"); // employee or admin

        // Debugging
        System.out.println("Entered username: " + username + "\nHashed password: " + password + "\nEntered role: " + role);

        try (Connection conn = DatabaseConnection.getConnection()) {

            // Debugging
            System.out.println("Connected to database success");

            String query;
            if ("admin".equals(role)) {
                query = "SELECT * FROM Admin WHERE Username = ?";
            } else {
                query = "SELECT * FROM Staff WHERE Username = ? AND Position = '收银员'";
            }

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();

                // Debugging
                System.out.println("Query: " + stmt.toString());

                if (rs.next()) {
                    // Username exists, check password
                    String dbPassword = rs.getString("Password");
                    if (dbPassword.equals(password)) {

                        // Debugging
                        System.out.println("Login successful");
                        System.out.println("Username: " + rs.getString("Username") + "\nPassword: " + rs.getString("Password") + "\nRole: " + role);

                        // Login successful
                        HttpSession session = request.getSession();
                        session.setAttribute("username", username);
                        session.setAttribute("role", role);

                        if ("admin".equals(role)) {
                            // TODO: AdminDashboardServlet.java; admin_dashboard.jsp
                            response.sendRedirect("admin_dashboard.jsp");
                            session.setAttribute("username", username);
                            session.setAttribute("role", role);

                        } else {
                            // TODO: EmployeeDashboardServlet.java; employee_dashboard.jsp
                            response.sendRedirect("employee_dashboard.jsp");
                        }
                    } else {
                        // Password incorrect
                        request.setAttribute("error", "Invalid password.");
                        request.setAttribute("username", username); // Retain entered username
                        request.getRequestDispatcher("login_staff.jsp").forward(request, response);
                    }
                } else {
                    // Username does not exist
                    request.setAttribute("error", "Username does not exist.");
                    request.getRequestDispatcher("login_staff.jsp").forward(request, response);

                    // Debugging
                    System.out.println("Login failed");
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database error occurred", e);
        }
    }
}
