<%@ page import="org.example.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
  <title>Product List</title>
  <style>
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
    }
  </style>
</head>
<body>
<h1>Product List</h1>
<table>
  <thead>
  <tr>
    <th>Product ID</th>
    <th>Name</th>
    <th>Category</th>
    <th>Selling Price</th>
    <th>Shelf Stock</th>
    <th>Details</th>
  </tr>
  </thead>
  <tbody>
  <%
    List<Product> products = (List<Product>) request.getAttribute("products");
    if (products != null) {
      for (Product product : products) {
  %>
  <tr>
    <td><%= product.getProductId() %></td>
    <td><%= product.getProductName() %></td>
    <td><%= product.getCategory() %></td>
    <td><%= product.getSellingPrice() %></td>
    <td><%= product.getShelfStock() %></td>
    <td><a href="product?action=details&productId=<%= product.getProductId() %>">View Details</a></td>
  </tr>
  <%
    }
  } else {
  %>
  <tr>
    <td colspan="6">No products available</td>
  </tr>
  <%
    }
  %>
  </tbody>
</table>
</body>
</html>
