USE ist722_jharri27_dw
GO

-- Load DimCategories
INSERT INTO northwind.DimCategories
		(CategoryID, CategoryName)
SELECT CategoryID, CategoryName
		FROM ist722_jharri27_stage.dbo.stgNorthwindCategories


-- Load DimOrders
INSERT INTO northwind.DimOrders
		(OrderID, OrderDate, RequiredDate, ShippedDate)
SELECT OrderID, OrderDate, RequiredDate, ShippedDate
		FROM ist722_jharri27_stage.dbo.stgNorthwindOrders


-- Load FactOrderFulfillment
INSERT INTO northwind.FactOrderFulfillment
		(CategoryKey, OrderKey, OrderDateKey, RequiredDateKey, ShippedDateKey, CategoryName)
SELECT c.CategoryKey, o.OrderKey,
		ExternalSources2.dbo.getDateKey (s.OrderDate) AS OrderDateKey,
		CASE WHEN ExternalSources2.dbo.getDateKey (s.ShippedDate) IS NULL THEN -1
			ELSE ExternalSources2.dbo.getDateKey (s.ShippedDate) END AS ShippedDateKey,
		CASE WHEN ExternalSources2.dbo.getDateKey (s.RequiredDate) IS NULL THEN -1
			ELSE ExternalSources2.dbo.getDateKey (s.RequiredDate) END AS RequiredDateKey,
		s.CategoryName
FROM ist722_jharri27_stage.dbo.stgNorthwindOrderFulfillment s
		JOIN ist722_jharri27_dw.northwind.DimCategories c
			ON s.CategoryID = c.CategoryID
		JOIN ist722_jharri27_dw.northwind.DimOrders o
			ON s.OrderID = o.OrderID


CREATE VIEW northwind.OrderFulfillmentMart
AS
SELECT c.CategoryID, c.CategoryName
		, o.OrderID
		, f.OrderDateKey, f.RequiredDateKey, f.ShippedDateKey

FROM northwind.FactOrderFulfillment f
	JOIN northwind.DimCategories c ON c.CategoryKey = f.CategoryKey
	JOIN northwind.DimOrders o ON o.OrderKey = f.OrderKey
	JOIN northwind.DimDate od ON od.DateKey = f.OrderDateKey

DROP VIEW northwind.OrderFulfillmentMart
SELECT * FROM northwind.OrderFulfillmentMart