# Banking Fraud Analytics with PostgreSQL

## Overview

This project demonstrates an end-to-end SQL analytics workflow using the IBM Synthetic Banking Dataset. It covers database design, ETL, data validation, exploratory data analysis, fraud analysis, and advanced SQL techniques in PostgreSQL.

The project is designed to simulate a real-world banking analytics pipeline by transforming raw transactional data into a normalized relational database and generating business insights through SQL.

---

## Objectives

- Design a normalized relational database
- Build an ETL pipeline using staging tables
- Validate imported data
- Perform exploratory data analysis
- Investigate fraud patterns
- Apply advanced SQL techniques
- Generate business-ready insights

---

## Dataset

IBM Synthetic Banking Dataset

Tables used:

- Accounts
- Transactions
- Alerts

---

## Database Architecture

The project follows a two-layer architecture.

Raw CSV Files

↓

Staging Tables

↓

Production Tables

↓

SQL Analysis

The staging layer preserves raw data exactly as received, while the production layer stores cleaned and normalized data.

---

## Database Schema

### Production Tables

- accounts
- transactions
- alerts

### Staging Tables

- stg_accounts
- stg_transactions
- stg_alerts

---

## ETL Workflow

1. Import raw CSV files into staging tables.
2. Validate imported data.
3. Transform and normalize data.
4. Load production tables.
5. Perform analytical SQL.

---

## Project Structure

```text
banking-fraud-analytics/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── data/
│   ├── raw/
│   └── processed/
│
├── docs/
│   ├── business_questions.md
│   ├── data_dictionary.md
│   ├── entity_relationship_notes.md
│   └── project_plan.md
│
├── images/
│   └── ER_Diagram.png
│
├── results/
│
├── schema/
│   ├── schema.sql
│   ├── staging_schema.sql
│   ├── constraints.sql
│   └── indexes.sql
│
└── sql/
    ├── 01_load_staging.sql
    ├── 02_transform_load.sql
    ├── 03_data_validation.sql
    ├── 04_account_analysis.sql
    ├── 05_transaction_analysis.sql
    ├── 06_fraud_analysis.sql
    ├── 07_advanced_sql.sql
    └── 08_final_insights.sql
```

---

## SQL Skills Demonstrated

### Database Design

- Relational Modeling
- Normalization
- Primary Keys
- Foreign Keys
- Constraints
- Indexing

### ETL

- Staging Tables
- Data Transformation
- Data Validation
- Production Loading

### SQL

- Joins
- Aggregations
- GROUP BY
- HAVING
- CASE
- FILTER
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- Views

---

## Business Questions Answered

- Which transaction types experience the highest fraud rates?
- Which countries have the highest concentration of fraudulent activity?
- Which accounts transfer the largest transaction volumes?
- What transaction behavior profiles are associated with fraud?
- Which alert types occur most frequently?
- Which accounts are considered high risk?

---

## Tools

- PostgreSQL
- pgAdmin
- SQL
- Git
- GitHub

---

## Future Enhancements

- Power BI Dashboard
- Query Performance Optimization
- Stored Procedures
- Materialized Views
- Automated ETL Pipeline

---

## Author

**Aparajito Paul**

MBA (Marketing) | Data Analytics
