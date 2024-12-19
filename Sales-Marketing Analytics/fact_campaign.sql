SELECT 
    E.CampaignID, 
    CUST.CustomerID,  -- Added CustomerID to the SELECT clause
    G.Country, 
    G.City, 
    P.ProductName,
    P.Price,
    J.VisitDate
FROM dbo.engagement_data E
JOIN dbo.products P ON E.ProductID = P.ProductID
JOIN dbo.customer_journey J ON P.ProductID = J.ProductID
JOIN dbo.customers CUST ON J.CustomerID = CUST.CustomerID
JOIN dbo.geography G ON CUST.GeographyID = G.GeographyID
WHERE J.Action = 'Purchase'
GROUP BY 
    E.CampaignID, 
    CUST.CustomerID,  -- Added CustomerID to the GROUP BY clause
    G.Country, 
    G.City, 
    P.ProductName,
    P.Price,
    J.VisitDate;
