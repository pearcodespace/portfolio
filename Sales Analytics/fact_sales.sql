SELECT 
    CUST.CustomerID,
    CUST.CustomerName,
    COUNT(J.JourneyID) AS PurchaseCount,  -- Count the number of purchases made by each customer
    SUM(P.Price) AS TotalPrice  -- Calculate the total price of all purchases for each customer
FROM dbo.customer_journey J
JOIN dbo.customers CUST ON J.CustomerID = CUST.CustomerID
JOIN dbo.products P ON J.ProductID = P.ProductID  -- Join with the products table to get the product price
WHERE J.Action = 'Purchase'  -- Filter only purchase actions
GROUP BY 
    CUST.CustomerID,
    CUST.CustomerName
HAVING COUNT(J.JourneyID) > 1;  -- Only include customers who made more than 1 purchase


SELECT 
    CUST.CustomerID,
    P.ProductName,
    P.Price,
    J.VisitDate,
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,
	G.Country,
	G.City
FROM dbo.engagement_data E
JOIN dbo.products P ON E.ProductID = P.ProductID
JOIN dbo.customer_journey J ON P.ProductID = J.ProductID
JOIN dbo.customers CUST ON J.CustomerID = CUST.CustomerID
JOIN dbo.geography G ON CUST.GeographyID = G.GeographyID
WHERE J.Action = 'Purchase' and E.ContentType != 'newsletter'