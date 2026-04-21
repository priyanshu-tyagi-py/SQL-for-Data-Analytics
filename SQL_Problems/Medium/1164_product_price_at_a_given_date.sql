-- Problem: Product Price at a Given Date
-- Source: LeetCode
-- Difficulty: Medium
-- Business Context:
-- A retail company wants to know the price of every product as of 2019-08-16.
-- Prices change over time, so the goal is to find the most recent price
-- change on or before that date. If a product has never been updated
-- by that date, its default price is 10.
--------------------------------------------------
-- Approach: CTE with ROW_NUMBER() + LEFT JOIN + COALESCE
-- Explanation:
-- 1. CTE (ranked): Filter all price changes on or before '2019-08-16',
--    then use ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY change_date DESC)
--    to rank each product's changes — rn = 1 gives the most recent change
-- 2. SELECT DISTINCT product_id from the full Products table to ensure
--    all products are included, even those with no changes by the target date
-- 3. LEFT JOIN the ranked CTE on product_id where rn = 1 to bring in
--    the most recent price for each product
-- 4. COALESCE(r.new_price, 10) handles products with no price changes
--    by that date, defaulting them to 10
--------------------------------------------------
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY change_date DESC
        ) AS rn
    FROM Products
    WHERE change_date <= '2019-08-16'
)
SELECT
    p.product_id,
    COALESCE(r.new_price, 10) AS price
FROM (SELECT DISTINCT product_id FROM Products) p
LEFT JOIN ranked r
    ON p.product_id = r.product_id
    AND r.rn = 1;
--------------------------------------------------
-- Insights:
-- ROW_NUMBER() is preferred over RANK() here because we want exactly
-- one row per product — ties on change_date are broken arbitrarily,
-- but the schema guarantees (product_id, change_date) is unique.
-- The DISTINCT subquery on Products is necessary to get all products
-- regardless of whether they appear in the filtered CTE.
-- COALESCE elegantly handles the default price of 10 without needing
-- a separate UNION branch for products with no prior changes.
