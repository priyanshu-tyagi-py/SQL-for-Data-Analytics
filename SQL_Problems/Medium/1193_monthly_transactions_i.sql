-- Problem: Monthly Transactions I
-- Source: LeetCode
-- Difficulty: Medium
-- Business Context:
-- A finance team wants a monthly breakdown of transactions per country,
-- showing both overall transaction stats and approved-only stats side by side.
-- This helps monitor approval rates and revenue across different regions over time.
--------------------------------------------------
-- Approach: GROUP BY with Conditional Aggregation
-- Explanation:
-- 1. TO_CHAR(trans_date, 'YYYY-MM') extracts the year-month from the date
--    to group transactions by month
-- 2. GROUP BY month and country to get per-region, per-month aggregates
-- 3. COUNT(*) counts all transactions regardless of state
-- 4. COUNT(CASE WHEN state = 'approved' THEN 1 END) counts only approved
--    transactions — NULLs from non-approved rows are not counted
-- 5. SUM(amount) totals all transaction amounts
-- 6. SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) totals
--    only approved transaction amounts
--------------------------------------------------
SELECT
    TO_CHAR(trans_date, 'YYYY-MM') AS month,
    country,
    COUNT(*) AS trans_count,
    COUNT(CASE WHEN state = 'approved' THEN 1 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country;
--------------------------------------------------
-- Insights:
-- Conditional aggregation with CASE WHEN inside COUNT/SUM is a clean
-- alternative to filtering with WHERE, as it lets us compute both
-- total and approved stats in a single pass over the data.
-- COUNT(CASE WHEN ...) naturally returns 0 for no matches since NULLs
-- are ignored, so no COALESCE is needed.
-- TO_CHAR is PostgreSQL-specific — use DATE_FORMAT in MySQL.
