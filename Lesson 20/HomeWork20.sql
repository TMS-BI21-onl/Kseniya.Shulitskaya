--1. Покажите всех менеджеров, которые имеют в подчинении больше 6-ти сотрудников.

SELECT First_name, Last_Name
FROM Employees empl LEFT JOIN 
	(SELECT d.Department_ID, d.Manager_ID, COUNT (Employee_ID) as cnt
	FROM Departments d LEFT JOIN  Employees e ON d.Department_ID=e.Department_ID
	GROUP BY Department_ID, Manager_ID
	HAVING COUNT (Employee_ID)>6) s
ON empl.Employee_ID=s.Manager_ID

--2.Вывести min и max зарплату с вычетом commission_pct для каждого департамента. (commission_pct на базе указывается в процентах). 

SELECT Department_name, MIN (Salary*(1-commission_pct)) as min_salary, MAX (Salary*(1-commission_pct)) as max_salary
FROM Departments d JOIN Employees e ON e.Department_ID=d.Department_ID
GROUP BY Department_name

--3.Вывести только регион, где работают больше всего людей.
SELECT Region_name
FROM 
(SELECT TOP 1 WITH TIES Region_name, COUNT(Employee_ID) as cnt
FROM Regions r 
	JOIN Countries c ON r.Region_ID=c.Region_ID
	JOIN Locations l ON l.Country_ID=c.Country_ID
	JOIN Departments d ON d.Location_ID=l.Location_ID
	JOIN Employees e ON e.Department_ID=d.Department_ID
	GROUP BY Region_name
	ORDER BY 2 DESC)

--4.Найдите разницу в процентах между средней зп по каждому департаменту от общей средней (по всем департаментам).
SELECT Department_name,  CONCAT((avg_d/avg_all-1)*100,'%') as diff
FROM 
	(SELECT Department_name,
			AVG(Salary) OVER (PARTITION BY Department_id) as avg_d,
			AVG(Salary) OVER() as avg_all
			FROM Departments d JOIN Employees e ON e.Department_ID=d.Department_ID)

--5.Найдите людей, кто проработал больше, чем 10 лет в одном департаменте. 

--6.Найдите людей, кто занимает 5-10 место по размеру зарплаты.  
SELECT First_Name, Last_Name
FROM 
	(SELECT First_Name, 
			Last_Name, 
			Employee_ID, 
			DENSE_RANK () OVER (ORDER BY Salary DESC) AS rn 
			FROM Employees) s
WHERE rn BETWEEN 5 AND 10

