/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
File         : 02_transform_load.sql

Description:
Transforms raw staging data and loads it into the normalized production tables.

Transformation Rules

• timestamp      → time_step
• Ignore ALERT_ID from stg_transactions
• Remove duplicate transaction information from alerts

===============================================================================
*/

-- ============================================================================
-- Load Accounts
-- ============================================================================

INSERT INTO accounts (

    account_id,
    customer_id,
    init_balance,
    country,
    account_type,
    is_fraud,
    tx_behavior_id

)

SELECT

    account_id,
    customer_id,
    init_balance,
    country,
    account_type,
    is_fraud,
    tx_behavior_id

FROM stg_accounts;

-- ============================================================================
-- Load Transactions
-- ============================================================================

INSERT INTO transactions (

    tx_id,
    sender_account_id,
    receiver_account_id,
    tx_type,
    tx_amount,
    time_step,
    is_fraud

)

SELECT

    tx_id,
    sender_account_id,
    receiver_account_id,
    tx_type,
    tx_amount,
    timestamp AS time_step,
    is_fraud

FROM stg_transactions;

-- ============================================================================
-- Load Alerts
-- ============================================================================

INSERT INTO alerts (

    alert_id,
    tx_id,
    alert_type,
    is_fraud

)

SELECT

    alert_id,
    tx_id,
    alert_type,
    is_fraud

FROM stg_alerts;

