WITH transaction_counts AS (
    SELECT owner_id, DATE_TRUNC('month', transaction_date) AS month, COUNT(*) AS txn_per_month
    FROM savings_savingsaccount GROUP BY owner_id, DATE_TRUNC('month', transaction_date)
),
monthly_avg AS (
    SELECT owner_id, AVG(txn_per_month) AS avg_txn
    FROM transaction_counts GROUP BY owner_id
),
categorized AS (
    SELECT
        CASE
            WHEN avg_txn >= 10 THEN 'High Frequency'
            WHEN avg_txn BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txn
    FROM monthly_avg
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category;
