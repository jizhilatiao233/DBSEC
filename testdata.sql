-- Product
INSERT INTO Product (ProductName, Category, PurchasePrice, SellingPrice, ShelfStock, WarehouseStock) VALUES
    ('Apple', 'Fruit', 1.00, 1.50, 100, 500),
    ('Banana', 'Fruit', 0.50, 0.80, 200, 300),
    ('Milk', 'Dairy', 2.00, 3.00, 50, 100),
    ('Bread', 'Bakery', 1.20, 1.80, 80, 150),
    ('Eggs', 'Poultry', 0.10, 0.20, 300, 1000),
    ('Carrot', 'Vegetable', 0.30, 0.50, 150, 400),
    ('Chicken', 'Meat', 5.00, 8.00, 20, 50),
    ('Pasta', 'Grocery', 1.50, 2.50, 60, 100),
    ('Rice', 'Grocery', 0.70, 1.00, 120, 300),
    ('Cheese', 'Dairy', 3.00, 4.50, 40, 80);

-- Customer
INSERT INTO Customer (CustomerName, ContactInfo, Username, Password, IsVIP, CreditRating) VALUES
    ('Alice Johnson', 'alice@example.com', 'alicej', 'password123', TRUE, 5),
    ('Bob Smith', 'bob@example.com', 'bobsmith', 'securepass', FALSE, 4),
    ('Catherine Lee', 'catherine@example.com', 'cathylee', 'catspass', TRUE, 5),
    ('David Brown', 'david@example.com', 'daveb', 'davidsafe', FALSE, 3),
    ('Evelyn Clark', 'evelyn@example.com', 'eveclark', 'pass567', TRUE, 4),
    ('Frank White', 'frank@example.com', 'frankw', 'frankpass', FALSE, 3),
    ('Grace Adams', 'grace@example.com', NULL, NULL, FALSE, 2),
    ('Henry Green', 'henry@example.com', 'henryg', 'henry123', TRUE, 4),
    ('Isabella King', 'isabella@example.com', 'isabellak', 'bella789', FALSE, 3),
    ('Jack Wilson', 'jack@example.com', NULL, NULL, FALSE, 2);

-- Admin
INSERT INTO Admin (AdminName, ContactInfo, Username, Password, RoleDescription) VALUES
    ('John Manager', 'john.manager@example.com', 'johnm', 'adminpass', 'Full access to product and sales management'),
    ('Jane Supervisor', 'jane.supervisor@example.com', 'janes', 'supervisor123', 'Manage staff and inventory');

-- Staff
INSERT INTO Staff (StaffName, ContactInfo, Username, Password, AdminID) VALUES
    ('Michael Cashier', 'michael.cashier@example.com', 'mikecash', 'cashier123', 1),
    ('Nina Teller', 'nina.teller@example.com', 'ninat', 'tellpass', 1),
    ('Olivia Clerk', 'olivia.clerk@example.com', 'oliviac', 'clerkpass', 2),
    ('Peter Operator', 'peter.operator@example.com', 'petero', 'operator123', 2);

-- Sales
INSERT INTO Sales (ProductID, CustomerID, StaffID, QuantitySold, SellingPrice, Profit) VALUES
    (1, 1, 1, 5, 1.50, 2.50),
    (2, 2, 1, 10, 0.80, 3.00),
    (3, 3, 2, 2, 3.00, 2.00),
    (4, 4, 2, 3, 1.80, 2.40),
    (5, 5, 3, 12, 0.20, 1.20),
    (6, 6, 3, 8, 0.50, 2.00),
    (7, 7, 4, 1, 8.00, 3.00),
    (8, 8, 4, 4, 2.50, 3.00),
    (9, 9, 1, 6, 1.00, 3.00),
    (10, 10, 1, 5, 1.50, 3.00);

-- WarehouseInventory
INSERT INTO WarehouseInventory (ProductID, Stock, LastRestockDate) VALUES
    (1, 500, '2024-11-20'),
    (2, 300, '2024-11-20'),
    (3, 100, '2024-11-20'),
    (4, 150, '2024-11-20'),
    (5, 1000, '2024-11-20'),
    (6, 400, '2024-11-20'),
    (7, 50, '2024-11-20'),
    (8, 100, '2024-11-20'),
    (9, 300, '2024-11-20'),
    (10, 80, '2024-11-20');

-- Supplier
INSERT INTO Supplier (SupplierName, ContactInfo) VALUES
    ('FreshFruits Ltd.', 'fruits@supplier.com'),
    ('DairyBest Inc.', 'dairy@supplier.com'),
    ('BakeryGoods Co.', 'bakery@supplier.com'),
    ('VeggieWorld', 'veggie@supplier.com'),
    ('MeatMaster Supplies', 'meat@supplier.com');

-- Purchase
INSERT INTO Purchase (ProductID, QuantityPurchased, PurchasePrice, AdminID, SupplierID) VALUES
    (1, 100, 0.80, 1, 1),
    (2, 200, 0.40, 1, 1),
    (3, 50, 1.50, 1, 2),
    (4, 80, 1.00, 1, 3),
    (5, 300, 0.05, 1, 4),
    (6, 150, 0.20, 1, 4),
    (7, 20, 4.00, 2, 5),
    (8, 60, 1.00, 2, 3),
    (9, 120, 0.60, 2, 2),
    (10, 40, 0.50, 2, 1);