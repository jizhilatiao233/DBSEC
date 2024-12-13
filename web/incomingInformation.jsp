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

        <!-- 查询功能表单 -->
        <div class="action-bar">
            <!-- 排序和搜索表单 -->
            <form method="get" action="incomingInformation.jsp">
                <!-- 排序方式 -->
                <select name="sortBy">
                    <option value="">排序方式</option>
                    <option value="purchaseDate">按进货日期排序</option>
                    <option value="supplier">按供应商排序</option>
                    <option value="totalCost">按订单总价排序</option>
                </select>
                <button type="submit">排序</button>
            </form>
            <br>
            <!-- 进货金额筛选 -->
            <form method="get" action="incomingInformation.jsp">
                <select name="product">
                    <option value="">选择商品</option>
                </select>
                <input type="number" name="minTotalCost" placeholder="最低订单总价" step="0.01" min="0">
                <input type="number" name="maxTotalCost" placeholder="最高订单总价" step="0.01" min="0">

                <input type="number" name="minPurchasePrice" placeholder="最低商品单价" step="0.01" min="0">
                <input type="number" name="maxPurchasePrice" placeholder="最低订单总价" step="0.01" min="0">

                <!-- 进货日期筛选 -->
                <input type="date" name="startDate" placeholder="开始日期">
                <input type="date" name="endDate" placeholder="结束日期">

                <!-- 供应商筛选 -->
                <select name="supplierName">
                    <option value="">选择供应商</option>
                </select>
                <select name="adminName">
                    <option value="">选择负责人</option>
                </select>

                <button type="submit">筛选</button>
            </form>

            <div class="button-group">
                <!-- 添加进货订单按钮 -->
                <button onclick="openModal('add')">添加进货订单</button>

                <!-- 导出 CSV 表单 -->
                <form method="get" action="exportCSV.jsp">
                    <button type="submit">导出CSV</button>
                </form>
            </div>
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
        <tbody>
        <tbody id="purchaseTableBody">
        <!-- 商品列表将在这里动态生成 -->
        </tbody>
        <!-- 动态加载进货数据 -->
        <tr>
            <td>1001</td>
            <td>商品A</td>
            <td>20</td>
            <td>￥100.00</td>
            <td>￥2000</td>
            <td>2024-12-05</td>
            <td>供应商X</td>
            <td>管理员A</td>
            <td>
                <div class="action-btns">
                    <e href="javascript:void(0)" onclick="openModal('edit', 1001)">编辑</e>
                    <c href="deleteIncomingOrder.jsp?id=1001" onclick="return confirm('确定要删除该进货订单吗？')">删除</c>
                </div>
            </td>
        </tr>
        <!-- 更多进货数据 -->
        </tbody>
    </table>
</div>
<!-- 添加进货订单的模态框 -->
<div class="modal" id="addModal">
    <div class="modal-content">
        <h3>添加进货订单</h3>
        <form action="addIncomingOrder.jsp" method="POST">
            <!-- 订单ID：新增时没有，编辑时有 -->
            <input type="hidden" name="purchaseID" id="purchaseID" value="">

            <!-- 商品名称 -->
            <label for="productName">商品名称:</label>
            <select name="productName" id="productName" required>
                <option value="">请选择商品</option>
            </select>

            <!-- 进货数量 -->
            <label for="quantityPurchased">进货数量:</label>
            <input type="number" name="quantityPurchased" id="quantityPurchased" required>

            <!-- 购买单价 -->
            <label for="purchasePrice">购买单价:</label>
            <input type="number" name="purchasePrice" id="purchasePrice" step="0.01" required>

            <!-- 订单总价 -->
            <label for="totalCost">订单总价:</label>
            <input type="text" name="totalCost" id="totalCost" readonly>

            <!-- 进货日期 -->
            <label for="purchaseDate">进货日期:</label>
            <input type="date" name="purchaseDate" id="purchaseDate" required>

            <!-- 供应商 -->
            <label for="supplierName">供应商:</label>
            <select name="supplierName" id="supplierName" required>
                <option value="">请选择供应商</option>
            </select>

            <!-- 负责人 -->
            <label for="adminName">负责人:</label>
            <input type="text" name="adminName" id="adminName" required>

            <button type="submit">添加订单</button>
            <button type="button" onclick="closeModal()">取消</button>
        </form>
    </div>
</div>

<!-- 编辑进货订单的模态框 -->
<div class="modal" id="editModal">
    <div class="modal-content">
        <h3>编辑进货订单</h3>
        <form action="updateIncomingOrder.jsp" method="POST">
            <!-- 进货订单号（隐藏字段，防止修改） -->
            <input type="hidden" name="purchaseID" id="purchaseID" value="">

            <!-- 商品名称 -->
            <label for="productName">商品名称:</label>
            <select name="productName" id="productName" required>
                <option value="">请选择商品</option>
            </select>

            <!-- 进货数量 -->
            <label for="quantityPurchased">进货数量:</label>
            <input type="number" name="quantityPurchased" id="quantityPurchased" required>

            <!-- 购买单价 -->
            <label for="purchasePrice">购买单价:</label>
            <input type="number" name="purchasePrice" id="purchasePrice" step="0.01" required>

            <!-- 订单总价 -->
            <label for="totalCost">订单总价:</label>
            <input type="text" name="totalCost" id="totalCost" readonly>

            <!-- 进货日期 -->
            <label for="purchaseDate">进货日期:</label>
            <input type="date" name="purchaseDate" id="purchaseDate" required>

            <!-- 供应商 -->
            <label for="supplierName">供应商:</label>
            <select name="supplierName" id="supplierName" required>
                <option value="">请选择供应商</option>
            </select>

            <!-- 负责人 -->
            <label for="adminName">负责人:</label>
            <input type="text" name="adminName" id="adminName" value="adminName" required>

            <button type="submit">保存修改</button>
            <button type="button" onclick="closeModal()">取消</button>
        </form>
    </div>
