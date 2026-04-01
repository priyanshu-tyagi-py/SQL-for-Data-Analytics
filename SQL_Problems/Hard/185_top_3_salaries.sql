-- Problem: Department Top 3 Salaries
-- Source: LeetCode
-- Difficulty: Hard

-- Business Context:
-- A company wants to identify the top 3 highest-paid employees
-- in each department for compensation analysis.

--------------------------------------------------

-- Approach: Window Function (DENSE_RANK)

-- Explanation:
-- 1. Partition employees by department
-- 2. Rank salaries in descending order within each department
-- 3. Use DENSE_RANK() to handle duplicate salaries correctly
-- 4. Filter top 3 ranks

--------------------------------------------------

SELECT Department, Employee, Salary
FROM (
    SELECT d.name AS Department,
           e.name AS Employee,
           e.salary AS Salary,
           DENSE_RANK() OVER (
               PARTITION BY d.id 
               ORDER BY e.salary DESC
           ) AS rnk
    FROM Employee e
    JOIN Department d
        ON e.departmentId = d.id
) t
WHERE rnk <= 3;

--------------------------------------------------

-- Insights:
-- DENSE_RANK() ensures that employees with the same salary
-- receive the same rank, preventing incorrect exclusions.

-- When to Use:
-- Use this pattern for "Top N per group" problems
-- (e.g., top customers, top products, top performers)
