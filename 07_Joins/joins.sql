-- joins

/* Syntax:
select 
from table1
join table table2
on table1.key =  table2.key
*/
use sql_ml;

/* Show me the product name and the category name.
product -- product name
linkage -- categoryId
category-- category Name
*/
select  
  p.productid,
  p.productname,
  c.CategoryID,
  c.categoryname
from products as p
join categories as c
on p.categoryid=c.CategoryID;

-- Display products belong to the electronic category.
select 
  p.productname,
  c.categoryname
from products as p
join categories as c
on p.CategoryID=c.CategoryID
where CategoryName="Electronics";

-- Display products with their category name,sorted by mrp from highest to lowest.
select 
   p.ProductID,
   p.productname,
   c.CategoryID,
   c.categoryname
from products as p
join categories as c
on p.CategoryID=c.CategoryID
order by p.MRP desc;

-- Display productname,categoryname and discount amount
select 
  p.ProductID,
  p.productname,
  c.CategoryID,
  c.categoryname,
  p.mrp - p.sellingprice as discount_amount
from products as p
join categories as c
on p.CategoryID=c.CategoryID;

-- Display each product along with its supplier name and supplier state.

select 
  p.productname,
  s.SupplierID,
  s.suppliername,
  s.state
from products as p
join suppliers as s
on p.SupplierID= s.SupplierID;

-- Display all cancelled custommer order along with customer name and city.
select 
  c.name,
  c.city,
  o.Status
from customers as c
join orders as o
on c.customerid=o.CustomerID
where status ="Cancelled";

-- Calaculate total sales value for every order.
select 
   o.orderid,
   sum(oi.total) as total_sales
from order_items as oi
join orders as o
on oi.OrderID=o.OrderID
group by o.OrderID;

-- calculate total sales value genrated by each customer.
/*
customername --> customers table
no linkage between two table . 
linkage table -> oders (third table)
total sales --> order_items

*/
select
   c.CustomerID,
   sum(oi.total) as total_sales
from customers as c
join orders as o
on o.customerid=c.customerid
join order_items as oi
on  oi.orderid =o.orderid
group by c.CustomerID;

-- Product-wise sales with product Name
select 
  p.ProductID,
  p.ProductName,
  sum(oi.Total) as total_sales
from products as p
join order_items as oi
on p.ProductID=oi.ProductID
group by p.ProductName ,p.ProductID;

-- CategoryName-wise total sales;

select 
  c.categoryid,
  c.categoryname,
  sum(total) as total_sales
from categories as c
join order_items as oi
join products as p
on oi.ProductID=p.ProductID
on p.CategoryID=c.CategoryID
group by c.CategoryID,CategoryName
order by total_sales desc;  

-- calculate total sales genrated by products from each supplier:
select
  s.supplierid,
  s.suppliername,
  sum(total) as total_sales
from products as p 
join order_items as oi
on p.ProductID =oi.ProductID
join suppliers as s
on s.SupplierID =p.SupplierID
group by s.SupplierID,s.SupplierName
order by total_sales desc;

-- Display all products and any orders-items sales associated with then
select 
  p.productid,
  p.productname,
  sum(total) as total_sales
from products as p
join order_items as oi
on p.ProductID = oi.ProductID
group by  p.ProductID,p.ProductName
order by total_sales desc;

-- Find products with no sales
/*
concept of left join 
*/
select 
 p.productid,
 p.productname,
 sum(total) as total_sales
from products as p
left join order_items as oi
on p.ProductID =oi.ProductID
where oi.ProductID is null
group by p.productid, p.ProductName;

-- Customer who registered but never have placed an order.
select 
  c.name,
  c.customerid,
  o.orderid
from coustomers as c
left join orders as o
 on o.CustomerID=c.customerid
 where o.OrderID is null;
 
 use sql_ml;
 /*for every customer show the num of order they have placed.
  including customers with zero orders.
  
  count(*): count null values
  count(colum name): not count null values
 */
select 
  c.CustomerID,
  c.name,
  count(*) as no_of_order
from customers as c
left join orders as o
on c.customerid=o.customerid
group by c.CustomerID ,c.name
order by no_of_order desc;

