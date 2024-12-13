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
    ('Cheese', 'Dairy', 3.00, 4.50, 40, 80),
    ('Orange', 'Fruit', 0.80, 1.20, 80, 200),
    ('Pineapple', 'Fruit', 2.00, 3.00, 40, 100),
    ('Peach', 'Fruit', 1.50, 2.00, 60, 150),
    ('Pear', 'Fruit', 1.20, 1.80, 70, 200),
    ('Grapes', 'Fruit', 1.00, 1.50, 90, 250),
    ('Strawberry', 'Fruit', 2.50, 3.50, 30, 80),
    ('Blueberry', 'Fruit', 2.00, 2.50, 50, 120),
    ('Watermelon', 'Fruit', 3.00, 4.00, 20, 60),
    ('Pumpkin', 'Vegetable', 1.50, 2.00, 40, 100),
    ('Potato', 'Vegetable', 0.40, 0.60, 100, 300),
    ('Tomato', 'Vegetable', 0.60, 0.80, 80, 200),
    ('Cucumber', 'Vegetable', 0.50, 0.70, 90, 250),
    ('Lettuce', 'Vegetable', 0.80, 1.00, 70, 150),
    ('Beef', 'Meat', 6.00, 10.00, 30, 80),
    ('Pork', 'Meat', 5.00, 8.00, 40, 100),
    ('Lamb', 'Meat', 7.00, 12.00, 20, 60),
    ('Salmon', 'Seafood', 8.00, 15.00, 20, 50),
    ('Shrimp', 'Seafood', 10.00, 18.00, 10, 30),
    ('Tuna', 'Seafood', 6.00, 12.00, 30, 80),
    ('Cod', 'Seafood', 7.00, 14.00, 20, 60),
    ('Sardine', 'Seafood', 5.00, 10.00, 40, 100),
    ('Soy Sauce', 'Grocery', 1.00, 1.50, 100, 200),
    ('Vinegar', 'Grocery', 0.80, 1.20, 120, 250),
    ('Sugar', 'Grocery', 0.50, 0.80, 150, 300),
    ('Flour', 'Grocery', 0.60, 1.00, 130, 280),
    ('Salt', 'Grocery', 0.30, 0.50, 200, 400),
    ('Pepper', 'Grocery', 0.40, 0.60, 180, 350),
    ('Cinnamon', 'Grocery', 1.00, 1.50, 100, 200),
    ('Nutmeg', 'Grocery', 1.20, 1.80, 80, 150),
    ('Oregano', 'Grocery', 0.80, 1.20, 120, 250),
    ('Basil', 'Grocery', 0.70, 1.00, 130, 280),
    ('Thyme', 'Grocery', 0.60, 0.80, 140, 300),
    ('Rosemary', 'Grocery', 0.50, 0.70, 150, 320),
    ('Cumin', 'Grocery', 0.90, 1.20, 110, 230),
    ('Curry Powder', 'Grocery', 1.00, 1.50, 100, 200),
    ('Paprika', 'Grocery', 0.80, 1.20, 120, 250),
    ('Chili Powder', 'Grocery', 0.70, 1.00, 130, 280),
    ('Garlic Powder', 'Grocery', 0.60, 0.80, 140, 300),
    ('Onion Powder', 'Grocery', 0.50, 0.70, 150, 320);

-- Customer
INSERT INTO Customer (CustomerName, ContactInfo, Username, Password, VIPLevel) VALUES
    ('Alice Johnson', 'alice@example.com', 'alicej', SHA2('alicepass', 256), 1),
    ('Bob Smith', 'bob@example.com', 'bobsmith', SHA2('bobpass', 256), 2),
    ('Catherine Lee', 'catherine@example.com', 'cathylee', SHA2('cathypass', 256), 3),
    ('David Brown', 'david@example.com', 'daveb', SHA2('davepass', 256), 4),
    ('Evelyn Clark', 'evelyn@example.com', 'eveclark', SHA2('evepass', 256), 5),
    ('Frank White', 'frank@example.com', 'frankw', SHA2('frankpass', 256), 4),
    ('Grace Adams', 'grace@example.com', NULL, NULL, 3),
    ('Henry Green', 'henry@example.com', 'henryg', SHA2('henrypass', 256), 3),
    ('Isabella King', 'isabella@example.com', 'isabellak', SHA2('isapass', 256), 2),
    ('Jack Wilson', 'jack@example.com', NULL, NULL, 1);

