# SQL — Business Problem Solving.

A collection of SQL queries written to solve real business problems — from tracking revenue trends and analyzing user behavior to ranking performance and segmenting data. Each query is documented with the business context it addresses, not just the technical solution.

---

## Repository Structure

```
.
├── 01_Joins/
├── 02_Aggregations/
├── 03_Window_Functions/
├── 04_Subqueries/
├── 05_Case_Statements/
└── 06_CTE/
```

| Folder | Business Use Cases |
|---|---|
| `01_Joins` | Combining data across entities — customers, orders, departments, products |
| `02_Aggregations` | Summarizing performance — totals, averages, group-level metrics |
| `03_Window_Functions` | Rankings, running totals, period-over-period comparisons |
| `04_Subqueries` | Filtered lookups, existence checks, derived business segments |
| `05_Case_Statements` | Conditional classification — tiers, labels, custom categories |
| `06_CTE` | Multi-step business logic broken into readable, maintainable steps |

---

## Documentation Approach

Every `.sql` file is self-contained and follows a consistent structure:

```sql
-- ============================================================
-- MySQL -- [Query Title]
-- ============================================================
--
-- Problem:   The business question being answered.
-- Approach:  How the query is structured to answer it.
-- Insights:  Key decisions, edge cases, and trade-offs.
-- Output:    What each returned column represents.
-- ============================================================
```

---

## Tools & Environment

- **SQL Dialect:** MySQL
- **Datasets:** Relational datasets modeled around business domains

---

## Author

**Priyanshu Tyagi**  
[GitHub](https://github.com/priyanshu-tyagi-py) · [LinkedIn](https://www.linkedin.com/in/priyanshu-tyagi8218/)
