-- Problem: Restaurant Growth
-- Source: LeetCode
-- Difficulty: Medium
-- Business Context:
-- A restaurant wants to analyze its revenue growth over time.
-- For each day (starting from the 7th day onward), calculate the total amount
-- and average amount spent by customers over the past 7 days (sliding window),
-- to help identify revenue trends and growth patterns.
--------------------------------------------------
-- Approach: CTE + Sliding Window Functions
-- Explanation:
-- 1. CTE (Daily): Aggregate total amount per day, since multiple customers
--    can visit on the same date
-- 2. Use SUM() OVER with ROWS BETWEEN 6 PRECEDING AND CURRENT ROW to compute
--    the 7-day rolling total
-- 3. Use AVG() OVER with the same frame to compute the 7-day rolling average,
--    rounded to 2 decimal places
-- 4. Filter: exclude rows where we don't yet have a full 7-day window,
--    by only keeping dates >= (MIN(visited_on) + 6 days)
--------------------------------------------------
WITH Daily AS (
    SELECT visited_on,
        SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
)
SELECT visited_on, amount, average_amount
FROM (
    SELECT visited_on,
        SUM(amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        ROUND(AVG(amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 2) AS average_amount
    FROM Daily
) AS windowed
WHERE visited_on >= (SELECT MIN(visited_on) FROM Customer) + INTERVAL 6 DAY
ORDER BY visited_on ASC;
--------------------------------------------------
-- Insights:
-- The CTE is necessary to collapse multiple customer visits on the same day
-- before applying the sliding window — otherwise the window frame would count
-- individual transactions instead of daily totals.
-- ROWS BETWEEN 6 PRECEDING AND CURRENT ROW defines a 7-day window (6 + current).
-- The WHERE filter ensures we only return complete 7-day windows,
-- avoiding partial averages at the start of the dataset.