-- using right join
select 
  c.CustomerID,
  c.name,
  count(*) as no_of_order
from orders as o
right join customers as c
on c.customerid=o.customerid
group by c.CustomerID ,c.name
order by no_of_order desc;

-/*
customerid,
customer name,
No of order placed
Total amount paid througn successful payment only
Display only customers whose successful payment amount is greater than 5000.
*/
select 
  c.CustomerID,
  c.Name,
  count(distinct o.OrderID) as no_of_orders,
  sum(p.Amount) as Total_Amount_paid
from customers as c
inner join orders as o
  on c.CustomerID=o.CustomerID
inner join payments as p
  on o.OrderID=p.OrderID
where p.status="Success"
group by c.CustomerID,c.name
having total_amount_paid >50000
order by total_amount_paid desc;

/*
Product Id, --> Product table
product name, -- Product table,
categoryname, --> category table
suppliername,  --> supplier table
Number of times the product appeared in order items --> order items
Total quantity sold --order items
Total sales value   -- order items
Average selling price  -- order items

only include products where the total sales value is greater then 1,00,000
*/
select 
 p.productid,
 p.productname,
 c.CategoryName,
 s.SupplierName,
 count(o.OrderID) as No_of_records,
 sum(Quantity) as Total_quality,
 sum(Total) as Total_sales,
 avg(o.SellingPrice) as avg_sellingprice
from products as p
inner join  categories as c
  on p.CategoryID =c.CategoryID
inner join suppliers as s
  on s.SupplierID =p.SupplierID
inner join order_items as o
  on o.productid =p.productid
group by p.productid,
         p.productname,
         c.CategoryName,
         s.SupplierName
having Total_sales >100000
order by Total_sales;


/*
Consider only products having on MRP greater than 20,000.

for every category ,calculate:
categoryid, --> Categories table
categoryname, --> Categories table
Number od qualfying products --> products 
Avg Mrp of qualifying products
Maximum MRP,
Minimum MRP

Display only categories having more than 2 qualifuing products.
sort by avg mrp from highest to lowest

*/

select 
 c.categoryid,
 c.categoryname,
 count(p.productid) as No_of_products,
 round(avg(p.Mrp),1)as avg_mrp,
 max(p.mrp) as max_mrp,
 min(p.mrp) as min_mrp
from categories as c
inner join products as p
on c.CategoryID=p.CategoryID
where p.mrp > 2000
group by  c.categoryid,
		  c.categoryname
having no_of_products >2
order by avg_mrp desc;


/*
Find all customers who have never placed an order.
Display:
  customerid,
  customer name,
  city,
  state
  
sort the result alphabetically by customer name
*/
select c.customerid,
		c.name,
        c.city,
        o.OrderID
from customers as c
left join orders as o
on c.CustomerID=o.CustomerID
where o.OrderID is null
order by c.name;

/*
For every supplier,calculate:
Supplierid,
suppliername,
Number of products supplied,
avg mrp of their products,
total sales genrated by their products,
total quantity sold

include suppliers even if their products have never been sold.
for suppliers with no sales, display the sales and quantity as 0
sort supplier by total sales from highest to lowest.

*/
select  s.supplierid,
        s.suppliername,
        count(p.productid) as no_products,
        avg(p.mrp)as avg_mrp,
        sum(o.total) as Total_sales,
        sum(o.quantity) as Total_quantity
from suppliers as s
inner join products as p
  on s.SupplierID=p.SupplierID
inner join order_items as o
  on o.ProductID=p.ProductID
group by s.supplierid,
         s.suppliername
order by Total_sales desc;

use sql_ml;
/*
Warehouseid, --> warehouses
Warehousename, --> warehouses
Num of orders handle,--> orders
Total quantity of product sold --> order_items
Total sales values --> order_items
Include warehouse even if they have no order

Display only warehouse where the total sales value is greater than 2,00,000.
sort from highest to lowest total sales
*/
select  w.warehouseid,
        w.warehouse,
        count(distinct o.orderid) as No_of_order,
        coalesce(sum(oi.Quantity),0) as Total_quality,
        coalesce(sum(oi.Total)) as Total_sales
