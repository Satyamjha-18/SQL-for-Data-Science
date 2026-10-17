# SQL JOINs — Complete Notes

## 1. What is a JOIN?

A JOIN in SQL is used to combine rows from two or more tables based on a related column between them.

**Why do we use JOINs?**
- To retrieve data from multiple tables.
- To connect related information.
- To generate reports and analyze data.
- To avoid storing all information in a single table.

## 2. Sample Tables

### Employees

| employee_id | employee_name | department_id |
|---:|---|---:|
| 1 | Aman | 10 |
| 2 | Priya | 20 |
| 3 | Rahul | 30 |
| 4 | Neha | NULL |

### Departments

| department_id | department_name |
|---:|---|
| 10 | IT |
| 20 | HR |
| 40 | Finance |

## 3. General JOIN Syntax

```sql
SELECT columns
FROM table1
JOIN table2
    ON table1.common_column = table2.common_column;
```

- `FROM`: Specifies the first table.
- `JOIN`: Specifies the second table.
- `ON`: Defines the matching condition.
- Table aliases such as `e` and `d` make queries easier to read.

## 4. INNER JOIN

Returns only rows that match the join condition in both tables.

```sql
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM Employees AS e
INNER JOIN Departments AS d
    ON e.department_id = d.department_id;
```

**Expected result:**

| employee_id | employee_name | department_name |
|---:|---|---|
| 1 | Aman | IT |
| 2 | Priya | HR |

**Use case:** Find employees who belong to a department present in the Departments table.

## 5. LEFT JOIN

Returns all rows from the left table and matching rows from the right table. Unmatched right-table columns contain NULL.

```sql
SELECT
    e.employee_name,
    d.department_name
FROM Employees AS e
LEFT JOIN Departments AS d
    ON e.department_id = d.department_id;
```

**Expected result:**

| employee_name | department_name |
|---|---|
| Aman | IT |
| Priya | HR |
| Rahul | NULL |
| Neha | NULL |

**Use case:** Find every employee, including those without a matching department.

## 6. RIGHT JOIN

Returns all rows from the right table and matching rows from the left table.

```sql
SELECT
    e.employee_name,
    d.department_name
FROM Employees AS e
RIGHT JOIN Departments AS d
    ON e.department_id = d.department_id;
```

**Expected result:**

| employee_name | department_name |
|---|---|
| Aman | IT |
| Priya | HR |
| NULL | Finance |

**Use case:** List every department, including departments without employees.

## 7. FULL OUTER JOIN

Returns matching rows and unmatched rows from both tables.

```sql
SELECT
    e.employee_name,
    d.department_name
FROM Employees AS e
FULL OUTER JOIN Departments AS d
    ON e.department_id = d.department_id;
```

**Note:** MySQL does not directly support `FULL OUTER JOIN`. You can emulate it with a `LEFT JOIN`, a `RIGHT JOIN`, and `UNION` or an appropriate `UNION ALL` pattern.

## 8. CROSS JOIN

Returns every possible combination of rows from both tables.

```sql
SELECT
    e.employee_name,
    d.department_name
FROM Employees AS e
CROSS JOIN Departments AS d;
```

If Employees has 4 rows and Departments has 3 rows, the result contains 4 × 3 = 12 rows.

**Use case:** Generate combinations, such as products and sizes.

## 9. SELF JOIN

A SELF JOIN joins a table with itself. Table aliases distinguish the two references.

### Example: Employees and Managers

```sql
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM Employees AS e
LEFT JOIN Employees AS m
    ON e.manager_id = m.employee_id;
```

**Use case:** Find employee-manager relationships or compare rows within the same table.

Note: This example assumes that the Employees table has a `manager_id` column.

## 10. Joining Multiple Tables

You can join more than two tables in a single query.

```sql
SELECT
    o.order_id,
    c.customer_name,
    p.product_name
FROM Orders AS o
INNER JOIN Customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN Products AS p
    ON o.product_id = p.product_id;
```

This example assumes Orders contains both `customer_id` and `product_id`.

## 11. JOIN with WHERE and ORDER BY

```sql
SELECT
    e.employee_name,
    d.department_name
FROM Employees AS e
LEFT JOIN Departments AS d
    ON e.department_id = d.department_id
WHERE e.employee_name LIKE 'A%'
ORDER BY e.employee_name;
```

`WHERE` filters the joined result, and `ORDER BY` sorts the output.

## 12. Important Differences

| JOIN type | What it returns |
|---|---|
| INNER JOIN | Matching rows only |
| LEFT JOIN | All left rows + matching right rows |
| RIGHT JOIN | All right rows + matching left rows |
| FULL OUTER JOIN | All rows from both sides |
| CROSS JOIN | Every possible combination |
| SELF JOIN | A table joined to itself |

## 13. Common Mistakes

1. Forgetting the `ON` condition in a regular INNER or OUTER JOIN.
2. Joining on unrelated columns.
3. Using ambiguous column names without table aliases.
4. Assuming every JOIN returns unique rows.
5. Ignoring duplicate keys, which may multiply result rows.
6. Using `WHERE` on a right-table column after a LEFT JOIN when unmatched left rows must be preserved.
7. Assuming MySQL supports `FULL OUTER JOIN` directly.

## 14. Practice Questions

1. Display employee names with their department names using INNER JOIN.
2. Display all employees, including those without a department.
3. Display all departments, including those without employees.
4. Find employees whose department does not exist in Departments.
5. Find departments that have no employees.
6. Join Customers and Orders to display customer names and order IDs.
7. Join Orders, Order_Items, and Products to display order details.
8. Use SELF JOIN to display employees and their managers.
9. Explain the difference between INNER JOIN and LEFT JOIN.
10. Explain why a JOIN can return more rows than either input table.

## 15. Interview Revision

- A JOIN combines related data from tables.
- `ON` specifies the join condition.
- INNER JOIN keeps matching rows.
- LEFT JOIN preserves every row from the left table.
- NULL may appear when an outer JOIN has no matching row.
- CROSS JOIN creates a Cartesian product.
- SELF JOIN uses aliases to reference the same table twice.
- Always check the relationship between join keys and the possibility of duplicate matches.

---

**Repository:** SQL_ML  
**Folder:** Joins  
**File:** joins_notes.md
