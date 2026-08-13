use QLStoreManagement

CREATE TABLE Category
(
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    IsActive BIT NOT NULL DEFAULT 1
)

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Category';

INSERT INTO Category
(
    CategoryName,
    Description
)
VALUES
(N'Laptop', N'Máy tính xách tay'),
(N'Điện thoại', N'Điện thoại thông minh'),
(N'Chuột', N'Chuột máy tính'),
(N'Bàn phím', N'Bàn phím máy tính'),
(N'Tai nghe', N'Tai nghe và phụ kiện âm thanh')

SELECT * FROM Category