from warehouses as w
inner join orders as o
  on w.WarehouseID=o.WarehouseID
inner join order_items as oi
  on oi.OrderID=o.OrderID
group by w.warehouseid,
          w.warehouse
having total_sales > 200000
order by total_sales desc;

/*
Calculate the total sales value genrated by every customer.
then Display only those customer whose total spending is greater than
 the avg customer spending.
Display:
customerid,
customername,
total spending

sort from highest spending to lowest.
*/

/*avg customer spending.
c1--> s1
c2 --> s2
....
avg cust spending --> (s1+s2+s3,....)/n
why not avg(total)
*/

select c.customerid,
       c.name,
       sum(oi.total) as Total_sales
from customers as c
inner join orders as o
  on c.CustomerID =o.CustomerID
inner join order_items as oi
  on o.OrderID=oi.OrderID
group  by c.customerid,
          c.name
having total_sales>(SELECT 
    round(AVG(total_sales),2) AS avg_total_sales
FROM (
    SELECT 
        o.CustomerID,
        SUM(oi.total)AS total_sales
    FROM order_items AS oi
    INNER JOIN orders AS o
        ON o.orderid = oi.orderid
    GROUP BY o.customerid
    ) 
AS customer_sales
)
order by total_sales desc;

/*
For every product,calculate its total sales value.

Display only product whose total sales value is greater then the avg total sales value of product
bekonging to the same category.

Display :
   1. product id,
   2.productname,
   3.categoryname,
   4,Total Sales
sort by total sales from highest to lowest

*/
WITH product_sales AS (
    SELECT
        p.ProductID,
        p.ProductName,
        p.CategoryID,
        c.CategoryName,
        SUM(oi.Total) AS Total_Sales
    FROM products AS p
    INNER JOIN categories AS c
        ON p.CategoryID = c.CategoryID
    INNER JOIN order_items AS oi
        ON p.ProductID = oi.ProductID
    GROUP BY
        p.ProductID,
        p.ProductName,
        p.CategoryID,
        c.CategoryName
),

category_avg AS (
    SELECT
        CategoryID,
        AVG(Total_Sales) AS Avg_Total_Sales
    FROM product_sales
    GROUP BY CategoryID
)

SELECT
    ps.ProductID,
    ps.ProductName,
    ps.CategoryName,
    ps.Total_Sales
FROM product_sales AS ps
INNER JOIN category_avg AS ca
    ON ps.CategoryID = ca.CategoryID
WHERE ps.Total_Sales > ca.Avg_Total_Sales
ORDER BY ps.Total_Sales DESC;

-- case when  statement
-- if-elseif-else
/*symtax:
  when conditiona1 then result1
  when condition2 then result2
  else default_result

*/
select Name,
       age,
	   gender,
       city,
       case
         when age >18 & age <=20 then "genz"
         when age >=21 & age <=40 then "adult"
         else "senior_citizen"
	   end  as ege_group
from customers ;

select c.customerid,
	   c.name,
       c.gender,
       case
       when Gender="F" then "Female"
       else "Male"
       end as Gender_new
from customers as c;

/*
For every order, Calculate the total order value by adding the total column from order_items.
then classify each order as:

High value -> total order value >= 50,000
Medium value -> Total order value between 20,000 and 40,000
Low value -> Total order value < 20,000

Display :
    1. orderid,
    2. order date,
    3. customername.
    4.total order value. --order items
    5.order category -- creating using total_sales
show the highest -value order fist
*/
select  o.orderid,
        o.orderdate,
        c.name,
        sum(oi.Total) as total_sales,
        case
        when sum(oi.total) >=50000 then "High value"
        when sum(oi.total)>=20000 then "Medium value"
        else "Low value"
        end as order_category
from orders as o
inner join customers as c
  on o.CustomerID=c.CustomerID
inner join order_items as oi
   on o.OrderID=oi.OrderID
group by  o.orderid,
        o.orderdate,
        c.name
order by order_category desc;


