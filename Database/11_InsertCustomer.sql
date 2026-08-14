USE QLStoreManagement

INSERT INTO Customer
(
    CustomerCode,
    CustomerName,
    Phone,
    Email,
    Address
)
VALUES
(
    'KH001',
    N'Nguyễn Văn An',
    '0901234567',
    'an@gmail.com',
    N'Hà Nội'
),
(
    'KH002',
    N'Trần Thị Bình',
    '0912345678',
    'binh@gmail.com',
    N'TP. Hồ Chí Minh'
)

SELECT * FROM Customer