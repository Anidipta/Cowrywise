WITH latest_txn AS (
    SELECT
        id,
        owner_id,
        'Savings' AS type,
        MAX(transaction_date) AS last_transaction_date
    FROM savings_savingsaccount
    GROUP BY id, owner_id

    UNION ALL

    SELECT
        id,
        owner_id,
        'Investment' AS type,
        MAX(transaction_date) AS last_transaction_date
    FROM plans_plan
    GROUP BY id, owner_id
)
SELECT
    id AS plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATE_PART('day', CURRENT_DATE - last_transaction_date) AS inactivity_days
FROM latest_txn
WHERE last_transaction_date < CURRENT_DATE - INTERVAL '365 days'
ORDER BY inactivity_days DESC;
