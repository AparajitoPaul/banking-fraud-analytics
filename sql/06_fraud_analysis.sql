/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
Database     : PostgreSQL
File         : 06_fraud_analysis.sql

Description:
Fraud detection and risk analysis using transaction,
account and alert information.

Business Objectives:
1. Understand fraud distribution.
2. Identify high-risk transaction types.
3. Detect suspicious accounts.
4. Analyze fraud alerts.
5. Generate fraud intelligence for investigators.

===============================================================================
*/


-- ============================================================================
-- SECTION 1 : FRAUD OVERVIEW
-- ============================================================================

-- Overall Fraud Rate

SELECT

COUNT(*) AS total_transactions,

SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_transactions,

ROUND(
100.0 *
SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END)
/ COUNT(*)
,2
) AS fraud_rate

FROM transactions;



-- ============================================================================
-- SECTION 2 : FRAUD BY TRANSACTION TYPE
-- ============================================================================

SELECT

tx_type,

COUNT(*) AS total_transactions,

SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_transactions,

ROUND(
100.0 *
SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END)
/ COUNT(*)
,2
) AS fraud_rate

FROM transactions

GROUP BY tx_type

ORDER BY fraud_rate DESC;



-- ============================================================================
-- SECTION 3 : FRAUD VALUE ANALYSIS
-- ============================================================================

SELECT

is_fraud,

ROUND(AVG(tx_amount),2) AS average_amount,

ROUND(MAX(tx_amount),2) AS maximum_amount,

ROUND(MIN(tx_amount),2) AS minimum_amount,

ROUND(SUM(tx_amount),2) AS total_amount

FROM transactions

GROUP BY is_fraud;



-- ============================================================================
-- SECTION 4 : TOP FRAUDULENT TRANSACTIONS
-- ============================================================================

SELECT *

FROM transactions

WHERE is_fraud = TRUE

ORDER BY tx_amount DESC

LIMIT 20;



-- ============================================================================
-- SECTION 5 : ACCOUNTS WITH MOST FRAUD TRANSACTIONS
-- ============================================================================

SELECT

sender_account_id,

COUNT(*) AS fraud_transactions,

ROUND(SUM(tx_amount),2) AS fraud_amount

FROM transactions

WHERE is_fraud = TRUE

GROUP BY sender_account_id

ORDER BY fraud_transactions DESC

LIMIT 20;



-- ============================================================================
-- SECTION 6 : FRAUD RECEIVING ACCOUNTS
-- ============================================================================

SELECT

receiver_account_id,

COUNT(*) AS fraud_transactions,

ROUND(SUM(tx_amount),2) AS fraud_amount

FROM transactions

WHERE is_fraud = TRUE

GROUP BY receiver_account_id

ORDER BY fraud_transactions DESC

LIMIT 20;



-- ============================================================================
-- SECTION 7 : FRAUD ALERTS
-- ============================================================================

SELECT

alert_type,

COUNT(*) AS total_alerts

FROM alerts

GROUP BY alert_type

ORDER BY total_alerts DESC;



SELECT

alert_type,

SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_alerts

FROM alerts

GROUP BY alert_type

ORDER BY fraud_alerts DESC;



-- ============================================================================
-- SECTION 8 : FRAUD BY COUNTRY
-- ============================================================================

SELECT

a.country,

COUNT(*) AS fraud_transactions,

ROUND(SUM(t.tx_amount),2) AS fraud_amount

FROM transactions t

JOIN accounts a

ON t.sender_account_id = a.account_id

WHERE t.is_fraud = TRUE

GROUP BY a.country

ORDER BY fraud_transactions DESC;



-- ============================================================================
-- SECTION 9 : FRAUD BY BEHAVIOUR PROFILE
-- ============================================================================

SELECT

a.tx_behavior_id,

COUNT(*) AS fraud_transactions,

ROUND(SUM(t.tx_amount),2) AS fraud_amount

FROM transactions t

JOIN accounts a

ON t.sender_account_id = a.account_id

WHERE t.is_fraud = TRUE

GROUP BY a.tx_behavior_id

ORDER BY fraud_transactions DESC;



-- ============================================================================
-- SECTION 10 : TRANSACTIONS WITH ALERTS
-- ============================================================================

SELECT

t.tx_id,

t.sender_account_id,

t.receiver_account_id,

t.tx_amount,

a.alert_type

FROM transactions t

JOIN alerts a

ON t.tx_id = a.tx_id

LIMIT 20;



-- ============================================================================
-- SECTION 11 : FRAUD TRANSACTIONS WITH ALERTS
-- ============================================================================

SELECT

t.tx_id,

t.tx_amount,

t.tx_type,

a.alert_type

FROM transactions t

JOIN alerts a

ON t.tx_id = a.tx_id

WHERE

t.is_fraud = TRUE

AND

a.is_fraud = TRUE

ORDER BY t.tx_amount DESC;



-- ============================================================================
-- SECTION 12 : HIGH-RISK ACCOUNTS
-- ============================================================================

SELECT

sender_account_id,

COUNT(*) FILTER (WHERE is_fraud = TRUE) AS fraud_transactions,

COUNT(*) AS total_transactions,

ROUND(

100.0 *

COUNT(*) FILTER (WHERE is_fraud = TRUE)

/

COUNT(*)

,2

) AS fraud_percentage

FROM transactions

GROUP BY sender_account_id

HAVING COUNT(*) > 10

ORDER BY fraud_percentage DESC;



-- ============================================================================
-- SECTION 13 : FRAUD NETWORK
-- ============================================================================

SELECT

sender_account_id,

receiver_account_id,

COUNT(*) AS transactions,

ROUND(SUM(tx_amount),2) AS total_amount

FROM transactions

WHERE is_fraud = TRUE

GROUP BY

sender_account_id,

receiver_account_id

ORDER BY transactions DESC

LIMIT 20;



-- ============================================================================
-- SECTION 14 : DATA QUALITY
-- ============================================================================

SELECT *

FROM alerts

WHERE alert_type IS NULL;



SELECT *

FROM alerts

WHERE tx_id IS NULL;



