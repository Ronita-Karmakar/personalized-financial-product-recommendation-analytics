# personalized-financial-product-recommendation-analytics

An end-to-end banking analytics project built with **Python, MySQL, SQL, and Power BI** to analyze customer behavior, banking-product usage, transaction patterns, and personalized cross-selling opportunities.


## 📌 Project Overview

Banks collect large amounts of customer, account, transaction, lending, investment, insurance, and card data. The challenge is to convert this data into useful business insights and identify which financial products may be relevant to individual customers.

This project builds a complete analytics workflow that:

- Generates realistic synthetic banking data using Python.
- Stores the data in a relational MySQL database.
- Validates and analyzes the data using SQL.
- Identifies product gaps and cross-selling opportunities.
- Creates interactive Power BI dashboards for management and customer-level analysis.
- Demonstrates a rule-based, explainable financial product recommendation approach.

---

## 🎯 Objectives

1. Build a structured relational banking database.
2. Generate realistic synthetic banking records at scale.
3. Implement a Python-to-MySQL ETL workflow.
4. Perform customer, transaction, and product analytics using SQL.
5. Identify cross-selling opportunities from customer behavior and product ownership.
6. Create interactive Power BI dashboards for business decision-making.
7. Provide customer-level insights through a Customer 360 view.

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| **Python** | Data generation, preparation, ETL |
| **Pandas** | Data manipulation and validation |
| **NumPy** | Numerical operations and controlled random generation |
| **Faker** | Realistic synthetic customer and banking data |
| **MySQL** | Relational database storage |
| **SQL** | Data validation, analysis, and recommendation logic |
| **Power BI** | Interactive dashboards and visualization |
| **Jupyter Notebook** | Python development and ETL workflow |

---

## 🗃️ Database Design

The MySQL database contains **8 related tables**:

| Table | Description | Approx. Records |
|---|---|---:|
| `Customers` | Customer profile and demographic information | 10,000 |
| `Accounts` | Savings/current account information | 15,000 |
| `Transactions` | Customer transaction history | 487,406 |
| `Credit_Cards` | Credit card details and balances | 4,000 |
| `Loans` | Loan portfolio and repayment information | 2,500 |
| `Fixed_Deposits` | FD investment and maturity information | 2,000 |
| `Insurance` | Insurance policy and coverage information | 3,000 |
| `Product_Recommendations` | Recommended products and recommendation reasons | ~14K |

The seven main operational tables contain **523,906 records**, with additional recommendation records generated from the recommendation analysis.

### Key relationships

```text
Customers
   │
   ├── Accounts
   │      │
   │      └── Transactions
   │
   ├── Credit_Cards
   ├── Loans
   ├── Fixed_Deposits
   ├── Insurance
   └── Product_Recommendations
```

Primary keys, foreign keys, check constraints, unique constraints, and indexes were used to maintain data integrity and support analytical queries.

---

## 🧪 Data Generation

Synthetic data was generated with Python rather than using real banking information.

### Generation approach

- Customer profiles were generated using **Faker** and controlled random distributions.
- Accounts were linked to customers.
- Transactions were generated across merchant categories, payment modes, cities, and transaction types.
- Credit-card limits, balances, and available credit were generated using customer income and segment-based rules.
- Loan types and amounts were generated using age and income-based logic, with EMI calculated from interest rate, amount, and tenure.
- Fixed deposits were generated using eligibility rules, deposit amounts, interest rates, tenure, and maturity calculations.
- Insurance policies were generated using age and marital-status-based rules.
- Product recommendations were created from customer/product gaps and business rules rather than being randomly assigned.

### Important data-quality rules

Examples include:

- `Available_Credit + Outstanding_Balance = Credit_Limit`
- `Remaining_Balance <= Loan_Amount`
- `Maturity_Amount >= Deposit_Amount`
- No missing values in the generated core datasets
- Unique IDs for customers, accounts, transactions, cards, loans, FDs, and policies
- Valid foreign-key relationships between tables

---

## 🔄 ETL Pipeline

The project includes a Python-based ETL workflow:

```text
Python Data Generation
        ↓
CSV Files
        ↓
Data Validation
        ↓
Python Batch ETL
        ↓
MySQL Database
        ↓
SQL Validation & Analysis
        ↓
Power BI
```

For large-volume loading, the import process uses **batch inserts** rather than attempting to insert the entire transaction dataset in one operation.

---

## 🔍 SQL Analysis

The SQL analysis was organized into 8 business-focused modules.

### Module 1 — Customer Analytics

Analyzed:

- Total customer base
- Customer segments
- Gender distribution
- Customers by state and city
- Occupation distribution
- Average income
- High-income customers
- Customer growth by year

### Module 2 — Account Analytics

Analyzed:

- Savings vs. Current accounts
- Account status
- Average balances
- Customers with multiple accounts
- Top customers by balance
- Balance by customer segment and city

### Module 3 — Transaction Analytics

Analyzed:

- Total transaction value
- Debit vs. credit activity
- Payment modes
- Merchant categories
- Monthly transaction trends
- Top spending customers
- High-value transactions
- Transaction activity by city and customer segment

