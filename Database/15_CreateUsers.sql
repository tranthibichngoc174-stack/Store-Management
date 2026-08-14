USE QLStoreManagement

CREATE TABLE Users 
( 
	UserId INT IDENTITY(1,1) PRIMARY KEY, 
	Username VARCHAR(50) NOT NULL UNIQUE, 
	Password VARCHAR(255) NOT NULL, 
	FullName NVARCHAR(100) NOT NULL, 
	Role VARCHAR(20) NOT NULL, 
	IsActive BIT NOT NULL DEFAULT 1 
)

IF NOT EXISTS
(
    SELECT 1
    FROM Users
    WHERE Username = 'admin'
)
BEGIN
    INSERT INTO Users
    (
        Username,
        Password,
        FullName,
        Role
    )
    VALUES
    (
        'admin',
        '123456',
        N'Quản trị viên',
        'Admin'
    )
END
GO

IF NOT EXISTS
(
    SELECT 1
    FROM Users
    WHERE Username = 'nhanvien'
)
BEGIN
    INSERT INTO Users
    (
        Username,
        Password,
        FullName,
        Role
    )
    VALUES
    (
        'nhanvien',
        '123456',
        N'Nhân viên bán hàng',
        'Staff'
    )
END

SELECT
    UserId,
    Username,
    FullName,
    Role,
    IsActive
FROM Users 

SELECT
    UserId,
    Username,
    FullName,
    Role,
    IsActive
FROM Users
ORDER BY UserId

SELECT
    UserId,
    Username,
    FullName,
    Role
FROM Users
WHERE Username = 'admin'
  AND Password = '123456'
  AND IsActive = 1

SELECT
    UserId,
    Username,
    FullName,
    Role
FROM Users
WHERE Username = 'admin'
  AND Password = '999999'
  AND IsActive = 1