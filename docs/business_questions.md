# Business Questions

## Project Objective

The objective of this project is to analyze banking transactions and fraud alerts to understand customer transaction behavior, identify suspicious activities, and generate actionable business insights using PostgreSQL.

---

# 1. Account Analysis

### 1.1 Account Distribution

- How many bank accounts are present in the dataset?
- What is the distribution of accounts across different countries?
- What percentage of accounts belong to each account type?
- What is the average initial balance by account type?
- Which countries have the highest average account balance?
- What is the distribution of fraudulent and non-fraudulent accounts?
- Which transaction behavior profiles are most common?

---

# 2. Transaction Analysis

### 2.1 Transaction Overview

- How many transactions were processed?
- What is the total transaction value?
- What is the average transaction amount?
- What is the minimum and maximum transaction amount?
- How many transactions occur for each transaction type?

### 2.2 Transaction Trends

- How does transaction volume change over time?
- What are the busiest transaction periods?
- What is the daily transaction value?
- What is the monthly transaction value?

### 2.3 Account Activity

- Which accounts send the most transactions?
- Which accounts receive the most transactions?
- Which accounts transfer the highest monetary value?
- Which accounts receive the highest monetary value?
- Which sender-receiver pairs transact most frequently?

---

# 3. Fraud Analysis

### 3.1 Fraud Overview

- How many fraudulent transactions exist?
- What percentage of transactions are fraudulent?
- What percentage of accounts are flagged as fraudulent?
- How many fraud alerts were generated?

### 3.2 Fraud by Transaction

- Which transaction types have the highest fraud rate?
- What is the average amount of fraudulent transactions?
- What is the largest fraudulent transaction?
- Do fraudulent transactions generally involve higher transaction values?

### 3.3 Fraud by Account

- Which accounts appear most frequently in fraudulent transactions?
- Which accounts have generated multiple fraud alerts?
- Which accounts have both fraudulent transactions and fraud flags?

### 3.4 Fraud by Country

- Which countries have the highest number of fraudulent accounts?
- Which countries generate the highest fraud transaction volume?

---

# 4. Alert Analysis

### 4.1 Alert Overview

- How many alerts exist for each alert type?
- Which alert type occurs most frequently?
- What percentage of alerts correspond to confirmed fraud?

### 4.2 Alert Investigation

- Which transactions generated alerts?
- Which accounts generate repeated alerts?
- Are certain transaction types more likely to trigger alerts?
- What is the average transaction amount for each alert type?

---

# 5. Customer & Account Behaviour

- Which accounts are the most active?
- Which accounts have unusually high transaction volumes?
- Which accounts transfer unusually large amounts?
- Which transaction behavior profiles correspond to higher fraud rates?
- Are fraudulent accounts associated with specific account types?

---

# 6. Advanced SQL Analysis

The following analyses will be implemented using advanced PostgreSQL features.

## Window Functions

- Rank accounts by total transaction value.
- Rank countries by fraud rate.
- Calculate running transaction totals.
- Identify the top 10 highest-value transactions.
- Calculate moving averages of transaction amounts.

## Common Table Expressions (CTEs)

- Identify high-risk accounts.
- Detect repeated fraud patterns.
- Summarize fraud statistics by country.
- Build reusable analytical queries.

## Views

- Create an Active Transactions View.
- Create a Fraud Transactions View.
- Create an Account Summary View.

---

# 7. Performance Optimization

- Which queries require indexing?
- How does query performance improve after indexing?
- Compare execution plans using EXPLAIN ANALYZE.

---

# Expected Deliverables

By answering these questions, the project will provide:

- Account-level insights
- Transaction behavior analysis
- Fraud detection insights
- Alert investigation reports
- Business-focused SQL analyses
- Optimized PostgreSQL queries