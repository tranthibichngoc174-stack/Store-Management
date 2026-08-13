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

