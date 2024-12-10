<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>订单管理 - 超市管理系统</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    /* 基础样式与商品管理页面一致 */
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f1f8ff;
      color: #333;
      animation: fadeIn 1s ease-in-out;
    }
    .button-group {
      display: flex;
      gap: 10px;  /* 按钮之间的间距 */
      align-items: center;
    }
    @keyframes fadeIn {
      0% { opacity: 0; }
      100% { opacity: 1; }
    }

    header {
      background-color: #4d94ff;
      color: white;
      padding: 20px;
      text-align: center;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

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

    .container {
      margin-left: 270px;
      padding: 30px 30px 80px;
      transition: margin-left 0.3s ease;
    }

    h2 {
      font-size: 28px;
      color: #0056b3;
      margin-bottom: 20px;
      font-weight: 600;
    }

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

    .action-bar {
      display: flex;
      flex-wrap: wrap;
      justify-content: flex-start;
      gap: 10px;
      align-items: center;
    }
    .action-bar input[type="text"], input[type="number"],.action-bar select, .action-bar input[type="date"] {
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
      margin-right: 10px;
      width: 140px;
      box-sizing: border-box;
    }
    .action-bar button {
      padding: 8px 12px;
      border: 1px solid #0066cc;
      background-color: #0066cc;
      color: white;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
      max-width: 120px;
    }
    .action-bar button:hover {
      background-color: #005bb5;
    }

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
      z-index: 9999;
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

    .pagination {
      display: flex;
      justify-content: center;
      margin-top: 20px;
    }
    .pagination a {
      padding: 10px 15px;
      margin: 0 5px;
      border: 1px solid #ddd;
      border-radius: 4px;
      text-decoration: none;
      color: #333;
      transition: background-color 0.3s, color 0.3s;
    }
    .pagination a:hover {
      background-color: #4d94ff;
      color: white;
    }
    .pagination a.active {
      background-color: #0066cc;
      color: white;
      border-color: #0066cc;
    }

  </style>
</head>
<body>

<header>
  <h1>订单管理 - 超市管理系统</h1>
</header>

<nav>
  <a href="admin_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> 首页</a>
  <a href="product_management.jsp"><i class="fas fa-cogs"></i> 商品管理</a>
  <a href="salesManagement.jsp"><i class="fas fa-shopping-cart"></i> 销售管理</a>
  <a href="customerManagement.jsp"><i class="fas fa-warehouse"></i> 客户管理</a>
  <a href="orderManagement.jsp" class="active"><i class="fas fa-box"></i> 订单管理</a>
  <a href="incomingInformation.jsp"><i class="fas fa-chart-line"></i> 进货信息</a>
  <a href="staffManagement.jsp"><i class="fas fa-users"></i> 员工管理</a>
  <a href="Logout?redirect=index.jsp"><i class="fas fa-sign-out-alt"></i> 退出</a>
</nav>

<div class="user-info">
  <span>
    <i class="fas fa-user"></i>
    <%
      String userName = (String) session.getAttribute("username");
      String role = (String) session.getAttribute("role");
      if (userName != null) {
        out.print(userName + " (" + role + ")");
      } else {
        out.print("访客");
      }
    %>
  </span>
  <a href="Logout?redirect=index.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i> 退出</a>
</div>

<div class="container">
  <h2>订单管理</h2>

  <!-- 查询功能表单 -->
  <div class="action-bar">
    <!-- 排序和搜索表单 -->
    <form method="get" action="orderManagement.jsp">
      <label for="sortBy">排序方式:</label>
      <select name="sortBy" id="sortBy">
        <option value="">排序方式</option>
        <option value="orderDate">按订单日期排序</option>
        <option value="supplier">按实付金额排序</option>
      </select>
      <button type="submit">排序</button>
    </form>
    <br>
    <!-- 筛选 -->
    <form method="get" action="orderManagement.jsp">
      <input type="text" name="customerName" placeholder="选择客户">
      <input type="text" name="employeeName" placeholder="选择收银员">
      <input type="date" name="orderDate" placeholder="选择日期">
      <button type="submit">筛选</button>
    </form>

    <div class="button-group">
      <!-- 批量删除表单 -->
      <form method="post" action="batchDeleteOrders.jsp">
        <button type="submit">批量删除</button>
      </form>

      <!-- 添加订单按钮 -->
      <button onclick="openModal('add')">添加订单</button>

      <!-- 导出 CSV 表单 -->
      <form method="get" action="exportCSV.jsp">
        <button type="submit">导出CSV</button>
      </form>

    </div>
  </div>

  <table>
    <thead>
    <tr>
      <th>订单号</th>
      <th>客户姓名</th>
      <th>收银员姓名</th>
      <th>总金额</th>
      <th>实付金额</th>
      <th>订单日期</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <!-- 动态加载进货数据 -->
    <tr>
      <td>101</td>
      <td>张三</td>
      <td>收银员A</td>
      <td>100</td>
      <td>80</td>
      <td>2024-12-05</td>
      <td>
        <div class="action-btns">
          <a href="javascript:void(0)" onclick="openModal('detail', 1001)">详情</a>
          <a href="deleteOrder.jsp?id=101" onclick="return confirm('确定要删除该订单吗？')">删除</a>
        </div>
      </td>
    </tr>
    <!-- 更多订单数据 -->
    </tbody>
  </table>
</div>
<!-- 添加订单的模态框 -->
<div class="modal" id="addModal">
  <div class="modal-content">
    <h3>添加订单</h3>
    <form action="addOrder.jsp" method="POST">
      <!-- 订单ID：新增时没有 -->
      <input type="hidden" name="orderId" id="orderId" value="">

      <!-- 商品名称 -->
      <label for="productName">商品名称:</label>
      <select name="productName" id="productName" required>
        <option value="">请选择商品</option>
      </select>

      <!-- 商品数量 -->
      <label for="quantity">商品数量:</label>
      <input type="number" name="quantity" id="quantity" required>

      <!-- 商品单价 -->
      <label for="sellingPrice">商品单价:</label>
      <input type="number" name="sellingPrice" id="sellingPrice" step="0.01" required>

      <!-- 客户名称 -->
      <label for="customerName">客户名称:</label>
      <input type="text" name="customerName" id="customerName" readonly>

      <!-- 折扣 -->
      <label for="discount">折扣:</label>
      <input type="number" name="discount" id="discount" required>

      <!-- 实付金额 -->
      <label for="ActualPayment">实付金额:</label>
      <input type="number" name="ActualPayment" id="ActualPayment" required>

      <!-- 订单日期 -->
      <label for="orderDate">订单日期:</label>
      <input type="date" name="orderDate" id="orderDate" required>

      <button type="submit">添加订单</button>
      <button type="button" onclick="closeModal()">取消</button>
    </form>
  </div>
</div>

<!-- 订单详情的模态框 -->
<div class="modal" id="detailModal">
  <div class="modal-content">
    <h3>订单信息</h3>
    <p><strong>客户姓名:</strong> <span id="customerName"></span></p>
    <p><strong>收银员姓名:</strong> <span id="employeeName"></span></p>
    <p><strong>订单日期:</strong> <span id="orderDate"></span></p>
    <p><strong>本订单商品信息:</strong>
    <table>
      <thead>
      <tr>
        <th>商品名称</th>
        <th>商品单价</th>
        <th>商品数目</th>
        <th>总金额</th>
        <th>折扣</th>
        <th>实付金额</th>
      </tr>
      </thead>
      <tbody>
      <!-- 动态加载订单数据 -->
      <tr>
        <td>商品1</td>
        <td>10</td>
        <td>3</td>
        <td>30</td>
        <td>0.8</td>
        <td>24</td>
      </tr>
      <!-- 更多订单数据 -->
      </tbody>
    </table>
    </p>
    <button type="button" onclick="closeModal()">返回</button>
  </div>
</div>


<div class="footer">
  <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<script>
  function openModal(action, orderId) {
    // 根据操作类型显示不同的模态框
    if(action === 'detail') {
      document.getElementById('detailModal').style.display = 'flex';
      const modal = document.getElementById("myModal");
      const showModalBtn = document.getElementById("showModalBtn");
      const closeModalBtn = document.getElementById("closeModalBtn");

      // 获取订单信息的显示区域
      const productName = document.getElementById("productName");
      const SellingPrice = document.getElementById("sellingPrice");
      const quantity = document.getElementById("quantity");
      const TotalAmount = document.getElementById("TotalAmount");
      const discount = document.getElementById("discount");
      const ActualPayment = document.getElementById("ActualPayment");


      // 模拟订单信息
      const orderInfo = {
        productName: "商品1",
        sellingPrice: "10",
        quantity: "3",
        TotalAmount: "30",
        discount: "0.8",
        ActualPayment: "24"
      };

      /*// 点击按钮时显示模态框
      showModalBtn.onclick = function() {
        // 设置订单信息
        productName.textContent = employee.name;
        employeePhone.textContent = employee.phone;
        position.textContent = employee.position;
      }*/
    } else if(action === 'add') {
      // 清空表单，为新增订单准备
      document.getElementById('addModal').style.display = 'flex';
      document.getElementById('orderId').value = '';  // 新增时没有订单ID//后端应该会写分配吧
      document.getElementById('productName').value = '';
      document.getElementById('quantity').value = '';
      document.getElementById('sellingPrice').value = '';
      document.getElementById('customerName').value = '';
      document.getElementById('discount').value = '';
      document.getElementById('ActualPayment').value = '';
      document.getElementById('orderDate').value = '';
    }
  }

  function closeModal() {
    // 关闭模态框
    document.getElementById('detailModal').style.display = 'none';
    document.getElementById('addModal').style.display = 'none';
  }


</script>

</body>
</html>
