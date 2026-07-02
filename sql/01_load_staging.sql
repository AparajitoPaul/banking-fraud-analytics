/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
File         : 01_load_staging.sql

Description:
This script documents the loading of raw CSV files into staging tables.

Files Loaded:

1. accounts.csv      -> stg_accounts
2. transactions.csv  -> stg_transactions
3. alerts.csv        -> stg_alerts

Data was imported using the pgAdmin Import/Export Wizard.

===============================================================================
*/

-- ============================================================================
-- Verify Row Counts
-- ============================================================================

SELECT COUNT(*) AS accounts_loaded
FROM stg_accounts;

SELECT COUNT(*) AS transactions_loaded
FROM stg_transactions;

SELECT COUNT(*) AS alerts_loaded
FROM stg_alerts;