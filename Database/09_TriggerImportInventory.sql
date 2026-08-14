USE QLStoreManagement

CREATE TRIGGER TR_ImportDetail_UpdateInventory
ON ImportDetail
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật tồn kho nếu sản phẩm đã có trong kho
    UPDATE i
    SET i.Quantity = i.Quantity + x.TotalQuantity
    FROM Inventory i
    INNER JOIN
    (
        SELECT
            d.ProductId,
            r.WarehouseId,
            SUM(d.Quantity) AS TotalQuantity
        FROM inserted d
        INNER JOIN ImportReceipt r
            ON d.ImportId = r.ImportId
        GROUP BY
            d.ProductId,
            r.WarehouseId
    ) x
        ON i.ProductId = x.ProductId
        AND i.WarehouseId = x.WarehouseId;

    -- Nếu sản phẩm chưa có trong kho thì tạo mới
    INSERT INTO Inventory
    (
        ProductId,
        WarehouseId,
        Quantity
    )
    SELECT
        x.ProductId,
        x.WarehouseId,
        x.TotalQuantity
    FROM
    (
        SELECT
            d.ProductId,
            r.WarehouseId,
            SUM(d.Quantity) AS TotalQuantity
        FROM inserted d
        INNER JOIN ImportReceipt r
            ON d.ImportId = r.ImportId
        GROUP BY
            d.ProductId,
            r.WarehouseId
    ) x
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Inventory i
        WHERE i.ProductId = x.ProductId
          AND i.WarehouseId = x.WarehouseId
    )
END
GO

DECLARE @ImportId INT;

INSERT INTO ImportReceipt
(
    ImportCode,
    SupplierId,
    WarehouseId,
    Note
)
VALUES
(
    'PN003',
    1,
    1,
    N'Nhập thêm Laptop ASUS lần 2'
);

SET @ImportId = SCOPE_IDENTITY();

INSERT INTO ImportDetail
(
    ImportId,
    ProductId,
    Quantity,
    ImportPrice
)
VALUES
(
    @ImportId,
    1,
    5,
    12000000
)

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