use sql_ml;

/*
for each supplier,calcualte:
no of products supplied
avg mrp of those products
max mrp of those products

Display only suppliers who supply at least 3 products.
sort them the no of product supplies from highest to loweset 
*/

select 
   supplierid,
  count(*) as no_of_product,
  avg(mrp)as avg_of_mrp,
  max(mrp) as max_mrp
from products
group by SupplierID
having no_of_product >=3
order by no_of_product desc;

/*
Find each category Id where avg mrp of product is greater than 1500.
Display
category id,
no_of products,
avg mrp,
max mrp

Sort categories by avg mrp from highest to lowest
*/

select 
  categoryid,
  count(*) as no_of_product,
  avg(mrp)as avg_mrp,
  max(mrp)as max_mrp
from products
group by CategoryID
having avg_mrp >1500
order by avg_mrp desc;

/* Using order_items,calculate the total quantity sold and
total sales value for every product.

Display only products where:
Total quantity sold is at least 10.
total sales value is grater then 100000

sort by total sales value descending
*/

select 
 productid,
 sum(quantity) as Total_Quantity,
 sum(total) as Total_sales
from order_items
group by productid
having total_quantity >=10 and  total_sales>10000
order by total_sales desc;

/*
Find product where the selling price is lower then mrp.
Display:
   1. Productid,
   2.Productname,
   3.mrp,
   4.selling price,
   5.discount amount,
   
sort product by the highest discount amount first.
*/

select
  ProductID,
  productname,
  mrp,
  sellingprice,
  (MRP-sellingprice) as discount_amount
from products
where SellingPrice <mrp
order by discount_amount desc;

/*
Find product where the discount is at least 10% of mrp.

Display:
     1. productid
     2.productname
     3.mrp
     4.sellingprice
     5.discount precentage
sort by discount percentage from higher to lower

*/

select 
  productid,
  productname,
  mrp,
  sellingprice,
  round(((mrp-sellingprice)/mrp),2)*100 as discount_percentage
from products
where round(((mrp-sellingprice)/mrp),2)*100>=10 
order by discount_percentage desc;

/* where clause sabse pahle execute hota hai esliye 
ye column present nhi tha to formula pr hi where apply kiye
*/

/*
Consider only sucessful payments.
for each payment method,calculate:
  1.no of sucessful transection
  2. total payment amount
  3.avg paymment amount
  4.max payment amount
Display only method where the total succesful payment amount exceed 100000
*/

select 
  method,
  count(*) as No_of_sucessful_transection,
  sum(amount)as Total_amount,
  avg(amount)as avg_amount,
  max(amount)as max_amount
from payments
where Status="Success"
group by method
having total_amount >10000;

/*
Find the customer who have places between 4 and 8 orders ,inclusive.
Display:
  1. customerid
  2.No of orders
sort the customer by order count descending and display only the top 10
*/

select 
  customerid,
  count(*) as No_of_order
from orders
group by customerid
having no_of_order >=4 and no_of_order<=8
order by no_of_order desc
limit 10;

select 
  customerid,
  count(*) as No_of_order
from orders
group by customerid
having no_of_order between 4 and 8
order by no_of_order desc
limit 10;

/*
For each warehouse ,calculate:
 1.total stock
 2.avg stock
 3.highest stock for product
 4.lowest stock for a product
 
 Display omly warehousse where total stock is greater then 500.analyze
 sort by total stock descending
*/

select 
   WarehouseID,
  sum(stock) as total_stock,
  avg(stock)as avg_stock,
  max(stock)as highest_stock,
  min(stock)as low_stock
from inventory
group by WarehouseID
having total_stock >500
order by total_stock desc;

/*
Find product that have at least one inventory record where stock is below 20 units.
Display:
   1.productid,
   2.no of inventory records
   3.minimum stock
   4.max stock
   
show only product whose minimum stock is below 20
*/
select
  productid,
  count(*) as no_of_inventory_records,
  min(stock)as min_stock,
  max(stock)as max_stock
from inventory
group by productid
having min_stock <20
order by min_stock;

/*
Calculate the num of order and percentage of total order represent by each order status
*/
select 
  status,
  count(*) as no_of_order,
  round(count(*)*100.0/(select count(*) from orders),2) as percentage_of_orders
from orders
group by status
order by no_of_order;

