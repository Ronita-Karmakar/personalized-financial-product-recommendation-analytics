-- — Data Validation
-- Check Duplicate Primary Keys
SELECT Customer_ID, COUNT(*)
FROM Customers
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

SELECT Account_ID, COUNT(*)
FROM Accounts
GROUP BY Account_ID
HAVING COUNT(*) > 1;

SELECT Transaction_ID, COUNT(*)
FROM Transactions
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

-- Check Foreign Keys - Accounts without Customers
SELECT *
FROM Accounts a
LEFT JOIN Customers c
ON a.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

-- Transactions without Accounts
SELECT *
FROM Transactions t
LEFT JOIN Accounts a
ON t.Account_ID = a.Account_ID
WHERE a.Account_ID IS NULL;

-- Transactions without Customers
SELECT *
FROM Transactions t
LEFT JOIN Customers c
ON t.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

-- Check Null Values
SELECT
SUM(Customer_ID IS NULL) AS CustomerID_Nulls,
SUM(Annual_Income IS NULL) AS Income_Nulls,
SUM(City IS NULL) AS City_Nulls
FROM Customers;

-- Check Negative Values
SELECT *
FROM Accounts
WHERE Current_Balance < 0;

SELECT *
FROM Loans
WHERE Loan_Amount < 0;

SELECT *
FROM Fixed_Deposits
WHERE Deposit_Amount < 0;

-- Customers joining before birth? (Should never happen.)
SELECT *
FROM Customers
WHERE Join_Date < DOB;

-- Relationship Validation - How many accounts per customer?
SELECT
COUNT(*) AS Accounts,
COUNT(DISTINCT Customer_ID) AS Customers
FROM Accounts;