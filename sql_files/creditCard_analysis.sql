-- How many credit cards has the bank issued?
SELECT COUNT(*) AS Total_Credit_Cards
FROM Credit_Cards;

-- How many Silver, Gold, and Platinum cards have been issued?
SELECT
    Card_Type,
    COUNT(*) AS Total_Cards
FROM Credit_Cards
GROUP BY Card_Type
ORDER BY Total_Cards DESC;  -- Helps understand the distribution of different card tiers.

-- Card Status Distribution
SELECT
    Card_Status,
    COUNT(*) AS Total_Cards
FROM Credit_Cards
GROUP BY Card_Status;    -- Shows how many cards are Active, Blocked, or Expired.

-- Average Credit Limit by Card Type
SELECT
    Card_Type,
    ROUND(AVG(Credit_Limit),2) AS Average_Credit_Limit
FROM Credit_Cards
GROUP BY Card_Type
ORDER BY Average_Credit_Limit DESC;

-- Top 10 Customers by Credit Limit
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    cc.Card_Type,
    cc.Credit_Limit
FROM Customers c
JOIN Credit_Cards cc
ON c.Customer_ID = cc.Customer_ID
ORDER BY cc.Credit_Limit DESC
LIMIT 10;        -- These customers are among the bank's highest credit-worthy clients.

-- Credit Utilization Analysis
-- Utilization % = Outstanding Balance ÷ Credit Limit × 100
SELECT
    Card_ID,
    Customer_ID,
    Card_Type,
    Credit_Limit,
    Outstanding_Balance,
    ROUND(
        (Outstanding_Balance / Credit_Limit) * 100,
        2
    ) AS Utilization_Percentage
FROM Credit_Cards
ORDER BY Utilization_Percentage DESC;   -- High utilization may indicate customers who are likely to need additional credit or may present higher repayment risk.

-- Customers with Utilization Above 80%
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    cc.Card_Type,
    ROUND(
        (cc.Outstanding_Balance / cc.Credit_Limit) * 100,
        2
    ) AS Utilization_Percentage
FROM Customers c
JOIN Credit_Cards cc
ON c.Customer_ID = cc.Customer_ID
WHERE
    (cc.Outstanding_Balance / cc.Credit_Limit) > 0.80
ORDER BY Utilization_Percentage DESC;     

-- Query 8: Average Utilization by Card Type
SELECT
    Card_Type,
    ROUND(
        AVG(
            (Outstanding_Balance / Credit_Limit) * 100
        ),
        2
    ) AS Average_Utilization
FROM Credit_Cards
GROUP BY Card_Type
ORDER BY Average_Utilization DESC;

-- Query 9: Premium Customers Holding Credit Cards
SELECT
    c.Customer_Segment,
    COUNT(*) AS Total_Cards
FROM Customers c
JOIN Credit_Cards cc
ON c.Customer_ID = cc.Customer_ID
GROUP BY c.Customer_Segment;        -- Shows how credit card ownership varies across customer segments.

-- Find customers whose available credit is less than ₹50,000.
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    cc.Card_Type,
    cc.Available_Credit
FROM Customers c
JOIN Credit_Cards cc
ON c.Customer_ID = cc.Customer_ID
WHERE cc.Available_Credit < 50000
ORDER BY cc.Available_Credit ASC;  -- These customers may be:  Heavy credit card users.
															-- Candidates for a credit limit review.
															-- Customers who should receive spending alerts or financial guidance.

-- Which customers have the highest total credit exposure?
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    SUM(cc.Credit_Limit) AS Total_Credit_Limit,
    SUM(cc.Outstanding_Balance) AS Total_Outstanding,
    ROUND(
        (SUM(cc.Outstanding_Balance) / SUM(cc.Credit_Limit)) * 100,
        2
    ) AS Overall_Utilization
FROM Customers c
JOIN Credit_Cards cc
ON c.Customer_ID = cc.Customer_ID
GROUP BY
    c.Customer_ID,
    Customer_Name
ORDER BY Total_Credit_Limit DESC
LIMIT 10;

