CREATE DATABASE  BranchSalesDB;

USE BranchSalesDB;


CREATE TABLE Position 
(
    JobId int identity primary key,
    Name nvarchar(30)
);

CREATE TABLE Branch 
(
    BranchId int identity primary key,
    Name nvarchar(30)
);

CREATE TABLE Employee 
(
    EmployeeId int identity primary key,
	FullName nvarchar(90) NOT NULL,
    JobId int NOT NULL REFERENCES Position(JobId),
    Salary money,
    BranchId int NOT NULL REFERENCES Branch(BranchId),
);

CREATE TABLE Product 
(
    ProductId int identity primary key,
    Name nvarchar(30),
    PurchasePrice money,
    SalePrice money
);

CREATE TABLE Sales 
(
    ProductId int NOT NULL REFERENCES Product(ProductId),
    EmployeeId int NOT NULL REFERENCES Employee(EmployeeId),
    SaleDate date DEFAULT(GETDATE())
);

-- Insert data into tables
INSERT INTO Position (Name) VALUES
('Manager'),
('Salesperson');

INSERT INTO Branch (Name) VALUES
('Main Branch'),
('Branch 2');

INSERT INTO Employee (FullName, JobId, Salary, BranchId) VALUES
('Jonh Doe',1, 50000, 1),
('Jonh Smith', 2, 30000, 2);

INSERT INTO Product (Name, PurchasePrice, SalePrice) VALUES
('Product A', 50, 100),
('Product B', 30, 60),
('Product C', 50.00, 100.00);

INSERT INTO Sales (ProductId, EmployeeId, SaleDate) VALUES
(1, 1, '2023-11-20'),
(2, 2, '2023-11-21'),
(3, 1, '2023-10-20');

--Task1

SELECT S.ProductId, E.FullName, S.SaleDate, Pr.PurchasePrice, Pr.SalePrice, B.Name AS BranchName, Pr.Name AS ProductName
FROM Sales AS S
JOIN Product AS Pr ON S.ProductId = Pr.ProductId
JOIN Employee AS E ON S.EmployeeId = E.EmployeeId
JOIN Branch AS B ON E.BranchId = B.BranchId
JOIN Position AS P ON E.JobId = P.JobId;

--Task 2

SELECT SUM(Pr.SalePrice) AS TotalSales
FROM Sales AS S
JOIN Product AS Pr on S.ProductId = Pr.ProductId

--Task 3

SELECT SUM(Pr.SalePrice) AS TotalSalesInCurrentMonth
FROM Sales AS S
JOIN Product AS Pr on S.ProductId = Pr.ProductId
WHERE MONTH(SaleDate) = MONTH(GETDATE()) AND YEAR(SaleDate) = YEAR(GETDATE());
