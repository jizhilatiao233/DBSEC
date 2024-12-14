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
            width: 110px;
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
            <select name="sortBy" id="sortBy">
                <option value="">排序方式</option>
                <option value="staffName">按姓名排序</option>
                <option value="joinDate">按加入日期排序</option>
            </select>
            <button type="submit">排序</button>
        </form>
        <br>
        <!-- 筛选 -->
        <form method="get" action="staffManagement.jsp">
            <input type="text" name="staffName" placeholder="姓名">
            <input type="text" name="contactInfo" placeholder="联系方式">
            <!-- 加入日期筛选 -->
            <input type="date" name="fromjoinDate" placeholder="最早加入日期">
            <input type="date" name="tojoinDate" placeholder="最晚加入日期">
            <!-- 职位筛选 -->
            <select name="position">
                <option value="">选择职位</option>
                <option value="收银员">收银员</option>
                <option value="管理员">管理员</option>
            </select>
            <button type="submit">筛选</button>
        </form>

            <button onclick="exportCSV({
            sortBy: getURLParam('sortBy') || '',
            sortOrder: getURLParam('sortOrder') || '',
            employeeId: getURLParam('staffID') || '',
            employeeName: getURLParam('staffName') || '',
            employeePhone: getURLParam('contactInfo') || '',
            joinDate: getURLParam('joinDate') || '',
            position: getURLParam('position') || ''
            staffName: getURLParam('staffName') || '',
            contactInfo: getURLParam('contactInfo') || '',
            fromJoinDate: getURLParam('fromJoinDate') || '',
            toJoinDate: getURLParam('toJoinDate') || '',
            position: getURLParam('position') || '',
            adminID: getURLParam('adminID') || '',
            adminName: getURLParam('adminName') || '',
        })">导出CSV</button>
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
        <tbody id="staffTableBody">
        <!-- 列表将在这里动态生成 -->
        </tbody>
    </table>
    <div class="pagination" id="pagination"></div>
</div>

