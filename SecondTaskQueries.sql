--Run CREATE and INSERT from the privious task first
--Task 4

SELECT Sales.EmployeeId, COUNT(Sales.ProductId) as SaleCount FROM Sales
GROUP BY Sales.EmployeeId

--Task 5

SELECT TOP 1 SaleCount, Branch.Name as SaleBranch FROM
(
SELECT Sales.EmployeeId, Employee.BranchId as SaleBranch, COUNT(Sales.ProductId) as SaleCount FROM Sales
JOIN Employee ON Employee.EmployeeId = Sales.EmployeeId
WHERE DAY(SaleDate) = DAY(GETDATE())
GROUP BY Sales.EmployeeId, Employee.BranchId
) as SomeTable
JOIN Branch ON Branch.BranchId = SaleBranch


--Task 6
INSERT INTO Sales (ProductId, EmployeeId, SaleDate) VALUES
(1, 1, '2023-11-20')

SELECT TOP 1 SaleCount, ProductName FROM 
(
SELECT COUNT(Sales.ProductId) as SaleCount, Product.Name as ProductName  FROM Sales
JOIN Product ON Product.ProductId = Sales.ProductId
WHERE MONTH(SaleDate) = MONTH(GETDATE())
GROUP BY Product.Name
) as SomeTable
