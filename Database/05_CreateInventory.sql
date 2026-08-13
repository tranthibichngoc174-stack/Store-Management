USE QLStoreManagement

CREATE TABLE Inventory
(
    InventoryId INT IDENTITY(1,1) PRIMARY KEY,
    ProductId INT NOT NULL,
    WarehouseId INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,

    CONSTRAINT FK_Inventory_Product
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),

    CONSTRAINT FK_Inventory_Warehouse
        FOREIGN KEY (WarehouseId)
        REFERENCES Warehouse(WarehouseId),

    CONSTRAINT UQ_Inventory_Product_Warehouse
        UNIQUE (ProductId, WarehouseId),

    CONSTRAINT CK_Inventory_Quantity
        CHECK (Quantity >= 0)
)

INSERT INTO Inventory
(
    ProductId,
    WarehouseId,
    Quantity
)
VALUES
(1, 1, 10),
(1, 2, 5),
(2, 1, 8),
(2, 2, 3),
(3, 1, 15),
(3, 2, 5),
(4, 1, 30),
(5, 1, 20),
(5, 2, 5),
(6, 1, 12)

SELECT
    p.ProductCode,
    p.ProductName,
    w.WarehouseCode,
    w.WarehouseName,
    i.Quantity
FROM Inventory i
INNER JOIN Product p
    ON i.ProductId = p.ProductId
INNER JOIN Warehouse w
    ON i.WarehouseId = w.WarehouseId
ORDER BY p.ProductCode

SELECT
    p.ProductCode,
    p.ProductName,
    SUM(i.Quantity) AS TotalQuantity
FROM Inventory i
INNER JOIN Product p
    ON i.ProductId = p.ProductId
GROUP BY
    p.ProductCode,
    p.ProductName
ORDER BY p.ProductCode