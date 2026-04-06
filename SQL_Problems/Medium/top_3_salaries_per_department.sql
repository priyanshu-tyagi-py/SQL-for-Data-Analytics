-- Problem:
-- Find the top 3 highest-paid employees in each department.
-- Include ties (same salary → same rank).

-- Approach:
-- 1. Join Employee and Department tables.
-- 2. Use DENSE_RANK() partitioned by department, ordered by salary DESC.
-- 3. Filter ranks <= 3.

-- Insights:
-- - DENSE_RANK avoids gaps in ranking when salaries tie.
-- - Window functions enable per-group ranking without aggregation.

WITH department_ranking AS (
    SELECT 
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (
            PARTITION BY d.name
            ORDER BY e.salary DESC
        ) AS rn
    FROM Employee e
    LEFT JOIN Department d
        ON e.departmentId = d.id
)

SELECT Department, Employee, Salary
FROM department_ranking
WHERE rn <= 3;