<div class="footer">
    <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<script>

    function exportCSV({sortBy = '', sortOrder = '',staffName = '', contactInfo = '', fromJoinDate = '', toJoinDate = '', position = '', adminID = '', adminName = ''})
    {

        // 向后端请求数据
        fetch('StaffManage?action=exportCSV' +
            '&sortBy=' + sortBy +
            '&sortOrder=' + sortOrder +
            '&staffName=' + staffName +
            '&contactInfo=' + contactInfo +
            '&fromJoinDate=' + fromJoinDate +
            '&toJoinDate=' + toJoinDate+
            '&position=' + position +
            '&adminID =' + adminID  +
            '&adminName =' + adminName
        )
            .then(response => {
                // 如果响应状态不正常，抛出错误
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

                // 获取二进制数据（CSV文件）
                return response.blob();
            })
            .then(blob => {
                // 创建 Blob URL 并触发下载
                const downloadUrl = URL.createObjectURL(blob);
                const link = document.createElement('a');
                link.href = downloadUrl;
                link.download = 'staffs.csv'; // 设置下载文件名
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                URL.revokeObjectURL(downloadUrl); // 释放 Blob URL
            })
            .catch(error => {
                console.error('Error exporting CSV:', error);
                alert('导出失败，请稍后再试！'); // 友好的用户提示
            });
    }

    // 删除员工
    function deleteStaff(staffID) {
        if (confirm('确定要删除此员工吗？')) {
            // 获取员工详情
            fetch('staff?action=getStaffDetails&staffID=' + staffID)
                .then(response => response.json())
                .then(data => {

                    // 更新员工信息
                    const formData = new FormData();
                    formData.append('action', 'editStaff');
                    formData.append('staffID', data.staffID);
                    formData.append('staffName', data.staffName);
                    formData.append('contactInfo', data.contactInfo);
                    formData.append('username', data.username);
                    formData.append('password', data.password);
                    formData.append('joinDate', data.joinDate);
                    formData.append('position', data.position);
                    formData.append('adminID', data.adminID);
                    formData.append('adminName', data.adminName);

                    return fetch('StaffManage', {
                        method: 'POST',
                        body: formData
                    });
                })
                .then(response => {
                    if (response.ok) {
                        alert('员工已成功删除！');
                        fetchStaff(1);
                    } else {
                        return response.text().then(text => {
                            throw new Error(text);
                        });
                    }
                })
                .catch(error => {
                    console.error('错误:', error);
                    alert('删除失败，请稍后重试！');
                });
        }
    }


    const itemsPerPage = 10; // 每页显示的数量
    let currentPage = 1; // 当前页码

    // 获取员工信息
    function fetchStaff({
                            page = currentPage, sortBy = '', sortOrder = '',
                            staffID = '', staffName = '', contactInfo = '', joinDate = '', position = ''
                        }) {
        currentPage = page;
        const offset = (page - 1) * itemsPerPage;
        const URLParams = {
            page: page,
            sortBy: sortBy,
            sortOrder: sortOrder,
            staffID: staffID,
            staffName: staffName,
            contactInfo: contactInfo,
            joinDate: joinDate,
            position: position
        };
        updateUrlParams(URLParams);

        fetch('StaffManage?action=getStaffs&offset=' + offset + '&limit=' + itemsPerPage
            + '&sortBy=' + sortBy + '&sortOrder=' + sortOrder
            + '&staffID=' + staffID + '&staffName=' + staffName + '&contactInfo=' + contactInfo + '&joinDate=' + joinDate + '&position=' + position)
            .then(response => response.json())
            .then(data => {
                const staffTableBody = document.getElementById('staffTableBody');
                staffTableBody.innerHTML = ''; // 清空表格

                if (data.staffs && data.staffs.length > 0) {
                    data.staffs.forEach(staff => {
                        const row = document.createElement('tr');
                        row.innerHTML = '<td>' + staff.staffID + '</td>'
                            + '<td>' + staff.staffName + '</td>'
                            + '<td>' + staff.contactInfo + '</td>'
                            + '<td>' + staff.joinDate + '</td>'
                            + '<td>' + staff.position + '</td>'
                            + '<td>' +
                            '<div class="action-btns">' +
                            '<c href="javascript:void(0)" onclick="deleteStaff(' + staff.staffID + ')">删除</>' +'</div>' +
                            '</td>';
                        staffTableBody.appendChild(row);
                    });
                } else {
                    const row = document.createElement('tr');
                    row.innerHTML = '<td colspan="8">没有找到员工信息</td>';
                    staffTableBody.appendChild(row);
                }

                updatePagination(data.totalPages);
            })
            .catch(error => console.error('Error fetching staffs:', error));
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
            pageBtn.onclick = () => fetchStaff({
                page: i,
                sortBy: URLParams.sortBy || '',
                sortOrder: URLParams.sortOrder || '',
                staffID: URLParams.staffID || '',
                staffName: URLParams.staffName || '',
                contactInfo: URLParams.contactInfo || '',
                joinDate: URLParams.joinDate || '',
                position: URLParams.position || ''
            });
            pagination.appendChild(pageBtn);
        }
    }
    // 获取URL中的查询参数
    function getURLParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }


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


    // 页面加载时：获取URL参数；获取销售信息并显示分页按钮
    window.onload = function () {
        const URLParams = getUrlParams();
        fetchStaff({
            page: URLParams.page || 1,
            sortBy: URLParams.sortBy || '',
            sortOrder: URLParams.sortOrder || '',
            staffID: URLParams.staffID || '',
            staffName: URLParams.staffName || '',
            contactInfo: URLParams.contactInfo || '',
            joinDate: URLParams.joinDate || '',
            position: URLParams.position || ''
        });
    };

</script>

</body>
</html>
