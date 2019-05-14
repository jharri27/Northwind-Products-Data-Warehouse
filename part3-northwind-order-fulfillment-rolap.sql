USE ist722_jharri27_dw
GO

DROP TABLE northwind.DimCategories
DROP TABLE northwind.DimOrders
DROP TABLE northwind.FactOrderFulfillment
GO


CREATE TABLE northwind.DimCategories (
	CategoryKey INT IDENTITY NOT NULL
	, CategoryID INT NOT NULL
	, CategoryName NVARCHAR(15) NOT NULL
	, [Description] NTEXT NULL
	, Picture IMAGE NULL
	, CONSTRAINT [PK_northwind.DimCategories] PRIMARY KEY CLUSTERED (CategoryKey)
) 
	ON [PRIMARY]
;


CREATE TABLE northwind.DimOrders (
	OrderKey INT IDENTITY NOT NULL
	, OrderID INT NOT NULL
	, OrderDate DATETIME
	, RequiredDate DATETIME
	, ShippedDate DATETIME
	, CONSTRAINT [PK_northwind.DimOrders] PRIMARY KEY CLUSTERED (OrderKey)
)
	ON [PRIMARY]
;

CREATE TABLE northwind.FactOrderFulfillment (
	CategoryKey INT NOT NULL
	, OrderKey INT NOT NULL
	, OrderDateKey INT
	, RequiredDateKey INT
	, ShippedDateKey INT
	, CategoryName NVARCHAR(15) NOT NULL
	, CONSTRAINT [PK_northwind.FactOrderFulfillment] PRIMARY KEY NONCLUSTERED
	  (CategoryKey, OrderKey)
)	ON [PRIMARY]
;

ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_CategoryKey FOREIGN KEY
   (
   CategoryKey
   ) REFERENCES northwind.DimCategories
   ( CategoryKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_OrderKey FOREIGN KEY
   (
   OrderKey
   ) REFERENCES northwind.DimOrders
   ( OrderKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES northwind.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES northwind.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_RequiredDateKey FOREIGN KEY
   (
   RequiredDateKey
   ) REFERENCES northwind.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;