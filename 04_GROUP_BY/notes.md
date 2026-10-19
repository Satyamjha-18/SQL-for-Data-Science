# GROUP BY — SQL Notes

## 1. Introduction

`GROUP BY` clause ka use rows ko kisi ek ya multiple columns ke basis par **groups mein divide** karne ke liye hota hai.

Ye mostly **aggregate functions** ke saath use hota hai.

Common aggregate functions:

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

Example:

    SELECT categoryid, COUNT(*) AS total_products
    FROM products
    GROUP BY categoryid;

Is query mein same `categoryid` wale products ek group mein aa jayenge aur har category ke products count honge.

---

# 2. Basic Syntax

    SELECT column_name, aggregate_function(column_name)
    FROM table_name
    GROUP BY column_name;

Example:

    SELECT categoryid, COUNT(*) AS total_products
    FROM products
    GROUP BY categoryid;

---

# 3. Why Do We Use GROUP BY?

Agar hume individual rows nahi balki **group-wise information** chahiye, to `GROUP BY` use karte hain.

Example:

Without GROUP BY:

    SELECT COUNT(*)
    FROM products;

Ye total products ka count dega.

With GROUP BY:

    SELECT categoryid, COUNT(*) AS total_products
    FROM products
    GROUP BY categoryid;

Ye har category ke products ka count dega.

---

# 4. GROUP BY with COUNT()

`COUNT()` records ki quantity/count find karne ke liye use hota hai.

### Example

    SELECT categoryid,
           COUNT(*) AS total_products
    FROM products
    GROUP BY categoryid;

Meaning:

Har category mein kitne products hain.

---

# 5. COUNT(*) vs COUNT(column)

## COUNT(*)

Table/group ki total rows count karta hai.

    SELECT categoryid,
           COUNT(*) AS total_products
    FROM products
    GROUP BY categoryid;

## COUNT(column)

Specified column ki non-NULL values count karta hai.

    SELECT categoryid,
           COUNT(productid) AS total_products
    FROM products
    GROUP BY categoryid;

---

# 6. GROUP BY with SUM()

`SUM()` numeric values ka total calculate karta hai.

Example:

    SELECT productid,
           SUM(quantity) AS total_quantity
    FROM order_items
    GROUP BY productid;

Meaning:

Har product ki total quantity sold.

---

# 7. GROUP BY with AVG()

`AVG()` average value calculate karta hai.

Example:

    SELECT productid,
           ROUND(AVG(total), 2) AS avg_sales
    FROM order_items
    GROUP BY productid;

Meaning:

Har product ki average sales value.

---

# 8. GROUP BY with MIN()

`MIN()` minimum value find karta hai.

Example:

    SELECT productid,
           MIN(total) AS min_sales
    FROM order_items
    GROUP BY productid;

Meaning:

Har product ki minimum sales value.

---

# 9. GROUP BY with MAX()

`MAX()` maximum value find karta hai.

Example:

    SELECT productid,
           MAX(total) AS max_sales
    FROM order_items
    GROUP BY productid;

Meaning:

Har product ki maximum sales value.

---

# 10. Multiple Aggregate Functions

Ek hi query mein multiple aggregate functions use kar sakte hain.

Example:

    SELECT productid,
           COUNT(*) AS no_sales,
           SUM(total) AS total_sales,
           ROUND(AVG(total), 2) AS avg_sales,
           MIN(total) AS min_sales,
           MAX(total) AS max_sales
    FROM order_items
    GROUP BY productid;

Ye har product ke liye:

- Number of sales
- Total sales
- Average sales
- Minimum sales
- Maximum sales

show karega.

---

# 11. GROUP BY Multiple Columns

Ek se zyada columns ke basis par grouping kar sakte hain.

Syntax:

    SELECT column1, column2, COUNT(*)
    FROM table_name
    GROUP BY column1, column2;

Example:

    SELECT categoryid,
           supplierid,
           COUNT(*) AS total_products
    FROM products
    GROUP BY categoryid, supplierid;

Meaning:

Category aur supplier ke combination ke basis par groups banenge.

---

# 12. GROUP BY with ORDER BY

Grouped results ko sort karne ke liye `ORDER BY` use kar sakte hain.

Example:

    SELECT productid,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY productid
    ORDER BY total_sales DESC;

Ye highest total sales wale product ko top par show karega.

---

# 13. ORDER BY Aggregate Alias

Aggregate result ko alias dekar `ORDER BY` mein use kar sakte hain.

Example:

    SELECT productid,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY productid
    ORDER BY total_sales DESC;

Yahan `total_sales` alias hai.

---

# 14. ASC and DESC

## ASC

Ascending order ke liye.

    ORDER BY total_sales ASC;

Smallest se largest.

## DESC

Descending order ke liye.

    ORDER BY total_sales DESC;

Largest se smallest.

---

# 15. GROUP BY with LIMIT

Top N grouped results find karne ke liye `LIMIT` use kar sakte hain.

