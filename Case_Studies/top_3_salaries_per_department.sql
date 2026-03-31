-- Problem: Find top 3 highest-paid employees in each department
-- Tables:
-- Employee(id, name, salary, departmentId)
-- Department(id, name)

-- Approach:
-- 1. Join Employee with Department to get department names
-- 2. Use DENSE_RANK() to rank employees based on salary within each department
-- 3. Filter top 3 ranks per department

WITH department_ranking AS (
    SELECT 
        d.name AS Department,        -- Department name
        e.name AS Employee,          -- Employee name
        e.salary AS Salary,          -- Employee salary
        
        -- Assign rank based on salary within each department
        -- Highest salary gets rank 1
        -- Same salaries get same rank (no gaps)
        DENSE_RANK() OVER (
            PARTITION BY d.name      -- Reset ranking for each department
            ORDER BY e.salary DESC   -- Highest salary first
        ) AS rn
        
    FROM Employee e
    
    -- Join to map departmentId → department name
    LEFT JOIN Department d
        ON e.departmentId = d.id
)

-- Select only top 3 salary ranks per department
SELECT 
    Department,
    Employee,
    Salary
FROM department_ranking
WHERE rn <= 3;   -- Keep only top 3 ranks
