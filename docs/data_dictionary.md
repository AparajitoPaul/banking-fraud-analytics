# Data Dictionary

## accounts.csv

| Column | Data Type | Description |
|---------|-----------|-------------|
| ACCOUNT_ID | BIGINT | Unique account identifier |
| CUSTOMER_ID | BIGINT | Customer identifier |
| INIT_BALANCE | DECIMAL | Initial account balance |
| COUNTRY | VARCHAR | Country where the account is registered |
| ACCOUNT_TYPE | VARCHAR | Type of account |
| IS_FRAUD | BOOLEAN | Indicates whether the account has been associated with fraudulent activity |
| TX_BEHAVIOR_ID | INTEGER | Transaction behavior profile identifier |

---

## transactions.csv

| Column | Data Type | Description |
|---------|-----------|-------------|
| TX_ID | BIGINT | Unique transaction identifier |
| SENDER_ACCOUNT_ID | BIGINT | Sender account |
| RECEIVER_ACCOUNT_ID | BIGINT | Receiver account |
| TX_TYPE | VARCHAR | Transaction type |
| TX_AMOUNT | DECIMAL | Transaction amount |
| TIMESTAMP | TIMESTAMP | Date and time of transaction |
| IS_FRAUD | BOOLEAN | Fraud indicator |
| ALERT_ID | BIGINT | Associated fraud alert identifier |

---

## alerts.csv

| Column | Data Type | Description |
|---------|-----------|-------------|
| ALERT_ID | BIGINT | Unique fraud alert identifier |
| ALERT_TYPE | VARCHAR | Type of fraud alert |
| IS_FRAUD | BOOLEAN | Fraud confirmation flag |
| TX_ID | BIGINT | Related transaction |
| SENDER_ACCOUNT_ID | BIGINT | Sender account |
| RECEIVER_ACCOUNT_ID | BIGINT | Receiver account |
| TX_TYPE | VARCHAR | Transaction type |
| TX_AMOUNT | DECIMAL | Transaction amount |
| TIMESTAMP | TIMESTAMP | Transaction timestamp |