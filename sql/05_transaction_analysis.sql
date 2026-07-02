/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
Database     : PostgreSQL
File         : 05_transaction_analysis.sql

Description:
Exploratory Data Analysis on banking transactions.

Business Objectives:
1. Analyze transaction volume.
2. Identify high-value transactions.
3. Analyze transaction types.
4. Identify top sending and receiving accounts.
5. Study money flow.
===============================================================================
*/


-- ============================================================================
-- SECTION 1 : DATASET OVERVIEW
-- ============================================================================

-- Total Transactions

SELECT
COUNT(*) AS total_transactions
FROM transactions;


-- Total Transaction Value

SELECT
ROUND(SUM(tx_amount),2) AS total_transaction_value
FROM transactions;


-- Average Transaction Value

SELECT
ROUND(AVG(tx_amount),2) AS average_transaction_value
FROM transactions;


-- ============================================================================
-- SECTION 2 : TRANSACTION TYPE ANALYSIS
-- ============================================================================

SELECT

tx_type,

COUNT(*) AS total_transactions,

ROUND(SUM(tx_amount),2) AS total_amount,

ROUND(AVG(tx_amount),2) AS average_amount,

MIN(tx_amount) AS minimum_amount,

MAX(tx_amount) AS maximum_amount

FROM transactions

GROUP BY tx_type

ORDER BY total_amount DESC;



-- ============================================================================
-- SECTION 3 : TRANSACTION AMOUNT ANALYSIS
-- ============================================================================

SELECT

ROUND(MIN(tx_amount),2) AS minimum_transaction,

ROUND(MAX(tx_amount),2) AS maximum_transaction,

ROUND(AVG(tx_amount),2) AS average_transaction,

ROUND(SUM(tx_amount),2) AS total_transaction_value

FROM transactions;


-- Top 10 Largest Transactions

SELECT *

FROM transactions

ORDER BY tx_amount DESC

LIMIT 10;


-- Top 10 Smallest Transactions

SELECT *

FROM transactions

ORDER BY tx_amount

LIMIT 10;



-- ============================================================================
-- SECTION 4 : SENDER ANALYSIS
-- ============================================================================

SELECT

sender_account_id,

COUNT(*) AS transactions_sent,

ROUND(SUM(tx_amount),2) AS total_sent,

ROUND(AVG(tx_amount),2) AS average_sent

FROM transactions

GROUP BY sender_account_id

ORDER BY total_sent DESC

LIMIT 20;



-- ============================================================================
-- SECTION 5 : RECEIVER ANALYSIS
-- ============================================================================

SELECT

receiver_account_id,

COUNT(*) AS transactions_received,

ROUND(SUM(tx_amount),2) AS total_received,

ROUND(AVG(tx_amount),2) AS average_received

FROM transactions

GROUP BY receiver_account_id

ORDER BY total_received DESC

LIMIT 20;



-- ============================================================================
-- SECTION 6 : ACCOUNT ACTIVITY
-- ============================================================================

SELECT

sender_account_id,

COUNT(*) AS total_transactions

FROM transactions

GROUP BY sender_account_id

ORDER BY total_transactions DESC

LIMIT 20;



SELECT

receiver_account_id,

COUNT(*) AS total_transactions

FROM transactions

GROUP BY receiver_account_id

ORDER BY total_transactions DESC

LIMIT 20;



-- ============================================================================
-- SECTION 7 : FRAUD TRANSACTIONS
-- ============================================================================

SELECT

is_fraud,

COUNT(*) AS total_transactions,

ROUND(

100.0*COUNT(*)/

SUM(COUNT(*)) OVER(),

2

) AS percentage

FROM transactions

GROUP BY is_fraud;



SELECT

tx_type,

COUNT(*) FILTER(WHERE is_fraud = TRUE) AS fraud_transactions,

COUNT(*) AS total_transactions,

ROUND(

100.0 *

COUNT(*) FILTER(WHERE is_fraud = TRUE)

/

COUNT(*)

,2

) AS fraud_rate

FROM transactions

GROUP BY tx_type

ORDER BY fraud_rate DESC;



-- ============================================================================
-- SECTION 8 : TIME STEP ANALYSIS
-- ============================================================================

SELECT

time_step,

COUNT(*) AS total_transactions,

ROUND(SUM(tx_amount),2) AS transaction_value

FROM transactions

GROUP BY time_step

ORDER BY time_step;



-- ============================================================================
-- SECTION 9 : ACCOUNT INFORMATION USING JOIN
-- ============================================================================

SELECT

t.tx_id,

t.tx_amount,

t.tx_type,

a.country,

a.account_type

FROM transactions t

JOIN accounts a

ON t.sender_account_id = a.account_id

LIMIT 20;



-- ============================================================================
-- SECTION 10 : COUNTRY WISE MONEY OUTFLOW
-- ============================================================================

SELECT

a.country,

ROUND(SUM(t.tx_amount),2) AS total_sent

FROM transactions t

JOIN accounts a

ON t.sender_account_id = a.account_id

GROUP BY a.country

ORDER BY total_sent DESC;



-- ============================================================================
-- SECTION 11 : COUNTRY WISE MONEY INFLOW
-- ============================================================================

SELECT

a.country,

ROUND(SUM(t.tx_amount),2) AS total_received

FROM transactions t

JOIN accounts a

ON t.receiver_account_id = a.account_id

GROUP BY a.country

ORDER BY total_received DESC;



-- ============================================================================
-- SECTION 12 : DATA QUALITY
-- ============================================================================

SELECT *

FROM transactions

WHERE

tx_amount < 0;



SELECT *

FROM transactions

WHERE

sender_account_id = receiver_account_id;



