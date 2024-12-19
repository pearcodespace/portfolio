SELECT
	ProductID,
	ProductName,
	Category,
	Price,
	CASE
		WHEN Price < 150 THEN 'Low'
		WHEN Price BETWEEN 150 AND 300 THEN 'Medium'
		ELSE 'High'
	END AS PriceCategory
FROM dbo.products