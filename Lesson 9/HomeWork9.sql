--2.
SELECT 
CONCAT(p.FirstName, p.LastName) as ФИО,
CONCAT(pf.FirstName, pf.LastName) as ФИО_Отца  
FROM People p LEFT JOIN People pf ON p.ID_Father=pf.ID
WHERE p.FirstName LIKE 'Дмитрий'