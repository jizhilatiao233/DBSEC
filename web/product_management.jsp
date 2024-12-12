<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品管理 - 超市管理系统</title>
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

        /* Header Section */
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
            transform: scale(1.05);
        }
        nav a.active {
            background-color: #003366;
        }

        /* Main content area */
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

        /* 商品管理表格 */
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

        .footer {
            background-color: #0066cc;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        /* 用户信息 */
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

        /* Search, Sort, and Action Buttons in one row */
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        .action-bar form {
            display: inline-flex;
            align-items: center;
        }
        .action-bar input[type="text"], .action-bar select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 10px;
        }
        .action-bar button {
            padding: 8px 12px;
            border: 1px solid #0066cc;
            background-color: #0066cc;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .action-bar button:hover {
            background-color: #005bb5;
        }

        /* 弹窗样式 */
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
            z-index: 9999;  /* Ensure modal appears on top */
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

        /* 分页按钮 */
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

        /* 库存预警卡片 */
        .stock-warning-card {
            background: linear-gradient(135deg, #9c0202 30%, #ed0404 100%); /* 渐变从蓝色到深蓝色 */
            color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            text-align: center;
            font-size: 18px;
        }
        .stock-warning-card a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        .stock-warning-card a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>

<!-- Header Section -->
<header>
    <h1>商品管理 - 超市管理系统</h1>
</header>

<!-- Side Navigation -->
<nav id="sideNav">
    <a href="admin_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> 仪表盘</a>
    <a href="product_management.jsp" class="active"><i class="fas fa-cogs"></i> 商品管理</a>
    <a href="salesManagement.jsp"><i class="fas fa-shopping-cart"></i> 销售管理</a>
    <a href="customerManagement.jsp"><i class="fas fa-warehouse"></i> 客户管理</a>
    <a href="orderManagement.jsp"><i class="fas fa-box"></i> 订单管理</a>
    <a href="incomingInformation.jsp"><i class="fas fa-chart-line"></i> 进货信息</a>
    <a href="staffManagement.jsp"><i class="fas fa-users"></i> 员工管理</a>
    <a href='Logout?redirect=index.jsp'><i class="fas fa-sign-out-alt"></i> 退出</a>
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
    <a href='Logout?redirect=index.jsp' class="logout-btn"><i class="fas fa-sign-out-alt"></i> 退出</a>
</div>
<!-- Main Content Section -->
<div class="container">
    <h2>商品列表</h2>
    <!-- 库存不足警告卡片 -->
    <div class="card stock-warning-card" style="display: none;">
        <p class="card-title"><strong>库存预警！</strong></p>
        <p class="card-content">当前有商品库存低于最低设定库存，请及时检查。</p>
        <a class="card-link" id="lowStockLink" href="product_management.jsp?page=1&sortBy=warehouseStock">点击查看库存不足商品</a>
    </div>
    <!-- 搜索框、排序、筛选和导出按钮 -->
    <div class="action-bar">
        <form method="get" action="product_management.jsp">
            <input type="text" name="search" placeholder="输入商品名称">
            <button type="submit">搜索</button>
        </form>

        <form method="get" action="product_management.jsp">
            <label for="sortBy">排序方式:</label>
            <select name="sortBy" id="sortBy">
                <option value="productName">商品名称</option>
                <option value="category">商品类别</option>
                <option value="purchasePrice">进价</option>
                <option value="sellingPrice">售价</option>
                <option value="shelfStock">上架数量</option>
                <option value="warehouseStock">仓库库存</option>
            </select>
            <button type="submit">排序</button>
        </form>

        <form method="get" action="product_management.jsp">
            <label for="categoryFilter">类别:</label>
            <select name="category" id="categoryFilter">
                <!-- 商品类别将在这里动态生成 -->
            </select>

            <label for="minPrice">最低价格:</label>
            <input type="number" name="minPrice" id="minPrice" placeholder="最低价格" min="0" step="0.01">
            <label for="maxPrice">最高价格:</label>
            <input type="number" name="maxPrice" id="maxPrice" placeholder="最高价格" min="0" step="0.01">

            <button type="submit">筛选</button>
        </form>

<%--        <form method="post" action="batchDelete">--%>
<%--            <button type="submit">批量删除</button>--%>
<%--        </form>--%>

        <!-- 导出CSV按钮 (DEPRECATED) -->
        <%--        <form id="exportCSVForm" action="javascript:void(0)">--%>
        <%--            <button type="submit" onclick="exportCSV()">导出CSV</button>--%>
        <%--        </form>--%>

        <!-- 添加商品按钮 -->
        <button onclick="openModal('add')">添加商品</button>

    </div>

    <!-- 商品列表展示 -->
    <table>
        <thead>
        <tr>
            <th><input type="checkbox" id="selectAll"> 全选</th>
            <th>商品ID</th>
            <th>商品名称</th>
            <th>类别</th>
            <th>进价</th>
            <th>售价</th>
            <th>上架数量</th>
            <th>仓库库存</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="productTableBody">
        <!-- 商品列表将在这里动态生成 -->
        </tbody>
    </table>
    <div class="pagination" id="pagination">
        <!-- 分页按钮将在这里动态生成 -->
    </div>
</div>

<!-- Footer Section -->
<div class="footer">
    <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<!-- 商品操作弹窗 -->
<div id="productModal" class="modal">
    <div class="modal-content">
        <h2 id="modalTitle"></h2>
        <form id="productForm" onsubmit="return submitModal();">
            <input type="hidden" name="productId" id="productId">
            <input type="hidden" name="action" id="action">

            <label for="productName">商品名称:</label>
            <input type="text" name="productName" id="productName" required>

            <label for="category">类别:</label>
            <input type="text" name="category" id="category" required>

            <label for="purchasePrice">进价:</label>
            <input type="number" name="purchasePrice" id="purchasePrice" min="0" step="0.01" required>

            <label for="sellingPrice">售价:</label>
            <input type="number" name="sellingPrice" id="sellingPrice" min="0" step="0.01" required>

            <div id="restockRow" style="display: none;">
                <label for="restockAmount">货架补货:</label>
                <input type="number" name="restockAmount" id="restockAmount" min="0" value="0">
            </div>

            <div id="addStockRow" style="display: none;">
                <label for="shelfStock">上架数量:</label>
                <input type="number" name="shelfStock" id="shelfStock" min="0" value="0">

                <label for="warehouseStock">仓库库存:</label>
                <input type="number" name="warehouseStock" id="warehouseStock" min="0" value="0">
            </div>

            <button type="submit" class="submit-btn">提交</button>
            <button type="reset" class="close-btn" onclick="closeModal()">关闭</button>
        </form>
    </div>
</div>

<script>
    // 打开弹窗
    function openModal(action, productId = null) {
        var modal = document.getElementById('productModal');
        var modalTitle = document.getElementById('modalTitle');
        var productForm = document.getElementById('productForm');
        var restockRow = document.getElementById('restockRow');
        var addStockRow = document.getElementById('addStockRow');

        if (action === 'add') {
            modalTitle.textContent = '添加商品';
            document.getElementById('action').value = 'addProduct';
            document.getElementById('productId').value = '';
            document.getElementById('productName').value = '';
            document.getElementById('category').value = '';
            document.getElementById('purchasePrice').value = '';
            document.getElementById('sellingPrice').value = '';
            document.getElementById('shelfStock').value = '';
            document.getElementById('warehouseStock').value = '';
            restockRow.style.display = 'none';
            addStockRow.style.display = 'block';
        } else if (action === 'edit') {
            modalTitle.textContent = '编辑商品';
            document.getElementById('action').value = 'editProduct';
            document.getElementById('productId').value = productId;
            restockRow.style.display = 'block';
            addStockRow.style.display = 'none';

            // 通过AJAX获取商品详情来填充表单
            fetch('product?action=getProductDetails&productId=' + productId)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('productName').value = data.productName;
                    document.getElementById('category').value = data.category;
                    document.getElementById('purchasePrice').value = data.purchasePrice;
                    document.getElementById('sellingPrice').value = data.sellingPrice;
                    document.getElementById('shelfStock').value = data.shelfStock;
                    document.getElementById('warehouseStock').value = data.warehouseStock;
                })
                .catch(error => console.error('Error fetching product details:', error));
        }

        modal.style.display = 'flex';
    }

    // 提交弹窗
    function submitModal() {

        // 获取表单数据
        const form = document.getElementById('productForm');
        const formData = new FormData(form); // 封装表单数据
        const action = formData.get('action'); // 获取 action，用于判断是新增还是编辑

        // 补货逻辑
        if (action === 'editProduct') {
            const restockAmount = parseInt(formData.get('restockAmount'));
            const shelfStock = parseInt(formData.get('shelfStock'));
            const warehouseStock = parseInt(formData.get('warehouseStock'));

            if (restockAmount <= warehouseStock) {
                formData.set('shelfStock', shelfStock + restockAmount);
                formData.set('warehouseStock', warehouseStock - restockAmount);
            } else {
                alert('补货数量不能超过仓库库存！');
                return false;
            }
        }

        // 发送 AJAX 请求
        fetch('ProductManage', {
            method: 'POST',
            body: formData,
        })
            .then(response => {
                if (response.ok) {
                    if (action === 'addProduct') {
                        alert('商品新增成功！');
                    } else if (action === 'editProduct') {
                        alert('商品编辑成功！');
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

    // 下架商品
    function offShelf(productId) {
        if (confirm('确定要下架此商品吗？')) {
            // 获取商品详情
            fetch('product?action=getProductDetails&productId=' + productId)
                .then(response => response.json())
                .then(data => {
                    const shelfStock = data.shelfStock;
                    const warehouseStock = data.warehouseStock + shelfStock;

                    // 更新商品信息
                    const formData = new FormData();
                    formData.append('action', 'editProduct');
                    formData.append('productId', productId);
                    formData.append('productName', data.productName);
                    formData.append('category', data.category);
                    formData.append('purchasePrice', data.purchasePrice);
                    formData.append('sellingPrice', data.sellingPrice);
                    formData.append('shelfStock', 0);
                    formData.append('warehouseStock', warehouseStock);

                    return fetch('ProductManage', {
                        method: 'POST',
                        body: formData
                    });
                })
                .then(response => {
                    if (response.ok) {
                        alert('商品已成功下架！');
                        fetchProducts(1);
                        checkStockWarning();
                    } else {
                        return response.text().then(text => { throw new Error(text); });
                    }
                })
                .catch(error => {
                    console.error('错误:', error);
                    alert('下架失败，请稍后重试！');
                });
        }
    }

    // 关闭弹窗
    function closeModal() {
        var modal = document.getElementById('productModal');
        modal.style.display = 'none';
        document.getElementById('productForm').reset(); // 清空表单
        checkStockWarning();
    }

    // 检查库存预警
    const warningThreshold = 10; // 设定的库存预警值
    function checkStockWarning() {
        fetch('product?action=getProducts')
            .then(response => response.json())
            .then(data => {
                let showWarning = false;

                data.products.forEach(product => {
                    if (product.warehouseStock < warningThreshold) {
                        showWarning = true;
                    }
                });

                if (showWarning) {
                    document.querySelector('.stock-warning-card').style.display = 'block';
                } else {
                    document.querySelector('.stock-warning-card').style.display = 'none';
                }
            })
            .catch(error => console.error('Error checking stock warning:', error));
    }

    // 全选操作
    document.getElementById('selectAll').addEventListener('change', function () {
        var checkboxes = document.querySelectorAll('input[name="selectedProducts"]');
        checkboxes.forEach(checkbox => checkbox.checked = this.checked);
    });

    // 获取商品列表
    const itemsPerPage = 10; // 每页显示的商品数量
    let currentPage = 1; // 当前页码
    function fetchProducts({
            page = currentPage, sortBy = '', sortOrder = '',
            productName = '', category = '',
            minPrice = '', maxPrice = ''
        }) {
        currentPage = page;
        const offset = (page - 1) * itemsPerPage;
        const URLParams = {
            page: page,
            sortBy: sortBy,
            sortOrder: sortOrder,
            search: productName,
            category: category,
            minPrice: minPrice,
            maxPrice: maxPrice
        };
        updateUrlParams(URLParams);

        // 发送请求获取当前页的商品
        fetch('product?action=getProducts&offset=' + offset + '&limit=' + itemsPerPage +
            '&sortBy=' + sortBy + '&sortOrder=' + sortOrder +
            '&productName=' + productName + '&category=' + category +
            '&minPrice=' + minPrice + '&maxPrice=' + maxPrice)
            .then(response => response.json())
            .then(data => {
                const productTableBody = document.getElementById('productTableBody');
                productTableBody.innerHTML = ''; // Clear existing rows

                // Debugging
                console.log(data);

                if (data.products && data.products.length > 0) {
                    data.products.forEach(product => {
                        const row = document.createElement('tr');

                        row.innerHTML = '<td><input type="checkbox" name="selectedProducts" value="' + product.productId + '"></td>' +
                            '<td>' + product.productId + '</td>' +
                            '<td>' + product.productName + '</a></td>' +
                            '<td>' + product.category + '</td>' +
                            '<td>' + product.purchasePrice + '</td>' +
                            '<td>' + product.sellingPrice + '</td>' +
                            '<td>' + product.shelfStock + '</td>' +
                            '<td>' + product.warehouseStock + '</td>' +
                            '<td>' +
                            '<div class="action-btns">' +
                                '<a href="javascript:void(0)" onclick="openModal(\'edit\', ' + product.productId + ')">编辑</a>' +
                                '<a href="javascript:void(0)" onclick="offShelf(' + product.productId + ')">下架</a>' +
                            '</div>' +
                            '</td>';

                        productTableBody.appendChild(row);
                    });
                } else {
                    const row = document.createElement('tr');
                    row.innerHTML = '<td colspan="9">No products available.</td>';
                    productTableBody.appendChild(row);
                }

                // Update pagination based on the total number of products
                updatePagination(data.totalPages);
            })
            .catch(error => console.error('Error fetching products:', error));
    }

    // 获取商品类别，填充筛选下拉框
    function fetchCategories() {
        fetch('product?action=getCategories')
            .then(response => response.json())
            .then(data => {
                const categoryFilter = document.getElementById('categoryFilter');
                categoryFilter.innerHTML = '<option value="">所有</option>'; // 添加“所有”选项
                data.forEach(category => {
                    const option = document.createElement('option');
                    option.value = category;
                    option.textContent = category;
                    categoryFilter.appendChild(option);
                });
            })
            .catch(error => console.error('Error fetching categories:', error));
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
            pageBtn.onclick = () => fetchProducts({
                page: i,
                sortBy: URLParams.sortBy || '',
                sortOrder: URLParams.sortOrder || '',
                productName: URLParams.search || '',
                category: URLParams.category || '',
                minPrice: URLParams.minPrice || '',
                maxPrice: URLParams.maxPrice || ''
            });
            pagination.appendChild(pageBtn);
        }
    }

    // 导出CSV (DEPRECATED)
    // TODO: 修改此函数
    function exportCSV() {
        const params = getUrlParams();

        fetch('product?action=exportCSV' +
            '&productName=' + params.search +
            '&category=' + params.category +
            '&minPrice=' + params.minPrice +
            '&maxPrice=' + params.maxPrice +
            '&sortBy=' + params.sortBy +
            '&sortOrder=' + params.sortOrder)
                .then(response => response.blob())
            .then(blob => {
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.style.display = 'none';
                a.href = url;
                a.download = 'products.csv';
                document.body.appendChild(a);
                a.click();
                window.URL.revokeObjectURL(url);
            })
            .catch(error => console.error('Error exporting CSV:', error));
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

    // 页面加载时：获取URL参数；获取商品类别；获取商品并显示分页按钮；检查库存预警
    window.onload = function() {
        const URLParams = getUrlParams();
        fetchCategories();
        fetchProducts({
            page: URLParams.page || 1,
            sortBy: URLParams.sortBy || '',
            sortOrder: URLParams.sortOrder || '',
            productName: URLParams.search || '',
            category: URLParams.category || '',
            minPrice: URLParams.minPrice || '',
            maxPrice: URLParams.maxPrice || ''
        });
        checkStockWarning();
    };
</script>

</body>
</html>