/*
Using order_items, find the top 5 product based on total quantity sold.alter
Display:
  1.Productid,
  2.Total quality sold,
  3.no of order-items records,
  4.Total sales values
  
*/
select 
  productid,
  sum(Quantity) as total_quantity_sold,
  count(*) as No_of_order_items,
  sum(total) as total_sales
from order_items
group by productid
order by total_quantity_sold desc
limit 5;

/*
Consider only order-items records where 
total value of item is greater then 25000.

for each product : calculate:
   1. no of such records
   2.total quantity
   3.total sales values
Display product having at least 3 qualifying records.
*/
select 
   ProductID,
   count(*) as no_of_order,
   sum(quantity) as sum_of_quantity,
   sum(total) as total_sales
from order_items
where total >2500
group by  ProductID
having   no_of_order>=3;

/*
For each product ,calculate:
  1.minimum selling price,
  2.maximum selling price,
  3.avg selling price,
  4. num of ordre-items records
display only product where the minimum selling price is greater then 10000
sort by avg selling price descending
*/

select 
  productid,
  count(*) as no_order_items,
  min(sellingprice)as min_sellingprice,
  max(sellingprice)as max_sellingprice,
  avg(sellingprice)as avg_sellingprice
from order_items
group by productid
having min_sellingprice >1000
order by avg_sellingprice desc;

/*
For every where house, calculate:
 No of different product stored
 total stock
 avg stock per product
 
 display only warehouse storing at least 5 diffeent products.
 
 sort by total stock descending.analyze

*/
select 
  warehouseid,
  count(distinct productid) as no_of_product,
  sum(stock)as total_stock,
  round(avg(stock),2) as avg_stock
from inventory
group by WarehouseID
having no_of_product >=5
order by total_stock desc;

-- Find the product whose MRP is greater then the avg MRP of all products.

select avg(mrp) from products;
select 
   productid,
   mrp
from products
where  mrp >= 2312.7400;

select 
   productid,
   mrp
from products
where  mrp >= 
            (select avg(mrp) 
            from products);
            
-- find product whose mrp is below the avg mrp.
select 
  productid,
  mrp
from products
where mrp <(select avg(mrp) from products);

-- find the product or products having the highest MRP.

select 
  * from products
  where mrp = (select max(mrp) from products);
  
 -- find those products which have the top 5 mrp price.
 
 select distinct(mrp)
 from products
 order by mrp desc
 limit 5;
 
 use sql_ml;
 
 -- Find all the products whose mrp is greater then the avg mrp
 
 select
  productid,
  mrp
from products
where mrp > (select round(avg(mrp),2) from products);

-- filter out those product whhose mrp is among the top 5 distinct mrp products.

select distinct(mrp)
from products
order by mrp desc
limit 5; 

select min(distinct(mrp))
from products
order by mrp desc
limit 5; 

select * 
from  products
where (mrp =4937) or (mrp=4927) or(mrp=4880) or (mrp=4698) or (mrp=4662);

select *
from products
where mrp in (4937,4937,4662,4662,4880);

select * 
from products
WHERE MRP in 
	(SELECT distinct(mrp)
	from products 
	order by mrp desc
	limit 5
    );
    
-- find the product or products having the highest mrp

select *
from products
where mrp in 
     (select max(mrp)
     from products);

select *
from products
where mrp = 
     (select max(mrp)
     from products);
     
-- find products supplied by suppliers who supply at least 5 products.
select 
 supplierid,
 count(*) as no_of_products
from products
group by SupplierID
having no_of_products>=5;

-- Find customer IDs who have placed atleast 3 orders.
select 
 customerid,
 count(*) as no_of_orderplaced
from orders
group by customerid
having no_of_orderplaced >=3
order by no_of_orderplaced desc;

-- Display details of those customers who have placed atleast 3 orders.

select 
 customerid
from orders
group by customerid
having count(*) >=3;

select * 
from customers
where CustomerID in (
                     select 
                       customerid
					from orders
                    group by CustomerID
                    having count(*) >=3);
                    

/* find suppliers whose no of products is greater then the 
avg no of product supplied per supplier.
*/

select 
  supplierid,
  count(*) as no_of_product
from products
group by supplierid;

select 
    avg(no_of_product)
from (
    select 
        supplierid,
        count(*) as no_of_product
    from products
    group by supplierid
) as supplier_product_count;
