<%@ page import="org.example.Product" %>
<!DOCTYPE html>
<html>
<head>
  <title>Product Details</title>
  <style>
    table {
      border-collapse: collapse;
      width: 50%;
      margin: 20px auto;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
    }
    form {
      margin: 20px auto;
      width: 50%;
    }
    form label, input {
      display: block;
      margin: 10px 0;
    }
    button {
      margin-top: 10px;
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
    }
    button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
<h1 style="text-align:center;">Product Details</h1>
<%
  Product product = (Product) request.getAttribute("product");
  if (product != null) {
%>
<table>
  <tr>
    <th>Product ID:</th>
    <td><%= product.getProductId() %></td>
  </tr>
  <tr>
    <th>Name:</th>
    <td><%= product.getProductName() %></td>
  </tr>
  <tr>
    <th>Category:</th>
    <td><%= product.getCategory() %></td>
  </tr>
  <tr>
    <th>Purchase Price:</th>
    <td><%= product.getPurchasePrice() %></td>
  </tr>
  <tr>
    <th>Selling Price:</th>
    <td><%= product.getSellingPrice() %></td>
  </tr>
  <tr>
    <th>Shelf Stock:</th>
    <td><%= product.getShelfStock() %></td>
  </tr>
  <tr>
    <th>Warehouse Stock:</th>
    <td><%= product.getWarehouseStock() %></td>
  </tr>
</table>
<form action="purchase" method="post">
  <input type="hidden" name="productId" value="<%= product.getProductId() %>">
  <label for="quantity">Quantity:</label>
  <input type="number" id="quantity" name="quantity" required min="1" max="<%= product.getShelfStock() %>">
  <label for="customerName">Your Name:</label>
  <input type="text" id="customerName" name="customerName" required>
  <label for="contactInfo">Contact Info:</label>
  <input type="text" id="contactInfo" name="contactInfo" required>
  <button type="submit">Purchase</button>
</form>
<%
} else {
%>
<p style="text-align:center;">Product not found.</p>
<%
  }
%>
</body>
</html>
