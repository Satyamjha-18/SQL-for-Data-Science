# Day 02 - SELECT Statements

# SQL SELECT Statements

## 1. Introduction

The `SELECT` statement is used to retrieve data from one or more tables in a database.

It is one of the most commonly used SQL statements in Data Science and Data Analytics.

### Basic Syntax

SELECT column1, column2
FROM table_name;

---

## 2. SELECT All Columns

To retrieve all columns from a table, use `*`.

### Syntax

SELECT *
FROM table_name;

### Example

SELECT *
FROM customers;

This returns all columns and all rows from the `customers` table.

---

## 3. SELECT Specific Columns

We can select only the columns that we need.

### Example

SELECT CustomerID, Name, City
FROM customers;

This returns only:

- CustomerID
- Name
- City

---

## 4. SELECT a Single Column

### Example

SELECT Name
FROM customers;

This returns only the `Name` column.

---

## 5. SELECT Multiple Columns

Multiple columns can be selected by separating them with commas.

### Example

SELECT Name, Age, City
FROM customers;

---

## 6. SELECT with WHERE

The `WHERE` clause is used to filter rows based on a condition.

### Syntax

SELECT column1, column2
FROM table_name
WHERE condition;

### Example

SELECT *
FROM customers
WHERE City = "Mumbai";

This returns customers whose city is Mumbai.

---

## 7. Comparison Operators

SQL provides comparison operators for filtering data.

| Operator | Meaning |
|---|---|
| = | Equal to |
| != | Not equal to |
| <> | Not equal to |
| > | Greater than |
| < | Less than |
| >= | Greater than or equal to |
| <= | Less than or equal to |

### Example

SELECT *
FROM customers
WHERE Age > 30;

---

## 8. AND Operator

`AND` is used when all conditions must be true.

### Example

SELECT *
FROM customers
WHERE City = "Mumbai"
AND Age > 25;

Both conditions must be satisfied.

---

## 9. OR Operator

`OR` is used when at least one condition must be true.

### Example

SELECT *
FROM customers
WHERE City = "Mumbai"
OR City = "Delhi";

---

## 10. NOT Operator

`NOT` is used to exclude a condition.

### Example

SELECT *
FROM customers
WHERE NOT City = "Mumbai";

This returns customers who are not from Mumbai.

---

## 11. DISTINCT

`DISTINCT` is used to remove duplicate values from the result.

### Syntax

SELECT DISTINCT column_name
FROM table_name;

### Example

SELECT DISTINCT City
FROM customers;

This displays each city only once.

---

## 12. DISTINCT with Multiple Columns

`DISTINCT` can also be applied to multiple columns.

### Example

SELECT DISTINCT City, Gender
FROM customers;

This returns unique combinations of City and Gender.

---

## 13. ORDER BY

`ORDER BY` is used to sort query results.

### Ascending Order

`ASC` sorts values from smallest to largest or A to Z.

### Example

SELECT *
FROM customers
ORDER BY Age ASC;

### Descending Order

`DESC` sorts values from largest to smallest or Z to A.

### Example

SELECT *
FROM customers
ORDER BY Age DESC;

---

## 14. ORDER BY Multiple Columns

We can sort data using more than one column.

### Example

SELECT *
FROM customers
ORDER BY City ASC, Age DESC;

The result is first sorted by City and then by Age.

---

## 15. LIMIT

`LIMIT` is used to restrict the number of rows returned.

### Example

SELECT *
FROM customers
LIMIT 5;

This returns only 5 records.

---

## 16. ORDER BY with LIMIT

`ORDER BY` and `LIMIT` can be used together.

### Example

SELECT *
FROM customers
ORDER BY Age DESC
LIMIT 5;

This returns the 5 oldest customers.

---

## 17. Column Alias

An alias gives a temporary name to a column in the result.

### Syntax

SELECT column_name AS alias_name
FROM table_name;

### Example

SELECT Name AS Customer_Name
FROM customers;

The output column will be displayed as `Customer_Name`.

---

## 18. Alias without AS

The `AS` keyword is optional for column aliases.

### Example

SELECT Name Customer_Name
FROM customers;

This works similarly to:

SELECT Name AS Customer_Name
FROM customers;

---

## 19. Calculated Columns

SQL allows us to perform calculations while retrieving data.

### Example

SELECT ProductID,
       SellingPrice,
       SellingPrice * 2 AS Double_Price
FROM products;

This creates a calculated column called `Double_Price`.

---

## 20. Arithmetic Operators

