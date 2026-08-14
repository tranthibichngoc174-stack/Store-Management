USE QLStoreManagement

CREATE TABLE Product
(
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    ProductCode VARCHAR(20) NOT NULL UNIQUE,
    ProductName NVARCHAR(150) NOT NULL,
    CategoryId INT NOT NULL,
    ImportPrice DECIMAL(18,2) NOT NULL,
    SalePrice DECIMAL(18,2) NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    Unit NVARCHAR(30) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_Product_Category
        FOREIGN KEY (CategoryId)
        REFERENCES Category(CategoryId),

    CONSTRAINT CK_Product_ImportPrice
        CHECK (ImportPrice >= 0),

    CONSTRAINT CK_Product_SalePrice
        CHECK (SalePrice >= 0),

    CONSTRAINT CK_Product_Quantity
        CHECK (Quantity >= 0)
)

SELECT * FROM Product

SELECT
    p.ProductId,
    p.ProductCode,
    p.ProductName,
    c.CategoryName,
    p.ImportPrice,
    p.SalePrice,
    p.Quantity,
    p.Unit
FROM Product p
INNER JOIN Category c
    ON p.CategoryId = c.CategoryId

INSERT INTO Product
(
    ProductCode,
    ProductName,
    CategoryId,
    ImportPrice,
    SalePrice,
    Quantity,
    Unit
)
VALUES
('LAP001', N'Laptop ASUS Vivobook 15', 1, 12000000, 14500000, 10, N'Cái'),
('LAP002', N'Laptop Lenovo IdeaPad 3', 1, 11000000, 13500000, 8, N'Cái'),
('IP001', N'iPhone 15 128GB', 2, 18000000, 20500000, 15, N'Cái'),
('MOU001', N'Chuột Logitech M331', 3, 350000, 490000, 30, N'Cái'),
('KEY001', N'Bàn phím cơ DareU', 4, 700000, 990000, 20, N'Cái'),
('EAR001', N'Tai nghe Bluetooth Sony', 5, 1200000, 1690000, 12, N'Cái')