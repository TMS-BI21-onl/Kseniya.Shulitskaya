--3. All values in ORDER BY clause column should be unique  

--4.a
USE [AdventureWorks2017]
SELECT*
FROM [Production].[UnitMeasure]
WHERE UnitMeasureCode LIKE'T%'
 -- no UnitMeasureCode begin with T

SELECT COUNT(UnitMeasureCode)
FROM [Production].[UnitMeasure]
-- = 38

INSERT INTO [Production].[UnitMeasure] (UnitMeasureCode, Name, ModifiedDate)
VALUES ('TT1', 'Test 1', '2020-09-09'), ('TT2', 'Test 2', GETDATE())

SELECT*
FROM [Production].[UnitMeasure]
WHERE UnitMeasureCode LIKE'T%'

--4.b
CREATE TABLE [Production].[UnitMeasureTest] (UnitMeasureCode, Name, ModifiedDate)
VALUES ('TT1', 'Test 1', '2020-09-09'), ('TT2', 'Test 2', GETDATE())

SELECT *
INTO [Production].[UnitMeasureTest] 
FROM [Production].[UnitMeasure]
WHERE UnitMeasureCode LIKE'T%'

INSERT INTO [Production].[UnitMeasureTest] 
SELECT  UnitMeasureCode, Name, ModifiedDate
FROM [Production].[UnitMeasure]
WHERE UnitMeasureCode='CAN'

SELECT*
FROM [Production].[UnitMeasureTest]
ORDER BY UnitMeasureCode

--4.c
UPDATE [Production].[UnitMeasureTest]
SET UnitMeasureCode='TTT'

--4.d
DELETE FROM [Production].[UnitMeasureTest]

--4.e
SELECT*
FROM [Sales].[SalesOrderDetail]
WHERE SalesOrderID IN ('43659', '43664')

SELECT DISTINCT SalesOrderID,
MAX(LineTotal) OVER (PARTITION BY SalesOrderID) as Max,
MIN (LineTotal) OVER (PARTITION BY SalesOrderID) as Min,
AVG (LineTotal) OVER (PARTITION BY SalesOrderID) as Avg
FROM [Sales].[SalesOrderDetail]
WHERE SalesOrderID IN ('43659', '43664')

--4.f
 --Linda Mitchell №1 SalesYTD, Ranjit Varkey Chudukatil №1 SalesLastYear
SELECT 
RANK () OVER (ORDER BY SalesYTD DESC) AS Sales_Rank,
FirstName, LastName, SalesYTD, 
CONCAT(UPPER(LEFT(LastName,3)),'login', ISNULL (TerritoryGroup,'')) AS Login
FROM [Sales].[vSalesPerson]

--4.g :(

--5.
 COUNT(1)= 4
 COUNT (name)= 2
 COUNT (id) = 4
 COUNT (*) = 4