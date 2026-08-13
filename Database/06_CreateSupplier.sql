USE QLStoreManagement

CREATE TABLE Supplier
(
    SupplierId INT IDENTITY(1,1) PRIMARY KEY,
    SupplierCode VARCHAR(20) NOT NULL UNIQUE,
    SupplierName NVARCHAR(150) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address NVARCHAR(255),
    IsActive BIT NOT NULL DEFAULT 1
)

INSERT INTO Supplier
(
    SupplierCode,
    SupplierName,
    Phone,
    Email,
    Address
)
VALUES
('SUP001', N'Công ty ASUS Việt Nam', '0901111111', 'asus@gmail.com', N'Hà Nội'),
('SUP002', N'Apple Distributor', '0902222222', 'apple@gmail.com', N'TP.HCM'),
('SUP003', N'Logitech Việt Nam', '0903333333', 'logi@gmail.com', N'Đà Nẵng')

SELECT * FROM Supplier