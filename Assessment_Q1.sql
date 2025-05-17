SELECT
    u.id AS owner_id, u.name,
    COUNT(DISTINCT s.id) AS savings_count, COUNT(DISTINCT p.id) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100.0, 2) AS total_deposits
FROM users_customuser u
JOIN savings_savingsaccount s ON s.owner_id = u.id AND s.confirmed_amount > 0
JOIN plans_plan p ON p.owner_id = u.id AND p.is_a_fund = 1 AND p.confirmed_amount > 0
WHERE s.is_regular_savings = 1 GROUP BY u.id, u.name
HAVING COUNT(DISTINCT s.id) >= 1 AND COUNT(DISTINCT p.id) >= 1
ORDER BY total_deposits DESC;