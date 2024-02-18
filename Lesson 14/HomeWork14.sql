--1.
--рейтинг пассажиров по количеству полетов в месяц
USE [Airport]
GO
CREATE VIEW v_TopPassengersView
AS
SELECT TOP 50 s.PassengerID, s.FirstName, s.LastName, SUM (s.points) as sum_points
FROM 
	(SELECT p.PassengerID, 
			p.FirstName, 
			p.LastName, 
			CONCAT(YEAR (f.DepartureDateTime),'.',MONTH(f.DepartureDateTime)) AS month_flight,
			CASE WHEN COUNT (t.TicketID) >10 THEN 3 
				 WHEN COUNT (t.TicketID)  BETWEEN 5 AND 10 THEN 2
				 WHEN COUNT (t.TicketID) <5 THEN 1
				 ELSE 0
				 END as points
			FROM dbo.Passengers p JOIN dbo.Tickets t ON p.PassengerID=t.PassengerID 
						JOIN dbo.Flights f ON t.FlightID=f.FlightID -- берем дату полета для группировки
			GROUP BY p.PassengerID, p.FirstName,	p.LastName, CONCAT(YEAR (f.DepartureDateTime),'.',MONTH(f.DepartureDateTime))
			) s
GROUP BY s.PassengerID, s.FirstName, s.LastName
ORDER BY sum_points DESC

SELECT * FROM v_TopPassengersView

--2. 
--a.
 1) убрать фон
 2) сделать все столбцы одинакового цвета
 3) убрать легенду справа
 4) убрать названия горизонтальной (Type of food) и вертикальной (Number of calories) осей (т.к. это понятно из названия)

--b.
1) убрать объем, сделать двухмерной
2) столбцы вместо конусов

--c.
1) все подписи сделать крупнее
2) вертикальную ось начать не с 0, а с 3-4 тыс.
3) подписи на нижней оси горизонтально отразить, возмонжо оставить только номера 8-91-1, описание вынести в легенду/описание
4) в названи вверху как-то пояснить, что такое "версия" и зачем она нужна