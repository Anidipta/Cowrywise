WITH transactions AS (
    SELECT owner_id,COUNT(*) AS total_transactions, SUM(confirmed_amount) AS total_amount
    FROM savings_savingsaccount GROUP BY owner_id
),
tenure AS (
    SELECT id AS customer_id, name, DATE_PART('month', AGE(CURRENT_DATE, date_joined)) AS tenure_months FROM users_customuser
),
combined AS (
    SELECT
    t.owner_id AS customer_id, u.name, u.tenure_months, t.total_transactions,
    ROUND((t.total_amount / t.total_transactions) / 100.0, 2) AS avg_profit_per_transaction
    FROM transactions t JOIN tenure u ON u.customer_id = t.owner_id
)
SELECT customer_id, name, tenure_months, total_transactions,
ROUND((total_transactions::decimal / NULLIF(tenure_months, 0)) * 12 * avg_profit_per_transaction * 0.001, 2) AS estimated_clv
FROM combined ORDER BY estimated_clv DESC;