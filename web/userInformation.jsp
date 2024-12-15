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
        <img id="userAvatar" src="./img/img.png" alt="用户头像" width="100" height="100">
        <div class="user-info-main">
            <p><strong>用户名:</strong> <span id="username">加载中...</span></p>
            <p><strong>姓名:</strong> <span id="adminName">加载中...</span></p>
            <p><strong>联系方式:</strong> <span id="contactInfo">加载中...</span></p>
            <p><strong>职位:</strong> <span id="role">加载中...</span></p>
        </div>
    </div>
    <div class="action-bar">
        <button class="btn" onclick="showModal('changePasswordModal')">修改密码</button>
        <button class="btn" onclick="showModal('changeInfoModal')">修改信息</button>
        <button class="btn btn-danger" onclick="logout()">登出</button>
        <button class="btn btn-danger" onclick="deleteAccount()">销号</button>
    </div>
    <br>
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

        </tbody>
    </table>



</div>

<div id="changePasswordModal" class="modal">
    <div class="modal-content">
        <h3>修改密码</h3>
        <form id="changePasswordForm" method="POST">
            <label for="newPassword">新密码:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            <label for="confirmPassword">确认密码:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <button type="button" class="btn" onclick="submitPasswordModal()">修改密码</button>
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
            <button type="button" class="btn" onclick="submitInformatinModal()">修改信息</button>
            <button type="button" class="btn" onclick="closeModal('changeInfoModal')">取消</button>
        </form>
    </div>
</div>

