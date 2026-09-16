use sql_ml;

-- Give the individual product whose mrp > 20000

select *
from products
where mrp>2000;

-- which supplier have more than 3 products
/*
we can use having cluse
individual row pr filter lagana ho to where clause
group by pr filter lagana hai to having caluse 
*/
select 
 SupplierID,
 count(*) as product_count
from products
group by SupplierID
having product_count >3;

-- which customers have place more than 5 order

select 
 customerid,
 count(orderid)as no_of_order
from orders
group by CustomerID
having no_of_order>5;

select 
 customerid,
 count(orderid)as no_of_order
from orders
group by CustomerID
having no_of_order>5
order by no_of_order desc;

-- supplier with 2 or fewer product
select 
 SupplierID,
 count(*) as no_of_prod
 from products
 group by SupplierID
 having no_of_prod>=1;

-- product with sales above 5000
select 
 productid,
 sum(total) as total_sales
 from order_items
 group by ProductID
 having total_sales>50000;
 
 select supplierId,
   count(*)as no_of_product
from products
where mrp>1000
group by SupplierID
having no_of_product >2
order by  no_of_product desc
limit 5;

use sql_ml;

/*
(1). Display supplierid and the number of product supplied by each supplier
show supllier with the highest num of product first.
*/

select 
  supplierid,
  count(*) as no_of_product
from products
group by SupplierID
order by no_of_product desc;
    
/* Display the total sales value for each productid using
 the total column for each item .display the product from highest to lowest 
 sales value and show only the top 10.
 */
 select 
   productid,
   sum(total) as Total_sales
from order_items
group by productid
order by Total_sales desc
limit 10;

/*
Display only product whose total sales value is greater then 50,000
sorted by total sales value from highest to lowest.a
*/

/*
Where : filter hume individual row pr filter lagata hai
haviging : agreegation pr filter lagata hai
*/
select 
  productid,
  sum(total)as total_sales
from order_items
group by ProductID
having total_sales >50000 
order by total_sales desc;

select 
  productid,
  sum(total)as total_sales
from order_items
group by ProductID
order by total_sales >50000  desc;


/*
for only payments where status = "success".
calculate the number of transaction and total payment amount for each method.
display method with the highest total payment amount first.
*/
select 
  method,
  status,
  count(*) as no_of_transection,
  sum(amount) as total_payment
from payments
where Status = "Success"
group by method
order by total_payment desc;

/*
calculate the num of order placed by every customerID.
Display only customer who have place more than 3 orders.
*/
select 
  customerid,
  count(*)no_of_order_placed
from orders
group by CustomerID
having no_of_order_placed >3
order by no_of_order_placed desc;

/*
Consider only product having on MRP greater than 2,000.
for each category ,count the num of such product.
display only categories having more than 2 qualifying products.
*/
select 
  categoryid,
  count(*) as no_of_product
from products
where mrp >2000
group by CategoryID
having no_of_product >2;

/*
for every wherehouse,calculate:
1.total stock
2.avg stock per inventory recors
3.maximun stock
4.minimum stock
sort warehouse by total stock from highest to lowest.alter
*/

select 
   WarehouseID,
  sum(stock) as total_stock,
  avg(stock)as avg_stock,
  max(stock) as max_stock,
  min(stock) as min_stock
from inventory
group by WarehouseID
order by total_stock desc;

/*
for every status in the order table, calculate the num of orders.
Display the most common order status first,
*/
select 
 status,
 count(*) as no_orders
from orders
group by status
order by no_orders  desc;

/*
Consider only order_items record where sellingprice >10000.for each productid,calcualte:
no_of_order-item records
total quantity sold
total_sales value
avg_selling price

display only product whose total sales value is greater than 50000.
sorted by total sales valaues highest to lowest
*/
select 
  ProductID,
  count(OrderItemID) as no_of_orderitems,
  sum(Quantity)as total_quantity_sold,
  sum(total)as total_sales,
  avg(SellingPrice) as avg_selling_price
from order_items
where SellingPrice>1000
group by  ProductID
having total_sales >5000
order by total_sales desc;

