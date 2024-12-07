<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>库存预警 - 超市管理系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f1f8ff;
            color: #333;
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
        }

        nav a:hover {
            background-color: #004d99;
            transform: scale(1.05);
        }

        .container {
            margin-left: 270px;
            padding: 30px;
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

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        input[type="number"] {
            width: 70%;
            padding: 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .submit-btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .submit-btn:hover {
            background-color: #0056b3;
        }

        /* Right Top User Identity Section */
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

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
        }

        .back-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<!-- Header Section -->
<header>
    <h1>库存预警 - 超市管理系统</h1>
</header>

<!-- Side Navigation -->
<nav>
    <a href="admin_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> 仪表盘</a>
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
    <a href="Logout?redirect=index.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i> 退出</a>
</div>

<!-- Main Content Section -->
<div class="container">
    <a href="previous_page.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> 返回</a>

    <table>
        <thead>
        <tr>
            <th>商品ID</th>
            <th>商品名称</th>
            <th>当前库存</th>
            <th>最低库存</th>
            <th>编辑最低库存</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>001</td>
            <td>商品1</td>
            <td style="color: red;">30</td>
            <td>50</td>
            <td>
                <form action="update_product_stock.jsp" method="post">
                    <input type="number" name="min_stock" value="50" min="1" required>
                    <input type="hidden" name="product_id" value="001">
                    <button type="submit" class="submit-btn">更新</button>
                </form>
            </td>
        </tr>
        <tr>
            <td>002</td>
            <td>商品2</td>
            <td style="color: red;">15</td>
            <td>20</td>
            <td>
                <form action="update_product_stock.jsp" method="post">
                    <input type="number" name="min_stock" value="20" min="1" required>
                    <input type="hidden" name="product_id" value="002">
                    <button type="submit" class="submit-btn">更新</button>
                </form>
            </td>
        </tr>
        </tbody>
    </table>
</div>

</body>
</html>