<script>
    function submitPasswordModal() {
        // 获取表单数据
        const form = document.getElementById('changePasswordForm');
        const formData = new FormData(form); // 获取表单数据

        const newPassword = formData.get('newPassword');
        const confirmPassword = formData.get('confirmPassword');

        // 验证密码是否一致
        if (newPassword !== confirmPassword) {
            alert('新密码和确认密码不一致！');
            return false; // 阻止提交
        }

        // 获取 adminID（可以通过 session 或其他方式获取）
        const adminID = '<%= session.getAttribute("adminID") %>'; // 从服务器端获取 adminID




        // 发送 AJAX 请求
        fetch('AdminInformation?action=editPassword&adminID='+adminID+'&newPassword=' + newPassword)
            .then(response => {
                if (response.ok) {
                    alert('密码修改成功！');
                    closeModal('changePasswordModal'); // 关闭弹窗
                } else {
                    return response.text().then(text => { throw new Error(text); });
                }
            })
            .catch(error => {
                console.error('错误:', error);
                alert('操作失败，请稍后重试！');
            });

        return false; // 阻止表单默认提交行为
    }

    function submitInformatinModal() {
        // 获取表单数据
        const form = document.getElementById('changeInfoForm');
        const formData = new FormData(form); // 获取表单数据

        const newUsername = formData.get('newUsername');
        const newContactInfo = formData.get('newContactInfo');

        // 获取 adminID
        const adminID = '<%= session.getAttribute("adminID") %>'; // 从服务器端获取 adminID
        document.getElementById('username').textContent = String(newUsername);

        // 发送 AJAX 请求
        fetch('AdminInformation?action=editInformation&adminID=' + adminID + '&username=' + newUsername + '&contactInfo=' + newContactInfo)
            .then(response => {
                if (response.ok) {
                    alert('个人信息修改成功！');
                    fetchUserInformation(adminID); // 重新加载用户信息
                    closeModal('changeInfoModal'); // 关闭弹窗
                } else {
                    alert('操作失败，请稍后重试！');
                    return response.text().then(text => { throw new Error(text); });
                }
            })
            .catch(error => {
                console.error('错误:', error);
            });

        return false; // 阻止表单默认提交行为
    }

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

    const itemsPerPage = 10; // 每页显示的数量
    let currentPage = 1; // 当前页码
    // 获取员工信息
    function fetchstaffs({page = currentPage, sortBy = '', sortOrder = '', staffID = '',staffName = '', contactInfo = '', joinDate = '',position = '',adminID = '',adminName = ''
        }) {
        currentPage = page;
        const offset = (page - 1) * itemsPerPage;
        adminID = '<%= session.getAttribute("adminID") %>';
        const URLParams = {
            page: page,
            sortBy: sortBy,
            sortOrder: sortOrder,
            staffID:staffID,
            staffName: staffName,
            contactInfo: contactInfo,
            joinDate:joinDate,
            position: position,
            adminID: adminID,
            adminName: adminName
        };
        updateUrlParams(URLParams);

        fetch('StaffManage?action=getStaffs&offset=' + offset + '&limit=' + itemsPerPage
            + '&sortBy=' + sortBy + '&sortOrder=' + sortOrder + '&staffID=' +staffID +
            + '&staffName=' + staffName + '&contactInfo=' + contactInfo
            + '&joinDate=' + joinDate + '&position=' + position
            + '&adminID=' + adminID+ '&adminName=' + adminName)
            .then(response => response.json())
            .then(data => {
                const staffTable = document.getElementById('staffTable');
                staffTable.innerHTML = ''; // 清空表格

                if (data.staffs && data.staffs.length > 0) {
                    data.staffs.forEach(staff => {
                        const row = document.createElement('tr');
                        row.innerHTML =  '<td>' + staff.staffID + '</td>'
                            + '<td>' + staff.staffName + '</td>'
                            + '<td>' + staff.contactInfo + '</td>'
                            + '<td>' + staff.position + '</td>'
                            + '<td>' + staff.joinDate + '</td>';
                        staffTable.appendChild(row);
                    });
                } else {
                    const row = document.createElement('tr');
                    row.innerHTML = '<td colspan="8">没有找到管理员工信息</td>';
                    staffTable.appendChild(row);
                }

                updatePagination(data.totalPages);
            })
            .catch(error => console.error('Error fetching staffs:', error));
    }

    // 页面加载时：获取URL参数；获取客户信息并显示分页按钮
    window.onload = function () {
        const URLParams = getUrlParams();
        fetchstaffs({
            page: URLParams.page || 1,
            sortBy: URLParams.sortBy || '',
            sortOrder: URLParams.sortOrder || '',
            staffID:URLParams.staffID || '',
            staffName: URLParams.staffName || '',
            contactInfo: URLParams.contactInfo || '',
            joinDate: URLParams.joinDate || '',
            position: URLParams.position || '',
            adminID: URLParams.adminID || '',
            adminName: URLParams.adminName|| '',
        });
    };

    // 获取URL参数
    function getUrlParams() {
        const URLParams = {};
        const queryString = window.location.search.substring(1);
        const regex = /([^&=]+)=([^&]*)/g;
        let m;
        while (m = regex.exec(queryString)) {
            URLParams[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
        }
        return URLParams;
    }

    // 更新URL参数
    function updateUrlParams(URLParams) {
        const queryString = Object.keys(URLParams)
            .filter(key => URLParams[key] !== '' && URLParams[key] !== null && URLParams[key] !== undefined)
            .map(key => encodeURIComponent(key) + '=' + encodeURIComponent(URLParams[key]))
            .join('&');
        history.pushState(null, '', '?' + queryString);
    }

    // 清除URL参数
    function clearUrlParams() {
        history.pushState(null, '', window.location.pathname);
    }

    function showModal(modalId) {
        document.getElementById(modalId).style.display = 'flex';
    }

    function closeModal(modalId) {
        var modal = document.getElementById(modalId);
        modal.style.display = 'none';
    }


    function logout() {
        window.location.href = "Logout?redirect=index.jsp";
    }

    function deleteAccount() {
        // 获取 adminID
        const adminID = '<%= session.getAttribute("adminID") %>'; // 从服务器端获取 adminID

        // 发送 AJAX 请求
        fetch('AdminInformation?action=deleteAdmin&adminID=' + adminID)
            .then(response => {
                if (response.ok) {
                    alert("账户销号成功！");
                } else {
                    return response.text().then(text => { throw new Error(text); });
                }
            })
            .catch(error => {
                console.error('错误:', error);
                alert('操作失败，请稍后重试！');
            });

        return false; // 阻止表单默认提交行为
    }
    // 更新分页按钮
    function updatePagination(totalPages) {
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';  // 清空现有的分页按钮
        const URLParams = getUrlParams(); // 获取当前 URL 参数
        const currentPage = parseInt(URLParams.page);

        for (let i = 1; i <= totalPages; i++) {
            const pageBtn = document.createElement('a');
            pageBtn.href = 'javascript:void(0)';
            pageBtn.textContent = i;
            if (i === currentPage) {
                pageBtn.classList.add('active');
            }
            pageBtn.onclick = () => fetchstaffs({
                page: URLParams.page || 1,
                sortBy: URLParams.sortBy || '',
                sortOrder: URLParams.sortOrder || '',
                staffID:URLParams.staffID || '',
                staffName: URLParams.staffName || '',
                contactInfo: URLParams.contactInfo || '',
                joinDate: URLParams.joinDate || '',
                position: URLParams.position || '',
                adminID: URLParams.adminID || '',
                adminName: URLParams.adminName|| '',
            });
            pagination.appendChild(pageBtn);
        }
    }


</script>

</body>
</html>
