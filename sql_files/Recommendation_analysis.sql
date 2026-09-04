-- Find customers who don't own a credit card.
-- Query 1: Customers Without Credit Cards
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    c.Customer_Segment,

    c.Annual_Income

FROM Customers c

LEFT JOIN Credit_Cards cc

ON c.Customer_ID = cc.Customer_ID

WHERE cc.Customer_ID IS NULL

ORDER BY c.Annual_Income DESC;       -- Potential customers for a Credit Card marketing campaign.

-- Recommend Credit Card to High-Income Customers
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    c.Annual_Income,

    c.Customer_Segment,

    'Credit Card' AS Recommended_Product

FROM Customers c

LEFT JOIN Credit_Cards cc

ON c.Customer_ID=cc.Customer_ID

WHERE
    cc.Customer_ID IS NULL
    AND
    c.Annual_Income > 1000000;
    
-- Recommend Fixed Deposit   - Customers with high account balances but no FD.

SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    a.Current_Balance,

    'Fixed Deposit' AS Recommended_Product

FROM Customers c

JOIN Accounts a

ON c.Customer_ID=a.Customer_ID

LEFT JOIN Fixed_Deposits fd

ON c.Customer_ID=fd.Customer_ID

WHERE

    fd.Customer_ID IS NULL

    AND

    a.Current_Balance > 500000;
    
-- Recommend Personal Loan - Customers with high income and no loan.
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    c.Annual_Income,

    'Personal Loan' AS Recommended_Product

FROM Customers c

LEFT JOIN Loans l

ON c.Customer_ID=l.Customer_ID

WHERE

    l.Customer_ID IS NULL

    AND

    c.Annual_Income > 800000;

-- Recommend Insurance  -- Customers without insurance.
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    c.City,

    'Insurance' AS Recommended_Product

FROM Customers c

LEFT JOIN Insurance i

ON c.Customer_ID=i.Customer_ID

WHERE i.Customer_ID IS NULL;

-- Rule-Based Recommendation Engine - This is one of the strongest SQL queries in your project.
SELECT

    c.Customer_ID,

    CONCAT(c.First_Name,' ',c.Last_Name) AS Customer_Name,

    c.Customer_Segment,

    c.Annual_Income,

    CASE

        WHEN cc.Customer_ID IS NULL
             AND c.Annual_Income > 1000000
        THEN 'Credit Card'

        WHEN l.Customer_ID IS NULL
             AND c.Annual_Income > 800000
        THEN 'Personal Loan'

        WHEN fd.Customer_ID IS NULL
             AND a.Current_Balance > 500000
        THEN 'Fixed Deposit'

        WHEN i.Customer_ID IS NULL
        THEN 'Insurance'

        ELSE 'No Recommendation'

 END AS Recommended_Product

FROM Customers c

JOIN Accounts a

ON c.Customer_ID = a.Customer_ID

LEFT JOIN Credit_Cards cc

ON c.Customer_ID = cc.Customer_ID

LEFT JOIN Loans l

ON c.Customer_ID = l.Customer_ID

LEFT JOIN Fixed_Deposits fd

ON c.Customer_ID = fd.Customer_ID

LEFT JOIN Insurance i

ON c.Customer_ID = i.Customer_ID;


-- Product Recommendation Summary - How many customers are recommended for each product?
SELECT

    Recommended_Product,

    COUNT(*) AS Total_Customers

FROM (

    SELECT

        CASE

            WHEN cc.Customer_ID IS NULL
                 AND c.Annual_Income > 1000000
            THEN 'Credit Card'

            WHEN l.Customer_ID IS NULL
                 AND c.Annual_Income > 800000
            THEN 'Personal Loan'

            WHEN fd.Customer_ID IS NULL
                 AND a.Current_Balance > 500000
            THEN 'Fixed Deposit'

            WHEN i.Customer_ID IS NULL
            THEN 'Insurance'

            ELSE 'No Recommendation'

        END AS Recommended_Product

    FROM Customers c

    JOIN Accounts a
    ON c.Customer_ID = a.Customer_ID

    LEFT JOIN Credit_Cards cc
    ON c.Customer_ID = cc.Customer_ID

    LEFT JOIN Loans l
    ON c.Customer_ID = l.Customer_ID

    LEFT JOIN Fixed_Deposits fd
    ON c.Customer_ID = fd.Customer_ID

    LEFT JOIN Insurance i
    ON c.Customer_ID = i.Customer_ID

) AS Recommendations

GROUP BY Recommended_Product

ORDER BY Total_Customers DESC;


-- Insert Recommendations into Product_Recommendations Table
  -- Now we'll use the table you created earlier.

INSERT INTO Product_Recommendations
(
    Customer_ID,
    Recommended_Product,
    Recommendation_Score,
    Recommendation_Reason,
    Recommendation_Date
)

SELECT

    c.Customer_ID,

    CASE

        WHEN cc.Customer_ID IS NULL
             AND c.Annual_Income > 1000000
        THEN 'Credit Card'

        WHEN l.Customer_ID IS NULL
             AND c.Annual_Income > 800000
        THEN 'Personal Loan'

        WHEN fd.Customer_ID IS NULL
             AND a.Current_Balance > 500000
        THEN 'Fixed Deposit'

        WHEN i.Customer_ID IS NULL
        THEN 'Insurance'

        ELSE NULL

    END AS Recommended_Product,

    ROUND(RAND()*20+80,2) AS Recommendation_Score,

    CASE

        WHEN cc.Customer_ID IS NULL
             AND c.Annual_Income > 1000000
        THEN 'High income without a credit card'

        WHEN l.Customer_ID IS NULL
             AND c.Annual_Income > 800000
        THEN 'High income and no existing loan'

        WHEN fd.Customer_ID IS NULL
             AND a.Current_Balance > 500000
        THEN 'High account balance with no fixed deposit'

        WHEN i.Customer_ID IS NULL
        THEN 'No insurance policy found'

    END,

    CURDATE()

FROM Customers c

JOIN Accounts a
ON c.Customer_ID = a.Customer_ID

LEFT JOIN Credit_Cards cc
ON c.Customer_ID = cc.Customer_ID

LEFT JOIN Loans l
ON c.Customer_ID = l.Customer_ID

LEFT JOIN Fixed_Deposits fd
ON c.Customer_ID = fd.Customer_ID

LEFT JOIN Insurance i
ON c.Customer_ID = i.Customer_ID

WHERE

(
    cc.Customer_ID IS NULL
    AND c.Annual_Income > 1000000
)

OR

(
    l.Customer_ID IS NULL
    AND c.Annual_Income > 800000
)

OR

(
    fd.Customer_ID IS NULL
    AND a.Current_Balance > 500000
)

OR

(
    i.Customer_ID IS NULL
);