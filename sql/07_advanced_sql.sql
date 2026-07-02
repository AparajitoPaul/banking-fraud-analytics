/*
===============================================================================
Project      : Banking Fraud Analytics
Author       : Aparajito Paul
Database     : PostgreSQL
File         : 07_advanced_sql.sql

Description:
Advanced SQL analysis using CTEs, Window Functions,
Ranking Functions and Analytical Queries.

===============================================================================
*/


-- ============================================================================
-- SECTION 1 : TOP 10 LARGEST TRANSACTIONS USING ROW_NUMBER()
-- ============================================================================

WITH ranked_transactions AS (

SELECT

tx_id,

sender_account_id,

receiver_account_id,

tx_amount,

ROW_NUMBER() OVER(ORDER BY tx_amount DESC) AS row_num

FROM transactions

)

SELECT *

FROM ranked_transactions

WHERE row_num <= 10;



-- ============================================================================
-- SECTION 2 : RANK TRANSACTIONS
-- ============================================================================

SELECT

tx_id,

tx_amount,

RANK() OVER(ORDER BY tx_amount DESC) AS transaction_rank

FROM transactions;



-- ============================================================================
-- SECTION 3 : DENSE RANK
-- ============================================================================

SELECT

tx_id,

tx_amount,

DENSE_RANK() OVER(ORDER BY tx_amount DESC) AS dense_rank

FROM transactions;



-- ============================================================================
-- SECTION 4 : TOP TRANSACTION OF EACH TRANSACTION TYPE
-- ============================================================================

WITH ranked AS (

SELECT

tx_type,

tx_id,

tx_amount,

ROW_NUMBER() OVER(

PARTITION BY tx_type

ORDER BY tx_amount DESC

) AS rn

FROM transactions

)

SELECT *

FROM ranked

WHERE rn=1;



-- ============================================================================
-- SECTION 5 : RUNNING TOTAL OF TRANSACTION VALUE
-- ============================================================================

SELECT

time_step,

tx_amount,

SUM(tx_amount) OVER(

ORDER BY time_step

) AS running_total

FROM transactions

ORDER BY time_step;



-- ============================================================================
-- SECTION 6 : MOVING AVERAGE
-- ============================================================================

SELECT

time_step,

tx_amount,

ROUND(

AVG(tx_amount)

OVER(

ORDER BY time_step

ROWS BETWEEN 4 PRECEDING

AND CURRENT ROW

),2)

AS moving_average

FROM transactions;



-- ============================================================================
-- SECTION 7 : PREVIOUS TRANSACTION AMOUNT
-- ============================================================================

SELECT

tx_id,

sender_account_id,

tx_amount,

LAG(tx_amount)

OVER(

PARTITION BY sender_account_id

ORDER BY time_step

)

AS previous_transaction

FROM transactions;



-- ============================================================================
-- SECTION 8 : NEXT TRANSACTION
-- ============================================================================

SELECT

tx_id,

sender_account_id,

tx_amount,

LEAD(tx_amount)

OVER(

PARTITION BY sender_account_id

ORDER BY time_step

)

AS next_transaction

FROM transactions;



-- ============================================================================
-- SECTION 9 : DIFFERENCE FROM PREVIOUS TRANSACTION
-- ============================================================================

SELECT

tx_id,

sender_account_id,

tx_amount,

tx_amount -

LAG(tx_amount)

OVER(

PARTITION BY sender_account_id

ORDER BY time_step

)

AS difference

FROM transactions;



-- ============================================================================
-- SECTION 10 : TOP 5 SENDERS PER COUNTRY
-- ============================================================================

WITH ranked_sender AS (

SELECT

a.country,

t.sender_account_id,

SUM(t.tx_amount) AS total_sent,

ROW_NUMBER()

OVER(

PARTITION BY a.country

ORDER BY SUM(t.tx_amount) DESC

)

AS rn

FROM transactions t

JOIN accounts a

ON t.sender_account_id=a.account_id

GROUP BY

a.country,

t.sender_account_id

)

SELECT *

FROM ranked_sender

WHERE rn<=5;



-- ============================================================================
-- SECTION 11 : NTILE()
-- ============================================================================

SELECT

tx_id,

tx_amount,

NTILE(4)

OVER(

ORDER BY tx_amount

)

AS transaction_quartile

FROM transactions;



-- ============================================================================
-- SECTION 12 : CUMULATIVE FRAUD COUNT
-- ============================================================================

SELECT

time_step,

SUM(

CASE

WHEN is_fraud

THEN 1

ELSE 0

END

)

OVER(

ORDER BY time_step

)

AS cumulative_fraud

FROM transactions;



-- ============================================================================
-- SECTION 13 : TOP ACCOUNTS BY TOTAL TRANSACTION VALUE
-- ============================================================================

WITH account_volume AS (

SELECT

sender_account_id,

SUM(tx_amount) AS total_amount

FROM transactions

GROUP BY sender_account_id

)

SELECT *

FROM account_volume

ORDER BY total_amount DESC

LIMIT 20;



-- ============================================================================
-- SECTION 14 : COUNTRY FRAUD RANKING
-- ============================================================================

WITH fraud_country AS (

SELECT

a.country,

COUNT(*) AS fraud_transactions

FROM transactions t

JOIN accounts a

ON t.sender_account_id=a.account_id

WHERE t.is_fraud=TRUE

GROUP BY a.country

)

SELECT

*,

RANK()

OVER(

ORDER BY fraud_transactions DESC

)

AS fraud_rank

FROM fraud_country;



-- ============================================================================
-- SECTION 15 : VIEW CREATION
-- ============================================================================

CREATE OR REPLACE VIEW vw_transaction_summary AS

SELECT

a.country,

t.tx_type,

COUNT(*) AS total_transactions,

ROUND(SUM(tx_amount),2) AS total_amount

FROM transactions t

JOIN accounts a

ON t.sender_account_id=a.account_id

GROUP BY

a.country,

t.tx_type;



SELECT *

FROM vw_transaction_summary

ORDER BY total_amount DESC;



-- ============================================================================
-- SECTION 16 : FRAUD ALERT SUMMARY VIEW
-- ============================================================================

CREATE OR REPLACE VIEW vw_fraud_alerts AS

SELECT

a.alert_type,

COUNT(*) AS alerts,

ROUND(AVG(t.tx_amount),2) AS average_amount

FROM alerts a

JOIN transactions t

ON a.tx_id=t.tx_id

GROUP BY a.alert_type;



SELECT *

FROM vw_fraud_alerts;



