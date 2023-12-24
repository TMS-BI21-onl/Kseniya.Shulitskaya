--1. a)
USE AdventureWorks2017
SElECT *
FROM [Sales].[SalesTerritory]

--1. b)
SElECT TerritoryID, Name
FROM [Sales].[SalesTerritory]

--1. c)
SElECT*
FROM [Person].[Person]
WHERE LastName='Norman'

--1. d)
SElECT*
FROM [Person].[Person]
WHERE EmailPromotion!=2

--3. VAR, STDEV, CHECKSUM_AGG

--4. a)
SELECT COUNT(DISTINCT PersonType)
FROM [Person].[Person]
WHERE LastName LIKE 'M%'
AND EmailPromotion!=1
--4. b)
SELECT TOP 3*
FROM [Sales].[SpecialOffer]
WHERE StartDate BETWEEN '2013-01-01' AND '2014-01-01'
ORDER BY DiscountPct DESC

--4. c)
SELECT MIN(Weight)
FROM [Production].[Product]

SELECT MAX(Size)
FROM [Production].[Product]

--4. d)
SELECT ProductSubcategoryID, MIN(Weight) MinWeight, MAX(Size) MaxSize
FROM [Production].[Product]
GROUP BY ProductSubcategoryID

--4. e)
SELECT ProductSubcategoryID, MIN(Weight) MinWeight, MAX(Size) MaxSize, Color
FROM [Production].[Product]
WHERE Color IS NOT NULL
GROUP BY ProductSubcategoryID, Color