# Day 02 - SELECT Statements

## 1. What is SELECT?

`SELECT` statement ka use database table se data retrieve (read) karne ke liye hota hai.

### Syntax

```sql
SELECT column_name
FROM table_name;

2. SELECT *: * ka matlab hota hai all columns.
SELECT *
FROM customers;

3. Selecting Specific Columns: Agar hume sirf kuch columns chahiye:

SELECT CustomerID, Name, City
FROM customers;

4. Selecting Multiple Columns: Multiple columns ko comma , se separate karte hain.

SELECT ProductID, ProductName, SellingPrice
FROM products;

5. Column Alias: Alias ka use output me column ka temporary naam change karne ke liye hota hai.

Syntax
SELECT column_name AS new_name
FROM table_name;

# Example
SELECT SellingPrice AS Price
FROM products;

6. DISTINCT: DISTINCT duplicate values ko remove karta hai.

SELECT DISTINCT City
FROM customers;