-- Admin
INSERT INTO Admin (AdminName, ContactInfo, Username, Password, Position) VALUES
    ('John Manager', 'john.manager@example.com', 'johnm', SHA2('adminpass', 256), '管理员'),
    ('Jane Supervisor', 'jane.supervisor@example.com', 'janes', SHA2('supervisor123', 256), '管理员');

-- Staff
INSERT INTO Staff (StaffName, ContactInfo, Username, Password, AdminID) VALUES
    ('Michael Cashier', 'michael.cashier@example.com', 'mikecash', SHA2('chashier123', 256), 1),
    ('Nina Teller', 'nina.teller@example.com', 'ninat', SHA2('tellpass', 256), 1),
    ('Olivia Clerk', 'olivia.clerk@example.com', 'oliviac', SHA2('clerkpass', 256), 2),
    ('Peter Operator', 'peter.operator@example.com', 'petero', SHA2('operator123', 256), 2);

-- Orders
INSERT INTO Orders (OrderID, CustomerID, StaffID, OrderDate) VALUES
    (1, 1, 1, '2024-12-01 12:00:00'),
    (2, 1, 3, '2024-12-02 12:00:00'),
    (3, 1, 2, '2024-12-03 12:00:00'),
    (4, 2, 2, '2024-12-04 12:00:00'),
    (5, 3, 4, '2024-12-05 12:00:00'),
    (6, 3, 4, '2024-12-06 12:00:00'),
    (7, 4, 2, '2024-12-07 12:00:00'),
    (8, 5, 3, '2024-12-08 12:00:00'),
    (9, 6, 1, '2024-12-09 12:00:00'),
    (10, 6, 3, '2024-12-10 12:00:00'),
    (11, 7, 4, '2024-12-11 12:00:00'),
    (12, 8, 2, '2024-12-12 12:00:00'),
    (13, 9, 1, '2024-12-13 12:00:00'),
    (14, 10, 3, '2024-12-14 12:00:00'),
    (15, 10, 4, '2024-12-15 12:00:00');

