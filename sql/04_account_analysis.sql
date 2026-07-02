/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
Database     : PostgreSQL
File         : 04_account_analysis.sql

Description:
Exploratory Data Analysis (EDA) on customer accounts.

Business Objectives:
1. Understand customer distribution.
2. Analyze account balances.
3. Identify fraud concentration.
4. Explore customer behaviour profiles.
5. Generate insights for fraud investigation.

===============================================================================
*/

-- ============================================================================
-- SECTION 1 : DATASET OVERVIEW
-- ============================================================================

-- Total Accounts

SELECT
COUNT(*) AS total_accounts
FROM accounts;


-- Total Customers

SELECT
COUNT(DISTINCT customer_id) AS total_customers
FROM accounts;


-- Number of Countries

SELECT
COUNT(DISTINCT country) AS countries
FROM accounts;


-- Number of Account Types

SELECT
COUNT(DISTINCT account_type) AS account_types
FROM accounts;



-- ============================================================================
-- SECTION 2 : COUNTRY ANALYSIS
-- ============================================================================

-- Accounts by Country

SELECT

country,

COUNT(*) AS total_accounts

FROM accounts

GROUP BY country

ORDER BY total_accounts DESC;


-- Initial Balance by Country

SELECT

country,

ROUND(SUM(init_balance),2) AS total_balance,

ROUND(AVG(init_balance),2) AS average_balance,

MIN(init_balance) AS minimum_balance,

MAX(init_balance) AS maximum_balance

FROM accounts

GROUP BY country

ORDER BY total_balance DESC;



-- ============================================================================
-- SECTION 3 : ACCOUNT TYPE ANALYSIS
-- ============================================================================

SELECT

account_type,

COUNT(*) AS total_accounts,

ROUND(AVG(init_balance),2) AS average_balance,

ROUND(SUM(init_balance),2) AS total_balance

FROM accounts

GROUP BY account_type

ORDER BY total_accounts DESC;



-- ============================================================================
-- SECTION 4 : FRAUD ANALYSIS
-- ============================================================================

-- Fraud vs Non-Fraud Accounts

SELECT

is_fraud,

COUNT(*) AS total_accounts,

ROUND(

100.0*COUNT(*)/

SUM(COUNT(*)) OVER(),

2

) AS percentage

FROM accounts

GROUP BY is_fraud;


-- Fraud by Country

SELECT

country,

COUNT(*) FILTER(WHERE is_fraud = TRUE) AS fraud_accounts,

COUNT(*) AS total_accounts,

ROUND(

100.0 *

COUNT(*) FILTER(WHERE is_fraud = TRUE)

/

COUNT(*)

,2

) AS fraud_percentage

FROM accounts

GROUP BY country

ORDER BY fraud_percentage DESC;



-- ============================================================================
-- SECTION 5 : BALANCE ANALYSIS
-- ============================================================================

-- Overall Statistics

SELECT

ROUND(AVG(init_balance),2) AS average_balance,

ROUND(MIN(init_balance),2) AS minimum_balance,

ROUND(MAX(init_balance),2) AS maximum_balance,

ROUND(SUM(init_balance),2) AS total_balance

FROM accounts;


-- Top 10 Highest Balance Accounts

SELECT *

FROM accounts

ORDER BY init_balance DESC

LIMIT 10;


-- Top 10 Lowest Balance Accounts

SELECT *

FROM accounts

ORDER BY init_balance

LIMIT 10;



-- ============================================================================
-- SECTION 6 : CUSTOMER ANALYSIS
-- ============================================================================

-- Customers with Multiple Accounts

SELECT

customer_id,

COUNT(*) AS accounts_owned

FROM accounts

GROUP BY customer_id

HAVING COUNT(*)>1

ORDER BY accounts_owned DESC;



-- ============================================================================
-- SECTION 7 : TRANSACTION BEHAVIOUR PROFILE
-- ============================================================================

-- Distribution

SELECT

tx_behavior_id,

COUNT(*) AS total_accounts

FROM accounts

GROUP BY tx_behavior_id

ORDER BY total_accounts DESC;


-- Fraud Distribution by Behaviour Profile

SELECT

tx_behavior_id,

COUNT(*) FILTER(WHERE is_fraud = TRUE) AS fraud_accounts,

COUNT(*) AS total_accounts,

ROUND(

100.0 *

COUNT(*) FILTER(WHERE is_fraud = TRUE)

/

COUNT(*)

,2

) AS fraud_rate

FROM accounts

GROUP BY tx_behavior_id

ORDER BY fraud_rate DESC;



-- ============================================================================
-- SECTION 8 : DATA QUALITY CHECK
-- ============================================================================

-- Missing Values

SELECT *

FROM accounts

WHERE

customer_id IS NULL

OR country IS NULL

OR account_type IS NULL

OR init_balance IS NULL

OR tx_behavior_id IS NULL;


-- Duplicate Accounts

SELECT

account_id,

COUNT(*)

FROM accounts

GROUP BY account_id

HAVING COUNT(*)>1;