/*
create a category-level sales report containing:
   Categoryid,
   categoryName,
   Number of product in the category,--> product table
   Number of different product sold,  --> order_items
   Total quantity sold  
   avg selling price
   
   only consider order-items records where:
        sellingprice >10000
   display only category where :
        total_sales value >500000

*/
select c.categoryid,
       c.categoryname,
       count(distinct(p.productid)) as No_of_product,
       count(distinct(oi.ProductID)) as No_of_different_product_sold,
       sum(oi.quantity) as Total_quality_sold,
       sum(oi.total) as total_sales,
       avg(oi.sellingPrice) as avg_selling_price
from categories as c
inner join products as p
  on c.CategoryID=p.CategoryID
inner join order_items as oi
  on p.ProductID=oi.ProductID
where oi.SellingPrice >1000
group by c.categoryid,
       c.categoryname
having total_sales > 50000
order by total_sales desc;

/*
Find products where:
MRP is greater then 15000 --> where 
discount percentage is greater than 20% -->having
Total sales value is greater then 75000  -->having

Display:  
   1.productid, --> products table
   2.productname, --> products table,
   3.categoryname, --> category table,
   4.Mrp, -->product table,
   5.sellingprice,  --> products
   6.Discount percentage, --> derived (mrp- sellingprice)*100/mrp
   7.total sales -->products table
Sort by disount percentage from highest to lowest

*/
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.MRP,
    p.SellingPrice,
    ((p.MRP - p.SellingPrice) * 100) / p.MRP AS discount_percentage,
    SUM(oi.Total) AS Total_sales
FROM products AS p
INNER JOIN categories AS c
    ON p.CategoryID = c.CategoryID
INNER JOIN order_items AS oi
    ON p.ProductID = oi.ProductID
WHERE p.MRP > 15000
GROUP BY 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.MRP,
    p.SellingPrice
HAVING 
    ((p.MRP - p.SellingPrice) * 100) / p.MRP > 20
    AND SUM(oi.Total) > 75000
ORDER BY discount_percentage DESC;

use sql_ml;
/*For every employee, calculate:

employeeid, --> employees
employeename, --> employess
department,  --> employess
No of orders handle, --> order_itmes
No of order whose total value exceeds 50000  --> case when
total sales value of all orders handler   --> order_items

Display only employees who have handle at least 5 orders.  --> having
sort employee by total sales value from higher to lowest.   
*/
select e.employeeid,
       e.name,
       e.department,
	   count(distinct o.OrderID) as orders_handled,
       count(
         distinct case
         when order_totals.order_value >50000
         then o.OrderID
         end
       )as highvalueorders,
       sum(order_totals.order_value) as total_sales
from employees as e
inner join orders as o
  on e.EmployeeID=o.EmployeeID
inner join (select 
                 OrderID,
                 sum(total) as order_value
			from order_items 
            group by OrderID) as order_totals
  on o.OrderID=order_totals.OrderID
  group by e.employeeid,
       e.name,
       e.department
having orders_handled >=5
order by total_Sales desc;

/*For every employee, calculate:

employeeid --> employee
employee name --> emplpyee
department -->  employee
no of order handle --> orders
no of different customers served --orders

display only employees who have handle more than 5 order --> having
sort employee by number of order handle from higest to lowest -- order by
*/
select e.employeeid,
       e.Name,
       e.Department,
       count(distinct(o.OrderID)) as total_order,
       count(distinct(o.CustomerID)) as different_customers
from employees as e
inner join orders as o
  on e.EmployeeID=o.EmployeeID
group by e.employeeid,
       e.Name,
       e.Department
having total_order >5
order by total_order desc;

/*For every city,calculate:
    number of customers
    number of orders
    total sales
    avg order-items value
display only cities where the total sales value is greater then 3,00000
sort cities by total sales id descending order
*/
select 
       c.city,
       count(distinct(c.customerid)) as num_of_customer,
       count(distinct(o.orderid)) as num_of_orders,
       sum(oi.total)as total_sales,
       avg(oi.Total) as  avg_item_value
from customers as c
inner join orders as o
  on c.CustomerID =o.CustomerID
inner join order_items as oi
  on oi.OrderID=o.OrderID
group by c.City
having total_sales > 300000
order by total_sales desc;

