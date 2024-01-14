--3.
USE AdventureWorks2017
GO
CREATE PROCEDURE HumanResources.uspUpdIDNumber
	@BusinessEntityID int,   
	@NationalIDNumberNEW nvarchar(15)
	AS
	UPDATE  HumanResources.Employee
		SET NationalIDNumber=@NationalIDNumberNEW
		WHERE BusinessEntityID=@BusinessEntityID;

EXEC HumanResources.uspUpdIDNumber '15', '879341111'; 

--Procedures in AdwentureWorks2017:
[dbo].[uspGetBillOfMaterials]
[dbo].[uspGetEmployeeManagers]
[dbo].[uspGetManagerEmployees]
[dbo].[uspGetWhereUsedProductID]
[dbo].[uspLogError]
[dbo].[uspPrintError]
[dbo].[uspSearchCandidateResumes]
[HumanResources].[uspUpdateEmployeeHireInfo]
[HumanResources].[uspUpdateEmployeeLogin]
[HumanResources].[uspUpdateEmployeePersonalInfo]
