-- Problem:
-- Find users whose total transaction amount exceeds 10,000

-- Approach:
-- Join Users with Transactions using account number
-- Calculate total using SUM()
-- Filter using HAVING

SELECT 
    u.name, 
    SUM(t.amount) AS balance
FROM Users u
LEFT JOIN Transactions t
    ON u.account = t.account 
GROUP BY u.name
HAVING SUM(t.amount) > 10000;
