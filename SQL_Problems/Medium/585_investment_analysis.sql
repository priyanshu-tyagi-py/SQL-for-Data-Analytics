-- Problem: Investments in 2016
-- Source: LeetCode
-- Difficulty: Medium

-- Business Context:
-- An insurance company wants to calculate the total investment value (tiv_2016)
-- for policyholders who:
-- 1. Have the same tiv_2015 value as at least one other policyholder (duplicate values)
-- 2. Are located in a unique location (no other policyholder shares the same lat, lon)

--------------------------------------------------

-- Approach: Window Functions

-- Explanation:
-- 1. Use COUNT() OVER (PARTITION BY tiv_2015) to identify duplicate tiv_2015 values
-- 2. Use COUNT() OVER (PARTITION BY lat, lon) to identify unique locations
-- 3. Filter:
--      - tiv2015_count > 1 → keep duplicates
--      - location_count = 1 → keep unique locations
-- 4. Sum tiv_2016 and round to 2 decimal places

--------------------------------------------------

SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM (
    SELECT *,
        COUNT(*) OVER (PARTITION BY tiv_2015) AS tiv2015_count,
        COUNT(*) OVER (PARTITION BY lat, lon) AS location_count
    FROM Insurance
) t
WHERE tiv2015_count > 1
  AND location_count = 1;

--------------------------------------------------

-- Key Insight:
-- Window functions allow us to compute group-level information (counts)
-- without collapsing rows, avoiding the need for multiple GROUP BY and JOIN operations.
