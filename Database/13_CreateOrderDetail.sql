USE QLStoreManagement

CREATE TABLE SalesOrderDetail
(
    OrderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    SalePrice DECIMAL(18,2) NOT NULL,

    CONSTRAINT FK_SalesOrderDetail_Order
        FOREIGN KEY (OrderId)
        REFERENCES SalesOrder(OrderId),

    CONSTRAINT FK_SalesOrderDetail_Product
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),

    CONSTRAINT CK_SalesOrderDetail_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT CK_SalesOrderDetail_SalePrice
        CHECK (SalePrice >= 0)
)