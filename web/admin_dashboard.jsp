<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %> <!-- 开启 session -->
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>超市管理系统 - 管理者首页</title>
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
            transform: scale(1.05); /* 鼠标悬停时放大 */
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

        .dashboard-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
            animation: fadeIn 1s ease-out;
        }

        .card {
            background: linear-gradient(135deg, #e3f2fd 30%, #90caf9 100%);
            width: 30%;
            padding: 20px;
            text-align: center;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
            margin-bottom: 20px;
            cursor: pointer;
            transform: translateY(20px); /* 初始位置稍微下移 */
            opacity: 0; /* 初始透明度为0 */
            animation: cardAppear 1s ease-out forwards; /* 动画加载 */
        }

        @keyframes cardAppear {
            0% { transform: translateY(20px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            background-color: #80d4ff; /* 卡片悬浮时背景变浅 */
        }

        .card i {
            font-size: 40px;
            color: #0066cc;
            margin-bottom: 10px;
            transition: color 0.3s ease;
        }

        .card:hover i {
            color: #003366; /* 图标悬停时颜色变深 */
        }

        .card h3 {
            margin-top: 10px;
            font-size: 22px;
            color: #333;
        }

        .card p {
            color: #666;
            font-size: 15px;
            margin-bottom: 15px;
        }

        .card a {
            display: inline-block;
            margin-top: 10px;
            color: #0066cc;
            text-decoration: none;
            font-weight: 600;
            border: 2px solid #0066cc;
            padding: 6px 16px;
            border-radius: 6px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .card a:hover {
            background-color: #0066cc;
            color: white;
        }

        /* Footer Section */
        .footer {
            background-color: #0066cc;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        /* Right Top User Identity Section */
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

        /* Hamburger Icon for the Side Navigation */
        .hamburger {
            display: none;
            font-size: 30px;
            color: white;
            padding: 10px;
            position: absolute;
            top: 20px;
            left: 20px;
            cursor: pointer;
        }

        /* Media query for small screens to handle side navigation */
        @media (max-width: 768px) {
            nav {
                width: 200px;
                position: fixed;
                top: 0;
                left: -200px;
                transition: all 0.3s ease;
            }

            nav.open {
                left: 0;
            }

            .container {
                margin-left: 0;
                padding-left: 20px;
            }

            .hamburger {
                display: block;
            }
        }

    </style>
</head>
<body>

<!-- Header Section -->
<header>
    <h1>欢迎使用超市管理系统</h1>
</header>

<!-- Side Navigation -->
<nav id="sideNav">
    <a href="admin_dashboard.jsp" class="active"><i class="fas fa-tachometer-alt"></i> 仪表盘</a>
    <a href="product_management.jsp"><i class="fas fa-cogs"></i> 商品管理</a>
    <a href="salesManagement.jsp"><i class="fas fa-shopping-cart"></i> 销售管理</a>
    <a href="customerManagement.jsp"><i class="fas fa-warehouse"></i> 客户管理</a>
    <a href="orderManagement.jsp"><i class="fas fa-box"></i> 订单管理</a>
    <a href="incomingInformation.jsp"><i class="fas fa-chart-line"></i> 进货信息</a>
    <a href="employeeManagement.jsp"><i class="fas fa-users"></i> 员工管理</a> <!-- 新增员工管理 -->
    <a href='Logout?redirect=index.jsp'><i class="fas fa-sign-out-alt"></i> 退出</a>
</nav>

<!-- Hamburger Button for Mobile -->
<div class="hamburger" onclick="toggleNav()">
    <i class="fas fa-bars"></i>
</div>

<!-- Right Top User Info -->
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
    <a href='Logout?redirect=index.jsp' class="logout-btn"><i class="fas fa-sign-out-alt"></i> 退出</a>
</div>

<!-- Main Content Section -->
<div class="container">
    <h2>管理概览</h2>
    <div class="dashboard-cards">
        <!-- 商品管理 -->
        <div class="card">
            <i class="fas fa-cogs"></i>
            <h3>商品管理</h3>
            <p>添加、编辑、删除商品，管理商品信息。</p>
            <a href="product_management.jsp">进入商品管理</a>
        </div>

        <!-- 销售管理 -->
        <div class="card">
            <i class="fas fa-shopping-cart"></i>
            <h3>销售管理</h3>
            <p>查看销售记录、生成销售报表，跟踪销售情况。</p>
            <a href="salesManagement.jsp">进入销售管理</a>
        </div>

        <!-- 客户管理 -->
        <div class="card">
            <i class="fas fa-warehouse"></i>
            <h3>客户管理</h3>
            <p>管理客户等操作。</p>
            <a href="customerManagement.jsp">进入客户管理</a>
        </div>

        <!-- 订单管理 -->
        <div class="card">
            <i class="fas fa-box"></i>
            <h3>订单管理</h3>
            <p>查看订单信息、管理订单状态。</p>
            <a href="orderManagement.jsp">进入订单管理</a>
        </div>

        <!-- 报表统计 -->
        <div class="card">
            <i class="fas fa-chart-line"></i>
            <h3>进货信息</h3>
            <p>查看相关进货信息。</p>
            <a href="incomingInformation.jsp">进入进货信息</a>
        </div>

        <!-- 员工管理 -->
        <div class="card">
            <i class="fas fa-users"></i>
            <h3>员工管理</h3>
            <p>查看、添加、编辑和删除员工信息。</p>
            <a href="employeeManagement.jsp">进入员工管理</a>
        </div>
    </div>
</div>


<!-- Footer Section -->
<div class="footer">
    <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<script>
    // 控制侧边栏的展开与收缩
    function toggleNav() {
        var sideNav = document.getElementById('sideNav');
        sideNav.classList.toggle('open');
    }
</script>

</body>
</html>
