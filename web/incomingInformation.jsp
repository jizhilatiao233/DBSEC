<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>进货信息 - 超市管理系统</title>
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
            width: 120px;
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
    <h1>进货信息 - 超市管理系统</h1>
</header>

<nav>
    <a href="admin_dashboard.jsp" ><i class="fas fa-tachometer-alt"></i> 首页</a>
    <a href="product_management.jsp"><i class="fas fa-cogs"></i> 商品管理</a>
    <a href="salesManagement.jsp"><i class="fas fa-shopping-cart"></i> 销售管理</a>
    <a href="customerManagement.jsp"><i class="fas fa-warehouse"></i> 客户管理</a>
    <a href="orderManagement.jsp"><i class="fas fa-box"></i> 订单管理</a>
    <a href="incomingInformation.jsp" class="active"><i class="fas fa-chart-line"></i> 进货信息</a>
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
    <h2>进货订单管理</h2>
    <div class="action-bar">
        <!-- 排序 -->
        <form method="get" action="incomingInformation.jsp">
            <label for="sortBy">排序方式:</label>
            <select name="sortBy" id="sortBy">
                <option value="">排序方式</option>
                <option value="purchaseDate">按进货日期排序</option>
                <option value="supplierName">按供应商排序</option>
                <option value="totalCost">按订单总价排序</option>
            </select>
            <button type="submit">排序</button>
        </form>
        <br>
        <!-- 筛选 -->
        <form method="get" action="incomingInformation.jsp">
            <input type="number" name="purchaseID" placeholder="进货订单号" step="1" min="0">
            <input type="text" name="productName" id="productName" placeholder="商品名称">

            <input type="number" name="minTotalCost" placeholder="最低订单总价" step="0.01" min="0">
            <input type="number" name="maxTotalCost" placeholder="最高订单总价" step="0.01" min="0">

            <input type="number" name="minPurchasePrice" placeholder="最低商品单价" step="0.01" min="0">
            <input type="number" name="maxPurchasePrice" placeholder="最低订单单价" step="0.01" min="0">

            <input type="date" name="purchaseDate" placeholder="进货日期">
            <input type="text" name="supplierName" placeholder="选择供应商">
            <input type="text" name="adminName" placeholder="选择负责人">

            <button type="submit">筛选</button>
        <!-- 添加进货订单按钮 -->
        <button onclick="openModal('add')">添加进货订单</button>
        <!-- 导出 CSV 表单 -->
        <button onclick="exportCSV(getUrlParams())">导出CSV</button>
        </form>
    </div>

    <table>
        <thead>
        <tr>
            <th>进货订单号</th>
            <th>商品名称</th>
            <th>进货数量</th>
            <th>购买单价</th>
            <th>订单总价</th>
            <th>进货日期</th>
            <th>供应商</th>
            <th>负责人</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="purchaseTableBody">
        <!-- 列表将在这里动态生成 -->
        </tbody>
    </table>
    <div class="pagination" id="pagination">
        <!-- 分页按钮将在这里动态生成 -->
    </div>
</div>

<div class="footer">
    <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<!-- 进货订单模态框 -->
<div id="purchaseModal" class="modal">
    <div class="modal-content">
        <h2 id="modalTitle"></h2>
        <form id="purchaseForm" onsubmit="return submitModal();">
            <input type="hidden" name="purchaseID" id="purchaseID">
            <input type="hidden" name="action" id="action">

            <label for="productName">商品名称:</label>
            <input type="text" name="productName" required>

            <label for="quantityPurchased">进货数量:</label>
            <input type="number" name="quantityPurchased" id="quantityPurchased" required>

            <label for="purchasePrice">购买单价:</label>
            <input type="number" name="purchasePrice" id="purchasePrice" step="0.01" required>

            <label for="totalCost">订单总价:</label>
            <input type="number" name="totalCost" id="totalCost" readonly>

            <label for="purchaseDate">进货日期:</label>
            <input type="date" name="purchaseDate" id="purchaseDate" required>

            <label for="supplierName">供应商:</label>
            <input type="text" name="supplierName" id="supplierName" required>

            <label for="adminName">负责人:</label>
            <input type="text" name="adminName" id="adminName" required>

            <button type="submit" class="submit-btn">确认</button>
            <button type="reset" class="close-btn" onclick="closeModal()">取消</button>
        </form>
    </div>
</div>

