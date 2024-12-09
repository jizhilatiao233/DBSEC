<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>客户管理 - 超市管理系统</title>
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

        /* 调整搜索框和批量删除框宽度一致 */
        /* 调整 action-bar 为 flex 布局，确保所有按钮和搜索框在一排 */
        /*.action-bar {*/
        /*    display: flex;*/
        /*    flex-direction: column;  !* 将布局方向设置为列方向，确保元素在垂直方向排列 *!*/
        /*    justify-content: flex-start;  !* 垂直方向上左对齐 *!*/
        /*    align-items: flex-start;  !* 垂直方向上左对齐 *!*/
        /*    gap: 10px;  !* 各个输入框和按钮之间的间距 *!*/
        /*    margin-bottom: 20px;*/
        /*}*/

        /* 修改后的 action-bar 样式 */


        /* 新增的按钮组容器，确保按钮在同一行显示 */
        .button-group {
            display: flex;
            gap: 10px;  /* 按钮之间的间距 */
            align-items: center;
        }

        .action-bar {
                     display: flex;
                     flex-wrap: wrap;  /* 自动换行 */
                     justify-content: flex-start;
                     gap: 10px;  /* 元素间距 */
                     align-items: center; /* 元素垂直居中 */
                 }
        /* 输入框和下拉框的样式 */
        .action-bar input[type="text"], .action-bar input[type="email"], .action-bar input[type="date"], .action-bar select, .action-bar input[type="number"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 10px;
            width: 120px; /* 设置宽度确保它们整齐 */
            box-sizing: border-box; /* 确保输入框的宽度包括内边距和边框 */
        }

        /* 姓名输入框增加左边距，保证与排序下拉框之间有空间 */
        .action-bar input[name="searchName"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-left: 20px;  /* 增加左边距 */
            width: 150px; /* 调整宽度，确保元素整齐 */
            box-sizing: border-box;  /* 确保宽度包含内边距和边框 */
        }

        /* 按钮的样式 */
        .action-bar button {
            padding: 8px 12px;
            border: 1px solid #0066cc;
            background-color: #0066cc;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: auto;
            max-width: 120px; /* 限制最大宽度 */
        }

        .action-bar button:hover {
            background-color: #005bb5;
        }

        .action-bar form {
            display: inline-flex;
            align-items: center;
        }

        .action-bar form button {
            margin-left: 20px; /* 按钮之间的间隔 */
        }

        /* 确保导出CSV按钮样式一致 */
        .action-bar form button[type="submit"] {
            padding: 8px 12px;
            background-color: #0066cc;  /* 绿色按钮 */
            border-color: #0066cc;
        }

        .action-bar form button[type="submit"]:hover {
            background-color: #005bb5; /* 按钮悬停效果 */
        }

        input[type="email"], input[type="text"],input[type="date"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin: 2px 0;
            width: 100%;
        }

        input[type="email"]:focus, input[type="text"],input[type="date"]:focus {
            border-color: #0066cc;
            outline: none;
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
    <h1>客户管理 - 超市管理系统</h1>
</header>

<nav>
    <a href="admin_dashboard.jsp" class="active"><i class="fas fa-tachometer-alt"></i> 首页</a>
    <a href="product_list.jsp"><i class="fas fa-cogs"></i> 商品管理</a>
    <a href="salesManagement.jsp"><i class="fas fa-shopping-cart"></i> 销售管理</a>
    <a href="customerManagement.jsp"><i class="fas fa-warehouse"></i> 客户管理</a>
    <a href="orderManagement.jsp"><i class="fas fa-box"></i> 订单管理</a>
    <a href="incomingInformation.jsp"><i class="fas fa-chart-line"></i> 进货信息</a>
    <a href="staffManagement.jsp"><i class="fas fa-users"></i> 员工管理</a>
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

<div class="container">
    <h2>客户列表</h2>
    <div class="action-bar">
        <form method="get" action="customerManagement.jsp">
            <select name="sortBy">
                <option value="">排序方式</option>
                <option value="email">按邮箱排序</option>
                <option value="name">按姓名排序</option>
                <option value="joinDate">按加入日期排序</option>
            </select>
            <button type="submit">排序</button>

            <input type="text" name="searchName" placeholder="姓名">
            <input type="text" name="searchPhone" placeholder="手机号">
            <input type="email" name="searchEmail" placeholder="邮箱">
            <input type="text" name="searchAddress" placeholder="地址">
//表里没有地址的 考虑改或者删

            <button type="submit">搜索</button>
        </form>
        <br>
        <form method="get" action="customerManagement.jsp">
        <!-- 新增消费金额筛选 -->
        <input type="number" name="minSpent" placeholder="最低消费金额" step="0.01" min="0">
        <input type="number" name="maxSpent" placeholder="最高消费金额" step="0.01" min="0">
         <!-- 新增加入日期筛选 -->
        <input type="date" name="startDate" placeholder="开始日期">
        <input type="date" name="endDate" placeholder="结束日期">
        <!-- 新增VIP等级筛选 -->
        <select name="vipLevel">
            <option value="">选择VIP等级</option>
            <option value="VIP 1">VIP 1</option>
            <option value="VIP 2">VIP 2</option>
            <option value="VIP 3">VIP 3</option>
            <option value="VIP 4">VIP 4</option>
        </select>
        <select name="status">
            <option value="">客户状态</option>
            <option value="active">已激活</option>
            <option value="inactive">已停用</option>
        </select>
            <button type="submit">筛选</button>
        </form>

        <div class="button-group">
            <form method="post" action="batchDeleteCustomer">
                <button type="submit">批量删除</button>
            </form>
            <button onclick="openModal('add')">添加客户</button>
            <form method="get" action="exportCSV.jsp">
                <button type="submit">导出CSV</button>
            </form>
        </div>
    </div>



    <table>
        <thead>
        <tr>
            <th><input type="checkbox" id="selectAll"> 全选</th>
            <th>客户ID</th>
            <th>姓名</th>
            <th>手机号</th>
            <th>邮箱</th>
            <th>地址</th>
            <th>加入日期</th>
            <th>状态</th>
            <th>消费总金额</th> <!-- 新增列 -->
            <th>VIP等级</th> <!-- 新增列 -->
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="customerList">
        <!-- 客户数据将通过 AJAX 动态加载 -->
        <!-- 示例数据 -->
        <tr>
            <td><input type="checkbox" name="selectedCustomers" value="1"></td>
            <td>1001</td>
            <td>张三</td>
            <td>13800000000</td>
            <td>zhangsan@example.com</td>
            <td>北京市朝阳区</td>
            <td>2022-01-01</td>
            <td>已激活</td>
            <td>￥5000</td> <!-- 示例消费总金额 -->
            <td>VIP 1</td> <!-- 示例VIP等级 -->
            <td>
                <div class="action-btns">
                    <a onclick="openModal('edit', 1001)">编辑</a>
                    <a onclick="deleteCustomer(1001)">删除</a>
                </div>
            </td>
        </tr>
        <!-- 更多客户数据 -->
        </tbody>
    </table>

    <div class="pagination" id="pagination"></div>
</div>

<div class="footer">
    <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<script>
    function openModal(action, customerId = null) {
        const modal = document.getElementById('customerModal');
        const modalTitle = document.getElementById('modalTitle');
        const form = document.getElementById('customerForm');

        if (action === 'add') {
            modalTitle.textContent = '添加客户';
            form.action = 'addCustomer.jsp';
            form.reset();
        } else if (action === 'edit') {
            modalTitle.textContent = '编辑客户';
            form.action = 'editCustomer.jsp';
            // 通过 AJAX 获取客户信息
        }

        modal.style.display = 'flex';
    }

    function closeModal() {
        const modal = document.getElementById('customerModal');
        modal.style.display = 'none';
    }

    document.getElementById('selectAll').addEventListener('change', function () {
        document.querySelectorAll('input[name="selectedCustomers"]').forEach(checkbox => checkbox.checked = this.checked);
    });
</script>

</body>
</html>
