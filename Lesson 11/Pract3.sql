--Поликлиника (№2)
--1.Найти самое популярное назначаемое лекарство для каждого диагноза.
SELECT Диагноз, Лекарство 
FROM 
	(SELECT Диагноз, Лекарство, RANK() OVER (PARTITION BY Диагноз ORDER BY freq DESC ) AS rnk
	FROM
		(SELECT Диагноз, Лекарство, ЛекарствоId, COUNT(НазначениеId) OVER (PARTITION BY ЛекарствоId, Диагноз) AS freq
		FROM Назначения JOIN Лекарства ON Назначения.ЛекарствоId=Лекарства.ЛекарствоId)
	)
	GROUP BY
WHERE rnk=1


--2.Вывести количество пациентов по возрасту (18-30 лет, 31-39 лет, 40-59 лет, 60 и старше), 
--обратившихся в поликлинику с диагнозом "ОРИ" за январь месяц 2023 года, а также за январь месяц 2024 года. 
--Результаты вывести в виде транспонированной таблицы. (Оси - группы пациентов и годы обращений)

SELECT ВозрастнаяГруппа, [2023], [2024]
FROM 
(SELECT DATEPART(year, Дата_приема) as Год, ПациентId, 
		[ВозрастнаяГруппа]=
			CASE 
			WHEN DATEDIFF(year, Дата_рождения, GETDATE()) BETWEEN 18 AND 30 THEN '18-30 лет'
			WHEN DATEDIFF(year, Дата_рождения, GETDATE()) BETWEEN 31 AND 39 THEN '31-39 лет'
			WHEN DATEDIFF(year, Дата_рождения, GETDATE()) BETWEEN 49 AND 59 THEN '40-59 лет'
			WHEN DATEDIFF(year, [BirthDate], GETDATE()) >= 60 THEN '60 и старше'
			END 
		FROM Приемы JOIN Пациенты ON Приемы.ПациентId=Пациенты.ПациентId
					JOIN Назначения ON Приемы.ПриемId
		WHERE DATEPART(month, Дата_приема)=1 AND DATEPART(year, Дата_приема) IN (2023,2024) AND Диагноз = 'ОРИ')
AS SourceTable  
PIVOT
( 
	COUNT(ПациентId) 
	FOR Год IN ([2023], [2024])
) AS PivotTable
