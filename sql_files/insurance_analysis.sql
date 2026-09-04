-- How many insurance policies has the bank sold?
SELECT

    COUNT(*) AS Total_Policies,

    ROUND(SUM(Premium),2) AS Total_Premium,

    ROUND(AVG(Premium),2) AS Average_Premium

FROM Insurance;

-- Query 2: Policy Type Distribution
SELECT

    Policy_Type,

    COUNT(*) AS Total_Policies,

    ROUND(SUM(Premium),2) AS Total_Premium

FROM Insurance

GROUP BY Policy_Type

ORDER BY Total_Premium DESC;     -- Shows which insurance product generates the highest premium revenue.

-- Active vs Expired Policies
SELECT

    Policy_Status,

    COUNT(*) AS Total_Policies

FROM Insurance

GROUP BY Policy_Status;

-- Average Coverage by Policy Type
SELECT

    Policy_Type,

    ROUND(AVG(Coverage),2) AS Average_Coverage

FROM Insurance

GROUP BY Policy_Type

ORDER BY Average_Coverage DESC;

-- Top 10 Highest Coverage Policies
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    i.Policy_Type,

    i.Coverage

FROM Customers c

JOIN Insurance i

ON c.Customer_ID = i.Customer_ID

ORDER BY i.Coverage DESC

LIMIT 10;

-- Customers Paying Highest Premiums
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    i.Policy_Type,

    i.Premium

FROM Customers c

JOIN Insurance i

ON c.Customer_ID = i.Customer_ID

ORDER BY i.Premium DESC

LIMIT 10;

-- Insurance Portfolio by Customer Segment
SELECT

    c.Customer_Segment,

    COUNT(*) AS Total_Policies,

    ROUND(SUM(i.Premium),2) AS Total_Premium

FROM Customers c

JOIN Insurance i

ON c.Customer_ID = i.Customer_ID

GROUP BY c.Customer_Segment

ORDER BY Total_Premium DESC;  -- Shows which customer segment contributes the highest insurance premium.

-- Insurance Portfolio by City
SELECT

    c.City,

    COUNT(*) AS Total_Policies,

    ROUND(SUM(i.Premium),2) AS Total_Premium

FROM Customers c

JOIN Insurance i

ON c.Customer_ID = i.Customer_ID

GROUP BY c.City

ORDER BY Total_Premium DESC;

-- Customers with Premium Above ₹50,000
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    i.Policy_Type,

    i.Premium

FROM Customers c

JOIN Insurance i

ON c.Customer_ID = i.Customer_ID

WHERE i.Premium > 50000

ORDER BY i.Premium DESC;

-- Coverage-to-Premium Ratio  - This helps identify customers receiving the highest insurance coverage relative to the premium paid.
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    i.Policy_Type,

    i.Premium,

    i.Coverage,

    ROUND(i.Coverage / i.Premium,2) AS Coverage_Ratio

FROM Customers c

JOIN Insurance i

ON c.Customer_ID = i.Customer_ID

ORDER BY Coverage_Ratio DESC

LIMIT 10;

-- Customers Holding Multiple Banking Products
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    CASE WHEN cc.Customer_ID IS NOT NULL THEN 'Yes' ELSE 'No' END AS Has_Credit_Card,

    CASE WHEN l.Customer_ID IS NOT NULL THEN 'Yes' ELSE 'No' END AS Has_Loan,

    CASE WHEN fd.Customer_ID IS NOT NULL THEN 'Yes' ELSE 'No' END AS Has_FD,

    CASE WHEN i.Customer_ID IS NOT NULL THEN 'Yes' ELSE 'No' END AS Has_Insurance

FROM Customers c

LEFT JOIN Credit_Cards cc
ON c.Customer_ID = cc.Customer_ID

LEFT JOIN Loans l
ON c.Customer_ID = l.Customer_ID

LEFT JOIN Fixed_Deposits fd
ON c.Customer_ID = fd.Customer_ID

LEFT JOIN Insurance i
ON c.Customer_ID = i.Customer_ID

LIMIT 100;

