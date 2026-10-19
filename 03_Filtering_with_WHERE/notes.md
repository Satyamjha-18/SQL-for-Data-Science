# Filtering with WHERE — SQL Notes

## 1. Introduction

`WHERE` clause ka use SQL table se **specific rows ko filter** karne ke liye hota hai.

Agar hume table ki saari rows nahi chahiye aur sirf condition satisfy karne wali rows chahiye, to `WHERE` use karte hain.

### Basic Syntax

    SELECT column1, column2
    FROM table_name
    WHERE condition;

### Example

    SELECT *
    FROM customers
    WHERE city = 'Mumbai';

Ye query sirf Mumbai city ke customers ko show karegi.

---

# 2. Comparison Operators

SQL mein conditions banane ke liye comparison operators use hote hain.

| Operator | Meaning |
|---|---|
| = | Equal to |
| <> | Not equal to |
| != | Not equal to |
| > | Greater than |
| < | Less than |
| >= | Greater than or equal to |
| <= | Less than or equal to |

---

# 3. Equal To (=)

Kisi particular value ko find karne ke liye `=` use karte hain.

### Example

    SELECT *
    FROM customers
    WHERE city = 'Mumbai';

---

# 4. Not Equal To

Do operators commonly use hote hain:

    <>
    
    !=

### Example

    SELECT *
    FROM customers
    WHERE city <> 'Delhi';

Ya:

    SELECT *
    FROM customers
    WHERE city != 'Delhi';

---

# 5. Greater Than (>)

Kisi value se greater records find karne ke liye `>` use hota hai.

### Example

    SELECT *
    FROM customers
    WHERE age > 30;

Ye 30 se greater age wale customers show karega.

---

# 6. Less Than (<)

Kisi value se smaller records find karne ke liye `<` use hota hai.

### Example

    SELECT *
    FROM customers
    WHERE age < 25;

---

# 7. Greater Than or Equal To (>=)

### Example

    SELECT *
    FROM customers
    WHERE age >= 30;

Isme age 30 bhi include hogi.

---

# 8. Less Than or Equal To (<=)

### Example

    SELECT *
    FROM customers
    WHERE age <= 25;

Isme age 25 bhi include hogi.

---

# 9. AND Operator

`AND` ka use tab hota hai jab **multiple conditions simultaneously true** honi chahiye.

### Example

    SELECT *
    FROM customers
    WHERE age > 25
    AND city = 'Delhi';

Meaning:

- Age 25 se greater honi chahiye
- City Delhi honi chahiye

Dono conditions true honi chahiye.

---

# 10. OR Operator

`OR` ka use tab hota hai jab **multiple conditions mein se koi ek condition true** ho.

### Example

    SELECT *
    FROM customers
    WHERE city = 'Delhi'
    OR city = 'Mumbai';

Ye Delhi ya Mumbai ke customers return karega.

---

# 11. AND + OR

Multiple logical conditions ko combine kar sakte hain.

### Example

    SELECT *
    FROM customers
    WHERE city = 'Delhi'
    OR city = 'Mumbai'
    AND age > 30;

Complex conditions mein parentheses `()` use karna better hota hai.

### Example

    SELECT *
    FROM customers
    WHERE (city = 'Delhi' OR city = 'Mumbai')
    AND age > 30;

Meaning:

Delhi ya Mumbai ke customers jinki age 30 se greater hai.

---

# 12. NOT Operator

`NOT` kisi condition ko reverse karta hai.

### Example

    SELECT *
    FROM customers
    WHERE NOT city = 'Delhi';

Ye Delhi ko exclude karega.

---

# 13. BETWEEN Operator

`BETWEEN` kisi range ke andar values filter karne ke liye use hota hai.

### Syntax

    SELECT *
    FROM table_name
    WHERE column_name BETWEEN value1 AND value2;

### Example

    SELECT *
    FROM customers
    WHERE age BETWEEN 20 AND 30;

Important:

`BETWEEN` generally **both boundary values ko include karta hai**.

Yaani 20 aur 30 dono include honge.

---

# 14. IN Operator

`IN` ka use multiple possible values ko check karne ke liye hota hai.

### Example

    SELECT *
    FROM customers
    WHERE city IN ('Delhi', 'Mumbai', 'Nagpur');

Ye Delhi, Mumbai aur Nagpur ke customers return karega.

---

# 15. NOT IN Operator

Specified values ko exclude karne ke liye `NOT IN` use hota hai.

