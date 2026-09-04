CREATE DATABASE IF NOT EXISTS bank_recommend_analytics;
use bank_recommend_analytics;

CREATE TABLE Customers (
    Customer_ID VARCHAR(10) PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Gender ENUM('Male','Female','Other') NOT NULL,
    DOB DATE NOT NULL,

    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15) UNIQUE,

    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,

    Occupation VARCHAR(100) NOT NULL,

    Annual_Income DECIMAL(12,2) NOT NULL,
    Marital_Status ENUM('Single','Married','Divorced','Widowed'),

    Customer_Segment ENUM('Retail','Premium','VIP')
        DEFAULT 'Retail',

    Join_Date DATE NOT NULL,

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CHECK (Annual_Income >= 0)
);

CREATE TABLE Accounts (
    Account_ID VARCHAR(12) PRIMARY KEY,

    Customer_ID VARCHAR(10) NOT NULL,

    Account_Type ENUM('Savings','Current') NOT NULL,

    Branch_Code VARCHAR(10),

    Branch_City VARCHAR(50),

    Opening_Date DATE NOT NULL,

    Current_Balance DECIMAL(15,2) DEFAULT 0,

    Status ENUM('Active','Inactive','Closed')
        DEFAULT 'Active',

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CHECK(Current_Balance >= 0),

    CONSTRAINT fk_accounts_customer
    FOREIGN KEY(Customer_ID)
    REFERENCES Customers(Customer_ID)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

CREATE TABLE Transactions (

    Transaction_ID VARCHAR(15) PRIMARY KEY,

    Account_ID VARCHAR(12) NOT NULL,

    Customer_ID VARCHAR(10) NOT NULL,

    Transaction_Date DATETIME NOT NULL,

    Merchant VARCHAR(100),

    Merchant_Category ENUM(
        'Shopping',
        'Food',
        'Travel',
        'Bills',
        'Healthcare',
        'Entertainment',
        'Education',
        'Fuel',
        'Salary',
        'Investment',
        'Other'
    ),

    Amount DECIMAL(12,2) NOT NULL,

    Payment_Mode ENUM(
        'UPI',
        'Debit Card',
        'Credit Card',
        'Net Banking',
        'Cash'
    ),

    Transaction_Type ENUM(
        'Debit',
        'Credit'
    ),

    City VARCHAR(50),

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CHECK(Amount > 0),

    FOREIGN KEY(Account_ID)
        REFERENCES Accounts(Account_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY(Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE Transactions;

CREATE TABLE Transactions (

    Transaction_ID VARCHAR(15) PRIMARY KEY,

    Account_ID VARCHAR(12) NOT NULL,

    Customer_ID VARCHAR(10) NOT NULL,

    Transaction_Date DATETIME NOT NULL,

    Merchant VARCHAR(100),

    Merchant_Category ENUM(
        'Shopping',
        'Food',
        'Travel',
        'Bills',
        'Healthcare',
        'Entertainment',
        'Education',
        'Fuel',
        'Salary',
        'Investment',
        'Grocery',
        'Other'
    ),

    Amount DECIMAL(12,2) NOT NULL,

    Payment_Mode ENUM(
        'UPI',
        'Debit Card',
        'Credit Card',
        'Net Banking',
        'Cash Deposit',
        'Cheque'
    ),

    Transaction_Type ENUM(
        'Debit',
        'Credit'
    ),

    City VARCHAR(50),

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CHECK (Amount > 0),

    FOREIGN KEY(Account_ID)
        REFERENCES Accounts(Account_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY(Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


CREATE TABLE Credit_Cards (

    Card_ID VARCHAR(12) PRIMARY KEY,

    Customer_ID VARCHAR(10) NOT NULL,

    Card_Type ENUM(
        'Silver',
        'Gold',
        'Platinum'
    ),

    Credit_Limit DECIMAL(12,2),

    Outstanding_Balance DECIMAL(12,2),

    Available_Credit DECIMAL(12,2),

    Card_Status ENUM(
        'Active',
        'Blocked',
        'Expired'
    ),

    Issue_Date DATE,

    Expiry_Date DATE,

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CHECK(Credit_Limit >= 0),

    CHECK(Outstanding_Balance >= 0),

    FOREIGN KEY(Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Loans (

    Loan_ID VARCHAR(12) PRIMARY KEY,

    Customer_ID VARCHAR(10) NOT NULL,

    Loan_Type ENUM(
        'Personal',
        'Home',
        'Auto',
        'Education'
    ),

    Loan_Amount DECIMAL(15,2),

    Interest_Rate DECIMAL(5,2),

    EMI DECIMAL(12,2),

    Remaining_Balance DECIMAL(15,2),

    Loan_Status ENUM(
        'Active',
        'Closed'
    ),

    Start_Date DATE,

    End_Date DATE,

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CHECK(Loan_Amount > 0),

    CHECK(Interest_Rate BETWEEN 1 AND 25),

    FOREIGN KEY(Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Fixed_Deposits (

    FD_ID VARCHAR(12) PRIMARY KEY,

    Customer_ID VARCHAR(10) NOT NULL,

    Deposit_Amount DECIMAL(15,2),

    Interest_Rate DECIMAL(5,2),

    Duration_Months INT,

    Maturity_Amount DECIMAL(15,2),

    Start_Date DATE,

    Maturity_Date DATE,

    Status ENUM(
        'Active',
        'Matured',
        'Closed'
    ),

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CHECK(Deposit_Amount > 0),

    CHECK(Duration_Months BETWEEN 6 AND 120),

    FOREIGN KEY(Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Insurance (

    Policy_ID VARCHAR(12) PRIMARY KEY,

    Customer_ID VARCHAR(10) NOT NULL,

    Policy_Type ENUM(
        'Health',
        'Life',
        'Vehicle'
    ),

    Premium DECIMAL(12,2),

    Coverage DECIMAL(15,2),

    Start_Date DATE,

    End_Date DATE,

    Policy_Status ENUM(
        'Active',
        'Expired'
    ),

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CHECK(Premium > 0),

    FOREIGN KEY(Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Product_Recommendations (

    Recommendation_ID INT AUTO_INCREMENT PRIMARY KEY,

    Customer_ID VARCHAR(10) NOT NULL,

    Recommended_Product ENUM(
        'Credit Card',
        'Personal Loan',
        'Home Loan',
        'Fixed Deposit',
        'Insurance'
    ),

    Recommendation_Score DECIMAL(5,2),

    Recommendation_Reason VARCHAR(255),

    Recommendation_Date DATE,

    FOREIGN KEY(Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DESCRIBE Transactions;
DESCRIBE credit_cards;

SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Accounts;
SELECT COUNT(*) FROM Transactions;
SELECT COUNT(*) FROM Credit_Cards;
SELECT COUNT(*) FROM Loans;
SELECT COUNT(*) FROM Fixed_Deposits;
SELECT COUNT(*) FROM Insurance;