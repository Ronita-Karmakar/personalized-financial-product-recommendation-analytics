-- Query 1: Total Customers

SELECT COUNT(*) AS Total_Customers
FROM Customers;    -- Helps estimate the size of the customer base.

-- How many customers belong to each customer segment?
-- Query 2: Customers by Segment

SELECT
    Customer_Segment,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Customer_Segment
ORDER BY Total_Customers DESC;        -- Shows whether the bank has more Retail, Premium, or VIP customers.
 
-- Query 3: Customers by Gender

SELECT
    Gender,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Gender;

-- Top 10 Cities by Customer Count

SELECT
    City,
    COUNT(*) AS Customers
FROM Customers
GROUP BY City
ORDER BY Customers DESC
LIMIT 10;        -- Helps decide where to open new branches or expand marketing efforts.

-- Query 5: Top Occupations

SELECT
    Occupation,
    COUNT(*) AS Customers
FROM Customers
GROUP BY Occupation
ORDER BY Customers DESC
LIMIT 10;

-- Query 6: Average Income by Occupation

SELECT
    Occupation,
    ROUND(AVG(Annual_Income),2) AS Average_Income
FROM Customers
GROUP BY Occupation
ORDER BY Average_Income DESC;    -- Identifies occupations with higher earning potential for premium financial products.

-- Query 7: Top 10 Highest Income Customers

SELECT
    Customer_ID,
    First_Name,
    Last_Name,
    Occupation,
    Annual_Income
FROM Customers
ORDER BY Annual_Income DESC
LIMIT 10;

-- Query 8: Average Income by Segment

SELECT
    Customer_Segment,
    ROUND(AVG(Annual_Income),2) AS Average_Income
FROM Customers
GROUP BY Customer_Segment
ORDER BY Average_Income DESC;

-- Query 9: Marital Status Distribution

SELECT
    Marital_Status,
    COUNT(*) AS Customers
FROM Customers
GROUP BY Marital_Status;

-- Customers Joined Each Year -- Query 10: Customer Growth

SELECT
    YEAR(Join_Date) AS Join_Year,
    COUNT(*) AS New_Customers
FROM Customers
GROUP BY YEAR(Join_Date)
ORDER BY Join_Year;

-- Average Income by State
SELECT
    State,
    ROUND(AVG(Annual_Income),2) AS Avg_Income
FROM Customers
GROUP BY State
ORDER BY Avg_Income DESC;   -- Highlights regions with higher-income customers for targeted campaigns.

