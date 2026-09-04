-- What is the bank's total loan portfolio value?
SELECT
    COUNT(*) AS Total_Loans,
    ROUND(SUM(Loan_Amount),2) AS Total_Loan_Amount,
    ROUND(AVG(Loan_Amount),2) AS Average_Loan_Amount
FROM Loans;

-- Query 2: Loan Type Distribution
SELECT
    Loan_Type,
    COUNT(*) AS Total_Loans,
    ROUND(SUM(Loan_Amount),2) AS Total_Amount,
    ROUND(AVG(Loan_Amount),2) AS Average_Loan
FROM Loans
GROUP BY Loan_Type
ORDER BY Total_Amount DESC;    -- Identifies which loan products contribute most to the bank's lending portfolio.

-- Active vs Closed Loans
SELECT
    Loan_Status,
    COUNT(*) AS Total_Loans
FROM Loans
GROUP BY Loan_Status;

-- Average Interest Rate by Loan Type
SELECT
    Loan_Type,
    ROUND(AVG(Interest_Rate),2) AS Average_Interest
FROM Loans
GROUP BY Loan_Type
ORDER BY Average_Interest DESC;    -- Shows pricing differences across loan products.

-- Top 10 Highest Loan Amounts
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    l.Loan_Type,
    l.Loan_Amount
FROM Customers c
JOIN Loans l
ON c.Customer_ID = l.Customer_ID
ORDER BY l.Loan_Amount DESC
LIMIT 10;

-- Highest Outstanding Loan Balance
SELECT
    c.Customer_ID,
    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,
    l.Loan_Type,
    l.Remaining_Balance
FROM Customers c
JOIN Loans l
ON c.Customer_ID = l.Customer_ID
ORDER BY l.Remaining_Balance DESC
LIMIT 10;        -- Highlights customers with the largest remaining loan exposure.

-- Average EMI by Loan Type
SELECT
    Loan_Type,
    ROUND(AVG(EMI),2) AS Average_EMI
FROM Loans
GROUP BY Loan_Type
ORDER BY Average_EMI DESC;

-- Loan Portfolio by Customer Segment
SELECT
    c.Customer_Segment,
    COUNT(*) AS Total_Loans,
    ROUND(SUM(l.Loan_Amount),2) AS Total_Portfolio
FROM Customers c
JOIN Loans l
ON c.Customer_ID = l.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY Total_Portfolio DESC;   -- Shows which customer segments account for the largest share of lending.

-- Customers with Multiple Loan Types
SELECT
    Customer_ID,
    COUNT(DISTINCT Loan_Type) AS Loan_Types
FROM Loans
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Loan_Type) > 1
ORDER BY Loan_Types DESC;    -- Customers with multiple loan types may have broader financing needs and can be considered for relationship banking services.







