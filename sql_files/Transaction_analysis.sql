-- What is the total value of all transactions?
SELECT
    ROUND(SUM(Amount),2) AS Total_Transaction_Amount
FROM Transactions;

-- Debit vs Credit Transactions
SELECT
    Transaction_Type,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount),2) AS Total_Amount,
    ROUND(AVG(Amount),2) AS Average_Amount
FROM Transactions
GROUP BY Transaction_Type;   -- Shows whether customers spend more (Debit) or receive more money (Credit).

-- Transactions by Payment Mode
SELECT
    Payment_Mode,
    COUNT(*) AS Transactions,
    ROUND(SUM(Amount),2) AS Total_Amount
FROM Transactions
GROUP BY Payment_Mode
ORDER BY Transactions DESC;

-- Merchant Category Analysis
SELECT
    Merchant_Category,
    COUNT(*) AS Transactions,
    ROUND(SUM(Amount),2) AS Total_Spent
FROM Transactions
GROUP BY Merchant_Category
ORDER BY Total_Spent DESC;   -- This identifies which categories contribute the most transaction value.

-- Monthly Transaction Trend
SELECT
    YEAR(Transaction_Date) AS Year,
    MONTH(Transaction_Date) AS Month,
    COUNT(*) AS Transactions,
    ROUND(SUM(Amount),2) AS Total_Amount
FROM Transactions
GROUP BY
    YEAR(Transaction_Date),
    MONTH(Transaction_Date)
ORDER BY
    Year,
    Month;

-- Top 10 Highest Value Transactions
SELECT
    Transaction_ID,
    Customer_ID,
    Merchant,
    Merchant_Category,
    Amount
FROM Transactions
ORDER BY Amount DESC
LIMIT 10;

-- Top 10 Customers by Spending
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    ROUND(SUM(t.Amount),2) AS Total_Spending
FROM Customers c
JOIN Transactions t
ON c.Customer_ID = t.Customer_ID
WHERE t.Transaction_Type = 'Debit'
GROUP BY
    c.Customer_ID,
    Customer_Name
ORDER BY Total_Spending DESC
LIMIT 10;           -- These customers are excellent candidates for premium banking products and loyalty programs.

-- Average Transaction Amount by Customer Segment
SELECT
    c.Customer_Segment,
    ROUND(AVG(t.Amount),2) AS Average_Transaction
FROM Customers c
JOIN Transactions t
ON c.Customer_ID = t.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY Average_Transaction DESC;            

-- Top 10 Cities by Transaction Amount
SELECT
    City,
    ROUND(SUM(Amount),2) AS Total_Amount
FROM Transactions
GROUP BY City
ORDER BY Total_Amount DESC
LIMIT 10;

 -- Top Merchant Categories by Customer Segment
SELECT
    c.Customer_Segment,
    t.Merchant_Category,
    COUNT(*) AS Transactions,
    ROUND(SUM(t.Amount),2) AS Total_Spent
FROM Customers c
JOIN Transactions t
ON c.Customer_ID = t.Customer_ID
GROUP BY
    c.Customer_Segment,
    t.Merchant_Category
ORDER BY
    c.Customer_Segment,
    Total_Spent DESC;

-- Customers who spent more than ₹5,00,000
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    ROUND(SUM(t.Amount),2) AS Total_Spending
FROM Customers c
JOIN Transactions t
ON c.Customer_ID = t.Customer_ID
WHERE t.Transaction_Type='Debit'
GROUP BY
    c.Customer_ID,
    Customer_Name
HAVING SUM(t.Amount)>500000
ORDER BY Total_Spending DESC;