-- Total Fixed Deposit Portfolio
SELECT

    COUNT(*) AS Total_FDs,

    ROUND(SUM(Deposit_Amount),2) AS Total_Deposit,

    ROUND(AVG(Deposit_Amount),2) AS Average_Deposit

FROM Fixed_Deposits;

-- Deposit Distribution by Status
SELECT

    Status,

    COUNT(*) AS Total_FDs,

    ROUND(SUM(Deposit_Amount),2) AS Total_Deposit

FROM Fixed_Deposits

GROUP BY Status

ORDER BY Total_Deposit DESC;  -- Shows how much money is currently invested in active, matured, and closed FDs.

-- Average Interest Rate by FD Duration
SELECT

    Duration_Months,

    ROUND(AVG(Interest_Rate),2) AS Avg_Interest

FROM Fixed_Deposits

GROUP BY Duration_Months

ORDER BY Duration_Months;

-- Most Popular FD Duration
SELECT

    Duration_Months,

    COUNT(*) AS Total_FDs

FROM Fixed_Deposits

GROUP BY Duration_Months

ORDER BY Total_FDs DESC;   -- Identifies customers' preferred investment tenure.

-- Top 10 Highest FD Investments
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    f.Deposit_Amount,

    f.Duration_Months,

    f.Interest_Rate

FROM Customers c

JOIN Fixed_Deposits f

ON c.Customer_ID = f.Customer_ID

ORDER BY f.Deposit_Amount DESC

LIMIT 10;

-- Highest Maturity Amounts
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    f.Maturity_Amount

FROM Customers c

JOIN Fixed_Deposits f

ON c.Customer_ID = f.Customer_ID

ORDER BY f.Maturity_Amount DESC

LIMIT 10;

-- FD Portfolio by Customer Segment
SELECT

    c.Customer_Segment,

    COUNT(*) AS Total_FDs,

    ROUND(SUM(f.Deposit_Amount),2) AS Total_Deposit

FROM Customers c

JOIN Fixed_Deposits f

ON c.Customer_ID = f.Customer_ID

GROUP BY c.Customer_Segment

ORDER BY Total_Deposit DESC;     -- Shows which customer segment contributes the largest investment amount.

-- Customers with Active Fixed Deposits
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    f.Deposit_Amount,

    f.Duration_Months

FROM Customers c

JOIN Fixed_Deposits f

ON c.Customer_ID = f.Customer_ID

WHERE f.Status = 'Active'

ORDER BY f.Deposit_Amount DESC;

-- Average Deposit Amount by City
SELECT

    c.City,

    ROUND(AVG(f.Deposit_Amount),2) AS Average_Deposit,

    COUNT(*) AS Total_FDs

FROM Customers c

JOIN Fixed_Deposits f

ON c.Customer_ID = f.Customer_ID

GROUP BY c.City

ORDER BY Average_Deposit DESC;    -- Highlights cities where customers tend to invest larger amounts in fixed deposits.

-- Customers with Fixed Deposits Above ₹15 Lakhs
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    f.Deposit_Amount,

    f.Duration_Months,

    f.Interest_Rate

FROM Customers c

JOIN Fixed_Deposits f

ON c.Customer_ID = f.Customer_ID

WHERE f.Deposit_Amount > 1500000

ORDER BY f.Deposit_Amount DESC;

-- Top 10 Customers by Total Fixed Deposit Portfolio
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    COUNT(f.FD_ID) AS Number_of_FDs,

    ROUND(SUM(f.Deposit_Amount),2) AS Total_Deposit,

    ROUND(SUM(f.Maturity_Amount),2) AS Total_Maturity_Value

FROM Customers c

JOIN Fixed_Deposits f

ON c.Customer_ID = f.Customer_ID

GROUP BY

    c.Customer_ID,
    Customer_Name

ORDER BY Total_Deposit DESC

LIMIT 10;