Example:

    SELECT productid,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY productid
    ORDER BY total_sales DESC
    LIMIT 5;

Meaning:

Top 5 products according to total sales.

---

# 16. GROUP BY with WHERE

`WHERE` grouping se pehle rows ko filter karta hai.

Example:

    SELECT productid,
           SUM(total) AS total_sales
    FROM order_items
    WHERE quantity > 1
    GROUP BY productid;

Meaning:

Pehle quantity > 1 wali rows filter hongi, phir product-wise grouping hogi.

---

# 17. GROUP BY with HAVING

`HAVING` grouped results ko filter karne ke liye use hota hai.

Example:

    SELECT productid,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY productid
    HAVING total_sales > 5000;

Meaning:

Sirf un products ko show karo jinki total sales 5000 se greater hai.

---

# 18. WHERE vs HAVING

| WHERE | HAVING |
|---|---|
| Rows ko filter karta hai | Groups ko filter karta hai |
| GROUP BY se pehle apply hota hai | GROUP BY ke baad apply hota hai |
| Individual records par kaam karta hai | Grouped results par kaam karta hai |
| Aggregate result filtering ke liye normally use nahi hota | Aggregate functions ke saath use hota hai |

Example:

    SELECT productid,
           SUM(total) AS total_sales
    FROM order_items
    WHERE quantity > 1
    GROUP BY productid
    HAVING total_sales > 5000;

---

# 19. GROUP BY and only_full_group_by

MySQL mein `only_full_group_by` SQL mode enabled hone par SELECT list mein non-aggregated columns ko properly GROUP BY mein include karna zaroori hota hai.

Example of problematic query:

    SELECT productid, sellingprice
    FROM products
    GROUP BY sellingprice;

Problem:

`sellingprice` group kiya gaya hai, lekin `productid` na aggregate function mein hai aur na hi GROUP BY mein.

Correct approach:

    SELECT sellingprice,
           COUNT(*) AS total_products
    FROM products
    GROUP BY sellingprice;

Ya agar productid bhi chahiye:

    SELECT productid, sellingprice
    FROM products
    GROUP BY productid, sellingprice;

---

# 20. Important GROUP BY Rule

Agar SELECT mein koi column aggregate function ke andar nahi hai, to normally us column ko `GROUP BY` mein include karna chahiye.

Example:

    SELECT categoryid,
           COUNT(*) AS total_products
    FROM products
    GROUP BY categoryid;

Yahan:

- `categoryid` → GROUP BY mein hai
- `COUNT(*)` → aggregate function hai

---

# 21. GROUP BY with DISTINCT Concept

`GROUP BY` grouped results produce karta hai.

Example:

    SELECT city
    FROM customers
    GROUP BY city;

Ye unique cities ko grouped form mein show karega.

Alternative:

    SELECT DISTINCT city
    FROM customers;

Simple unique values ke liye `DISTINCT` use karna generally clearer hota hai.

---

# 22. GROUP BY Query Execution Order

Conceptually SQL query ko roughly is order mein process kiya jata hai:

    FROM
    ↓
    WHERE
    ↓
    GROUP BY
    ↓
    HAVING
    ↓
    SELECT
    ↓
    ORDER BY
    ↓
    LIMIT

Important:

`WHERE` → rows filter

`GROUP BY` → groups create

`HAVING` → groups filter

`ORDER BY` → result sort

`LIMIT` → result ki rows limit

---

# 23. Real-World Examples

## Category-wise Products

    SELECT categoryid,
           COUNT(*) AS total_products
    FROM products
    GROUP BY categoryid;

## Product-wise Sales

    SELECT productid,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY productid;

## Supplier-wise Products

    SELECT supplierid,
           COUNT(*) AS no_of_products
    FROM products
    GROUP BY supplierid;

## Payment Method-wise Total

    SELECT method,
           SUM(amount) AS total_payment
    FROM payments
    GROUP BY method;

## Payment Method-wise Average

    SELECT method,
           ROUND(AVG(amount), 2) AS avg_payment
    FROM payments
    GROUP BY method;

---

# 24. Common GROUP BY Mistakes

## Mistake 1: Non-grouped column

Wrong:

    SELECT productid,
           sellingprice
    FROM products
    GROUP BY sellingprice;

Correct:

    SELECT sellingprice,
           COUNT(*) AS total_products
    FROM products
    GROUP BY sellingprice;

---

## Mistake 2: Aggregate function without GROUP BY

This is valid when you want one overall result:

    SELECT SUM(total)
    FROM order_items;

But if you want product-wise total:

    SELECT productid,
           SUM(total)
    FROM order_items
    GROUP BY productid;

---

## Mistake 3: Using WHERE for aggregate result

Wrong:

    SELECT productid,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY productid
    WHERE total_sales > 5000;

Correct:

    SELECT productid,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY productid
    HAVING total_sales > 5000;

---

