-- 创建数据库
# CREATE DATABASE ShopManagement;

-- 以root用户登录
-- mysql -u root -p

-- 使用数据库
USE ShopManagement;

DROP USER IF EXISTS 'shopmanage';

-- 授权
CREATE USER 'shopmanage'@'%' IDENTIFIED BY '123456';
grant all privileges on ShopManagement.* to 'shopmanage';
flush privileges;

DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS StaffManagement;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Product;

-- 创建商品表
CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,     -- 商品编号
    ProductName VARCHAR(255) NOT NULL,            -- 商品名称
    Category VARCHAR(100) NOT NULL,                        -- 商品类别
    PurchasePrice DECIMAL(10, 2) NOT NULL,        -- 进货单价
    SellingPrice DECIMAL(10, 2) NOT NULL,         -- 销售单价
    ShelfStock INT DEFAULT 0,                     -- 货架库存
    WarehouseStock INT DEFAULT 0                  -- 仓库库存
);

-- 创建客户表
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,    -- 客户编号
    CustomerName VARCHAR(255) NOT NULL,           -- 客户姓名
    ContactInfo VARCHAR(255),                     -- 联系方式
    Username VARCHAR(100),                        -- 用户名（可为空）
    Password VARCHAR(255),                        -- 密码（可为空）
    IsVIP BOOLEAN DEFAULT FALSE,                  -- 是否为VIP
    PurchaseSum DECIMAL(10, 2) NOT NULL
);

-- 创建管理员表
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY AUTO_INCREMENT,      -- 管理员编号
    AdminName VARCHAR(255) NOT NULL,             -- 管理员姓名
    ContactInfo VARCHAR(255),                    -- 联系方式
    Username VARCHAR(100) NOT NULL,              -- 用户名
    Password VARCHAR(255) NOT NULL,              -- 密码
    Position VARCHAR(100) DEFAULT '管理员'            -- 职位 (固定为“管理员”)
);


-- 创建收银员表
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,      -- 收银员编号
    StaffName VARCHAR(255) NOT NULL,             -- 收银员姓名
    ContactInfo VARCHAR(255),                    -- 联系方式
    Username VARCHAR(100) NOT NULL,              -- 用户名
    Password VARCHAR(255) NOT NULL,              -- 密码
    Position VARCHAR(100) DEFAULT '收银员',       -- 职位 (固定为“收银员”)
    AdminID INT NOT NULL,                                 -- 管理员编号 (外键)
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
);

-- 创建员工管理表
CREATE TABLE StaffManagement (
    ManagementID INT PRIMARY KEY AUTO_INCREMENT,  -- 管理信息编号
    StaffID INT NOT NULL,                                  -- 被调度收银员编号 (外键)
    AdminID INT NOT NULL,                                  -- 执行调度的管理员编号 (外键)
    ManagementTimestamp DATETIME DEFAULT CURRENT_TIMESTAMP,  -- 调度日期
    ManagementDescription TEXT,                   -- 调度信息描述
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
);

-- 创建订单表
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    StaffID INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    ActualPayment DECIMAL(10, 2) NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- 创建销售表
CREATE TABLE Sales (
    OrderID INT NOT NULL,                       -- 销售单号
    ProductID INT NOT NULL,                     -- 商品编号 (外键)
    StaffID INT NOT NULL,                           -- 收银员编号 (外键)
    QuantitySold INT NOT NULL,                   -- 销售数量
    SellingPrice DECIMAL(10, 2) NOT NULL,        -- 商品销售单价 (当时的价格，可能不等于商品表中的销售单价)
    ActualPayment DECIMAL(10, 2),
    Profit DECIMAL(10, 2),                       -- 利润 (按当时的销售单价与进货单价计算)
    SalesDate DATETIME DEFAULT CURRENT_TIMESTAMP, -- 销售日期
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- 创建供应商表
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,   -- 供应商编号
    SupplierName VARCHAR(255) NOT NULL,          -- 供应商名称
    ContactInfo VARCHAR(255)                     -- 联系方式
);

-- 创建进货表
CREATE TABLE Purchase (
    PurchaseID INT PRIMARY KEY AUTO_INCREMENT,   -- 进货单号
    ProductID INT NOT NULL,                               -- 商品编号 (外键)
    QuantityPurchased INT NOT NULL,              -- 进货数量
    PurchasePrice DECIMAL(10, 2) NOT NULL,       -- 进货单价
    TotalCost DECIMAL(10, 2) AS (QuantityPurchased * PurchasePrice),  -- 总金额
    PurchaseDate DATETIME DEFAULT CURRENT_TIMESTAMP, -- 进货日期
    AdminID INT NOT NULL,                                 -- 管理员编号 (外键)
    SupplierID INT NOT NULL,                              -- 供应商编号 (外键)
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);
commit;