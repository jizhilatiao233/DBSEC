<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>商品管理 - 超市管理系统</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f1f8ff;
      color: #333;
      animation: fadeIn 1s ease-in-out;
    }

    /* 页面加载渐现动画 */
    @keyframes fadeIn {
      0% { opacity: 0; }
      100% { opacity: 1; }
    }

    /* Header Section */
    header {
      background-color: #4d94ff;
      color: white;
      padding: 20px;
      text-align: center;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    /* Side Navigation */
    nav {
      height: 100%;
      width: 250px;
      position: fixed;
      top: 0;
      left: 0;
      background-color: #0066cc;
      padding-top: 30px;
      box-shadow: 4px 0 8px rgba(0, 0, 0, 0.1);
      transition: all 0.3s ease;
    }

    nav a {
      display: block;
      color: white;
      padding: 16px;
      text-decoration: none;
      font-size: 18px;
      margin: 0;
      transition: background-color 0.3s ease;
      position: relative;
    }

    nav a:hover {
      background-color: #004d99;
      transform: scale(1.05);
    }

    nav a.active {
      background-color: #003366;
    }

    /* Main content area */
    .container {
      margin-left: 270px;
      padding: 30px;
      transition: margin-left 0.3s ease;
    }

    h2 {
      font-size: 28px;
      color: #0056b3;
      margin-bottom: 20px;
      font-weight: 600;
    }

    /* 商品管理表格 */
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    table th, table td {
      padding: 10px;
      border: 1px solid #ddd;
      text-align: center;
    }

    table th {
      background-color: #4d94ff;
      color: white;
    }

    .action-btns {
      display: flex;
      gap: 10px;
      justify-content: center;
    }

    .action-btns a {
      padding: 8px 16px;
      background-color: #4d94ff;
      color: white;
      text-decoration: none;
      border-radius: 6px;
      transition: background-color 0.3s;
    }

    .action-btns a:hover {
      background-color: #003366;
    }

    .footer {
      background-color: #0066cc;
      color: white;
      text-align: center;
      padding: 10px;
      position: fixed;
      bottom: 0;
      width: 100%;
    }

    /* Right Top User Info */
    .user-info {
      position: absolute;
      top: 20px;
      right: 20px;
      background-color: #0066cc;
      color: white;
      padding: 10px 20px;
      border-radius: 30px;
      font-size: 16px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .user-info .logout-btn {
      background-color: #f44336;
      color: white;
      padding: 5px 10px;
      border-radius: 4px;
      text-decoration: none;
      font-size: 14px;
      display: inline-block;
      cursor: pointer;
    }

    .user-info .logout-btn:hover {
      background-color: #d32f2f;
    }

    /* Search, Sort, and Action Buttons in one row */
    .action-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      flex-wrap: wrap;
    }

    .action-bar form {
      display: inline-flex;
      align-items: center;
    }

    .action-bar input[type="text"], .action-bar select {
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
      margin-right: 10px;
    }

    .action-bar button {
      padding: 8px 12px;
      border: 1px solid #0066cc;
      background-color: #0066cc;
      color: white;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .action-bar button:hover {
      background-color: #005bb5;
    }

    /* 弹窗样式 */
    .modal {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      justify-content: center;
      align-items: center;
      z-index: 9999;  /* Ensure modal appears on top */
    }

    .modal-content {
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      width: 400px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .modal-content input, .modal-content select, .modal-content button {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border-radius: 6px;
      border: 1px solid #ddd;
    }

    .modal-content button {
      background-color: #4d94ff;
      color: white;
      cursor: pointer;
    }

    .modal-content button:hover {
      background-color: #003366;
    }


    .stock-warning-card {
      background: linear-gradient(135deg, #9c0202 30%, #ed0404 100%); /* 渐变从蓝色到深蓝色 */
      color: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      margin-bottom: 20px;
      text-align: center;
      font-size: 18px;
    }


    .stock-warning-card a {
      color: white;
      text-decoration: none;
      font-weight: bold;
    }

    .stock-warning-card a:hover {
      text-decoration: underline;
    }

  </style>
</head>
<body>

<!-- Header Section -->
<header>
  <h1>商品管理 - 超市管理系统</h1>
</header>

<!-- Side Navigation -->
<nav id="sideNav">
  <a href="admin_dashboard.jsp" class="active"><i class="fas fa-tachometer-alt"></i> 仪表盘</a>
  <a href="product_list.jsp"><i class="fas fa-cogs"></i> 商品管理</a>
  <a href="salesManagement.jsp"><i class="fas fa-shopping-cart"></i> 销售管理</a>
  <a href="customerManagement.jsp"><i class="fas fa-warehouse"></i> 客户管理</a>
  <a href="orderManagement.jsp"><i class="fas fa-box"></i> 订单管理</a>
  <a href="incomingInformation.jsp"><i class="fas fa-chart-line"></i> 进货信息</a>
  <a href="employeeManagement.jsp"><i class="fas fa-users"></i> 员工管理</a>
  <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> 退出</a>
</nav>
<div class="user-info">
        <span>
            <i class="fas fa-user"></i>
            <%
              // 从 session 获取当前用户的信息
              String userName = (String) session.getAttribute("username");
              String role = (String) session.getAttribute("role");
              if (userName != null) {
                out.print(userName + " (" + role + ")");
              } else {
                out.print("访客");
              }
            %>
        </span>
  <a href="logout.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i> 退出</a>
</div>
<!-- Main Content Section -->
<div class="container">
  <h2>商品列表</h2>
  <!-- 库存不足警告卡片 -->
  <!-- 库存预警卡片 -->
  <div class="card stock-warning-card">
    <p class="card-title"><strong>库存预警！</strong></p>
    <p class="card-content">当前有商品库存低于最低设定库存，请及时检查。</p>
    <a class="card-link" href="product_warning.jsp">点击查看库存预警详情</a>
  </div>
  <!-- 搜索框、排序、筛选、批量删除和导出按钮 -->
  <div class="action-bar">
    <form method="get" action="product_list.jsp">
      <input type="text" name="search" placeholder="输入商品名称或类别">
      <button type="submit">搜索</button>
    </form>

    <form method="get" action="product_list.jsp">
      <label for="sortBy">排序方式:</label>
      <select name="sortBy" id="sortBy">
        <option value="productName">商品名称</option>
        <option value="purchasePrice">进价</option>
        <option value="sellingPrice">售价</option>
        <option value="shelfStock">上架数量</option>
      </select>
      <button type="submit">排序</button>
    </form>

    <form id="filterForm">
      <label for="category">类别:</label>
      <select name="category" id="category">
        <option value="all">所有</option>
        <option value="食品">食品</option>
        <option value="饮料">饮料</option>
      </select>

      <label for="priceRange">价格范围:</label>
      <select name="priceRange" id="priceRange">
        <option value="all">全部</option>
        <option value="0-50">0-50元</option>
        <option value="51-100">51-100元</option>
      </select>

      <button type="button" onclick="applyFilter()">筛选</button>
    </form>


    <form method="post" action="batchDeleteProduct">
      <button type="submit">批量删除</button>
    </form>

    <form method="post" action="exportCSV">
      <button type="submit">导出CSV</button>
    </form>

    <!-- 添加商品按钮 -->
    <button onclick="openModal('add')">添加商品</button>

  </div>

  <!-- 商品列表展示 -->
  <table>
    <thead>
    <tr>
      <th><input type="checkbox" id="selectAll"> 全选</th>
      <th>商品ID</th>
      <th>商品名称</th>
      <th>类别</th>
      <th>进价</th>
      <th>售价</th>
      <th>上架数量</th>
      <th>仓库库存</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <!-- 示例数据 -->
    <tr>
      <td><input type="checkbox" name="selectedProducts" value="1"></td>
      <td>001</td>
      <td><a href="product_detail.jsp?id=1">商品1</a></td>
      <td>类别1</td>
      <td>50.00</td>
      <td>80.00</td>
      <td>100</td>
      <td>500</td> <!-- 仓库库存 -->
      <td>
        <div class="action-btns">
          <a href="javascript:void(0)" onclick="openModal('edit', 1)">编辑</a>
          <a href="deleteProduct.jsp?id=1">删除</a>
        </div>
      </td>
    </tr>
    </tbody>
  </table>
  <div class="pagination" id="pagination">
    <!-- 分页按钮将在这里动态生成 -->
  </div>
</div>

<!-- Footer Section -->
<div class="footer">
  <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<!-- 商品操作弹窗 -->
<div id="productModal" class="modal">
  <div class="modal-content">
    <h2 id="modalTitle">添加商品</h2>
    <form id="productForm" method="post" action="addOrEditProduct.jsp">
      <input type="hidden" name="productId" id="productId">

      <label for="productName">商品名称:</label>
      <input type="text" name="productName" id="productName" required>

      <label for="category">类别:</label>
      <input type="text" name="category" id="category" required>

      <label for="purchasePrice">进价:</label>
      <input type="number" name="purchasePrice" id="purchasePrice" min="0" step="0.01" required>

      <label for="sellingPrice">售价:</label>
      <input type="number" name="sellingPrice" id="sellingPrice" min="0" step="0.01" required>

      <label for="shelfStock">上架数量:</label>
      <input type="number" name="shelfStock" id="shelfStock" min="0" required>

      <label for="warehouseStock">仓库库存:</label>
      <input type="number" name="warehouseStock" id="warehouseStock" min="0" required>

      <button type="submit" class="submit-btn">提交</button>
      <button class="close-btn" onclick="closeModal()">关闭</button>
    </form>
  </div>
</div>

<script>
  // 打开弹窗
  function openModal(action, productId = null) {
    var modal = document.getElementById('productModal');
    var modalTitle = document.getElementById('modalTitle');
    var productForm = document.getElementById('productForm');

    if (action === 'add') {
      modalTitle.textContent = '添加商品';
      productForm.action = 'addProduct.jsp';  // 添加商品的处理路径
      document.getElementById('productId').value = '';
      document.getElementById('productName').value = '';
      document.getElementById('category').value = '';
      document.getElementById('purchasePrice').value = '';
      document.getElementById('sellingPrice').value = '';
      document.getElementById('shelfStock').value = '';
      document.getElementById('warehouseStock').value = '';
    } else if (action === 'edit') {
      modalTitle.textContent = '编辑商品';
      productForm.action = 'editProduct.jsp';  // 编辑商品的处理路径
      document.getElementById('productId').value = productId;

      // 通过AJAX获取商品详情来填充表单（例如：从数据库加载商品信息）
      fetch('getProductDetails.jsp?id=' + productId)
              .then(response => response.json())
              .then(data => {
                document.getElementById('productName').value = data.productName;
                document.getElementById('category').value = data.category;
                document.getElementById('purchasePrice').value = data.purchasePrice;
                document.getElementById('sellingPrice').value = data.sellingPrice;
                document.getElementById('shelfStock').value = data.shelfStock;
                document.getElementById('warehouseStock').value = data.warehouseStock;
              })
              .catch(error => console.error('Error fetching product details:', error));
    }

    modal.style.display = 'flex';
  }

  // 关闭弹窗
  function closeModal() {
    var modal = document.getElementById('productModal');
    modal.style.display = 'none';
  }

  //商品筛选
  function applyFilter() {
    const category = document.getElementById('category').value;
    const priceRange = document.getElementById('priceRange').value;

    fetch(`filterProduct.jsp?category=${category}&priceRange=${priceRange}`)
            .then(response => response.json())
            .then(data => {
              const productList = document.getElementById('productList');
              productList.innerHTML = ''; // 清空原有的商品列表

              data.products.forEach(product => {
                const row = document.createElement('tr');
                row.innerHTML = `
          <td><input type="checkbox" name="selectedProducts" value="${product.productId}"></td>
          <td>${product.productId}</td>
          <td><a href="product_detail.jsp?id=${product.productId}">${product.productName}</a></td>
          <td>${product.category}</td>
          <td>${product.purchasePrice}</td>
          <td>${product.sellingPrice}</td>
          <td>${product.shelfStock}</td>
          <td>${product.warehouseStock}</td>
          <td>
            <div class="action-btns">
              <a href="javascript:void(0)" onclick="openModal('edit', ${product.productId})">编辑</a>
              <a href="deleteProduct.jsp?id=${product.productId}">删除</a>
            </div>
          </td>
        `;
                productList.appendChild(row);
              });

              // 更新分页（如需要）
              updatePagination(data.totalPages);
            })
            .catch(error => console.error('Error applying filter:', error));
  }

  // 全选操作
  document.getElementById('selectAll').addEventListener('change', function () {
    var checkboxes = document.querySelectorAll('input[name="selectedProducts"]');
    checkboxes.forEach(checkbox => checkbox.checked = this.checked);
  });

    // 每页显示的商品数量
    const itemsPerPage = 50;

    // 当前页码
    let currentPage = 1;

    // 获取商品列表和分页信息
    function fetchProducts(page = 1) {
    currentPage = page;
    const offset = (page - 1) * itemsPerPage;

    // 发送请求获取当前页的数据
    fetch(`getProducts.jsp?offset=${offset}&limit=${itemsPerPage}`)
    .then(response => response.json())
    .then(data => {
    // 更新商品列表
    const productList = document.getElementById('productList');
    productList.innerHTML = '';  // 清空现有的商品列表

    data.products.forEach(product => {
    const row = document.createElement('tr');
    row.innerHTML = `
            <td><input type="checkbox" name="selectedProducts" value="${product.productId}"></td>
            <td>${product.productId}</td>
            <td><a href="product_detail.jsp?id=${product.productId}">${product.productName}</a></td>
            <td>${product.category}</td>
            <td>${product.purchasePrice}</td>
            <td>${product.sellingPrice}</td>
            <td>${product.shelfStock}</td>
            <td>${product.warehouseStock}</td>
            <td>
              <div class="action-btns">
                <a href="javascript:void(0)" onclick="openModal('edit', ${product.productId})">编辑</a>
                <a href="deleteProduct.jsp?id=${product.productId}">删除</a>
              </div>
            </td>
          `;
    productList.appendChild(row);
  });

    // 更新分页按钮
    updatePagination(data.totalPages);
  })
    .catch(error => console.error('Error fetching products:', error));
  }

    // 更新分页按钮
    function updatePagination(totalPages) {
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';  // 清空现有的分页按钮

    for (let i = 1; i <= totalPages; i++) {
    const pageBtn = document.createElement('a');
    pageBtn.href = 'javascript:void(0)';
    pageBtn.textContent = i;
    pageBtn.classList.add(i === currentPage ? 'active' : '');
    pageBtn.onclick = () => fetchProducts(i);
    pagination.appendChild(pageBtn);
  }
  }

    // 页面加载时，获取第一页的商品
    window.onload = function() {
    fetchProducts(1);
  };
</script>

</body>
</html>