SQL supports common arithmetic operations.

| Operator | Operation |
|---|---|
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |
| % | Modulus |

### Example

SELECT SellingPrice,
       SellingPrice * 0.90 AS Discounted_Price
FROM products;

---

## 21. BETWEEN

`BETWEEN` is used to select values within a specific range.

### Syntax

SELECT *
FROM table_name
WHERE column_name BETWEEN value1 AND value2;

### Example

SELECT *
FROM customers
WHERE Age BETWEEN 20 AND 30;

This includes values from 20 through 30.

---

## 22. IN

`IN` is used to check multiple possible values.

### Example

SELECT *
FROM customers
WHERE City IN ("Mumbai", "Delhi", "Pune");

This is shorter than using multiple `OR` conditions.

Instead of:

WHERE City = "Mumbai"
OR City = "Delhi"
OR City = "Pune";

We can write:

WHERE City IN ("Mumbai", "Delhi", "Pune");

---

## 23. LIKE

`LIKE` is used for pattern matching.

### Starts With

SELECT *
FROM customers
WHERE Name LIKE "A%";

Returns names starting with `A`.

### Ends With

SELECT *
FROM customers
WHERE Name LIKE "%a";

Returns names ending with `a`.

### Contains

SELECT *
FROM customers
WHERE Name LIKE "%an%";

Returns names containing `an`.

---

## 24. Wildcards

SQL commonly uses two wildcards with `LIKE`.

### `%`

Represents zero or more characters.

Example:

WHERE Name LIKE "A%";

### `_`

Represents exactly one character.

Example:

WHERE Name LIKE "A_i";

---

## 25. IS NULL

`IS NULL` is used to find records containing missing values.

### Example

SELECT *
FROM customers
WHERE City IS NULL;

---

## 26. IS NOT NULL

`IS NOT NULL` is used to find records where a value exists.

### Example

SELECT *
FROM customers
WHERE City IS NOT NULL;

---

## 27. Multiple Conditions

Multiple conditions can be combined using `AND` and `OR`.

### Example

SELECT *
FROM customers
WHERE Age > 25
AND Gender = "F"
AND City = "Mumbai";

This returns female customers from Mumbai who are older than 25.

---

## 28. Query Execution Order

A SQL query is written in a particular order.

### Written Order

SELECT
FROM
WHERE
ORDER BY
LIMIT

### Simplified Execution Order

1. FROM
2. WHERE
3. SELECT
4. ORDER BY
5. LIMIT

Understanding execution order becomes important when working with advanced SQL queries.

---

## 29. Important SELECT Syntax

### Basic Query

SELECT *
FROM table_name;

### Selecting Specific Columns

SELECT column1, column2
FROM table_name;

### Filtering

SELECT *
FROM table_name
WHERE condition;

### Sorting

SELECT *
FROM table_name
ORDER BY column_name ASC;

### Filtering + Sorting

SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column_name DESC;

### Filtering + Sorting + Limiting

SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column_name DESC
LIMIT 10;

---

# Important Differences

## WHERE vs SELECT

### SELECT

Used to choose columns.

SELECT Name, Age
FROM customers;

### WHERE

Used to filter rows.

SELECT *
FROM customers
WHERE Age > 30;

### Together

SELECT Name, Age
FROM customers
WHERE Age > 30;

---

## ASC vs DESC

### ASC

Ascending order.

SELECT *
FROM customers
ORDER BY Age ASC;

### DESC

Descending order.

SELECT *
FROM customers
ORDER BY Age DESC;

---

## IN vs OR

Using OR:

WHERE City = "Mumbai"
OR City = "Delhi"
OR City = "Pune";

Using IN:

WHERE City IN ("Mumbai", "Delhi", "Pune");

`IN` is generally cleaner when checking multiple values.

---

# Common SELECT Mistakes

## Mistake 1: Missing FROM

Incorrect:

SELECT *
customers;

Correct:

SELECT *
FROM customers;

---

## Mistake 2: Missing Comma

Incorrect:

SELECT Name Age City
FROM customers;

Correct:

SELECT Name, Age, City
FROM customers;

---

## Mistake 3: Incorrect Text Value

Incorrect:

SELECT *
FROM customers
WHERE City = Mumbai;

Correct:

SELECT *
FROM customers
WHERE City = "Mumbai";

---

## Mistake 4: Wrong Column Name

If the selected column does not exist in the table, MySQL will return an error.

Example:

SELECT Customer_Name
FROM customers;

If `Customer_Name` is not a column in the table, the query will fail.