-- Sales
INSERT INTO Sales (OrderID, ProductID, StaffID, QuantitySold, SellingPrice, ActualPayment, Profit) VALUES
    (1, 1, 1, 10, 1.50, CEIL(15.00 * 0.9 * 100) / 100, 5.00),  -- VIP1
    (1, 2, 1, 20, 0.80, CEIL(16.00 * 0.9 * 100) / 100, 8.00),  -- VIP1
    (1, 3, 1, 5, 3.00, CEIL(15.00 * 0.9 * 100) / 100, 5.00),   -- VIP1
    (1, 4, 1, 8, 1.80, CEIL(14.40 * 0.9 * 100) / 100, 6.00),   -- VIP1
    (1, 5, 1, 30, 0.20, CEIL(6.00 * 0.9 * 100) / 100, 3.00),   -- VIP1
    (2, 1, 3, 10, 1.50, CEIL(15.00 * 0.9 * 100) / 100, 5.00),  -- VIP1
    (2, 2, 3, 20, 0.80, CEIL(16.00 * 0.9 * 100) / 100, 8.00),  -- VIP1
    (2, 3, 3, 5, 3.00, CEIL(15.00 * 0.9 * 100) / 100, 5.00),   -- VIP1
    (2, 4, 3, 8, 1.80, CEIL(14.40 * 0.9 * 100) / 100, 6.00),   -- VIP1
    (2, 6, 3, 15, 0.50, CEIL(7.50 * 0.9 * 100) / 100, 3.75),   -- VIP1
    (2, 7, 3, 2, 8.00, CEIL(16.00 * 0.9 * 100) / 100, 8.00),   -- VIP1
    (3, 6, 2, 15, 0.50, CEIL(7.50 * 0.9 * 100) / 100, 3.75),   -- VIP1
    (3, 7, 2, 2, 8.00, CEIL(16.00 * 0.9 * 100) / 100, 8.00),   -- VIP1
    (3, 8, 2, 6, 1.00, CEIL(6.00 * 0.9 * 100) / 100, 3.00),    -- VIP1
    (3, 9, 2, 12, 1.50, CEIL(18.00 * 0.9 * 100) / 100, 9.00),  -- VIP1
    (3, 10, 2, 4, 0.50, CEIL(2.00 * 0.9 * 100) / 100, 2.00),   -- VIP1
    (4, 11, 2, 8, 1.20, CEIL(9.60 * 0.85 * 100) / 100, 4.00),  -- VIP2
    (4, 12, 2, 4, 3.00, CEIL(12.00 * 0.85 * 100) / 100, 6.00), -- VIP2
    (4, 13, 2, 6, 2.00, CEIL(12.00 * 0.85 * 100) / 100, 6.00), -- VIP2
    (5, 14, 4, 10, 1.80, CEIL(18.00 * 0.8 * 100) / 100, 9.00), -- VIP3
    (5, 15, 4, 5, 2.50, CEIL(12.50 * 0.8 * 100) / 100, 6.25),  -- VIP3
    (5, 16, 4, 3, 3.50, CEIL(10.50 * 0.8 * 100) / 100, 5.25),  -- VIP3
    (6, 17, 4, 6, 4.00, CEIL(24.00 * 0.8 * 100) / 100, 12.00), -- VIP3
    (6, 18, 4, 3, 1.00, CEIL(3.00 * 0.8 * 100) / 100, 1.50),   -- VIP3
    (6, 19, 4, 5, 1.20, CEIL(6.00 * 0.8 * 100) / 100, 3.00),   -- VIP3
    (7, 20, 2, 8, 2.00, CEIL(16.00 * 0.75 * 100) / 100, 8.00), -- VIP4
    (7, 21, 2, 4, 0.60, CEIL(2.40 * 0.75 * 100) / 100, 1.20),  -- VIP4
    (7, 22, 2, 6, 0.80, CEIL(4.80 * 0.75 * 100) / 100, 2.40),  -- VIP4
    (8, 23, 3, 10, 1.00, CEIL(10.00 * 0.7 * 100) / 100, 5.00),-- VIP5
    (8, 24, 3, 5, 0.60, CEIL(3.00 * 0.7 * 100) / 100, 1.50),  -- VIP5
    (8, 25, 3, 8, 0.80, CEIL(6.40 * 0.7 * 100) / 100, 3.20),  -- VIP5
    (9, 26, 1, 6, 10.00, CEIL(60.00 * 0.75 * 100) / 100, 30.00),-- VIP4
    (9, 27, 1, 3, 8.00, CEIL(24.00 * 0.75 * 100) / 100, 12.00), -- VIP4
    (9, 28, 1, 5, 12.00, CEIL(60.00 * 0.75 * 100) / 100, 30.00),-- VIP4
    (10, 29, 3, 8, 15.00, CEIL(120.00 * 0.75 * 100) / 100, 60.00),-- VIP4
    (10, 30, 3, 4, 18.00, CEIL(72.00 * 0.75 * 100) / 100, 36.00),-- VIP4
    (10, 31, 3, 6, 10.00, CEIL(60.00 * 0.75 * 100) / 100, 30.00),-- VIP4
    (11, 32, 4, 10, 20.00, CEIL(200.00 * 0.8 * 100) / 100, 100.00),-- VIP3
    (11, 33, 4, 5, 15.00, CEIL(75.00 * 0.8 * 100) / 100, 37.50),-- VIP3
    (11, 34, 4, 8, 18.00, CEIL(144.00 * 0.8 * 100) / 100, 72.00),-- VIP3
    (12, 35, 2, 6, 10.00, CEIL(60.00 * 0.8 * 100) / 100, 30.00),-- VIP3
    (12, 36, 2, 3, 12.00, CEIL(36.00 * 0.8 * 100) / 100, 18.00),-- VIP3
    (12, 37, 2, 5, 10.00, CEIL(50.00 * 0.8 * 100) / 100, 25.00),-- VIP3
    (13, 38, 1, 8, 8.00, CEIL(64.00 * 0.85 * 100) / 100, 32.00),-- VIP2
    (13, 39, 1, 4, 10.00, CEIL(40.00 * 0.85 * 100) / 100, 20.00),-- VIP2
    (13, 40, 1, 6, 12.00, CEIL(72.00 * 0.85 * 100) / 100, 36.00),-- VIP2
    (14, 41, 3, 10, 15.00, CEIL(150.00 * 0.9 * 100) / 100, 75.00),-- VIP1
    (14, 42, 3, 5, 18.00, CEIL(90.00 * 0.9 * 100) / 100, 45.00),-- VIP1
    (14, 43, 3, 8, 10.00, CEIL(80.00 * 0.9 * 100) / 100, 40.00),-- VIP1
    (15, 44, 4, 6, 20.00, CEIL(120.00 * 0.9 * 100) / 100, 60.00),-- VIP1
    (15, 45, 4, 3, 15.00, CEIL(45.00 * 0.9 * 100) / 100, 22.50),-- VIP1
    (15, 46, 4, 5, 18.00, CEIL(90.00 * 0.9 * 100) / 100, 45.00);-- VIP1

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
commit;