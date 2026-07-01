/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
File         : indexes.sql
Description  : Creates indexes to improve query performance.
===============================================================================
*/

-- ============================================================================
-- Accounts
-- ============================================================================

CREATE INDEX idx_accounts_customer
ON accounts(customer_id);

CREATE INDEX idx_accounts_country
ON accounts(country);

-- ============================================================================
-- Transactions
-- ============================================================================

CREATE INDEX idx_transactions_sender
ON transactions(sender_account_id);

CREATE INDEX idx_transactions_receiver
ON transactions(receiver_account_id);

CREATE INDEX idx_transactions_type
ON transactions(tx_type);

CREATE INDEX idx_transactions_fraud
ON transactions(is_fraud);

-- ============================================================================
-- Alerts
-- ============================================================================

CREATE INDEX idx_alerts_type
ON alerts(alert_type);

CREATE INDEX idx_alerts_fraud
ON alerts(is_fraud);