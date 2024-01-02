USE AdventureWorks2017

--2. a)
SELECT Name,
	CASE WHEN StandardCost =0 OR StandardCost IS NULL THEN 'Not for sale'
	     WHEN StandardCost <100 THEN '<$100'
		 WHEN StandardCost <500 THEN '<$500'
	ELSE '>=500'
	END as PriceRange
FROM Production.Product

--2. b)

SELECT ProductID, [Purchasing].[ProductVendor].BusinessEntityID, Name 
FROM [Purchasing].[ProductVendor] LEFT JOIN [Purchasing].[Vendor] 
	ON [Purchasing].[ProductVendor].BusinessEntityID=[Purchasing].[Vendor].BusinessEntityID 
WHERE Purchasing.ProductVendor.StandardPrice>10
AND [Purchasing].[Vendor].Name like '%X%' or [Purchasing].[Vendor].Name like 'N%'

--2. c)
SELECT [Purchasing].[Vendor].Name
FROM [Purchasing].[ProductVendor] 
JOIN [Purchasing].[Vendor] 
	ON [Purchasing].[ProductVendor].BusinessEntityID=[Purchasing].[Vendor].BusinessEntityID 
LEFT JOIN [Sales].[SalesOrderDetail]
	ON [Sales].[SalesOrderDetail].ProductID=[Purchasing].[ProductVendor].ProductID
	WHERE [Sales].[SalesOrderDetail].ProductID IS NULL

--3. a)
SELECT [Production].[Product].Name, [Production].[Product].StandardCost, [Production].[ProductModel].Name
FROM [Production].[Product] JOIN [Production].[ProductModel]
ON [Production].[Product].ProductModelID=[Production].[ProductModel].ProductModelID
WHERE [Production].[ProductModel].Name LIKE 'LL%'

--3. b)
SELECT DISTINCT [Purchasing].[Vendor].Name, [Sales].[Store].Name
FROM [Purchasing].[ProductVendor] 
JOIN [Purchasing].[Vendor] 
	ON [Purchasing].[ProductVendor].BusinessEntityID=[Purchasing].[Vendor].BusinessEntityID 
JOIN [Sales].[SalesOrderDetail]
	ON [Purchasing].[ProductVendor].ProductID=[Sales].[SalesOrderDetail].ProductID
JOIN [Sales].[SalesOrderHeader]
	ON [Sales].[SalesOrderDetail].SalesOrderID=[Sales].[SalesOrderHeader].SalesOrderID
JOIN [Sales].[Store] 
	ON [Sales].[SalesOrderHeader].SalesPersonID=[Sales].[Store].SalesPersonID
ORDER BY [Purchasing].[Vendor].Name, [Sales].[Store].Name

--3. c)
SELECT [Production].[Product].Name
FROM [Production].[Product] 
JOIN [Sales].[SpecialOfferProduct]
	ON [Sales].[SpecialOfferProduct].ProductID=[Production].[Product].ProductID
JOIN [Sales].[SpecialOffer]
	ON [Sales].[SpecialOffer].SpecialOfferID=[Sales].[SpecialOfferProduct].SpecialOfferID
GROUP BY [Production].[Product].Name
HAVING COUNT ([Sales].[SpecialOffer].SpecialOfferID)>1