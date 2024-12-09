<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>销售管理 - 超市管理系统</title>
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
            padding: 30px;
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

    </style>
</head>
<body>

<header>
    <h1>销售管理 - 超市管理系统</h1>
</header>

<nav>
    <a href="admin_dashboard.jsp" class="active"><i class="fas fa-tachometer-alt"></i> 首页</a>
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

<%--<div class="container">--%>
<%--    <h2>进货订单管理</h2>--%>

<%--    <div class="action-bar">--%>
<%--        <form method="get" action="incomingInformation.jsp">--%>
<%--            <select name="supplier">--%>
<%--                <option value="">选择供应商</option>--%>
<%--                <!-- 动态加载供应商 -->--%>
<%--            </select>--%>

<%--            <button type="submit">筛选</button>--%>
<%--        </form>--%>

<%--        <button onclick="openModal('add')" class="action-btn">添加进货订单</button>--%>

<%--    </div>--%>
<%--    --%>
<div class="container">
    <h2>销售管理</h2>

    <!-- 查询功能表单 -->
    <div class="action-bar">
        <!-- 排序和搜索表单 -->
        <form method="get" action="salesManagement.jsp">
            <!-- 排序方式 -->
            <select name="sortBy">
                <option value="">排序方式</option>
                <option value="productID">按商品排序</option>
                <option value="orderID">按订单排序</option>
                <option value="SalesDate">按日期排序</option>
            </select>
            <button type="submit">排序</button>
        </form>
        <br>
        <!-- 筛选 -->
        <form method="get" action="salesManagement.jsp">
            <input type="number" name="orderID" placeholder="订单ID">
            <input type="text" name="productName" placeholder="商品名称">
            <input type="text" name="employeeName" placeholder="收银员姓名">
            <input type="date" name="SalesDate" placeholder="销售日期">

            <button type="submit">筛选</button>
        </form>

        <div class="button-group">
            <!-- 批量删除表单 -->
            <form method="post" action="batchDeleteSales.jsp">
                <button type="submit">批量删除</button>
            </form>

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
            <th>商品名称</th>
            <th>收银员姓名</th>
            <th>商品单价</th>
            <th>商品数量</th>
            <th>实际支付</th>
            <th>利润</th>
            <th>销售日期</th>
        </tr>
        </thead>
        <tbody>
        <!-- 动态加载进货数据 -->
        <tr>
            <td>1001</td>
            <td>商品A</td>
            <td>收银员A</td>
            <td>100</td>
            <td>5</td>
            <td>400</td>
            <td>300</td>
            <td>2024-12-05</td>
        </tr>
        <!-- 更多进货数据 -->
        </tbody>
    </table>
</div>


<div class="footer">
    <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<script>

</script>

</body>
</html>