/*For every product that has been sold , calculate:
productid,
productname,
number of orders containing the product,
total quantity sold
avg sellling price

display only product whose avg selling price is greater than 5,000
show the highest avg selling price first
*/
select p.productid,
	   p.productname,
       count(distinct(oi.OrderID)) as num_of_orders,
       sum(oi.quantity) as total_quantity,
        avg(oi.sellingprice) as avg_selling_price
from products as p
inner join order_items as oi
  on p.ProductID=oi.ProductID
group by p.productid,
	   p.productname
having avg_selling_price >1500
order by avg_selling_price desc;

/*for every category ,calculate:
categoryname
num of products
max mrp,
min mrp
difference betweeen max and min
display only categories where the different between 
the maxmimum and minimum mrp is greater then 10000 
*/
select c.categoryname,
       count(distinct(p.productid)) as num_of_product,
       min(p.mrp) as min_mrp,
       max(p.mrp) as max_mrp,
       max(p.mrp)-min(p.mrp) as mrp_diff
from categories as c
inner join products as p
  on c.CategoryID=p.CategoryID
inner join order_items as oi
  on p.ProductID=oi.ProductID
group by c.categoryname
having mrp_diff>100;

use sql_ml;
/*for each payment method,calculate:
Num of successful transections,
total successfull payment,
avg sucessfull payment,
maximum sucessfull payment

display only payment method having more then 10 sucessful transection 
sort by avg trnasection amount from highest to lowest
*/













/*For evert warehouse,calculate:
    warehouseid, --> warehouses
    warehousename, --> warehousename
    num of inventory records, --> inventory 
    total stock,  --> inventory
    avg stock,   --> inventory 
    highest stock in single inventory records --> inventory 
display only warehouse where the avg stock per inventory records is greater then 100.

sort by total stock descending
*/
select 
   w.warehouseid,
   w.warehouse,
   count(i.WarehouseID)  as num_of_inventory_record,
   sum(i.stock) as total_stock,
   round(avg(i.stock),2) as avg_stock,
   max(i.stock) as max_stock
from warehouses as w
inner join inventory as i
   on  w.WarehouseID=i.WarehouseID
group by  w.warehouseid,
          w.warehouse
having avg_stock > 100;

/*find product that:
exist in the product catalogue
have inventory records
have never appeared in any order items
Display:
    productid,
    productname,
    supplierid,
    num of inventory records,
    total stock
sort by total stock from highest to lowest
*/
select p.productid,
	   p.productname,
       p.supplierid,
       count(i.warehouseid) as num_of_inventory_records,
       sum(i.stock) as total_stock
from products as p
inner join inventory as i
  on p.ProductID=i.ProductID
left join order_items as oi
  on p.ProductID=oi.ProductID
where oi.ProductID is null
group by p.productid,
	    p.productname,
        p.supplierid
order by total_stock;

/*For each supplier ,calculate:
  suppliername,
  number of products,
  avg mrp,
  highest mrp,
  lowest mrp,
  classify each supplier as:
profit supplier if avg mrp >= 38,000,
mid-range supplier if avg mrp >= 15000
buduget supplier otherwise
display the supplier with the highest avg mrp fisrt.
*/
select  s.suppliername,
		count(p.productid) as no_of_product,
        avg(p.mrp) as avg_mrp,
        max(p.mrp) as highest_mrp,
        min(p.mrp) as lowest_mrp,
        case
          when avg(p.mrp)>=38000 then "profit_suplier"
          when avg(p.mrp) >=15000 then "Mid range suplier"
          else "buduget supplier" 
          end as supplier_category
from suppliers as s
inner join products as p
  on s.SupplierID=p.SupplierID
group by  s.suppliername
order by avg_mrp desc; 
 
 /*
 Display:
   customerid, --> customers
   customername,  --> customers
   number of different categories purchased  --> product
   total quantity purchased  --> order_itmes
   total amount spent  --> order_itmes
sort by number of different catgories purchased from highest to lowest.
 */
 select c.customerid,
		 c.name,
         count(distinct p.CategoryID) as diff_categories,
         sum(oi.quantity) as total_quality,
         sum(oi.total) as total_amount
