# HAVING Clause — SQL Notes


## 1. Introduction

`HAVING` clause ka use `GROUP BY` ke baad banne wale **groups ko filter** karne ke liye hota hai.

`WHERE` individual rows ko filter karta hai, jabki `HAVING` grouped results ko filter karta hai.

`HAVING` mostly aggregate functions ke saath use hota hai:

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

---

# 2. Basic Syntax

    SELECT column_name,
           aggregate_function(column_name)
    FROM table_name
    GROUP BY column_name
    HAVING condition;

### Example

    SELECT SupplierID,
           COUNT(*) AS total_products
    FROM products
    GROUP BY SupplierID
    HAVING COUNT(*) > 5;

Ye query sirf un suppliers ko return karegi jinke paas 5 se zyada products hain.

---

# 3. Why Do We Use HAVING?

`WHERE` ka use grouping se pehle rows filter karne ke liye hota hai.

`HAVING` ka use grouping ke baad groups filter karne ke liye hota hai.

Example:

    SELECT SupplierID,
           COUNT(*) AS total_products
    FROM products
    GROUP BY SupplierID
    HAVING COUNT(*) > 5;

Yahan:

1. Products ko `SupplierID` ke according group kiya jayega.
2. Har supplier ke products count honge.
3. Sirf wahi groups show honge jinka count 5 se greater hai.

---

# 4. WHERE vs HAVING

| WHERE | HAVING |
|---|---|
| Rows ko filter karta hai | Groups ko filter karta hai |
| GROUP BY se pehle apply hota hai | GROUP BY ke baad apply hota hai |
| Individual records par kaam karta hai | Grouped results par kaam karta hai |
| Aggregate result filtering ke liye normally use nahi hota | Aggregate functions ke saath commonly use hota hai |

### WHERE Example

    SELECT *
    FROM products
    WHERE SellingPrice > 1000;

### HAVING Example

    SELECT SupplierID,
           COUNT(*) AS total_products
    FROM products
    GROUP BY SupplierID
    HAVING COUNT(*) > 5;

---

# 5. HAVING with COUNT()

`COUNT()` ke result ko filter karne ke liye `HAVING` use kar sakte hain.

### Example

    SELECT SupplierID,
           COUNT(*) AS total_products
    FROM products
    GROUP BY SupplierID
    HAVING COUNT(*) > 10;

Meaning:

Sirf un suppliers ko show karo jinke paas 10 se zyada products hain.

---

# 6. HAVING with SUM()

`SUM()` ke grouped result ko filter kar sakte hain.

### Example

    SELECT ProductID,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY ProductID
    HAVING SUM(total) > 5000;

Meaning:

Sirf wahi products show honge jinki total sales 5000 se greater hai.

---

# 7. HAVING with AVG()

`AVG()` ke result par bhi condition laga sakte hain.

### Example

    SELECT ProductID,
           AVG(total) AS average_sales
    FROM order_items
    GROUP BY ProductID
    HAVING AVG(total) > 1000;

Meaning:

Sirf un products ko show karo jinki average sales 1000 se greater hai.

---

# 8. HAVING with MIN()

Minimum value ke basis par groups filter kar sakte hain.

### Example

    SELECT ProductID,
           MIN(total) AS minimum_sales
    FROM order_items
    GROUP BY ProductID
    HAVING MIN(total) > 100;

Meaning:

Sirf wahi products show honge jinki minimum sales value 100 se greater hai.

---

# 9. HAVING with MAX()

Maximum value ke basis par groups filter kar sakte hain.

### Example

    SELECT ProductID,
           MAX(total) AS maximum_sales
    FROM order_items
    GROUP BY ProductID
    HAVING MAX(total) > 5000;

---

# 10. HAVING with Alias

Aggregate result ko alias dekar `HAVING` mein use kar sakte hain.

### Example

    SELECT ProductID,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY ProductID
    HAVING total_sales > 5000;

Yahan `total_sales` aggregate expression ka alias hai.

---

# 11. HAVING with Multiple Conditions

Multiple conditions ko `AND` aur `OR` ke saath combine kar sakte hain.

