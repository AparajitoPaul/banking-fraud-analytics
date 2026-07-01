/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
Database     : PostgreSQL
File         : staging_schema.sql

Description:
Creates staging tables used to import raw CSV files exactly as received.

These tables mirror the source files and contain:
    ✓ Original column names
    ✓ Original data types
    ✓ No primary keys
    ✓ No foreign keys
    ✓ No constraints

The staging layer acts as a temporary landing area before data is
transformed and loaded into the production tables.
===============================================================================
*/


-- ============================================================================
-- Drop Existing Staging Tables
-- ============================================================================

DROP TABLE IF EXISTS stg_alerts;
DROP TABLE IF EXISTS stg_transactions;
DROP TABLE IF EXISTS stg_accounts;


-- ============================================================================
-- Staging Accounts
-- ============================================================================

CREATE TABLE stg_accounts (

    account_id          INTEGER,

    customer_id         VARCHAR(20),

    init_balance        NUMERIC(12,2),

    country             VARCHAR(50),

    account_type        VARCHAR(10),

    is_fraud            BOOLEAN,

    tx_behavior_id      INTEGER

);


-- ============================================================================
-- Staging Transactions
-- ============================================================================

CREATE TABLE stg_transactions (

    tx_id                   BIGINT,

    sender_account_id       INTEGER,

    receiver_account_id     INTEGER,

    tx_type                 VARCHAR(30),

    tx_amount               NUMERIC(12,2),

    timestamp               INTEGER,

    is_fraud                BOOLEAN,

    alert_id                INTEGER

);


-- ============================================================================
-- Staging Alerts
-- ============================================================================

CREATE TABLE stg_alerts (

    alert_id                INTEGER,

    alert_type              VARCHAR(30),

    is_fraud                BOOLEAN,

    tx_id                   BIGINT,

    sender_account_id       INTEGER,

    receiver_account_id     INTEGER,

    tx_type                 VARCHAR(30),

    tx_amount               NUMERIC(12,2),

    timestamp               INTEGER

);