### Example

    SELECT *
    FROM customers
    WHERE city NOT IN ('Delhi', 'Mumbai');

Ye Delhi aur Mumbai ko exclude karega.

---

# 16. LIKE Operator

`LIKE` ka use **pattern matching** ke liye hota hai.

Ye mostly text/string values ke saath use hota hai.

### Example

    SELECT *
    FROM customers
    WHERE customername LIKE 'A%';

---

# 17. Wildcard %

`%` zero, one ya multiple characters represent karta hai.

### Starts With

    WHERE customername LIKE 'A%';

Meaning:

Name `A` se start ho.

Examples:

- Amit
- Ankit
- Ajay

### Ends With

    WHERE customername LIKE '%a';

Meaning:

Name `a` par end ho.

### Contains

    WHERE customername LIKE '%an%';

Meaning:

Name ke andar `an` kahin bhi present ho.

---

# 18. Wildcard _

`_` exactly **one character** represent karta hai.

### Example

    SELECT *
    FROM customers
    WHERE customername LIKE '_a%';

Meaning:

Second character `a` hona chahiye.

Example:

- Ravi
- Rahul

Pattern actual data par depend karega.

---

# 19. IS NULL

NULL values ko check karne ke liye `=` use nahi karna chahiye.

Wrong:

    WHERE city = NULL;

Correct:

    WHERE city IS NULL;

### Example

    SELECT *
    FROM customers
    WHERE city IS NULL;

Ye un customers ko show karega jinki city missing/NULL hai.

---

# 20. IS NOT NULL

NULL values ko exclude karne ke liye:

    SELECT *
    FROM customers
    WHERE city IS NOT NULL;

---

# 21. Text Values ke saath WHERE

Text values ko quotes ke andar likhte hain.

### Example

    SELECT *
    FROM customers
    WHERE city = 'Delhi';

---

# 22. Numeric Values ke saath WHERE

Numbers ke around quotes required nahi hote.

### Example

    SELECT *
    FROM customers
    WHERE age > 25;

---

# 23. WHERE with SELECT

`WHERE` ko `SELECT` ke saath commonly use kiya jata hai.

### Example

    SELECT customername, city, age
    FROM customers
    WHERE age > 30;

---

# 24. WHERE with ORDER BY

Pehle records filter kar sakte hain aur phir sort kar sakte hain.

### Example

    SELECT *
    FROM products
    WHERE sellingprice > 1000
    ORDER BY sellingprice DESC;

Meaning:

1. Selling price 1000 se greater products filter honge.
2. Unhe highest price se lowest price tak sort kiya jayega.

---

# 25. WHERE with LIMIT

Filtered result mein limited rows return karne ke liye `LIMIT` use kar sakte hain.

### Example

    SELECT *
    FROM products
    WHERE sellingprice > 1000
    ORDER BY sellingprice DESC
    LIMIT 5;

Meaning:

1000 se expensive products mein se top 5 products.

---

# 26. Multiple Conditions

Multiple conditions combine karne ke liye `AND`, `OR`, `NOT` use kar sakte hain.

### Example

    SELECT *
    FROM customers
    WHERE age > 25
    AND gender = 'Female'
    AND city = 'Delhi';

---

# 27. WHERE vs HAVING

`WHERE` aur `HAVING` dono filtering ke liye use hote hain, lekin inka purpose different hai.

| WHERE | HAVING |
|---|---|
| Rows ko filter karta hai | Groups ko filter karta hai |
| GROUP BY se pehle apply hota hai | GROUP BY ke baad apply hota hai |
| Individual records par kaam karta hai | Aggregate/group results par kaam karta hai |
| Aggregate functions ke liye normally use nahi hota | Aggregate functions ke saath commonly use hota hai |

### WHERE Example

    SELECT *
    FROM customers
    WHERE age > 30;

### HAVING Example

    SELECT city, COUNT(*) AS total_customers
    FROM customers
    GROUP BY city
    HAVING COUNT(*) > 5;

---

# 28. Important WHERE Patterns

## Equal

    WHERE city = 'Delhi';

## Not Equal

    WHERE city <> 'Delhi';

## Greater Than

    WHERE age > 30;

## Less Than

    WHERE age < 30;

## Range

    WHERE age BETWEEN 20 AND 30;

## Multiple Values

    WHERE city IN ('Delhi', 'Mumbai');

## Exclude Multiple Values

    WHERE city NOT IN ('Delhi', 'Mumbai');

