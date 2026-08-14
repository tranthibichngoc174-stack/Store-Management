USE QLStoreManagement;
GO

CREATE TRIGGER TR_SalesOrderDetail_UpdateInventory
ON SalesOrderDetail
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra tồn kho trước khi trừ
    IF EXISTS
    (
        SELECT 1
        FROM
        (
            SELECT
                d.ProductId,
                o.WarehouseId,
                SUM(d.Quantity) AS TotalQuantity
            FROM inserted d
            INNER JOIN SalesOrder o
                ON d.OrderId = o.OrderId
            GROUP BY
                d.ProductId,
                o.WarehouseId
        ) x
        LEFT JOIN Inventory i
            ON i.ProductId = x.ProductId
            AND i.WarehouseId = x.WarehouseId
        WHERE i.InventoryId IS NULL
           OR i.Quantity < x.TotalQuantity
    )
    BEGIN
        RAISERROR(
            N'Không đủ tồn kho để thực hiện đơn hàng!',
            16,
            1
        );

        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Trừ tồn kho
    UPDATE i
    SET i.Quantity = i.Quantity - x.TotalQuantity
    FROM Inventory i
    INNER JOIN
    (
        SELECT
            d.ProductId,
            o.WarehouseId,
            SUM(d.Quantity) AS TotalQuantity
        FROM inserted d
        INNER JOIN SalesOrder o
            ON d.OrderId = o.OrderId
        GROUP BY
            d.ProductId,
            o.WarehouseId
    ) x
        ON i.ProductId = x.ProductId
        AND i.WarehouseId = x.WarehouseId;
END;
GO

SELECT
    p.ProductId,
    p.ProductCode,
    p.ProductName,
    w.WarehouseId,
    w.WarehouseCode,
    i.Quantity
FROM Inventory i
INNER JOIN Product p
    ON i.ProductId = p.ProductId
INNER JOIN Warehouse w
    ON i.WarehouseId = w.WarehouseId
ORDER BY p.ProductId



DECLARE @OrderId INT;

INSERT INTO SalesOrder
(
    OrderCode,
    CustomerId,
    WarehouseId,
    Status
)
VALUES
(
    'DH001',
    1,
    1,
    N'Đã tạo'
);

SET @OrderId = SCOPE_IDENTITY();

INSERT INTO SalesOrderDetail
(
    OrderId,
    ProductId,
    Quantity,
    SalePrice
)
VALUES
(
    @OrderId,
    1,
    2,
    15000000
);
GO

SELECT
    p.ProductName,
    w.WarehouseName,
    i.Quantity
FROM Inventory i
INNER JOIN Product p
    ON i.ProductId = p.ProductId
INNER JOIN Warehouse w
    ON i.WarehouseId = w.WarehouseId
WHERE p.ProductId = 1
  AND w.WarehouseId = 1


SELECT
    d.OrderDetailId,
    d.OrderId,
    p.ProductName,
    d.Quantity,
    d.SalePrice,
    d.Quantity * d.SalePrice AS ThanhTien
FROM SalesOrderDetail d
INNER JOIN Product p
    ON d.ProductId = p.ProductId
WHERE d.OrderId = 1

CREATE TRIGGER TR_SalesOrderDetail_UpdateTotalAmount
ON SalesOrderDetail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE o
    SET o.TotalAmount =
    (
        SELECT ISNULL(SUM(d.Quantity * d.SalePrice), 0)
        FROM SalesOrderDetail d
        WHERE d.OrderId = o.OrderId
    )
    FROM SalesOrder o
    WHERE o.OrderId IN
    (
        SELECT OrderId FROM inserted
        UNION
        SELECT OrderId FROM deleted
    );
END;
GO

UPDATE SalesOrder
SET TotalAmount =
(
    SELECT ISNULL(SUM(d.Quantity * d.SalePrice), 0)
    FROM SalesOrderDetail d
    WHERE d.OrderId = SalesOrder.OrderId
)
WHERE OrderId = 1

SELECT
    OrderId,
    OrderCode,
    Status,
    TotalAmount
FROM SalesOrder
WHERE OrderId = 1


INSERT INTO SalesOrderDetail
(
    OrderId,
    ProductId,
    Quantity,
    SalePrice
)
VALUES
(
    1,
    2,
    1,
    5000000
)

SELECT
    OrderId,
    OrderCode,
    TotalAmount
FROM SalesOrder
WHERE OrderId = 1

SELECT
    ProductId,
    ProductCode,
    ProductName
FROM Product