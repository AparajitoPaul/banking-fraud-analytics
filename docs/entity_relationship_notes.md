# Entity Relationship Notes

## Entities

The project contains three primary entities:

- Accounts
- Transactions
- Alerts

---

## Accounts

Stores master information for each bank account.

Primary Key:
- ACCOUNT_ID

---

## Transactions

Stores all financial transactions between accounts.

Primary Key:
- TX_ID

Foreign Keys:
- SENDER_ACCOUNT_ID → Accounts.ACCOUNT_ID
- RECEIVER_ACCOUNT_ID → Accounts.ACCOUNT_ID

Each transaction has one sender and one receiver.

---

## Alerts

Stores fraud alerts generated for suspicious transactions.

Primary Key:
- ALERT_ID

Foreign Key:
- TX_ID → Transactions.TX_ID

A transaction may generate zero or one fraud alert.

---

## Database Design Decisions

The raw alerts dataset duplicates several transaction attributes, including:

- Sender Account
- Receiver Account
- Transaction Amount
- Transaction Type
- Timestamp

These duplicated attributes will not be stored in the PostgreSQL alerts table.

Instead, they will be retrieved by joining the Alerts and Transactions tables.

This design reduces redundancy and improves database normalization.

---

## Planned Relationships

Accounts (1) ----< Transactions >---- (1) Accounts

Transactions (1) ---- (0..1) Alerts