from customers as c
inner join orders as o
  on c.CustomerID =o.CustomerID
inner join order_items as oi
   on oi.OrderID=o.OrderID
inner join products as p 
  on oi.ProductID=p.ProductID
group by c.customerid,
		 c.name
order by diff_categories desc;

/*Find customer who have at least one order associated with a failed payment.
  Display:
    customerid,
    customername,
    number of orders having failed payment,
    total value of these orders
display customers with the highest failed- payment order value first.
*/
select  c.customerid,
        c.name,
        count(distinct o.OrderID) as total_failed_order,
        sum(oi.total) as total_value
from customers as c
inner join  orders as o
 on c.CustomerID=o.CustomerID
inner join order_items as oi
  on o.OrderID=o.OrderID
inner join payments as p
  on p.OrderID=oi.OrderID
where p.Status="Failed"
group by  c.customerid,
        c.name
order by total_value desc;

/*Find employees who have handle at least one order 
whose total value is greater than 75000

  Display:
        employeid, -- employee
        employementname,  -- employee
        number of high-value orders  --> orders
        total value of high-value orders  --> order_items
        avg high-value order amount  -->order_items
sort by total high-value sales from highest to lowest.
*/
select e.employeeid,
        e.name,
        count(distinct(o.OrderID)) as no_of_orders,
        sum(oi.Total) as high_value_sales_amt,
        avg(oi.total) as avg_high_value_sales
from employees as e
inner join orders as o
  on e.EmployeeID=o.EmployeeID
inner join order_items as oi
  on o.Orderid =oi.OrderID
group by e.employeeid,
        e.name
having high_value_sales_amt >75000
order by high_value_sales_amt desc;

use sql_ml;
/*Find product whose mrp is greater then the avg mrp of all products.
  Display:
       productid,
       productname,
       categoryname,
       mrp
sort by highest mrp to lowest
*/
select p.ProductID,
       p.ProductName,
       c.CategoryName,
       p.MRP
from products as p 
inner join categories as c
 on p.categoryid=c.categoryid
where p.mrp>( select avg(p.mrp) from products)
order by p.mrp desc;

/* total_stock >=5000 then high stock
   total_stock >=2500 then medium stock
   else : low stock 
stock classification
Display:
         warehouseid,
         warehose name,
         total stock,
         avg stock,
         stock classification --> case when on stock column-- inventory table
sort warehouse by total stock descending
*/
select w.WarehouseID,
       w.Warehouse,
       sum(i.Stock) as total_stock,
      round(avg(i.stock),2) as avg_stock,
       case 
        when sum(i.stock) >=5000 then "high stock"
        when sum(i.stock) >=2500 then "medium stock"
        else "low stock"
        end as stock_classification
from warehouses as w
inner join inventory as i
   on w.warehouseid=i.warehouseid
group by w.WarehouseID,
         w.Warehouse
order by total_stock desc;


/*Find customer who placed order on more than 2 different order dates.
Dispaly:
    customerid,
    custmoername,
    number of different dates,
    total number of order,
    total quantity purchesed,
sort by number of different order dates from highest to lowest.
*/
select c.customerid,
       c.Name,
	   count(distinct(o.OrderDate)) as num_of_order_date,
       count(o.orderid) as total_order,
       sum(oi.Quantity) total_qty
from customers as c
inner join orders as o
  on c.CustomerID=o.CustomerID
inner join order_items as oi
  on o.OrderID=oi.OrderID
group by c.customerid,
       c.Name
having num_of_order_date >2
order by num_of_order_date desc;

/*For each category,find the product having the highest MRP.
Display:
    categoryname,
    productid,
    productname,
    mrp
sort by categories alplhabetically
*/
select 
    c.CategoryName,
    p.ProductID,
    p.ProductName,
    p.MRP
from categories as c
inner join products as p
    on c.CategoryID = p.CategoryID
where p.MRP = (
    select max(p2.MRP)
    from products as p2
    where p2.CategoryID = p.CategoryID
)
order by 
    c.CategoryName,
    p.ProductID,
    p.ProductName,
    p.MRP;