-- Query 1: Total Bank Accounts

SELECT COUNT(*) AS Total_Accounts
FROM Accounts;

-- How many Savings and Current accounts does the bank have?
-- Query 2: Account Type Distribution

SELECT
    Account_Type,
    COUNT(*) AS Total_Accounts
FROM Accounts
GROUP BY Account_Type
ORDER BY Total_Accounts DESC;   -- Banks use this to understand the distribution of account types.

-- Active vs Inactive vs Closed Accounts

SELECT
    Status,
    COUNT(*) AS Total_Accounts
FROM Accounts
GROUP BY Status;   -- A high number of inactive accounts may indicate customer churn.

-- Average Balance by Account Type

SELECT
    Account_Type,
    ROUND(AVG(Current_Balance),2) AS Average_Balance
FROM Accounts
GROUP BY Account_Type;

-- Query 5: Top Customers by Total Balance

SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    ROUND(SUM(a.Current_Balance),2) AS Total_Balance
FROM Customers c
INNER JOIN Accounts a
ON c.Customer_ID = a.Customer_ID
GROUP BY
    c.Customer_ID,
    Customer_Name
ORDER BY Total_Balance DESC
LIMIT 10;

-- Customers Having More Than One Account
SELECT
    Customer_ID,
    COUNT(Account_ID) AS Number_of_Accounts
FROM Accounts
GROUP BY Customer_ID
HAVING COUNT(Account_ID) > 1
ORDER BY Number_of_Accounts DESC;    -- Banks often target multi-account customers with premium products.

-- Average Balance by Customer Segment
SELECT
    c.Customer_Segment,
    ROUND(AVG(a.Current_Balance),2) AS Average_Balance
FROM Customers c
JOIN Accounts a
ON c.Customer_ID = a.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY Average_Balance DESC;

-- Number of Accounts in Each City
SELECT
    Branch_City,
    COUNT(*) AS Total_Accounts
FROM Accounts
GROUP BY Branch_City
ORDER BY Total_Accounts DESC;

-- Top 10 Richest Customers (Account Balance)
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    c.Customer_Segment,
    SUM(a.Current_Balance) AS Total_Balance
FROM Customers c
JOIN Accounts a
ON c.Customer_ID = a.Customer_ID
GROUP BY
    c.Customer_ID,
    Customer_Name,
    c.Customer_Segment
ORDER BY Total_Balance DESC
LIMIT 10;

-- Find customers who have more than one account AND a total balance above ₹10,00,000.
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    COUNT(a.Account_ID) AS Accounts,
    ROUND(SUM(a.Current_Balance),2) AS Total_Balance
FROM Customers c
JOIN Accounts a
ON c.Customer_ID = a.Customer_ID
GROUP BY
    c.Customer_ID,
    Customer_Name
HAVING
    COUNT(a.Account_ID) > 1
    AND
    SUM(a.Current_Balance) > 1000000
ORDER BY Total_Balance DESC;
