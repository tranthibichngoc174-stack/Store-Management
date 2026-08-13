USE QLStoreManagement

CREATE TABLE Warehouse
(
    WarehouseId INT IDENTITY(1,1) PRIMARY KEY,
    WarehouseCode VARCHAR(20) NOT NULL UNIQUE,
    WarehouseName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255),
    IsActive BIT NOT NULL DEFAULT 1
)

INSERT INTO Warehouse
(
    WarehouseCode,
    WarehouseName,
    Address
)
VALUES
('KHO01', N'Kho chính', N'Tầng 1 - Cửa hàng'),
('KHO02', N'Kho phụ', N'Tầng 2 - Cửa hàng')

SELECT * FROM Warehouse