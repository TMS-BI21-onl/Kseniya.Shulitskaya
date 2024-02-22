
--1. Найти ProductSubcategoryID из Production.Product, где мин вес такого ProductSubcategoryID больше 150. 
USE [AdventureWorks2017]

SELECT ProductSubcategoryID, MIN (Weight) as min_weight
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING MIN (Weight) >150 AND ProductSubcategoryID IS NOT NULL

--2. Найти самый дорогой продукт (поле StandardCost) из Production.Product. (4 способа)
--2.1
SELECT Name
from Production.Product
WHERE StandardCost=(SELECT MAX(StandardCost) FROM Production.Product)

--2.2
SELECT top 1 with ties Name
FROM Production.Product
ORDER BY StandardCost DESC

--2.3
SELECT Name
FROM 
(
	SELECT Name, RANK() over (ORDER BY StandardCost DESC) as rnk
	FROM Production.Product
) t
WHERE rnk=1

--2.4
SELECT * 
FROM
(
	SELECT Name, StandardCost, MAX(StandardCost) OVER () as max_cost
	FROM Production.Product
) t
WHERE StandardCost=max_cost

--3. Найти клиентов, которые за последний год не совершили ни одного заказа (схема GROUP2)
SELECT FirstName, LastName, MAX(CONVERT(date, OrderDate)) as last_order
FROM Client c LEFT JOIN Orders o ON c.ClientID=o.ClientID
GROUP BY FirstName, LastName
HAVING DATEDIFF(day, MAX(CONVERT(date, OrderDate)), GETDATE())>=365 OR MAX(CONVERT(date, OrderDate))  IS NULL

--4. Найти для каждого поставщика кол-во заказов за последние 5 лет.  (схема GROUP2)

SELECT Name, COUNT(OrderID) as count_o
FROM Vendor v JOIN Orders o ON o.VendorID=v.VendorID
WHERE Orderdate >  DATEADD(year, -5, GETDATE())
GROUP BY Name

--5. Найти список категорий для пользователя alex@gmail.com, в которых более 50 непрочитанных нотификаций

SELECT n.category, COUNT (n.id) as count_n
FROM 
	(SELECT n.category, n.id
	FROM Users u JOIN Notifications n ON u.id=n.user_id
	WHERE u.email = 'alex@gmail.com' AND n.is_read = 0)	
GROUP BY n.category
HAVING COUNT (n.id) > 50 