### AND Example

    SELECT ProductID,
           SUM(total) AS total_sales,
           COUNT(*) AS total_orders
    FROM order_items
    GROUP BY ProductID
    HAVING total_sales > 5000
       AND total_orders > 10;

Dono conditions satisfy honi chahiye.

---

# 12. HAVING with OR

### Example

    SELECT ProductID,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY ProductID
    HAVING total_sales > 5000
       OR total_sales < 100;

At least ek condition true honi chahiye.

---

# 13. HAVING with WHERE

`WHERE` aur `HAVING` ek hi query mein use kiye ja sakte hain.

### Example

    SELECT ProductID,
           SUM(total) AS total_sales
    FROM order_items
    WHERE quantity > 1
    GROUP BY ProductID
    HAVING total_sales > 5000;

### Processing

1. `WHERE` → quantity > 1 wali rows filter karega.
2. `GROUP BY` → ProductID ke according groups banayega.
3. `SUM()` → har product ki total sales calculate karega.
4. `HAVING` → total sales > 5000 wale groups filter karega.

---

# 14. HAVING with ORDER BY

Grouped results ko filter karne ke baad sort kar sakte hain.

### Example

    SELECT ProductID,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY ProductID
    HAVING total_sales > 5000
    ORDER BY total_sales DESC;

---

# 15. HAVING with LIMIT

Top results find karne ke liye `LIMIT` use kar sakte hain.

### Example

    SELECT ProductID,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY ProductID
    HAVING total_sales > 5000
    ORDER BY total_sales DESC
    LIMIT 5;

Meaning:

5000 se greater total sales wale products mein se top 5 products.

---

# 16. HAVING with Multiple Aggregate Functions

Ek query mein multiple aggregate functions use kar sakte hain.

### Example

    SELECT ProductID,
           COUNT(*) AS no_sales,
           SUM(total) AS total_sales,
           ROUND(AVG(total), 2) AS avg_sales
    FROM order_items
    GROUP BY ProductID
    HAVING total_sales > 5000
       AND no_sales > 5;

---

# 17. HAVING with GROUP BY Multiple Columns

Multiple columns ke basis par groups bana sakte hain.

### Example

    SELECT CategoryID,
           SupplierID,
           COUNT(*) AS total_products
    FROM products
    GROUP BY CategoryID, SupplierID
    HAVING total_products > 5;

---

# 18. HAVING with COUNT(DISTINCT)

Unique values count karne ke liye `COUNT(DISTINCT column)` use kar sakte hain.

### Example

    SELECT SupplierID,
           COUNT(DISTINCT CategoryID) AS total_categories
    FROM products
    GROUP BY SupplierID
    HAVING total_categories > 2;

Meaning:

Sirf un suppliers ko show karo jo 2 se zyada different categories mein products supply karte hain.

---

# 19. HAVING with BETWEEN

Aggregate result ko range ke andar filter kar sakte hain.

### Example

    SELECT ProductID,
           SUM(total) AS total_sales
    FROM order_items
    GROUP BY ProductID
    HAVING total_sales BETWEEN 5000 AND 10000;

---

# 20. HAVING with IN

HAVING condition mein `IN` bhi use kar sakte hain.

Example:

    SELECT Method,
           COUNT(*) AS total_transactions
    FROM payments
    GROUP BY Method
    HAVING Method IN ('Cash', 'UPI');

---

# 21. HAVING with Comparison Operators

HAVING mein comparison operators use kar sakte hain:

    >
    <
    >=
    <=
    =
    <>
    !=

### Example

    SELECT SupplierID,
           COUNT(*) AS total_products
    FROM products
    GROUP BY SupplierID
    HAVING COUNT(*) >= 10;

---

# 22. GROUP BY + HAVING Query Structure

General structure:

    SELECT column_name,
           aggregate_function(column_name) AS alias
    FROM table_name
    WHERE condition
    GROUP BY column_name
    HAVING aggregate_condition
    ORDER BY alias DESC
    LIMIT 5;

Example:

    SELECT ProductID,
           SUM(total) AS total_sales
    FROM order_items
    WHERE quantity > 1
    GROUP BY ProductID
    HAVING total_sales > 5000
    ORDER BY total_sales DESC
    LIMIT 5;

