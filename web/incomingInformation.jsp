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

                <!-- 搜索条件 -->
                <input type="text" name="searchProduct" placeholder="商品名称">
                <input type="text" name="searchSupplier" placeholder="供应商">
                <input type="text" name="searchResponsible" placeholder="负责人">

                <!-- 进货日期筛选 -->
                <input type="date" name="incomingDate" placeholder="进货日期">


                <button type="submit">搜索</button>
            </form>
            <br>
            <!-- 进货金额筛选 -->
            <form method="get" action="incomingInformation.jsp">
                <input type="number" name="minTotalCost" placeholder="最低订单总价" step="0.01" min="0">
                <input type="number" name="maxTotalCost" placeholder="最高订单总价" step="0.01" min="0">

                <input type="number" name="minPurchasePrice" placeholder="最低商品单价" step="0.01" min="0">
                <input type="number" name="maxPurchasePrice" placeholder="最低订单总价" step="0.01" min="0">

                <!-- 进货日期筛选 -->
                <input type="date" name="startDate" placeholder="开始日期">
                <input type="date" name="endDate" placeholder="结束日期">

                <!-- 供应商筛选 -->
                <select name="supplier">
                    <option value="">选择供应商</option>
                    <!-- 供应商列表动态加载 -->
                    <%-- 通过后台动态加载供应商数据 --%>
                    <%-- for (Supplier supplier : supplierList) { %>
                    <%-- out.print("<option value='" + supplier.getId() + "'>" + supplier.getName() + "</option>"); --%>
                    <%-- } --%>
                </select>
                <select name="supplier">
                    <option value="">选择负责人</option>
                    <!-- 负责人列表动态加载 -->
                    <%-- 通过后台动态加载供应商数据 --%>
                    <%-- for (Supplier supplier : supplierList) { %>
                    <%-- out.print("<option value='" + supplier.getId() + "'>" + supplier.getName() + "</option>"); --%>
                    <%-- } --%>
                </select>

                <button type="submit">筛选</button>
            </form>

            <div class="button-group">
                <!-- 批量删除表单 -->
                <form method="post" action="batchDeleteIncomingOrders.jsp">
                    <button type="submit">批量删除</button>
                </form>

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
                    <a href="javascript:void(0)" onclick="openModal('edit', 1001)">编辑</a>
                    <a href="deleteIncomingOrder.jsp?id=1001" onclick="return confirm('确定要删除该进货订单吗？')">删除</a>
                </div>  //这里应该要改一下1001这
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
            <input type="hidden" name="orderId" id="orderId" value="">

            <!-- 商品名称 -->
            <label for="productName">商品名称:</label>
            <select name="productName" id="productName" required>
                <option value="">请选择商品</option>
                <!-- 商品列表动态加载 -->
<%--                <%--%>
<%--                    List<Product> productList = ProductDAO.getAllProducts();--%>
<%--                    for (Product product : productList) {--%>
<%--                        out.print("<option value='" + product.getId() + "'>" + product.getName() + "</option>");--%>
<%--                    }--%>
<%--                %>--%>
            </select>

            <!-- 进货数量 -->
            <label for="quantity">进货数量:</label>
            <input type="number" name="quantity" id="quantity" required>

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
            <label for="supplier">供应商:</label>
            <select name="supplier" id="supplier" required>
                <option value="">请选择供应商</option>
<%--                <%--%>
<%--                    List<Supplier> supplierList = SupplierDAO.getAllSuppliers();--%>
<%--                    for (Supplier supplier : supplierList) {--%>
<%--                        out.print("<option value='" + supplier.getId() + "'>" + supplier.getName() + "</option>");--%>
<%--                    }--%>
<%--                %>--%>
            </select>

            <!-- 负责人 -->
            <label for="responsiblePerson">负责人:</label>
            <input type="text" name="responsiblePerson" id="responsiblePerson" value="responsiblePerson" required>

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
            <input type="hidden" name="orderId" id="orderId" value="">

            <!-- 商品名称 -->
            <label for="productName">商品名称:</label>
            <select name="productName" id="productName" required>
                <option value="">请选择商品</option>
                <!-- 商品列表动态加载 -->
