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

        /* 操作按钮 */
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
            width: 140px; /* 设置宽度确保它们整齐 */
            box-sizing: border-box; /* 确保输入框的宽度包括内边距和边框 */
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
            max-width: 120px;
        }

        .action-bar button:hover {
            background-color: #005bb5;
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

        select[name="vipLevel"] {
            margin-right: 0;
        }



        /* 按钮组之间的间距 */
        .button-group {
            display: flex;
            gap: 10px;  /* 按钮之间的间距 */
            align-items: center;
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
    <h1>客户管理 - 超市管理系统</h1>
</header>

<nav>
    <a href="admin_dashboard.jsp" ><i class="fas fa-tachometer-alt"></i> 首页</a>
    <a href="product_management.jsp"><i class="fas fa-cogs"></i> 商品管理</a>
    <a href="salesManagement.jsp"><i class="fas fa-shopping-cart"></i> 销售管理</a>
    <a href="customerManagement.jsp" class="active"><i class="fas fa-warehouse"></i> 客户管理</a>
    <a href="orderManagement.jsp"><i class="fas fa-box"></i> 订单管理</a>
    <a href="incomingInformation.jsp"><i class="fas fa-chart-line"></i> 进货信息</a>
    <a href="staffManagement.jsp"><i class="fas fa-users"></i> 员工管理</a>
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
    <h2>客户列表</h2>
    <div class="action-bar">
        <form method="get" action="customerManagement.jsp">
            <!-- 排序下拉框 -->
            <select name="sortBy">
                <option value="">排序方式</option>
                <option value="name">按姓名排序</option>
                <option value="joinDate">按加入日期排序</option>
            </select>
            <button type="submit">排序</button>

            <!-- 搜索框和筛选框 -->
            <input type="text" name="customerName" placeholder="姓名">
            <input type="email" name="contactInfo" placeholder="联系方式">
            <input type="date" name="joinDate" placeholder="加入日期">

            <!-- VIP等级筛选 -->
            <select name="vipLevel">
                <option value="">选择VIP等级</option>
                <option value="1">VIP1</option>
                <option value="2">VIP2</option>
                <option value="3">VIP3</option>
                <option value="4">VIP4</option>
                <option value="5">VIP5</option>
            </select>

            <input type="number" name="minTotalConsumption" placeholder="最低消费总金额" step="0.01" min="0">
            <input type="number" name="maxTotalConsumption" placeholder="最高消费总金额" step="0.01" min="0">
            <!-- 筛选按钮 -->

            <button type="submit">筛选</button>
            <!-- 导出CSV按钮 -->
            <button onclick="exportCSV({
            sortBy: getURLParam('sortBy') || '',
            sortOrder: getURLParam('sortOrder') || '',
            CustomerName: getURLParam('CustomerName') || '',
            Contactinfo: getURLParam('Contactinfo') || '',
            minTotalConsumption: getURLParam('minTotalConsumption') || '',
            maxTotalConsumption: getURLParam('maxTotalConsumption') || '',
            JoinDate: getURLParam('JoinDate') || '',
            VIPLevel: getURLParam('VIPLevel') || ''
        })">导出CSV</button>
            <button onclick="openModal('add')">添加客户</button>
        </form>
    </div>

    <table>
        <thead>
        <tr>
            <th>客户ID</th>
            <th>姓名</th>
            <th>联系方式</th>
            <th>加入日期</th>
            <th>消费总金额</th> <!-- 新增列 -->
            <th>VIP等级</th> <!-- 新增列 -->
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="customerTableBody">
        <!-- 客户列表将在这里动态生成 -->
        </tbody>
    </table>

    <div class="pagination" id="pagination"></div>
        <!-- 分页按钮将在这里动态生成 -->
</div>

<div class="footer">
    <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>
