<%@ page import="org.example.Product" %>
<!DOCTYPE html>
<html>
<head>
  <title>Product Details</title>
</head>
<body>
<h1>Product Details</h1>
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
<form action="product" method="post">
  <input type="hidden" name="action" value="purchase">
  <input type="hidden" name="productId" value="<%= product.getProductId() %>">
  <label for="quantity">Quantity:</label>
  <input type="number" id="quantity" name="quantity" required>
  <label for="customerName">Name:</label>
  <input type="text" id="customerName" name="customerName" required>
  <label for="contactInfo">Contact Info:</label>
  <input type="text" id="contactInfo" name="contactInfo" required>
  <button type="submit">Purchase</button>
</form>
<%
} else {
%>
<p>Product not found</p>
<%
  }
%>
</body>
</html>
