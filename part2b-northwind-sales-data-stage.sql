USE ist722_jharri27_stage
GO

-- stage customers
SELECT [CustomerID]
		,[CompanyName]
		,[ContactName]
		,[ContactTitle]
		,[Address]
		,[City]
		,[Region]
		,[PostalCode]
		,[Country]
INTO [dbo].[stgNorthwindCustomers]
FROM [Northwind].[dbo].[Customers]

-- stage employees
SELECT [EmployeeID]
		,[FirstName]
		,[LastName]
		,[Title]
INTO [dbo].[stgNorthwindEmployees]
FROM [Northwind].[dbo].[Employees]

-- stage products
SELECT [ProductID]
		,[ProductName]
		,[Discontinued]
		,[CompanyName]
		,[CategoryName]
INTO [dbo].[stgNorthwindProducts]
FROM [Northwind].[dbo].[Products] p
	join [Northwind].[dbo].Suppliers s
		on p.[SupplierID]= s.[SupplierID]
	join [Northwind].[dbo].Categories c
		on c.[CategoryID] = p.[CategoryID]

-- stage date
SELECT *
INTO [dbo].[stgNorthwindDates]
FROM [ExternalSources2].[dbo].[date_dimension]
WHERE Year between 1996 and 1998

-- stage fact
SELECT [ProductID]
		,d.[OrderID]
		,[CustomerID]
		,[EmployeeID]
		,[OrderDate]
		,[ShippedDate]
		,[UnitPrice]
		,[Quantity]
		,[Discount]
INTO [dbo].[stgNorthwindSales]
FROM [Northwind].[dbo].[Order Details] d
	join [Northwind].[dbo].[Orders] o
		on o.[OrderID] = d.[OrderID]
