### **1. 商品表 (Product)**

管理商品的基本信息，包括库存和定价信息。

- 字段：
	- `ProductID` (INT, 主键) - 商品编号
	- `ProductName` (VARCHAR) - 商品名称
	- `Category` (VARCHAR) - 商品类别
	- `PurchasePrice` (DECIMAL) - 进货单价
	- `SellingPrice` (DECIMAL) - 销售单价
	- `ShelfStock` (INT) - 货架库存
	- `WarehouseStock` (INT) - 仓库库存

------

### **2. 客户表 (Customer)**

管理客户信息，包括VIP和信用评级。

- 字段：
	- `CustomerID` (INT, 主键) - 客户编号
	- `CustomerName` (VARCHAR) - 客户名称
	- `ContactInfo` (VARCHAR) - 联系方式
	- `IsVIP` (BOOLEAN) - 是否为VIP
	- `CreditRating` (INT) - 信用评级 (1-5分)

------

### **3. 销售表 (Sales)**

记录销售单信息，包括利润计算和销售的明细。

- 字段：
	- `SalesID` (INT, 主键) - 销售单号
	- `ProductID` (INT, 外键) - 商品编号
	- `CustomerID` (INT, 外键) - 客户编号
	- `StaffID` (INT, 外键) - 收银员编号
	- `QuantitySold` (INT) - 销售数量
	- `SellingPrice` (DECIMAL) - 商品销售单价（冗余设计以支持历史价格追踪）
	- `TotalAmount` (DECIMAL) - 总金额（自动计算: `QuantitySold` × `SellingPrice`）
	- `Profit` (DECIMAL) - 利润（自动计算: `QuantitySold` × (`SellingPrice` - 商品表中的`PurchasePrice`)）
	- `SalesDate` (DATETIME) - 销售日期

------

### **4. 仓库库存表 (WarehouseInventory)**

记录每种商品在各个仓库中的库存信息和补货情况。

- 字段：
	- `WarehouseID` (INT, 主键) - 仓库编号
	- `ProductID` (INT, 外键) - 商品编号
	- `Stock` (INT) - 当前库存
	- 保质期
	- `LastRestockDate` (DATETIME) - 上次补货日期

------

### **5. 供应商表 (Supplier)**

记录供应商信息及其提供的商品。

- 字段：
	- `SupplierID` (INT, 主键) - 供应商编号
	- `SupplierName` (VARCHAR) - 供应商名称
	- `ContactInfo` (VARCHAR) - 联系方式

------

### **6. 进货表 (Purchase)**

记录进货单信息，包括总金额和相关的进货操作。

- 字段：
	- `PurchaseID` (INT, 主键) - 进货单号
	- `ProductID` (INT, 外键) - 商品编号
	- `QuantityPurchased` (INT) - 进货数量
	- `PurchasePrice` (DECIMAL) - 单个商品进货单价（冗余设计支持历史追踪）
	- `TotalCost` (DECIMAL) - 总金额（自动计算: `QuantityPurchased` × `PurchasePrice`）
	- `PurchaseDate` (DATETIME) - 进货日期
	- `AdminID` (INT, 外键) - 管理员编号
	- `SupplierID` (INT, 外键) - 供应商编号

------

### **7. 管理员表 (Admin)**

管理系统管理员信息。

- 字段：
	- `AdminID` (INT, 主键) - 管理员编号
	- `Username` (VARCHAR) - 用户名
	- `Password` (VARCHAR) - 密码
	- `RoleDescription` (TEXT) - 管理权限描述

------

### **8. 收银员表 (Staff)**

记录收银员的信息和职位。

- 字段：
	- `StaffID` (INT, 主键) - 收银员编号
	- `StaffName` (VARCHAR) - 收银员姓名
	- `ContactInfo` (VARCHAR) - 联系方式
	- `Position` (VARCHAR) - 职位（固定为“收银员”）

    管理员编号 (AdminID, 外键)
------------------------------------------------------------
关系设计
销售表与商品表
    关系：商品表 (Product) 1:N 销售表 (Sales)
    外键：Sales.ProductID → Product.ProductID

商品表与仓库库存表
    关系：商品表 (Product) 1:N 仓库库存表 (WarehouseInventory)
    外键：WarehouseInventory.ProductID → Product.ProductID

商品表与供应商表
    关系：商品表 (Product) 1:N 供应商表 (Supplier)
    外键：Supplier.ProductID → Product.ProductID

进货表与商品表、管理员表、供应商表
    关系：商品表 (Product) 1:N 进货表 (Purchase)
    外键：Purchase.ProductID → Product.ProductID
    关系：管理员表 (Admin) 1:N 进货表 (Purchase)
    外键：Purchase.AdminID → Admin.AdminID
    关系：供应商表 (Supplier) 1:N 进货表 (Purchase)
    外键：Purchase.SupplierID → Supplier.SupplierID

管理员表与仓库库存表
    关系：管理员表 (Admin) 1:N 仓库库存表 (WarehouseInventory)
    外键：WarehouseInventory.ManagedBy → Admin.AdminID

管理员表与商品表（补货逻辑）
    货架库存不足时，管理员负责将库存从仓库库存表中转移到商品表 (ShelfStock) 中。
    仓库库存不足时，管理员通过进货表联系供应商补货到仓库。