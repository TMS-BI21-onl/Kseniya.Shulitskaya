
--1)
SELECT FirstName,LastName,PhoneNumber
FROM [Person].[Person]
LEFT JOIN [Person].[PersonPhone] ON [Person].[Person].[BusinessEntityID]=[Person].[PersonPhone].[BusinessEntityID]
WHERE [PhoneNumber] LIKE '4_5%'

--2)
SELECT [BusinessEntityID], [NationalIDNumber],
	CASE WHEN DATEDIFF(year, [BirthDate], GETDATE()) BETWEEN 17 AND 20 THEN 'Adolescence'
	     WHEN DATEDIFF(year, [BirthDate], GETDATE()) BETWEEN 21 AND 59 THEN 'Adults'
		 WHEN DATEDIFF(year, [BirthDate], GETDATE()) BETWEEN 60 AND 75 THEN 'Elderly'
		 WHEN DATEDIFF(year, [BirthDate], GETDATE()) BETWEEN 60 AND 75 THEN 'Senile'
	ELSE 'Unknown'
	END as AgeGroup
FROM [HumanResources].[Employee]

--3) 
SELECT DISTINCT*
FROM 
	(SELECT [Color], [StandardCost], RANK() OVER (PARTITION BY [Color] ORDER BY [StandardCost] DESC ) as rnk
FROM [Production].[Product]) T
WHERE rnk=1

SELECT DISTINCT *
FROM 
	(SELECT [Color], [StandardCost], MAX([StandardCost]) OVER (PARTITION BY [Color]) AS max_cost 
FROM [Production].[Product]) T
WHERE [StandardCost]=max_cost


--4)
1. Рейсы расписание
2. Прибытие и отбытие факт
3. Пассажиры
4. Поезда
5. Билеты
6. Машинисты
7. Платформы