## Starts With

    WHERE customername LIKE 'A%';

## Ends With

    WHERE customername LIKE '%a';

## Contains

    WHERE customername LIKE '%an%';

## NULL

    WHERE city IS NULL;

## Not NULL

    WHERE city IS NOT NULL;

---

# 29. Practice Questions

## Basic WHERE

### Q1.
Saare customers find karo jo Nagpur se belong karte hain.

### Q2.
Saare female customers find karo.

### Q3.
30 se greater age wale customers find karo.

### Q4.
25 se younger customers find karo.

### Q5.
1000 se greater selling price wale products find karo.

### Q6.
500 se less selling price wale products find karo.

### Q7.
Exactly 30 years age wale customers find karo.

### Q8.
Delhi se belong na karne wale customers find karo.

---

## AND / OR

### Q9.
Female customers find karo jinki age 30 se greater hai.

### Q10.
Male customers find karo jo Mumbai se belong karte hain.

### Q11.
Delhi ya Mumbai ke customers find karo.

### Q12.
25 se greater aur 40 se less age wale customers find karo.

### Q13.
Nagpur ke customers find karo jinki age 25 se greater hai.

---

## BETWEEN

### Q14.
20 se 30 ke beech age wale customers find karo.

### Q15.
500 se 1500 ke beech selling price wale products find karo.

---

## IN / NOT IN

### Q16.
Nagpur, Delhi aur Mumbai ke customers find karo.

### Q17.
Nagpur, Delhi aur Mumbai ko chhodkar baaki cities ke customers find karo.

---

## LIKE

### Q18.
A se start hone wale customer names find karo.

### Q19.
'a' par end hone wale customer names find karo.

### Q20.
Jinke name mein `an` present hai un customers ko find karo.

### Q21.
Jinke name ka second character `a` hai un customers ko find karo.

---

## NULL

### Q22.
Jinke city column mein NULL value hai un customers ko find karo.

### Q23.
Jinke city column mein NULL value nahi hai un customers ko find karo.

---

## Advanced Filtering

### Q24.
Delhi ke female customers find karo jinki age 25 se greater hai.

### Q25.
1000 se greater aur 5000 se less selling price wale products find karo.

### Q26.
Specific categories ke products ko `IN` operator ka use karke find karo.

### Q27.
Delhi ya Mumbai ke customers find karo jinki age 30 se greater hai.

### Q28.
1000 se expensive products mein se top 5 most expensive products find karo.

### Q29.
20 se 40 age ke beech ke female customers find karo.

### Q30.
S se start hone wale products find karo.

### Q31.
Aise customers find karo jinke name mein `a` hai aur city Delhi hai.

### Q32.
Delhi ke nahi hain aur age 25 se greater hai, aise customers find karo.

---

# 30. Quick Revision

WHERE clause ka main purpose:

    Table se required rows ko filter karna.

Important operators:

    =
    <>
    !=
    >
    <
    >=
    <=

Important logical operators:

    AND
    OR
    NOT

Important range/value operators:

    BETWEEN
    IN
    NOT IN

Important pattern matching:

    LIKE
    %
    _

Important NULL operators:

    IS NULL
    IS NOT NULL

---

# 31. Most Important Query Structure

    SELECT column1, column2
    FROM table_name
    WHERE condition
    ORDER BY column_name ASC
    LIMIT 10;

SQL execution conceptually:

    FROM
    ↓
    WHERE
    ↓
    SELECT
    ↓
    ORDER BY
    ↓
    LIMIT

---

# 32. Key Takeaways

- `WHERE` rows ko filter karta hai.
- `=` equality check karta hai.
- `<>` aur `!=` not equal ke liye use hote hain.
- `>` aur `<` comparison ke liye use hote hain.
- `AND` mein sabhi conditions true honi chahiye.
- `OR` mein koi ek condition true ho sakti hai.
- `NOT` condition ko reverse karta hai.
- `BETWEEN` range filtering ke liye use hota hai.
- `IN` multiple values check karne ke liye use hota hai.
- `NOT IN` multiple values exclude karne ke liye use hota hai.
- `LIKE` pattern matching ke liye use hota hai.
- `%` multiple characters represent karta hai.
- `_` exactly one character represent karta hai.
- NULL check ke liye `IS NULL` aur `IS NOT NULL` use karo.
- `WHERE` aur `HAVING` same nahi hain.
- Complex conditions mein parentheses `()` use karna useful hota hai.

# End of Filtering with WHERE