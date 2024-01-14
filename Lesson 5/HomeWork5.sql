--6.
USE AdventureWorks2017

CREATE TABLE Patients
(
    ID			INT IDENTITY(1, 1),
    FirstName	CHAR(100), 
    LastName	NVARCHAR(100), 
    SSN			uniqueidentifier DEFAULT newid(),
	Email		AS  CONCAT(UPPER(LEFT(FirstName,1)),LOWER(LEFT(LastName,3)),'@mail.com'),
	Temp		FLOAT,
	CreatedDate DATE
);

--7.
INSERT INTO Patients (FirstName, LastName, Temp, CreatedDate)
VALUES
    ('Ivan','Ivanov','40.0','2024-01-01'),
    ('John','Johnson','36.6','2024-01-02'),
	('Sara','Johnson','38.1','2024-01-02');

SELECT*
FROM Patients;

--8.
ALTER TABLE Patients
ADD TempType AS 
	CASE WHEN Temp>37.5 THEN CONCAT('>','37.5','°C')
	ELSE CONCAT('<','37.5','°C')
	END;

--9.
CREATE VIEW Patients_v 
AS
	SELECT ID, FirstName, LastName, SSN, Email, Temp*9/5+32 TempF, CreatedDate, CONCAT(LEFT(TempType,1),'99.5','°F') AS TempTypeF
	FROM Patients;

SELECT*
FROM Patients_v

--10.
GO
CREATE FUNCTION dbo.udfConvertTemp (@TempCelsium FLOAT)
RETURNS FLOAT
AS
BEGIN
	RETURN @TempCelsium*9/5+32
END;
--test
SELECT dbo.udfConvertTemp (37.5)

--11. 	
SET DATEFIRST 1;
DECLARE @first INT
DECLARE @date DATE
SET @date=GETDATE()
SET @first = DATEPART (weekday, DATEFROMPARTS (YEAR (@date), MONTH (@date), 1))
	SELECT DATEFROMPARTS (YEAR (@date), MONTH (@date),
	CASE
		WHEN @first=6 THEN @first+2 
		WHEN @first=7 THEN @first+1 
		ELSE @first
	END) AS FirstWorkday

--12. 
SELECT First_name, 
	CASE WHEN Job_History.End_Date IS NOT NULL THEN
	CONCAT('Left company at', DATEPART(day, Job_History.End_Date),'of', DATENAME (month,DATEPART(monthname, Job_History.End_Date),',', YEAR(Job_History.End_Date))
	ELSE ('Currently Working')
	END AS Status
FROM Employees 
	LEFT JOIN Job_History ON Employees.Employee_ID=Job_History.Employee_ID


