<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工管理 - 超市管理系统</title>
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
        .action-btns e {
            padding: 8px 16px;
            background-color: #7bd168;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s;
        }
        .action-btns e:hover {
            background-color: #5a9a4b;
        }
        .action-btns c {
            padding: 8px 16px;
            background-color: #f16969;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s;
        }
        .action-btns c:hover {
            background-color: #ef444b;
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
            position: absolute ;
            top: 20px;
            right: 20px;
            background-color: #0066cc;
            color: white;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 16px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .user-info .info-btn {
            background-color: #4489e3;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            display: inline-block;
            cursor: pointer;
        }

        .user-info .info-btn:hover {
            background-color: #2475ef;
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
    <h1>员工管理 - 超市管理系统</h1>
</header>

<nav>
    <a href="admin_dashboard.jsp" ><i class="fas fa-tachometer-alt"></i> 首页</a>
    <a href="product_management.jsp"><i class="fas fa-cogs"></i> 商品管理</a>
    <a href="salesManagement.jsp"><i class="fas fa-shopping-cart"></i> 销售管理</a>
    <a href="customerManagement.jsp"><i class="fas fa-warehouse"></i> 客户管理</a>
    <a href="orderManagement.jsp"><i class="fas fa-box"></i> 订单管理</a>
    <a href="incomingInformation.jsp"><i class="fas fa-chart-line"></i> 进货信息</a>
    <a href="staffManagement.jsp" class="active"><i class="fas fa-users"></i> 员工管理</a>
</nav>
<!-- Right Top User Info -->
<div class="user-info">
    <span>
        <a href='userInformation.jsp' id="userInfoBtn" class="info-btn">
        <i class="fas fa-user"></i>
        <%
            // 从 session 获取当前用户的信息
            String userName = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            if (userName != null) {
        %>
            <span><%= userName %> (<%= role %>)</span>
        <%
        } else {
        %>
            <span>访客</span>
        <%
            }
        %>
        </a>
    </span>
    <a href='Logout?redirect=index.jsp' class="logout-btn"><i class="fas fa-sign-out-alt"></i> 退出</a>
</div>

<div class="container">
    <h2>员工列表</h2>
    <div class="action-bar">
        <form method="get" action="staffManagement.jsp">
            <select name="sortBy">
                <option value="">排序方式</option>
                <option value="name">按姓名排序</option>
                <option value="joinDate">按加入日期排序</option>
            </select>
            <button type="submit">排序</button>

            <input type="text" name="searchName" placeholder="姓名">
            <input type="text" name="searchPhone" placeholder="联系方式">

            <button type="submit">搜索</button>
        </form>
        <br>
        <form method="get" action="staffManagement.jsp">
            <!-- 加入日期筛选 -->
            <input type="date" name="startDate" placeholder="开始日期">
            <input type="date" name="endDate" placeholder="结束日期">
            <!-- 职位筛选 -->
            <select name="position">
                <option value="">选择职位</option>
                <option value="收银员">收银员</option>
                <option value="管理员">管理员</option>
            </select>
            <button type="submit">筛选</button>

        </form>

        <div class="button-group">
            <!-- 添加员工按钮 -->
            <button onclick="openModal('add')">添加员工</button>

            <!-- 导出 CSV 表单 -->
            <form method="get" action="exportCSV.jsp">
                <button type="submit">导出CSV</button>
            </form>
        </div>
    </div>



    <table>
        <thead>
        <tr>
            <th>员工ID</th>
            <th>姓名</th>
            <th>联系方式</th>
            <th>加入日期</th>
            <th>职位</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="employeeList">
        <tr>
            <td>1001</td>
            <td>张三</td>
            <td>13800000000</td>
            <td>2022-01-01</td>
            <td>收银员</td>
            <td>
                <div class="action-btns">
                    <e href="javascript:void(0)" onclick="openModal('detail', 1001)">详情</e>
                    <c href="deleteStaff.jsp?id=1001" onclick="return confirm('确定要删除该员工吗？')">删除</c>
                </div>
            </td>
        </tr>
        </tbody>
    </table>

    <div class="pagination" id="pagination"></div>
</div>

<!-- 添加员工的模态框 -->
<div class="modal" id="addModal">
    <div class="modal-content">
        <h3>添加员工</h3>
        <form action="addEmployee.jsp" method="POST">
            <!-- 员工ID：新增时没有 -->
            <input type="hidden" name="employeeId" id="employeeId" value="">

            <!-- 员工姓名 -->
            <label for="employeeName">员工姓名:</label>
            <input type="text" name="employeeName" id="employeeName" required>

            <!-- 联系方式 -->
            <label for="employeePhone">联系方式:</label>
            <input type="text" name="employeePhone" id="employeePhone" required>

            <!-- 职位 -->
            <label for="position">职位:</label>
            <select name="position" id="position" required>
                <option value="">请选择职位</option>
            </select>

            <!-- 管理员 -->
            <label for="admin">管理员:</label>
            <input type="text" name="admin" id="admin" value="" required>

            <button type="submit">添加员工</button>
            <button type="button" onclick="closeModal()">取消</button>
        </form>
    </div>
</div>

<!-- 查看员工信息详情 -->
<div class="modal" id="detailModal">
    <div class="modal-content">
        <h3>员工信息</h3>
        <p><strong>姓名:</strong> <span id="employeeName"></span></p>
        <p><strong>电话:</strong> <span id="employeePhone"></span></p>
        <p><strong>职位:</strong> <span id="position"></span></p>
        <p><strong>管理人员:</strong>
        <table>
            <tbody id="employeeList">
            <tr>
                <td><input type="checkbox" name="selectedEmployee" value=""></td>
                <td>1001</td>
                <td>张三</td>
                <td>13800000000</td>
                <td>2022-01-01</td>
                <td>收银员</td>
            </tr>
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
    function openModal(action, employeeId) {
        // 根据操作类型显示不同的模态框
        if(action === 'detail') {
            document.getElementById('detailModal').style.display = 'flex';
            const modal = document.getElementById("myModal");
            const showModalBtn = document.getElementById("showModalBtn");
            const closeModalBtn = document.getElementById("closeModalBtn");

            // 获取员工信息的显示区域
            const employeeName = document.getElementById("employeeName");
            const employeePhone = document.getElementById("employeePhone");
            const position = document.getElementById("position");

            // 模拟员工信息
            const employeeInfo = {
                name: "张三",
                phone: "1234567890",
                position: "收银员"
            };

            // 点击按钮时显示模态框
            showModalBtn.onclick = function() {
                // 设置员工信息
                employeeName.textContent = employee.name;
                employeePhone.textContent = employee.phone;
                position.textContent = employee.position;
            }
        } else if(action === 'add') {
            // 清空表单，为新增订单准备
            document.getElementById('addModal').style.display = 'flex';
            document.getElementById('employeeId').value = '';  // 新增时没有订单ID//后端应该会写分配吧
            document.getElementById('employeeName').value = '';
            document.getElementById('employeePhone').value = '';
            document.getElementById('position').value = '';
            document.getElementById('admin').value = '';
        }
    }

    function closeModal() {
        // 关闭模态框
        document.getElementById('detailModal').style.display = 'none';
        document.getElementById('addModal').style.display = 'none';
    }

    document.getElementById('selectAll').addEventListener('change', function () {
        document.querySelectorAll('input[name="selectedEmployee"]').forEach(checkbox => checkbox.checked = this.checked);
    });
</script>

</body>
</html>
