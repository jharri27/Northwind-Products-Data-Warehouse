USE ist722_jharri27_stage
GO

-- Stage Categories
SELECT CategoryID, CategoryName, [Description], Picture
INTO dbo.stgNorthwindCategories
FROM Northwind.dbo.Categories

-- Stage Orders
SELECT OrderID, OrderDate, RequiredDate, ShippedDate
INTO dbo.stgNorthwindOrders
FROM Northwind.dbo.Orders

-- Stage Order Fulfillment
SELECT CategoryID, OrderID, OrderDate, ShippedDate, RequiredDate, CategoryName
INTO dbo.stgNorthwindOrderFulfillment
FROM Northwind.dbo.Orders, Northwind.dbo.Categories

