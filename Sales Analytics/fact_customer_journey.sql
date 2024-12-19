WITH JourneyData AS (
    SELECT 
        JourneyID,
        CustomerID,
        ProductID, 
        VisitDate, 
        UPPER(Stage) AS Stage, 
        Action,
        Duration, 
        AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration,  -- Calculates the average duration for each date, using only numeric values
        ROW_NUMBER() OVER (
            PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action  -- Groups by these columns to identify duplicate records
            ORDER BY JourneyID  -- Orders by JourneyID to keep the first occurrence of each duplicate
        ) AS row_num  -- Assigns a row number to each row within the partition to identify duplicates
    FROM 
        dbo.customer_journey
)
SELECT 
    JourneyID, 
    CustomerID,  
    ProductID,  
    VisitDate,  
    Stage, 
    Action, 
    COALESCE(Duration, avg_duration) AS Duration  -- Replaces missing durations with the average duration for the corresponding date
FROM 
    JourneyData
WHERE 
    row_num = 1;  -- Keeps only the first occurrence of each duplicate group