</div>


<div class="footer">
    <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<script>
    function openModal(action, purchaseID) {
        var modal = document.getElementById('purchaseModal');
        var modalTitle = document.getElementById('modalTitle');
        // 根据操作类型显示不同的模态框
        if(action === 'edit') {
            document.getElementById('editModal').style.display = 'flex';
            modalTitle.textContent = '编辑商品';
            document.getElementById('action').value = 'editProduct';
            document.getElementById('productID').value = productID;
            restockRow.style.display = 'block';
            addStockRow.style.display = 'none';

            // 通过AJAX获取商品详情来填充表单
            fetch('purchase?action=getPurchaseDetails&productID=' + productID)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('productName').value = data.productName;
                    document.getElementById('category').value = data.category;
                    document.getElementById('purchasePrice').value = data.purchasePrice;
                    document.getElementById('sellingPrice').value = data.sellingPrice;
                    document.getElementById('shelfStock').value = data.shelfStock;
                    document.getElementById('warehouseStock').value = data.warehouseStock;
                    document.getElementById('productName').value = order.productName;
                    document.getElementById('productName').value = order.productName;
                    document.getElementById('quantity').value = order.quantity;
                    document.getElementById('purchasePrice').value = order.purchasePrice;
                    document.getElementById('totalCost').value = order.totalCost;
                    document.getElementById('purchaseDate').value = order.purchaseDate;
                    document.getElementById('supplier').value = order.supplierId;
                    document.getElementById('responsiblePerson').value = order.responsiblePerson;
                })
                .catch(error => console.error('Error fetching purchase details:', error));
        } else if(action === 'add') {
            // 清空表单，为新增订单准备
            modalTitle.textContent = '添加进货订单';
            document.getElementById('action').value = 'addPurchase';
            document.getElementById('addModal').style.display = 'flex';
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

    function closeModal() {
        // 关闭模态框
        document.getElementById('editModal').style.display = 'none';
        document.getElementById('addModal').style.display = 'none';
    }

    // 更新订单总价
    //document.getElementById('quantity').addEventListener('input', updateTotalCost);
    //document.getElementById('purchasePrice').addEventListener('input', updateTotalCost);

    //function updateTotalCost() {
    //    var quantity = parseInt(document.getElementById('quantity').value) || 0;
    //    var price = parseFloat(document.getElementById('purchasePrice').value) || 0;
    //    var totalCost = quantity * price;
    //    document.getElementById('totalCost').value = totalCost.toFixed(2);
    //}

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
    function offShelf(productID) {
        if (confirm('确定要下架此商品吗？')) {
            // 获取商品详情
            fetch('product?action=getProductDetails&productID=' + productID)
                .then(response => response.json())
                .then(data => {
                    const shelfStock = data.shelfStock;
                    const warehouseStock = data.warehouseStock + shelfStock;

                    // 更新商品信息
                    const formData = new FormData();
                    formData.append('action', 'editProduct');
                    formData.append('productID', productID);
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

                        row.innerHTML =
                            '<td>' + product.productID + '</td>' +
                            '<td>' + product.productName + '</a></td>' +
                            '<td>' + product.category + '</td>' +
                            '<td>' + product.purchasePrice + '</td>' +
                            '<td>' + product.sellingPrice + '</td>' +
                            '<td>' + product.shelfStock + '</td>' +
                            '<td>' + product.warehouseStock + '</td>' +
                            '<td>' +
                            '<div class="action-btns">' +
                            '<e href="javascript:void(0)" onclick="openModal(\'edit\', ' + product.productID + ')">编辑</e>' +
                            '<c href="javascript:void(0)" onclick="offShelf(' + product.productID + ')">下架</>' +
                            '</div>' +
                            '</td>';

                        productTableBody.appendChild(row);
                    });
                } else {
                    const row = document.createElement('tr');
                    row.innerHTML = '<td colspan="9">没有找到商品信息</td>';
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


    // 监听导出按钮点击事件
    // 获取URL中的查询参数
    function getURLParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }

    function exportCSV({sortBy = '', sortOrder = '',productName = '', category = '', minPrice = '', maxPrice = ''})
    {
        // 向后端请求数据
        fetch('product?action=exportCSV' +
            '&sortBy=' + sortBy +
            '&sortOrder=' + sortOrder +
            '&productName=' + productName +
            '&category=' + category +
            '&minPrice=' + minPrice +
            '&maxPrice=' + maxPrice
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
                link.download = 'products.csv'; // 设置下载文件名
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
