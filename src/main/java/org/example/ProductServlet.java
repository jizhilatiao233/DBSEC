package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String action = request.getParameter("action");

        try (Connection conn = DatabaseConnection.getConnection()) {

            // Debugging
            System.out.println("Database Connected Success");
            System.out.println("ProductServlet: action = " + action);

            if ("details".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                String query = "SELECT * FROM Product WHERE ProductID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, productId);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        Product product = new Product(
                                rs.getInt("ProductID"),
                                rs.getString("ProductName"),
                                rs.getString("Category"),
                                rs.getBigDecimal("PurchasePrice"),
                                rs.getBigDecimal("SellingPrice"),
                                rs.getInt("ShelfStock"),
                                rs.getInt("WarehouseStock")
                        );
                        request.setAttribute("product", product);
                        request.getRequestDispatcher("product_details.jsp").forward(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    }
                }
            } else {
                String query = "SELECT * FROM Product";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    ResultSet rs = stmt.executeQuery();
                    List<Product> products = new ArrayList<>();
                    while (rs.next()) {
                        products.add(new Product(
                                rs.getInt("ProductID"),
                                rs.getString("ProductName"),
                                rs.getString("Category"),
                                rs.getBigDecimal("PurchasePrice"),
                                rs.getBigDecimal("SellingPrice"),
                                rs.getInt("ShelfStock"),
                                rs.getInt("WarehouseStock")
                        ));
                    }
                    request.setAttribute("products", products);
                    request.getRequestDispatcher("product_list.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database error occurred", e);
        }
    }
}

//数据库表单已更新 请使用新的shopman.sql建库；
//数据库连接配置位于/resources/application.properties中，请按需求修改；
//数据库提供了几组AI生成的测试数据，详见testdata.sql；
//已实现功能：员工/管理员登陆页面、顾客注册页面、商品页面、商品详细信息页面 页面很简陋（我不会前端QAQ） 页面功能待验证。
