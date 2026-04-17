-- Problem: Customers Who Bought All Products
-- Source: LeetCode
-- Difficulty: Medium
-- Business Context:
-- A retail company wants to identify loyal customers who have purchased
-- every single product in the product catalog.
-- This can be used for reward programs, segmentation, or targeted marketing.
--------------------------------------------------
-- Approach: GROUP BY + HAVING with COUNT(DISTINCT)
-- Explanation:
-- 1. Group purchases by customer_id
-- 2. Use COUNT(DISTINCT product_key) to count unique products each customer bought
-- 3. Use a subquery to get the total number of products in the Product table
-- 4. Filter: only keep customers where their distinct product count matches the total
--------------------------------------------------
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);
--------------------------------------------------
-- Insights:
-- COUNT(DISTINCT) is critical here — without it, duplicate purchases
-- would inflate the count, leading to false positives.
-- This approach avoids a cross join by comparing counts instead of
-- generating every (customer, product) combination explicitly.
-- Semicolons terminate the full query and must never appear inside subquery parentheses.
