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
INSERT INTO Customer (CustomerName, ContactInfo, Username, Password, IsVIP, PurchaseSum) VALUES
    ('Alice Johnson', 'alice@example.com', 'alicej', SHA2('alicepass', 256), TRUE, 31341),
    ('Bob Smith', 'bob@example.com', 'bobsmith', SHA2('bobpass', 256), TRUE, 321),
    ('Catherine Lee', 'catherine@example.com', 'cathylee', SHA2('cathypass', 256), TRUE, 4636.9),
    ('David Brown', 'david@example.com', 'daveb', SHA2('davepass', 256), FALSE, 132),
    ('Evelyn Clark', 'evelyn@example.com', 'eveclark', SHA2('evepass', 256), FALSE, 1.9),
    ('Frank White', 'frank@example.com', 'frankw', SHA2('frankpass', 256), FALSE, 1333.56),
    ('Grace Adams', 'grace@example.com', NULL, NULL, FALSE, 2341),
    ('Henry Green', 'henry@example.com', 'henryg', SHA2('henrypass', 256), FALSE, 341),
    ('Isabella King', 'isabella@example.com', 'isabellak', SHA2('isapass', 256), FALSE, 4235),
    ('Jack Wilson', 'jack@example.com', NULL, NULL, FALSE, 1241);

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
INSERT INTO Orders (OrderID, CustomerID, StaffID, TotalAmount, ActualPayment) VALUES
    (1, 1, 1, 15.00, 15.00),
    (2, 2, 1, 16.00, 16.00),
    (3, 3, 2, 15.00, 15.00),
    (4, 4, 2, 14.40, 14.40),
    (5, 5, 1, 6.00, 6.00),
    (6, 6, 1, 7.50, 7.50),
    (7, 7, 2, 160.00, 160.00),
    (8, 8, 2, 6.00, 6.00),
    (9, 9, 1, 7.20, 7.20),
    (10, 10, 1, 2.00, 2.00);

-- Sales
INSERT INTO Sales (OrderID,ProductID, StaffID, QuantitySold, SellingPrice, Profit) VALUES
    (1, 1, 1, 10, 1.50, 5.00),
    (1, 2, 1, 20, 0.80, 8.00),
    (2, 3, 1, 5, 3.00, 5.00),
    (2, 4, 1, 8, 1.80, 5.60),
    (3, 5, 2, 30, 0.20, 3.00),
    (3, 6, 2, 15, 0.50, 3.75),
    (4, 7, 2, 2, 8.00, 6.00),
    (4, 8, 2, 6, 1.00, 3.60),
    (5, 9, 1, 12, 0.50, 3.00),
    (6, 10, 1, 4, 2.50, 2.00),
    (7, 1, 2, 10, 1.50, 5.00),
    (8, 2, 2, 20, 0.80, 8.00),
    (9, 3, 1, 5, 3.00, 5.00),
    (10, 4, 1, 8, 1.80, 5.60);

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