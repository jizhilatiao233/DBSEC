<%@ page import="java.util.*, org.json.*" %>
<%
    String category = request.getParameter("category");
    String priceRange = request.getParameter("priceRange");

    // 假设你从数据库获取商品数据的逻辑如下：
    List<Product> filteredProducts = ProductDAO.filterProducts(category, priceRange);

    // 创建JSON响应
    JSONObject jsonResponse = new JSONObject();
    JSONArray productsArray = new JSONArray();

    for (Product product : filteredProducts) {
        JSONObject productJson = new JSONObject();
        productJson.put("productId", product.getId());
        productJson.put("productName", product.getName());
        productJson.put("category", product.getCategory());
        productJson.put("purchasePrice", product.getPurchasePrice());
        productJson.put("sellingPrice", product.getSellingPrice());
        productJson.put("shelfStock", product.getShelfStock());
        productJson.put("warehouseStock", product.getWarehouseStock());
        productsArray.put(productJson);
    }

    jsonResponse.put("products", productsArray);
    jsonResponse.put("totalPages", calculateTotalPages(filteredProducts.size()));

    response.setContentType("application/json");
    response.getWriter().write(jsonResponse.toString());
%>
