USE bank_recommend_analytics;

-- Customers
CREATE INDEX idx_customer_city
ON Customers(City);

CREATE INDEX idx_customer_state
ON Customers(State);

CREATE INDEX idx_customer_income
ON Customers(Annual_Income);

CREATE INDEX idx_customer_segment
ON Customers(Customer_Segment);

-- Accounts
CREATE INDEX idx_account_customer
ON Accounts(Customer_ID);

CREATE INDEX idx_account_type
ON Accounts(Account_Type);

-- Transactions
CREATE INDEX idx_transaction_customer
ON Transactions(Customer_ID);

CREATE INDEX idx_transaction_account
ON Transactions(Account_ID);

CREATE INDEX idx_transaction_date
ON Transactions(Transaction_Date);

CREATE INDEX idx_transaction_category
ON Transactions(Merchant_Category);

CREATE INDEX idx_transaction_type
ON Transactions(Transaction_Type);

-- Credit Cards
CREATE INDEX idx_card_customer
ON Credit_Cards(Customer_ID);

-- Loans
CREATE INDEX idx_loan_customer
ON Loans(Customer_ID);

CREATE INDEX idx_loan_status
ON Loans(Loan_Status);

-- Fixed Deposits
CREATE INDEX idx_fd_customer
ON Fixed_Deposits(Customer_ID);

-- Insurance
CREATE INDEX idx_insurance_customer
ON Insurance(Customer_ID);

-- Recommendations
CREATE INDEX idx_recommend_customer
ON Product_Recommendations(Customer_ID);

SHOW INDEX FROM Transactions;