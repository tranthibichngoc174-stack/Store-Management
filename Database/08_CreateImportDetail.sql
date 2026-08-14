USE QLStoreManagement

CREATE TABLE ImportDetail
(
    ImportDetailId INT IDENTITY(1,1) PRIMARY KEY,
    ImportId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    ImportPrice DECIMAL(18,2) NOT NULL,

    CONSTRAINT FK_ImportDetail_Import
        FOREIGN KEY (ImportId)
        REFERENCES ImportReceipt(ImportId),

    CONSTRAINT FK_ImportDetail_Product
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId)
)

INSERT INTO ImportDetail
(
    ImportId,
    ProductId,
    Quantity,
    ImportPrice
)
VALUES
(1,1,5,12000000),
(1,4,20,350000)

SELECT
    ir.ImportCode,
    s.SupplierName,
    p.ProductName,
    id.Quantity,
    id.ImportPrice
FROM ImportDetail id
INNER JOIN ImportReceipt ir
    ON id.ImportId = ir.ImportId
INNER JOIN Product p
    ON id.ProductId = p.ProductId
INNER JOIN Supplier s
    ON ir.SupplierId = s.SupplierId