---

# 23. SQL Execution Order

Query ko conceptually roughly is order mein process kiya jata hai:

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

- `FROM` → table se data leta hai
- `WHERE` → rows filter karta hai
- `GROUP BY` → groups create karta hai
- `HAVING` → groups filter karta hai
- `SELECT` → required columns/results return karta hai
- `ORDER BY` → result sort karta hai
- `LIMIT` → result ki rows restrict karta hai

---

# 24. Common Mistake: WHERE Instead of HAVING

Wrong:

    SELECT SupplierID,
           COUNT(*) AS total_products
    FROM products
    WHERE COUNT(*) > 5
    GROUP BY SupplierID;

`WHERE` aggregate result ko directly filter karne ke liye use nahi karna chahiye.

Correct:

    SELECT SupplierID,
           COUNT(*) AS total_products
    FROM products
    GROUP BY SupplierID
    HAVING COUNT(*) > 5;

---

# 25. Common Mistake: HAVING Without GROUP BY

`HAVING` normally grouped results ke saath use hota hai.

Example:

    SELECT COUNT(*) AS total_products
    FROM products
    HAVING COUNT(*) > 100;

Ye aggregate result ko filter kar sakta hai, lekin practical grouped analysis mein `HAVING` commonly `GROUP BY` ke saath use hota hai.

---

# 26. WHERE + GROUP BY + HAVING Example

    SELECT CategoryID,
           COUNT(*) AS total_products,
           AVG(SellingPrice) AS average_price
    FROM products
    WHERE SellingPrice > 500
    GROUP BY CategoryID
    HAVING total_products > 5
    ORDER BY total_products DESC;

Meaning:

1. Selling price 500 se greater products filter honge.
2. Products CategoryID ke according group honge.
3. Har category ka count aur average price calculate hoga.
4. Sirf 5 se zyada products wali categories show hongi.
5. Result product count ke descending order mein sort hoga.

---

# 27. Real-World Use Cases

HAVING ka use real-world analytics mein hota hai:

- Suppliers with many products
- Products with high total sales
- Categories with many products
- Customers with many orders
- Cities with a minimum number of customers
- Payment methods with high transaction volume
- Employees with sufficient sales
- Products with a minimum number of reviews

---

# 28. Practice Questions

## Basic HAVING

### Q1.
Har supplier ke products count karo aur sirf un suppliers ko show karo jinke paas 5 se zyada products hain.

### Q2.
Har category ke products count karo aur sirf un categories ko show karo jahan products 10 se zyada hain.

### Q3.
Har product ki total sales calculate karo aur sirf 5000 se greater total sales wale products show karo.

### Q4.
Har product ki average sales calculate karo aur sirf 1000 se greater average wale products show karo.

### Q5.
Har payment method ka transaction count nikalo aur sirf 10 se zyada transactions wale methods show karo.

---

## SUM / COUNT / AVG

### Q6.
Product-wise total quantity calculate karo aur sirf un products ko show karo jinki total quantity 100 se greater hai.

### Q7.
Supplier-wise products count karo aur sirf un suppliers ko show karo jinke products 20 se greater hain.

### Q8.
Category-wise average selling price calculate karo aur sirf un categories ko show karo jinka average price 1000 se greater hai.

### Q9.
Payment method-wise total amount calculate karo aur sirf un methods ko show karo jinka total amount 10000 se greater hai.

### Q10.
Product-wise order count calculate karo aur sirf un products ko show karo jinke orders 5 se greater hain.

---

## WHERE + GROUP BY + HAVING

### Q11.
Quantity > 1 wali order items ko product-wise group karo aur sirf un products ko show karo jinki total sales 5000 se greater hai.

### Q12.
Selling price > 500 wale products ko category-wise group karo aur sirf un categories ko show karo jahan 5 se zyada products hain.

### Q13.
Delhi ke customers ko gender-wise group karo aur sirf un genders ko show karo jinka customer count 10 se greater hai.

