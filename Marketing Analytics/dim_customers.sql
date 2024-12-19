SELECT 
	CustomerID,
	CustomerName,
	Email,
	Gender,
	Age,
	Country,
	City
FROM dbo.customers c 
JOIN dbo.geography g ON c.GeographyID = g.GeographyID