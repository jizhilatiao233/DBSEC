<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>账户信息 - 超市管理系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 基础样式 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f1f8ff;
            color: #333;
            animation: fadeIn 0.8s ease-in-out;
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
            transition: width 0.3s ease;
        }
        nav a {
            display: block;
            color: white;
            padding: 16px;
            text-decoration: none;
            font-size: 18px;
            transition: background-color 0.3s ease, transform 0.2s;
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
        .user-profile {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .user-profile img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #4d94ff;
        }

        .user-info-main {
            font-size: 18px;
            line-height: 1.8;
        }

        .user-info-main p {
            margin: 5px 0;
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

        h2 {
            font-size: 28px;
            color: #0056b3;
            margin-bottom: 20px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        table th {
            background-color: #4d94ff;
            color: white;
        }

        .btn {
            display: inline-block;
            padding: 8px 16px;
            background-color: #4d94ff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            border: none;
            transition: background-color 0.3s, transform 0.2s;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #003366;
            transform: translateY(-2px);
        }

        .btn-danger {
            background-color: #f44336;
        }
        .btn-danger:hover {
            background-color: #d32f2f;
        }


        .action-bar {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }
        .action-bar input, .action-bar select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 10px;
            width: 140px;
            box-sizing: border-box;
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
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .modal-content input, .modal-content button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ddd;
        }

        @media (max-width: 768px) {
            nav {
                width: 200px;
            }
            .container {
                margin-left: 210px;
            }
        }

        @media (max-width: 576px) {
            nav {
                width: 100%;
                position: relative;
            }
            .container {
                margin-left: 0;
            }
        }

    </style>
</head>
<body>
<header>
    <h1>账户信息 - 超市管理系统</h1>
</header>

<nav>
    <a href="admin_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> 首页</a>
    <a href="product_management.jsp"><i class="fas fa-cogs"></i> 商品管理</a>
    <a href="salesManagement.jsp"><i class="fas fa-shopping-cart"></i> 销售管理</a>
    <a href="customerManagement.jsp"><i class="fas fa-warehouse"></i> 客户管理</a>
    <a href="orderManagement.jsp"><i class="fas fa-box"></i> 订单管理</a>
    <a href="incomingInformation.jsp"><i class="fas fa-chart-line"></i> 进货信息</a>
    <a href="staffManagement.jsp"><i class="fas fa-users"></i> 员工管理</a>
</nav>


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
    <h2>账户信息</h2>

    <div class="user-profile">
        <img id="userAvatar" src="https://via.placeholder.com/100" alt="用户头像">
        <div class="user-info-main">
            <p><strong>用户名:</strong> <span id="username">加载中...</span></p>
            <p><strong>姓名:</strong> <span id="adminName">加载中...</span></p>
            <p><strong>联系方式:</strong> <span id="contactInfo">加载中...</span></p>
            <p><strong>职位:</strong> <span id="role">加载中...</span></p>
        </div>
    </div>

    <h3>管理的人员</h3>
    <table>
        <thead>
        <tr>
            <th>员工ID</th>
            <th>姓名</th>
            <th>联系方式</th>
            <th>职位</th>
            <th>加入日期</th>
        </tr>
        </thead>
        <tbody id="staffTable">
        <tr>
            <td colspan="5">加载中...</td>
        </tr>
        </tbody>
    </table>


    <div class="action-bar">
        <button class="btn" onclick="showModal('changePasswordModal')">修改密码</button>
        <button class="btn" onclick="showModal('changeInfoModal')">修改信息</button>
        <button class="btn btn-danger" onclick="logout()">登出</button>
        <button class="btn btn-danger" onclick="deleteAccount()">销号</button>
    </div>
</div>

<div id="changePasswordModal" class="modal">
    <div class="modal-content">
        <h3>修改密码</h3>
        <form id="changePasswordForm">
            <label for="newPassword">新密码:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            <label for="confirmPassword">确认密码:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <button type="submit" class="btn">提交</button>
            <button type="button" class="btn" onclick="closeModal('changePasswordModal')">取消</button>
        </form>
    </div>
</div>

<div id="changeInfoModal" class="modal">
    <div class="modal-content">
        <h3>修改个人信息</h3>
        <form id="changeInfoForm">
            <label for="newUsername">新用户名:</label>
            <input type="text" id="newUsername" name="newUsername" required>
            <label for="newContactInfo">联系方式:</label>
            <input type="text" id="newContactInfo" name="newContactInfo" required>
            <button type="submit" class="btn">提交</button>
            <button type="button" class="btn" onclick="closeModal('changeInfoModal')">取消</button>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const adminID = '<%= session.getAttribute("adminID") %>'; // 从服务器端获取 adminID
        if (adminID) {
            fetchUserInformation(adminID);
            fetchStaffInformation(adminID);
        } else {
            console.error('Admin ID 未找到');
        }
    });

    function fetchUserInformation(adminID) {
        fetch('AdminInformation?action=getUserInformation&adminID=' + adminID)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                // 更新页面上的用户信息
                document.getElementById('username').textContent = data.username || '未知';
                document.getElementById('adminName').textContent = data.adminName || '未知';
                document.getElementById('contactInfo').textContent = data.contactInfo || '未知';
                document.getElementById('role').textContent = data.position || '未知';  // 将 "role" 改为 "position"
            })
            .catch(error => {
                console.error('Error fetching user information:', error);
                alert('无法加载用户信息，请稍后重试。');
            });
    }

    function fetchStaffInformation(adminID) {
        const offset = 0; // 从第0条开始
        const limit = 10; // 每次请求10条数据
        const sortBy = 'joinDate'; // 假设按加入日期排序
        const sortOrder = 'desc'; // 降序
        const staffName = ''; // 可用来筛选员工姓名
        const contactInfo = ''; // 可用来筛选联系方式
        const fromJoinDate = ''; // 可用来筛选加入日期
        const toJoinDate = ''; // 可用来筛选加入日期
        const position = ''; // 可用来筛选职位
        const adminName = ''; // 可用来筛选管理员名称

        const apiUrl = `/StaffManage?action=getStaffs&offset=${offset}&limit=${limit}&sortBy=${sortBy}&sortOrder=${sortOrder}&staffName=${staffName}&contactInfo=${contactInfo}&fromJoinDate=${fromJoinDate}&toJoinDate=${toJoinDate}&position=${position}&adminID=${adminID}&adminName=${adminName}`;

        fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
                // 如果获取成功，填充表格
                const staffTable = document.getElementById('staffTable');
                if (data && data.length > 0) {
                    staffTable.innerHTML = ''; // 清空加载中的文字
                    data.forEach(staff => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td>${staff.staffID}</td>
                            <td>${staff.name}</td>
                            <td>${staff.contactInfo}</td>
                            <td>${staff.position}</td>
                            <td>${staff.joinDate}</td>
                        `;
                        staffTable.appendChild(row);
                    });
                } else {
                    staffTable.innerHTML = '<tr><td colspan="5">没有找到员工数据。</td></tr>';
                }
            })
            .catch(error => {
                console.error('无法加载员工数据:', error);
                const staffTable = document.getElementById('staffTable');
                staffTable.innerHTML = '<tr><td colspan="5">加载失败，请稍后重试。</td></tr>';
            });
    }



    function showModal(modalId) {
        document.getElementById(modalId).style.display = 'flex';
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    function logout() {
        window.location.href = "Logout?redirect=index.jsp";
    }

    function deleteAccount() {
        alert("账户销号成功！");
    }
</script>

</body>
</html>
