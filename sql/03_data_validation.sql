/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
File         : 03_data_validation.sql

Description:
Validates that data has been successfully loaded into the production tables.
===============================================================================
*/


-- ============================================================================
-- Row Count Validation
-- ============================================================================
SELECT COUNT(*) AS accounts
FROM accounts;

SELECT COUNT(*) AS transactions
FROM transactions;

SELECT COUNT(*) AS alerts
FROM alerts;

-- ============================================================================
-- Staging Vs. Production Comparison
-- ============================================================================
SELECT
    (SELECT COUNT(*) FROM stg_accounts) AS staging_accounts,
    (SELECT COUNT(*) FROM accounts) AS production_accounts;


SELECT
    (SELECT COUNT(*) FROM stg_alerts) AS staging_alerts,
    (SELECT COUNT(*) FROM alerts) AS production_alerts;

SELECT
    (SELECT COUNT(*) FROM stg_transactions) AS staging_transactions,
    (SELECT COUNT(*) FROM transactions) AS production_transactions;

-- ============================================================================
-- Duplicate Check
-- ============================================================================
-- Accounts
SELECT
account_id,
COUNT(*)
FROM accounts
GROUP BY account_id
HAVING COUNT(*)>1;

-- Transactions
SELECT
tx_id,
COUNT(*)
FROM transactions
GROUP BY tx_id
HAVING COUNT(*)>1;

-- Alerts
SELECT
tx_id,
COUNT(*)
FROM alerts
GROUP BY tx_id
HAVING COUNT(*)>1;


-- ============================================================================
-- Null Check
-- ============================================================================
-- Accounts
SELECT *
FROM accounts
WHERE
account_id IS NULL
OR customer_id IS NULL
OR init_balance IS NULL
OR country IS NULL
OR account_type IS NULL
OR is_fraud IS NULL
OR tx_behavior_id IS NULL;

-- Transactions
SELECT *
FROM transactions
WHERE
tx_id IS NULL
OR sender_account_id IS NULL
OR receiver_account_id IS NULL
OR tx_type IS NULL
OR tx_amount IS NULL
OR time_step IS NULL
OR is_fraud IS NULL;

-- Alerts
SELECT *
FROM alerts
WHERE
tx_id IS NULL
OR alert_id IS NULL
OR alert_type IS NULL
OR is_fraud IS NULL;

-- ============================================================================
-- Foreign Key Validation
-- ============================================================================
-- Sender Accounts
SELECT COUNT(*) AS invalid_sender_accounts
FROM transactions t
LEFT JOIN accounts a
ON t.sender_account_id = a.account_id
WHERE a.account_id IS NULL;

-- Reciever Accounts
SELECT COUNT(*) AS invalid_receiver_accounts
FROM transactions t
LEFT JOIN accounts a
ON t.receiver_account_id = a.account_id
WHERE a.account_id IS NULL;

-- Alerts
SELECT COUNT(*) AS invalid_alert_transactions
FROM alerts a
LEFT JOIN transactions t
ON a.tx_id = t.tx_id
WHERE t.tx_id IS NULL;

-- ============================================================================
-- Business Rule Validation
-- ============================================================================
-- Negative balances
SELECT *
FROM accounts
WHERE init_balance < 0;

-- Negative transactions
SELECT *
FROM transactions
WHERE tx_amount < 0;

-- Fraud summary
SELECT
is_fraud,
COUNT(*)
FROM transactions
GROUP BY is_fraud;

-- ============================================================================
-- Final Validation Query
-- ============================================================================
SELECT

(SELECT COUNT(*) FROM accounts) Accounts,

(SELECT COUNT(*) FROM transactions) Transactions,

(SELECT COUNT(*) FROM alerts) Alerts;