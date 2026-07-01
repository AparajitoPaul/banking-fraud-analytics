/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
Database     : PostgreSQL
File         : constraints.sql

Description:
Adds foreign key and check constraints to the Banking Fraud Analytics database.
===============================================================================
*/

-- ============================================================================
-- Foreign Keys
-- ============================================================================

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_sender_account
FOREIGN KEY (sender_account_id)
REFERENCES accounts(account_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_receiver_account
FOREIGN KEY (receiver_account_id)
REFERENCES accounts(account_id);

ALTER TABLE alerts
ADD CONSTRAINT fk_alerts_transaction
FOREIGN KEY (tx_id)
REFERENCES transactions(tx_id);

-- ============================================================================
-- Check Constraints
-- ============================================================================

ALTER TABLE accounts
ADD CONSTRAINT chk_accounts_initial_balance
CHECK (init_balance >= 0);

ALTER TABLE transactions
ADD CONSTRAINT chk_transactions_amount
CHECK (tx_amount > 0);