### Module 4 — Credit Card Analytics

Analyzed:

- Card type and status
- Credit limits
- Outstanding balances
- Available credit
- Credit utilization
- High-utilization customers
- Card adoption by customer segment

### Module 5 — Loan Analytics

Analyzed:

- Loan portfolio
- Loan type distribution
- Active vs. closed loans
- Interest rates
- EMI values
- Outstanding balances
- Loan portfolio by segment
- High-value active loans

### Module 6 — Fixed Deposit Analytics

Analyzed:

- Total FD portfolio
- FD status
- Deposit duration
- Interest rates
- Top deposit amounts
- Maturity values
- FD portfolio by customer segment and city

### Module 7 — Insurance Analytics

Analyzed:

- Policy count
- Policy types
- Active vs. expired policies
- Premiums
- Coverage
- Insurance by segment and city
- Coverage-to-premium relationship

### Module 8 — Product Recommendation & Cross-Sell Analytics

Identified customers with product gaps such as:

- High income but no credit card
- High income but no loan
- High account balance but no fixed deposit
- No insurance policy

The recommendation logic also stores a **recommendation reason**, making the output explainable.

---

## 📊 Power BI Dashboards

The Power BI report contains four main pages.

### 1. Executive Dashboard

Provides a high-level overview of the banking portfolio.

Key metrics and visuals include:

- Total customers
- Total accounts
- Total transactions
- Total transaction amount
- Total loans
- Total credit cards
- Total fixed deposits
- Total insurance policies
- Customers by state
- Customers by gender
- Customer age groups
- Customer segments

**Purpose:** Help management quickly understand customer scale, product adoption, and overall banking activity.

---

### 2. Transaction Analytics Dashboard

Focuses on customer transaction behavior.

Includes:

- Total debit amount
- Total credit amount
- Average transaction amount
- Highest transaction
- Transaction trend over time
- Spending by merchant category
- Debit vs. credit split
- Top cities by transaction value
- Average transaction by category
- Payment mode usage

**Purpose:** Understand where customers spend, how they pay, and how transaction activity changes over time.

---

### 3. Product & Customer Insights Dashboard

Focuses on financial product adoption and recommendation opportunities.

Includes:

- Active loans
- Active credit cards
- Active insurance
- Active fixed deposits
- Total recommendations
- Product recommendation distribution
- Loan type distribution
- Credit card type distribution
- Insurance policy distribution
- Fixed deposit status
- Customer segment vs. recommended product
- Recommendation reason distribution

**Purpose:** Identify cross-selling opportunities and understand which products are most relevant to different customer groups.

---

### 4. Customer 360 Dashboard

Provides a detailed view of a selected customer.

Includes:

- Customer profile
- Account details
- Total balance
- Transaction count
- Total spending
- Loan information
- Credit card details
- Insurance policies
- Fixed deposits
- Product recommendations
- Recent transactions

**Purpose:** Give relationship managers or business users a complete view of one customer's relationship with the bank.

---

## 💡 Key Business Insights

Some of the main insights from the project include:

- The dataset represents a large and active banking customer base with **10,000 customers and 15,000 accounts**.
- Nearly **487K transactions** provide substantial behavioral information for analysis.
- **Premium customers form the largest customer segment** in the generated dataset.
- **UPI is the most frequently used payment method** in the transaction dataset.
- **Shopping and Investment** are among the highest-value merchant categories by transaction amount.
- Fixed Deposits represent a major cross-selling opportunity, particularly among customers with **high account balances and no FD**.
- Customers without insurance represent another clear product opportunity.
- Customer 360 analysis helps combine profile, product ownership, balance, spending, and recommendation information into a single view.

> These insights describe the **synthetic project dataset** and should not be interpreted as real banking-market statistics.

---

## ⭐ Business Recommendations

1. **Promote Fixed Deposits:** Target customers with high account balances but no existing FD.
2. **Improve Insurance Penetration:** Identify customers without insurance and provide profile-appropriate offers.
3. **Use Spending Behavior:** Use category-level transaction behavior to support relevant credit-card and reward offers.
4. **Focus on Premium/VIP Customers:** Develop differentiated offers for higher-value customer segments.
5. **Use Customer 360:** Allow relationship managers to review a customer's complete profile before making an offer.
6. **Target Matured FDs:** Contact customers with matured deposits for renewal or reinvestment opportunities.
7. **Avoid Irrelevant Cross-Selling:** Consider products a customer already owns and existing credit exposure before generating new recommendations.

---

## 📌 Limitations

- The banking data is **synthetic**, not real customer data.
- Recommendation logic is **rule-based**, not a machine-learning model.
- The project does not represent actual banking risk, credit approval, or financial suitability decisions.
- Thresholds and business rules are demonstration assumptions created for analytics purposes.

---


## 👩‍💻 Author

**Ronita Karmakar**  
B.Tech in Computer Science & Engineering  
Skills demonstrated: **Python | SQL | MySQL | Power BI | Data Analytics**