<!-- 添加客户和编辑客户的弹窗 -->
<div id="customerModal" class="modal">
    <div class="modal-content">
        <h2 id="modalTitle">添加客户</h2>
        <form id="customerForm" onsubmit="return submitModal();">
            <label for="customerName">姓名:</label>
            <input type="text" id="customerName" name="customerName" required>

            <label for="contactInfo">联系方式:</label>
            <input type="text" id="contactInfo" name="contactInfo" required>

            <label for="joinDate">加入日期:</label>
            <input type="date" id="joinDate" name="joinDate" required>

            <label for="totalConsumption">消费总金额:</label>
            <input type="number" id="totalConsumption" name="totalConsumption" required>

            <label for="vipLevel">VIP等级:</label>
            <select id="vipLevel" name="vipLevel" required>
                <option value="">请选择</option>
                <option value="1">VIP1</option>
                <option value="2">VIP2</option>
                <option value="3">VIP3</option>
                <option value="4">VIP4</option>
                <option value="5">VIP5</option>
            </select>

            <button type="submit">确认</button>
            <button type="button" onclick="closeModal()">取消</button>
        </form>
    </div>
</div>

<script>

    function openModal(action, customerID = null) {
        var modal = document.getElementById('customerModal');
        var modalTitle = document.getElementById('modalTitle');

        if (action === 'add') {
            modalTitle.textContent = '添加客户';
            document.getElementById('action').value = 'addCustomer';
            document.getElementById('customerID').value = '';
            document.getElementById('customerName').value = '';
            document.getElementById('contactInfo').value = '';
            document.getElementById('joinDate').value = '';
            document.getElementById('totalConsumption').value = '';
            document.getElementById('vipLevel').value = '';
        } else if (action === 'edit') {
            modalTitle.textContent = '编辑客户';
            document.getElementById('action').value = 'editCustomer';
            document.getElementById('customerID').value = '';
            document.getElementById('customerName').value = '';
            document.getElementById('contactInfo').value = '';
            document.getElementById('joinDate').value = '';
            document.getElementById('totalConsumption').value = '';
            document.getElementById('vipLevel').value = '';

            // 通过AJAX获取客户详情来填充表单
            fetch('customer?action=getCustomerDetails&customerID=' + customerID)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('customerName').value = data.customerName;
                    document.getElementById('contactInfo').value = data.contactInfo;
                    document.getElementById('joinDate').value = data.joinDate;
                    document.getElementById('totalConsumption').value = data.totalConsumption;
                    document.getElementById('vipLevel').value = data.vipLevel;
                })
                .catch(error => console.error('Error fetching customer details:', error));
        }

        modal.style.display = 'flex';
    }

    // 提交弹窗
    function submitModal() {

        // 获取表单数据
        const form = document.getElementById('customerForm');
        const formData = new FormData(form); // 封装表单数据
        const action = formData.get('action'); // 获取 action，用于判断是新增还是编辑

        // 发送 AJAX 请求
        fetch('CustomerManage', {
            method: 'POST',
            body: formData,
        })
            .then(response => {
                if (response.ok) {
                    if (action === 'addCustomer') {
                        alert('客户新增成功！');
                    } else if (action === 'editCustomer') {
                        alert('客户编辑成功！');
                    }
                    closeModal(); // 关闭弹窗
                    fetchProducts(1); // 刷新商品列表
                } else {
                    return response.text().then(text => { throw new Error(text); });
                }
            })
            .catch(error => {
                console.error('错误:', error);
                alert('操作失败，请检查输入或稍后重试！');
            });
        return false; // 阻止表单默认提交行为
    }

    // 关闭弹窗
    function closeModal() {
        var modal = document.getElementById('customerModal');
        modal.style.display = 'none';
        document.getElementById('customerForm').reset(); // 清空表单
    }

    function exportCSV({sortBy = '', sortOrder = '', CustomerName = '', Contactinfo = '',
                           JoinDate = '',VIPLevel = '', minTotalConsumption = '',maxTotalConsumption = ''})
    {
        // 向后端请求数据
        fetch('CustomerManage?action=exportCSV' +
            '&sortBy=' + sortBy +
            '&sortOrder=' + sortOrder +
            '&CustomerName=' + CustomerName+
            '&Contactinfo=' + Contactinfo +
            '&minTotalConsumption =' + minTotalConsumption +
            '&maxTotalConsumption =' + maxTotalConsumption +
            '&JoinDate=' + JoinDate +
            '&VIPLevel=' + VIPLevel
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
                link.download = 'customers.csv'; // 设置下载文件名
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



    const itemsPerPage = 10; // 每页显示的数量
    let currentPage = 1; // 当前页码

    // 获取客户信息
    function fetchCustomers({
                            page = currentPage, sortBy = '', sortOrder = '', customerName = '', contactInfo = '', joinDate = '',
                            vipLevel = '',minTotalConsumption = '',maxTotalConsumption = ''
                        }) {
        currentPage = page;
        const offset = (page - 1) * itemsPerPage;
        const URLParams = {
            page: page,
            sortBy: sortBy,
            sortOrder: sortOrder,
            customerName: customerName,
            contactInfo: contactInfo,
            joinDate: joinDate,
            vipLevel: vipLevel,
            minTotalConsumption: minTotalConsumption,
            maxTotalConsumption: maxTotalConsumption
        };
        updateUrlParams(URLParams);

        fetch('CustomerManage?action=getCustomers&offset=' + offset + '&limit=' + itemsPerPage
            + '&sortBy=' + sortBy + '&sortOrder=' + sortOrder
            + '&customerName=' + customerName + '&contactInfo=' + contactInfo
            + '&joinDate=' + joinDate + '&vipLevel=' + vipLevel + '&minTotalConsumption=' + minTotalConsumption + '&maxTotalConsumption=' + maxTotalConsumption)
            .then(response => response.json())
            .then(data => {
                const customerTableBody = document.getElementById('customerTableBody');
                customerTableBody.innerHTML = ''; // 清空表格

                if (data.customers && data.customers.length > 0) {
                    data.customers.forEach(customer => {
                        const row = document.createElement('tr');
                        row.innerHTML = '<td>' + customer.customerID + '</td>'
                            + '<td>' + customer.customerName + '</td>'
                            + '<td>' + customer.contactInfo + '</td>'
                            + '<td>' + customer.joinDate + '</td>'
                            + '<td>' + customer.totalConsumption + '</td>'
                            + '<td>' + customer.vipLevel + '</td>'
                            + '<td>' +
                            '<div class="action-btns">' +
                            '<e href="javascript:void(0)" onclick="openModal(\'edit\', ' + customer.customerID + ')">编辑</e>' +
                            '</div>' +
                            '</td>';
                        customerTableBody.appendChild(row);
                    });
                } else {
                    const row = document.createElement('tr');
                    row.innerHTML = '<td colspan="8">没有找到客户信息</td>';
                    customerTableBody.appendChild(row);
                }

                updatePagination(data.totalPages);
            })
            .catch(error => console.error('Error fetching customers:', error));
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
            pageBtn.onclick = () => fetchCustomers({
                page: i,
                sortBy: URLParams.sortBy || '',
                sortOrder: URLParams.sortOrder || '',
                customerName: URLParams.customerName || '',
                contactInfo: URLParams.contactInfo || '',
                joinDate: URLParams.joinDate || '',
                vipLevel: URLParams.vipLevel || '',
                minTotalConsumption: URLParams.minTotalConsumption || '',
                maxTotalConsumption: URLParams.maxTotalConsumption || ''
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


    // 页面加载时：获取URL参数；获取客户信息并显示分页按钮
    window.onload = function () {
        const URLParams = getUrlParams();
        fetchCustomers({
            page: URLParams.page || 1,
            sortBy: URLParams.sortBy || '',
            sortOrder: URLParams.sortOrder || '',
            customerName: URLParams.customerName || '',
            contactInfo: URLParams.contactInfo || '',
            joinDate: URLParams.joinDate || '',
            vipLevel: URLParams.vipLevel || '',
            minTotalConsumption: URLParams.minTotalConsumption || '',
            maxTotalConsumption: URLParams.maxTotalConsumption || ''
        });
    };

</script>



</body>
</html>
