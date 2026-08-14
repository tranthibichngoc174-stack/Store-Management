USE QLStoreManagement

CREATE TABLE SalesOrder
(
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    OrderCode VARCHAR(20) NOT NULL UNIQUE,
    CustomerId INT NOT NULL,
    WarehouseId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(30) DEFAULT N'Đã tạo',
    TotalAmount DECIMAL(18,2) DEFAULT 0,

    CONSTRAINT FK_SalesOrder_Customer
        FOREIGN KEY (CustomerId)
        REFERENCES Customer(CustomerId),

    CONSTRAINT FK_SalesOrder_Warehouse
        FOREIGN KEY (WarehouseId)
        REFERENCES Warehouse(WarehouseId)
)