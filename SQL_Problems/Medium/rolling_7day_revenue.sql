-- ============================================================
-- MySQL -- 7-Day Rolling Revenue & Average for Business Reporting
-- ============================================================
--
-- Problem:
--   The business wants to track weekly spending trends without
--   waiting for a calendar week to end. Leadership needs a
--   rolling 7-day window of total revenue and daily average
--   to spot momentum shifts, dips, and growth patterns in
--   real time.
--
-- Approach:
--   1. CTE (Daily): Collapse multiple customer transactions
--      on the same date into a single daily total.
--   2. Window functions compute a 7-day rolling SUM and AVG
--      over the daily totals, looking back 6 rows + current.
--   3. Filter out the first 6 days — they don't yet have a
--      full 7-day window behind them, making their averages
--      misleading for trend analysis.
--   4. Order chronologically for time-series reporting.
--
-- Insights:
--   - ROWS BETWEEN 6 PRECEDING AND CURRENT ROW is date-safe
--     only because the CTE guarantees one row per date.
--     Gaps in dates (no customers on a day) would silently
--     shrink the window — consider a calendar table if gaps
--     are possible.
--   - AVG is computed over daily totals (post-aggregation),
--     not over individual transactions — this gives average
--     revenue per day, not per visit.
--   - The WHERE filter uses MIN(visited_on) + INTERVAL 6 DAY
--     instead of hardcoding a date, keeping the query correct
--     regardless of when the data starts.
--   - Rolling metrics are preferred over weekly snapshots in
--     dashboards because they update daily and smooth out
--     weekend/weekday noise.
--
-- Output:
--   visited_on       -- The current date of the window
--   amount           -- Total revenue over the last 7 days
--   average_amount   -- Average daily revenue over the last 7 days
-- ============================================================

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