<script>
    function openModal(action, purchaseID = null) {
        var modal = document.getElementById('purchaseModal');
        var modalTitle = document.getElementById('modalTitle');

        if(action === 'edit') {
            modalTitle.textContent = '编辑进货订单';
            document.getElementById('action').value = 'editPurchase';
            document.getElementById('purchaseID').value = purchaseID;

            // 通过AJAX获取商品详情来填充表单
            fetch('purchase?action=getPurchaseDetails&purchaseID=' + purchaseID)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('productName').value = data.productName;
                    document.getElementById('quantityPurchased').value = data.quantityPurchased;
                    document.getElementById('purchasePrice').value = data.purchasePrice;
                    document.getElementById('totalCost').value = data.totalCost;
                    document.getElementById('purchaseDate').value = data.purchaseDate;
                    document.getElementById('supplierName').value = data.supplierName;
                    document.getElementById('adminName').value = data.adminName;
                })
                .catch(error => console.error('Error fetching purchase details:', error));
        } else if(action === 'add') {
            // 清空表单，为新增订单准备
            modalTitle.textContent = '添加进货订单';
            document.getElementById('action').value = 'addPurchase';
            document.getElementById('purchaseID').value = '';
            document.getElementById('productName').value = '';
            document.getElementById('quantityPurchased').value = '';
            document.getElementById('purchasePrice').value = '';
            document.getElementById('totalCost').value = '';
            document.getElementById('purchaseDate').value = '';
            document.getElementById('supplierName').value = '';
            document.getElementById('adminName').value = '';
        }
        modal.style.display = 'flex';
    }

    // 提交弹窗
    function submitModal() {

        // 获取表单数据
        const form = document.getElementById('purchaseForm');
        const formData = new FormData(form); // 封装表单数据
        const action = formData.get('action'); // 获取 action，用于判断是新增还是编辑

        // 进货逻辑


        // 发送 AJAX 请求
        fetch('PurchaseManage', {
            method: 'POST',
            body: formData,
        })
            .then(response => {
                if (response.ok) {
                    if (action === 'addPurchase') {
                        alert('进货订单新增成功！');
                    } else if (action === 'editPurchase') {
                        alert('进货订单编辑成功！');
                    }
                    closeModal(); // 关闭弹窗
                    fetchPurchase(1); // 刷新列表
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

    // 删除进货订单
    function deletePurchase(purchaseID) {
        if (confirm('确定要删除此进货订单吗？')) {
            // 获取订单详情
            fetch('purchase?action=getPurchaseDetails&purchaseID=' + purchaseID)
                .then(response => response.json())
                .then(data => {

                    // 更新订单信息
                    const formData = new FormData();
                    formData.append('action', 'editPurchase');
                    formData.append('purchaseID', data.purchaseID);
                    formData.append('productID', data.productID);
                    formData.append('productName', data.productName);
                    formData.append('quantityPurchased', data.quantityPurchased);
                    formData.append('purchasePrice', data.purchasePrice);
                    formData.append('totalCost', data.totalCost);
                    formData.append('purchaseDate', data.purchaseDate);
                    formData.append('adminID', data.adminID);
                    formData.append('adminName', data.adminName);
                    formData.append('supplierID', data.supplierID);
                    formData.append('supplierName', data.supplierName);

                    return fetch('purchaserManage', {
                        method: 'POST',
                        body: formData
                    });
                })
                .then(response => {
                    if (response.ok) {
                        alert('进货订单已成功删除！');
                        fetchPurchase(1);
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

    function closeModal() {
        var modal = document.getElementById('purchaseModal');
        modal.style.display = 'none';
        document.getElementById('purchaseForm').reset(); // 清空表单
        checkStockWarning();
    }


    const itemsPerPage = 10; // 每页显示的数量
    let currentPage = 1; // 当前页码

    // 获取进货信息
    function fetchPurchase({
                            page = currentPage, sortBy = '', sortOrder = '',
                            purchaseID = '', productName = '', minTotalCost = '', maxTotalCost = '',
                            minPurchasePrice = '', maxPurchasePrice = '', purchaseDate = '', supplierName = '',adminName = ''
                        }) {
        currentPage = page;
        const offset = (page - 1) * itemsPerPage;
        const URLParams = {
            page: page,
            sortBy: sortBy,
            sortOrder: sortOrder,
            purchaseID: purchaseID,
            productName: productName,
            minTotalCost: minTotalCost,
            maxTotalCost: maxTotalCost,
            minPurchasePrice: minPurchasePrice,
            maxPurchasePrice: maxPurchasePrice,
            purchaseDate: purchaseDate,
            supplierName: supplierName,
            adminName: adminName
        };
        updateUrlParams(URLParams);

        fetch('PurchaseManage?action=getPurchases&offset=' + offset + '&limit=' + itemsPerPage
            + '&sortBy=' + sortBy + '&sortOrder=' + sortOrder
            + '&purchaseID=' + purchaseID + '&productName=' + productName + '&minTotalCost=' +  minTotalCost + '&maxTotalCost=' + maxTotalCost
            + '&minPurchasePrice=' +  minPurchasePrice+ '&maxPurchasePrice=' +  maxPurchasePrice+ '&purchaseDate=' +  purchaseDate
            + '&supplierName=' + supplierName +  '&adminName=' + adminName)
            .then(response => response.json())
            .then(data => {
                const purchaseTableBody = document.getElementById('purchaseTableBody');
                purchaseTableBody.innerHTML = ''; // 清空表格

                if (data.purchases && data.purchases.length > 0) {
                    data.purchases.forEach(purchase => {
                        const row = document.createElement('tr');
                        row.innerHTML = '<td>' + purchase.purchaseID + '</td>'
                            + '<td>' + purchase.productName + '</td>'
                            + '<td>' + purchase.quantityPurchased + '</td>'
                            + '<td>' + purchase.purchasePrice + '</td>'
                            + '<td>' + purchase.totalCost + '</td>'
                            + '<td>' + purchase.purchaseDate + '</td>'
                            + '<td>' + purchase.adminName + '</td>'
                            + '<td>' + purchase.supplierName + '</td>' +
                            '<td>' +
                            '<div class="action-btns">' +
                            '<e href="javascript:void(0)" onclick="openModal(\'edit\', ' + purchase.purchaseID + ')">编辑</e>' +
                            '<c href="javascript:void(0)" onclick="deletePurchase(' + purchase.purchaseID + ')">删除</c>' +
                            '</div>' +
                            '</td>';
                        purchaseTableBody.appendChild(row);
                    });
                } else {
                    const row = document.createElement('tr');
                    row.innerHTML = '<td colspan="8">没有找到进货订单信息</td>';
                    purchaseTableBody.appendChild(row);
                }

                updatePagination(data.totalPages);
            })
            .catch(error => console.error('Error fetching purchases:', error));
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
            pageBtn.onclick = () => fetchPurchase({
                page: i,
                sortBy: URLParams.sortBy || '',
                sortOrder: URLParams.sortOrder || '',
                purchaseID: URLParams.purchaseID || '',
                productName: URLParams.productName || '',
                minTotalCost: URLParams.minTotalCost || '',
                maxTotalCost: URLParams.maxTotalCost || '',
                minPurchasePrice: URLParams.minPurchasePrice || '',
                maxPurchasePrice: URLParams.maxPurchasePrice || '',
                purchaseDate: URLParams.purchaseDate || '',
                supplierName: URLParams.supplierName || '',
                adminName: URLParams.adminName || ''
            });
            pagination.appendChild(pageBtn);
        }
    }
    // 获取URL中的查询参数
    function getURLParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }


    function exportCSV({sortBy = '', sortOrder = '', productName = '', supplierName= '',  adminName = '',purchaseDate = '',minTotalCost = '', maxTotalCost = '',
                           minPurchasePrice = '',maxPurchasePrice = '',fromPurchaseDate='',toPurchaseDate=''})
    {

        // 向后端请求数据
        fetch('PurchaseManage?action=exportCSV' +
            '&sortBy=' + sortBy +
            '&sortOrder=' + sortOrder +
            '&productName=' + productName +
            '&supplierName=' + supplierName +
            '&adminName=' + adminName +
            '&purchaseDate=' + purchaseDate +
            '&minTotalCost=' + minTotalCost +
            '&maxTotalCost=' +  maxTotalCost +
            '&minPurchasePrice=' + minPurchasePrice +
            '&maxPurchasePrice=' + maxPurchasePrice +
            '&fromPurchaseDate=' + fromPurchaseDate +
            '&toPurchaseDate=' + toPurchaseDate

        )
            .then(response => {
                // 如果响应状态不正常，抛出错误
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

            })
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


    // 页面加载时：获取URL参数；获取销售信息并显示分页按钮
    window.onload = function () {
        const URLParams = getUrlParams();
        fetchPurchase({
            page: URLParams.page || 1,
            sortBy: URLParams.sortBy || '',
            sortOrder: URLParams.sortOrder || '',
            purchaseID: URLParams.purchaseID || '',
            productName: URLParams.productName || '',
            minTotalCost: URLParams.minTotalCost || '',
            maxTotalCost: URLParams.maxTotalCost || '',
            minPurchasePrice: URLParams.minPurchasePrice || '',
            maxPurchasePrice: URLParams.maxPurchasePrice || '',
            purchaseDate: URLParams.purchaseDate || '',
            supplierName: URLParams.supplierName || '',
            adminName: URLParams.adminName || ''
        });
    };
</script>

</body>
</html>