### Q14.
Payments ko method-wise group karo aur sirf 100 se greater amount wale payments ko consider karke un methods ko show karo jinka total amount 10000 se greater hai.

---

## ORDER BY + HAVING

### Q15.
Product-wise total sales calculate karo, 5000 se greater sales wale products filter karo aur descending order mein show karo.

### Q16.
Supplier-wise product count calculate karo, 5 se greater products wale suppliers filter karo aur highest count ko top par show karo.

### Q17.
Category-wise product count calculate karo aur 10 se greater count wali categories ko descending order mein show karo.

---

## LIMIT + HAVING

### Q18.
5000 se greater total sales wale top 5 products find karo.

### Q19.
10 se greater products wale top 3 suppliers find karo based on product count.

### Q20.
Highest total payment wale top 5 payment methods find karo.

---

## Multiple Conditions

### Q21.
Un products ko find karo jinki total sales 5000 se greater aur order count 5 se greater hai.

### Q22.
Un suppliers ko find karo jinke products 10 se greater hain aur average selling price 500 se greater hai.

### Q23.
Un categories ko find karo jinka product count 5 se greater aur average selling price 1000 se greater hai.

### Q24.
Un payment methods ko find karo jinka transaction count 10 se greater aur total payment 10000 se greater hai.

---

## Advanced Practice

### Q25.
Product-wise:
- number of sales
- total sales
- average sales
- minimum sales
- maximum sales

calculate karo aur sirf un products ko show karo jinki total sales 10000 se greater hai.

### Q26.
Supplier-wise product count aur average selling price calculate karo aur sirf un suppliers ko show karo jinke products 10 se greater hain.

### Q27.
Category-wise product count aur average selling price calculate karo aur sirf un categories ko show karo jahan product count 5 se greater hai.

### Q28.
Product-wise total quantity aur total sales calculate karo aur sirf un products ko show karo jinki total quantity 50 se greater aur total sales 5000 se greater hai.

### Q29.
Payment method-wise transaction count, total payment aur average payment calculate karo aur sirf un methods ko show karo jinka total payment 10000 se greater hai.

### Q30.
Customer-wise order count calculate karo aur sirf un customers ko show karo jinhone 5 se zyada orders place kiye hain.

### Q31.
City-wise customer count calculate karo aur sirf un cities ko show karo jahan 20 se greater customers hain.

### Q32.
Top 5 categories find karo jinke products ka count 10 se greater hai, aur unhe product count ke descending order mein display karo.

---

# 29. Quick Revision

## WHERE

Rows filter karta hai.

    WHERE condition

## GROUP BY

Rows ko groups mein divide karta hai.

    GROUP BY column

## HAVING

Groups ko filter karta hai.

    HAVING aggregate_condition

## ORDER BY

Result ko sort karta hai.

    ORDER BY column DESC

## LIMIT

Result ko restrict karta hai.

    LIMIT 5

---

# 30. Most Important Example

    SELECT ProductID,
           COUNT(*) AS total_orders,
           SUM(total) AS total_sales,
           ROUND(AVG(total), 2) AS average_sales
    FROM order_items
    WHERE quantity > 1
    GROUP BY ProductID
    HAVING total_sales > 5000
    ORDER BY total_sales DESC
    LIMIT 5;

### Query Flow

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

---

# 31. Key Takeaways

- `HAVING` grouped data ko filter karta hai.
- `WHERE` individual rows ko filter karta hai.
- `HAVING` commonly `GROUP BY` ke saath use hota hai.
- `HAVING` aggregate functions ke saath bahut useful hai.
- `COUNT()` ke result ko `HAVING` se filter kar sakte hain.
- `SUM()` ke result ko `HAVING` se filter kar sakte hain.
- `AVG()` ke result ko `HAVING` se filter kar sakte hain.
- `MIN()` aur `MAX()` ke result ko bhi `HAVING` se filter kar sakte hain.
- `WHERE + GROUP BY + HAVING` ek hi query mein use ho sakte hain.
- `ORDER BY` grouped result ko sort karta hai.
- `LIMIT` final result ko restrict karta hai.
- Complex filtering ke liye `AND` aur `OR` use kar sakte hain.

# End of HAVING Clause