---

# SQL SELECT – Quick Revision

| Keyword | Purpose |
|---|---|
| SELECT | Retrieve data |
| FROM | Specify table |
| WHERE | Filter rows |
| DISTINCT | Remove duplicates |
| AND | All conditions must be true |
| OR | At least one condition must be true |
| NOT | Exclude a condition |
| IN | Match multiple values |
| BETWEEN | Select a range |
| LIKE | Pattern matching |
| IS NULL | Find missing values |
| IS NOT NULL | Find non-missing values |
| ORDER BY | Sort results |
| ASC | Ascending order |
| DESC | Descending order |
| LIMIT | Restrict rows |
| AS | Create an alias |

---

# SQL SELECT Practice Questions

## 1. Display all customers.

SELECT *
FROM customers;

## 2. Display only customer names.

SELECT Name
FROM customers;

## 3. Display CustomerID, Name and City.

SELECT CustomerID, Name, City
FROM customers;

## 4. Display customers from Mumbai.

SELECT *
FROM customers
WHERE City = "Mumbai";

## 5. Display customers from Nagpur.

SELECT *
FROM customers
WHERE City = "Nagpur";

## 6. Display all female customers.

SELECT *
FROM customers
WHERE Gender = "F";

## 7. Display customers older than 30.

SELECT *
FROM customers
WHERE Age > 30;

## 8. Display customers younger than 25.

SELECT *
FROM customers
WHERE Age < 25;

## 9. Display customers aged 30 or above.

SELECT *
FROM customers
WHERE Age >= 30;

## 10. Display customers aged 20 or below.

SELECT *
FROM customers
WHERE Age <= 20;

## 11. Display customers whose age is not 30.

SELECT *
FROM customers
WHERE Age != 30;

## 12. Display customers from Mumbai and older than 25.

SELECT *
FROM customers
WHERE City = "Mumbai"
AND Age > 25;

## 13. Display customers from Mumbai or Delhi.

SELECT *
FROM customers
WHERE City = "Mumbai"
OR City = "Delhi";

## 14. Display customers who are not from Mumbai.

SELECT *
FROM customers
WHERE NOT City = "Mumbai";

## 15. Display unique cities.

SELECT DISTINCT City
FROM customers;

## 16. Display unique genders.

SELECT DISTINCT Gender
FROM customers;

## 17. Display customers in ascending age order.

SELECT *
FROM customers
ORDER BY Age ASC;

## 18. Display customers in descending age order.

SELECT *
FROM customers
ORDER BY Age DESC;

## 19. Display customers sorted by city.

SELECT *
FROM customers
ORDER BY City ASC;

## 20. Display the 5 oldest customers.

SELECT *
FROM customers
ORDER BY Age DESC
LIMIT 5;

## 21. Display the 5 youngest customers.

SELECT *
FROM customers
ORDER BY Age ASC
LIMIT 5;

## 22. Display the first 10 customers.

SELECT *
FROM customers
LIMIT 10;

## 23. Display customers aged between 20 and 30.

SELECT *
FROM customers
WHERE Age BETWEEN 20 AND 30;

## 24. Display customers from Mumbai, Delhi or Pune.

SELECT *
FROM customers
WHERE City IN ("Mumbai", "Delhi", "Pune");

## 25. Display customers whose name starts with A.

SELECT *
FROM customers
WHERE Name LIKE "A%";

## 26. Display customers whose name ends with a.

SELECT *
FROM customers
WHERE Name LIKE "%a";

## 27. Display customers whose name contains "an".

SELECT *
FROM customers
WHERE Name LIKE "%an%";

## 28. Display customers whose city is NULL.

SELECT *
FROM customers
WHERE City IS NULL;

## 29. Display customers whose city is not NULL.

SELECT *
FROM customers
WHERE City IS NOT NULL;

## 30. Display products with selling price less than 1000.

SELECT *
FROM products
WHERE SellingPrice < 1000;

## 31. Display products with selling price greater than 1000.

SELECT *
FROM products
WHERE SellingPrice > 1000;

## 32. Display the 5 most expensive products.

SELECT *
FROM products
ORDER BY SellingPrice DESC
LIMIT 5;


# Final Revision

The most important SELECT query structure is:

SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column_name ASC
LIMIT 10;

These concepts form the foundation for advanced SQL topics such as:

- Aggregate Functions
- GROUP BY
- HAVING
- JOINs
- Subqueries
- CASE WHEN
- Window Functions
- SQL Case Studies