<%--                <%--%>
<%--                    // 从数据库或其他来源获取商品列表并填充--%>
<%--                    List<Product> productList = ProductDAO.getAllProducts();--%>
<%--                    for (Product product : productList) {--%>
<%--                        out.print("<option value='" + product.getId() + "'>" + product.getName() + "</option>");--%>
<%--                    }--%>
<%--                %>--%>
            </select>

            <!-- 进货数量 -->
            <label for="quantity">进货数量:</label>
            <input type="number" name="quantity" id="quantity" required>

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
            <label for="supplier">供应商:</label>
            <select name="supplier" id="supplier" required>
                <option value="">请选择供应商</option>
                <!-- 供应商列表动态加载 -->
<%--                <%--%>
<%--                    // 从数据库或其他来源获取供应商列表并填充--%>
<%--                    List<Supplier> supplierList = SupplierDAO.getAllSuppliers();--%>
<%--                    for (Supplier supplier : supplierList) {--%>
<%--                        out.print("<option value='" + supplier.getId() + "'>" + supplier.getName() + "</option>");--%>
<%--                    }--%>
<%--                %>--%>
            </select>

            <!-- 负责人 -->
            <label for="responsiblePerson">负责人:</label>
            <input type="text" name="responsiblePerson" id="responsiblePerson" value="responsiblePerson" required>

            <button type="submit">保存修改</button>
            <button type="button" onclick="closeModal()">取消</button>
        </form>
    </div>
</div>


<div class="footer">
    <p>&copy; 2024 超市管理系统 | 版权所有</p>
</div>

<script>
    function openModal(action, orderId) {
        // 根据操作类型显示不同的模态框
        if(action === 'edit') {
            document.getElementById('editModal').style.display = 'flex';
            document.getElementById('orderId').value = orderId;

            // 通过 AJAX 或其他方法加载进货订单的具体数据
            fetch(`/getIncomingOrder?id=${orderId}`)
                .then(response => response.json())
                .then(order => {
                    document.getElementById('productName').value = order.productName;
                    document.getElementById('productName').value = order.productName;
                    document.getElementById('quantity').value = order.quantity;
                    document.getElementById('purchasePrice').value = order.purchasePrice;
                    document.getElementById('totalCost').value = order.totalCost;
                    document.getElementById('purchaseDate').value = order.purchaseDate;
                    document.getElementById('supplier').value = order.supplierId;
                    document.getElementById('responsiblePerson').value = order.responsiblePerson;
                });
        } else if(action === 'add') {
            // 清空表单，为新增订单准备
            document.getElementById('addModal').style.display = 'flex';
            document.getElementById('orderId').value = '';  // 新增时没有订单ID//后端应该会写分配吧
            document.getElementById('productName').value = '';
            document.getElementById('quantity').value = '';
            document.getElementById('purchasePrice').value = '';
            document.getElementById('totalCost').value = '';
            document.getElementById('purchaseDate').value = '';
            document.getElementById('supplier').value = '';
            document.getElementById('responsiblePerson').value = '';
        }
    }

    function closeModal() {
        // 关闭模态框
        document.getElementById('editModal').style.display = 'none';
        document.getElementById('addModal').style.display = 'none';
    }

    // 更新订单总价
    document.getElementById('quantity').addEventListener('input', updateTotalCost);
    document.getElementById('purchasePrice').addEventListener('input', updateTotalCost);

    function updateTotalCost() {
        var quantity = parseInt(document.getElementById('quantity').value) || 0;
        var price = parseFloat(document.getElementById('purchasePrice').value) || 0;
        var totalCost = quantity * price;
        document.getElementById('totalCost').value = totalCost.toFixed(2);
    }

</script>

</body>
</html>