# 25. GROUP BY Quick Revision

### Count records

    COUNT(*)

### Total

    SUM(column)

### Average

    AVG(column)

### Minimum

    MIN(column)

### Maximum

    MAX(column)

### Group records

    GROUP BY column

### Sort grouped result

    ORDER BY column

### Filter rows before grouping

    WHERE condition

### Filter groups after grouping

    HAVING condition

---

# 26. Practice Questions

## Basic GROUP BY

### Q1.
Har category mein total products find karo.

### Q2.
Har supplier ke total products find karo.

### Q3.
Har product ki total sales quantity find karo.

### Q4.
Har product ki total sales amount find karo.

### Q5.
Har product ki average sales value find karo.

### Q6.
Har product ki minimum sales value find karo.

### Q7.
Har product ki maximum sales value find karo.

### Q8.
Har payment method ka total payment find karo.

---

## Sorting with GROUP BY

### Q9.
Products ko total sales ke descending order mein arrange karo.

### Q10.
Top 5 products find karo based on total sales.

### Q11.
Payment methods ko total payment ke descending order mein arrange karo.

### Q12.
Suppliers ko number of products ke descending order mein arrange karo.

---

## Multiple Columns

### Q13.
Category aur supplier ke basis par total products find karo.

### Q14.
City aur gender ke basis par customers ka count find karo.

### Q15.
Payment method aur status ke basis par total transactions find karo.

---

## WHERE + GROUP BY

### Q16.
Sirf un order items ko consider karke product-wise total sales find karo jinki quantity 1 se greater hai.

### Q17.
1000 se greater selling price wale products ko category-wise count karo.

### Q18.
Specific city ke customers ko gender-wise count karo.

---

## HAVING + GROUP BY

### Q19.
Un products ko find karo jinki total sales 5000 se greater hai.

### Q20.
Un suppliers ko find karo jinke paas 10 se greater products hain.

### Q21.
Un categories ko find karo jahan products ki quantity 5 se greater hai.

### Q22.
Un payment methods ko find karo jinka total payment 10000 se greater hai.

---

## Advanced Practice

### Q23.
Har product ke liye:
- number of sales
- total sales
- average sales
- minimum sales
- maximum sales

find karo.

### Q24.
Top 5 products find karo based on total sales.

### Q25.
Har category ka total product count find karo aur highest product count wali category ko top par show karo.

### Q26.
Har supplier ka product count find karo aur sirf un suppliers ko show karo jinke products 5 se greater hain.

### Q27.
Har payment method ka:
- total payment
- average payment
- minimum payment
- maximum payment

find karo.

### Q28.
Har category ke products ka average selling price find karo.

### Q29.
Har supplier ke products ka average selling price find karo.

### Q30.
Quantity > 1 wale order items ko product-wise group karke total quantity find karo.

### Q31.
Product-wise total sales calculate karo aur sirf un products ko show karo jinki total sales 10000 se greater hai.

### Q32.
Har category ke products count karo aur descending order mein arrange karke top 3 categories show karo.

---

# 27. Important Query Templates

## Basic GROUP BY

    SELECT column_name,
           COUNT(*)
    FROM table_name
    GROUP BY column_name;

## GROUP BY + SUM

    SELECT column_name,
           SUM(amount) AS total_amount
    FROM table_name
    GROUP BY column_name;

## GROUP BY + AVG

    SELECT column_name,
           AVG(amount) AS average_amount
    FROM table_name
    GROUP BY column_name;

## GROUP BY + ORDER BY

    SELECT column_name,
           SUM(amount) AS total_amount
    FROM table_name
    GROUP BY column_name
    ORDER BY total_amount DESC;

## GROUP BY + HAVING

    SELECT column_name,
           COUNT(*) AS total_count
    FROM table_name
    GROUP BY column_name
    HAVING total_count > 5;

## WHERE + GROUP BY + HAVING

    SELECT column_name,
           SUM(amount) AS total_amount
    FROM table_name
    WHERE condition
    GROUP BY column_name
    HAVING total_amount > 5000
    ORDER BY total_amount DESC
    LIMIT 5;



---

# 28. Final Takeaways

- `GROUP BY` rows ko groups mein divide karta hai.
- `GROUP BY` mostly aggregate functions ke saath use hota hai.
- `COUNT()` count ke liye use hota hai.
- `SUM()` total ke liye use hota hai.
- `AVG()` average ke liye use hota hai.
- `MIN()` minimum ke liye use hota hai.
- `MAX()` maximum ke liye use hota hai.
- Multiple columns ke saath bhi `GROUP BY` kar sakte hain.
- `WHERE` grouping se pehle rows filter karta hai.
- `HAVING` grouping ke baad groups filter karta hai.
- `ORDER BY` grouped result ko sort karta hai.
- `LIMIT` result ko restrict karta hai.
- `only_full_group_by` ke case mein non-aggregated selected columns ko proper grouping mein include karna important hai.

# End of GROUP BY