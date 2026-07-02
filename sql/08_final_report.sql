/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
Database     : PostgreSQL
File         : 08_final_insights.sql

Description:
Executive summary of key business insights generated from the Banking Fraud
Analytics database.

Audience:
• Business Managers
• Fraud Investigation Team
• Risk Management Team
• Data Analytics Team

===============================================================================
*/


-- ============================================================================
-- KPI 1 : DATABASE SUMMARY
-- ============================================================================

SELECT

(SELECT COUNT(*) FROM accounts)      AS total_accounts,

(SELECT COUNT(*) FROM transactions)  AS total_transactions,

(SELECT COUNT(*) FROM alerts)        AS total_alerts;



-- ============================================================================
-- KPI 2 : OVERALL FRAUD RATE
-- ============================================================================

SELECT

COUNT(*) AS total_transactions,

SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_transactions,

ROUND(

100.0 *

SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END)

/

COUNT(*)

,2)

AS fraud_rate

FROM transactions;



-- ============================================================================
-- KPI 3 : FRAUD RATE BY TRANSACTION TYPE
-- ============================================================================

SELECT

tx_type,

COUNT(*) AS total_transactions,

SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_transactions,

ROUND(

100.0 *

SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END)

/

COUNT(*)

,2)

AS fraud_rate

FROM transactions

GROUP BY tx_type

ORDER BY fraud_rate DESC;



-- ============================================================================
-- KPI 4 : TOP 10 HIGHEST VALUE TRANSACTIONS
-- ============================================================================

SELECT

tx_id,

sender_account_id,

receiver_account_id,

tx_amount,

tx_type

FROM transactions

ORDER BY tx_amount DESC

LIMIT 10;



-- ============================================================================
-- KPI 5 : TOP 10 SENDER ACCOUNTS
-- ============================================================================

SELECT

sender_account_id,

COUNT(*) AS transactions,

ROUND(SUM(tx_amount),2) AS total_sent

FROM transactions

GROUP BY sender_account_id

ORDER BY total_sent DESC

LIMIT 10;



-- ============================================================================
-- KPI 6 : TOP 10 RECEIVER ACCOUNTS
-- ============================================================================

SELECT

receiver_account_id,

COUNT(*) AS transactions,

ROUND(SUM(tx_amount),2) AS total_received

FROM transactions

GROUP BY receiver_account_id

ORDER BY total_received DESC

LIMIT 10;



-- ============================================================================
-- KPI 7 : FRAUD HOTSPOTS BY COUNTRY
-- ============================================================================

SELECT

a.country,

COUNT(*) FILTER (WHERE t.is_fraud = TRUE) AS fraud_transactions,

COUNT(*) AS total_transactions,

ROUND(

100.0 *

COUNT(*) FILTER (WHERE t.is_fraud = TRUE)

/

COUNT(*)

,2)

AS fraud_rate

FROM transactions t

JOIN accounts a

ON t.sender_account_id = a.account_id

GROUP BY a.country

ORDER BY fraud_rate DESC;



-- ============================================================================
-- KPI 8 : HIGH RISK BEHAVIOUR PROFILES
-- ============================================================================

SELECT

a.tx_behavior_id,

COUNT(*) AS total_accounts,

COUNT(*) FILTER (WHERE a.is_fraud = TRUE) AS fraud_accounts,

ROUND(

100.0 *

COUNT(*) FILTER (WHERE a.is_fraud = TRUE)

/

COUNT(*)

,2)

AS fraud_rate

FROM accounts a

GROUP BY a.tx_behavior_id

ORDER BY fraud_rate DESC;



-- ============================================================================
-- KPI 9 : MOST COMMON ALERT TYPES
-- ============================================================================

SELECT

alert_type,

COUNT(*) AS total_alerts

FROM alerts

GROUP BY alert_type

ORDER BY total_alerts DESC;



-- ============================================================================
-- KPI 10 : FRAUD ALERTS BY TYPE
-- ============================================================================

SELECT

alert_type,

COUNT(*) FILTER (WHERE is_fraud = TRUE) AS fraud_alerts,

COUNT(*) AS total_alerts

FROM alerts

GROUP BY alert_type

ORDER BY fraud_alerts DESC;



-- ============================================================================
-- KPI 11 : TOP SUSPICIOUS ACCOUNTS
-- ============================================================================

SELECT

sender_account_id,

COUNT(*) FILTER (WHERE is_fraud = TRUE) AS fraud_transactions,

ROUND(SUM(tx_amount),2) AS fraud_amount

FROM transactions

WHERE is_fraud = TRUE

GROUP BY sender_account_id

ORDER BY fraud_transactions DESC

LIMIT 20;



-- ============================================================================
-- KPI 12 : LARGEST FRAUDULENT TRANSACTIONS
-- ============================================================================

SELECT

tx_id,

sender_account_id,

receiver_account_id,

tx_amount,

tx_type

FROM transactions

WHERE is_fraud = TRUE

ORDER BY tx_amount DESC

LIMIT 20;



-- ============================================================================
-- KPI 13 : TRANSACTION VALUE SUMMARY
-- ============================================================================

SELECT

ROUND(SUM(tx_amount),2) AS total_transaction_value,

ROUND(AVG(tx_amount),2) AS average_transaction_value,

ROUND(MAX(tx_amount),2) AS maximum_transaction,

ROUND(MIN(tx_amount),2) AS minimum_transaction

FROM transactions;



-- ============================================================================
-- KPI 14 : ACCOUNT SUMMARY
-- ============================================================================

SELECT

COUNT(*) AS accounts,

ROUND(AVG(init_balance),2) AS average_balance,

ROUND(SUM(init_balance),2) AS total_balance

FROM accounts;



-- ============================================================================
-- KPI 15 : PROJECT COMPLETION
-- ============================================================================

SELECT
'Banking Fraud Analytics SQL Project Completed Successfully'
AS project_status;