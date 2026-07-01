/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
Database     : PostgreSQL
File         : schema.sql

Description:
Creates the core database tables for the Banking Fraud Analytics project.

This script creates:
    • accounts
    • transactions
    • alerts

Included:
    ✓ Tables
    ✓ Data Types
    ✓ Primary Keys

Not Included:
    ✗ Foreign Keys
    ✗ Check Constraints
    ✗ Indexes

These will be added separately in:
    constraints.sql
    indexes.sql
===============================================================================
*/


-- ============================================================================
-- Drop Existing Tables
-- ============================================================================

DROP TABLE IF EXISTS alerts;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;


-- ============================================================================
-- Accounts Table
-- ============================================================================

CREATE TABLE accounts (

    account_id          INTEGER PRIMARY KEY,

    customer_id         VARCHAR(20) NOT NULL,

    init_balance        NUMERIC(12,2) NOT NULL,

    country             VARCHAR(50) NOT NULL,

    account_type        VARCHAR(10) NOT NULL,

    is_fraud            BOOLEAN NOT NULL,

    tx_behavior_id      INTEGER NOT NULL

);


-- ============================================================================
-- Transactions Table
-- ============================================================================

CREATE TABLE transactions (

    tx_id                   BIGINT PRIMARY KEY,

    sender_account_id       INTEGER NOT NULL,

    receiver_account_id     INTEGER NOT NULL,

    tx_type                 VARCHAR(30) NOT NULL,

    tx_amount               NUMERIC(12,2) NOT NULL,

    time_step               INTEGER NOT NULL,

    is_fraud                BOOLEAN NOT NULL

);


-- ============================================================================
-- Alerts Table
-- ============================================================================

CREATE TABLE alerts (

    alert_id                INTEGER PRIMARY KEY,

    tx_id                   BIGINT NOT NULL UNIQUE,

    alert_type              VARCHAR(30) NOT NULL,

    is_fraud                BOOLEAN NOT NULL

);