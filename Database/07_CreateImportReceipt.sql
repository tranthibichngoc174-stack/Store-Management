USE QLStoreManagement

CREATE TABLE ImportReceipt
(
    ImportId INT IDENTITY(1,1) PRIMARY KEY,
    ImportCode VARCHAR(20) NOT NULL UNIQUE,
    SupplierId INT NOT NULL,
    WarehouseId INT NOT NULL,
    ImportDate DATETIME NOT NULL DEFAULT GETDATE(),
    Note NVARCHAR(255),

    CONSTRAINT FK_Import_Supplier
        FOREIGN KEY (SupplierId)
        REFERENCES Supplier(SupplierId),

    CONSTRAINT FK_Import_Warehouse
        FOREIGN KEY (WarehouseId)
        REFERENCES Warehouse(WarehouseId)
)

INSERT INTO ImportReceipt
(
    ImportCode,
    SupplierId,
    WarehouseId,
    Note
)
VALUES
(
    'PN001',
    1,
    1,
    N'Nhập hàng đầu tiên'
)
