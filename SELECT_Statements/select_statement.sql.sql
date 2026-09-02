use sql_ml;

select * from categories;

select * from categories limit 5;

-- show me the top 10 records of the customers
select * from customers limit 10;

-- show the names of all the coustomers:
select name from customers ;

-- show customers citites.
select city from customers;

-- Finance want only payment methods.
select * from payments limit 5;
select Method from payments;

-- HR wants employee names.
select * from employees;
select name from employees;

-- show  multiple column 
select * from products;
select 
ProductID,
ProductName
from products;

-- show product_id,product_name,category_id
select 
ProductID,
ProductName,
CategoryID
from products;

--  kon se customer kon se city se belong krte hai
/*
Distinct hum krte hai unique value ke liye
*/
select distinct city from customers;

-- Finance want only how many payment method
select distinct method 
from payments;

-- different states
select distinct state 
from suppliers;

select * 
from orders;

select * 
from payments;

-- how many distinct amount do we have in this table

select distinct amount 
from payments;

-- distinct apply on multiple column 

select * 
from customers;

-- on which dates there has been atleasr 1 customer who signed up

select distinct 
signupdate
from customers; 
select distinct age ,city
from customers;

-- which are unique combination of payment method and payment status.

select distinct method,status
from payments;

use sql_ml;

select * 
from customers;

select distinct customerId
from customers;

-- give me information of the customer with id c014

select *
from customers
where customerid = 'C014';  

select 
  customerid ,
  name,
  signupdate
from customers
where customerid='c014';

-- find the customer who have spent morne than 10000: --> this will need join concept

-- the customer support team want a list of all customers(customereid,name) with their city .
select 
 customerId,
 name,
 city
from customers;

-- show all product categories available.
select distinct categoryid
from products;

-- display customer from nagpur
select *
from customers
where city ="nagpur";

-- Display all the female customer.
select * 
from customers
where gender="F";

-- Display customer older than 30:
select * 
from customers 
where age>30;

-- display products costing at most(less then equal to) 30000

select * 
from products
where sellingprice<=3000;

-- display deliverd orders
select  * 
from order_items 
limit 5 ;

select distinct status
from orders;

select * 
from orders 
where status ="delivered";

-- count total customers

select count(*)
from customers;

-- count customer from mumbai

select count(city)
from customers
where city="mumbai";

-- the HR Manager wants to use the name of employes working in the operation department.

select * from 
employees;

select distinct department 
from employees;

select * 
from employees
where department ='operation';

-- display all product suplied by suplier id 3.
select * 
from products ;

select * 
from products
where supplierid="sup003";

-- the inventory team want to see product having stock less than 30 units.
select * from  inventory;

select * from inventory
where stock <30;

-- find all customers who signed up after 2023-01-01.
select * 
from customers
where signupDate>"2024-01-01";

-- count how maney different product category exist in the product table.
select distinct categoryid
from products;

select count(distinct categoryid)
from products;

-- how many different cities do the custoomers belongs to?
select count(distinct(city))
from customers;

-- how many different product to we have:
select  count(*)
from products;

-- how many customers are from mumbai
select count(city)
from customers
where city="mumbai";

-- count the  different customers that we have
select count(customerid)   -- count the number of nonnull value in that column.
from customers;

-- count(*) calculate the no of row
select count(*)
from customers;

-- how many different supplier states exist.
select * from suppliers;

select count(distinct(state))
from suppliers;

-- what is the total sales values represent by all order-item records
select * from order_items;

select sum(total)
from order_items; 

-- how many individual product units more sold across all order-item reocrds
select * from 
order_items;

select sum(quantity)
from order_items;

-- Total quantity sold where order items have a quantity greater than 1:
select * from order_items;

select sum(quantity)
from order_items
where quantity>1;
