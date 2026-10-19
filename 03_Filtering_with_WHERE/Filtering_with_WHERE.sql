use sql_ml;

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

-- display customer from nagpur

select name,city
from customers
where city ="nagpur";

-- Display all the female customer.

select name,gender
from customers
where gender="F";

-- Display customer older than 30:
select name,age
from customers
where age >30;

-- display products costing at most(less then equal to) 30000
select productname,mrp
from products
where SellingPrice <=30000;

-- the HR Manager wants to use the name of employes working in the operation department.
select * from employees;

select distinct(department)
from employees;

select name,department
from employees
where Department="operation";

-- display all product suplied by suplier id 3.
select productname,supplierid
from products
where SupplierID="sup003";

-- the inventory team want to see product having stock less than 30 units.
select productid,stock
from inventory
where stock<30;

-- find all customers who signed up after 2023-01-01.

select name,signupdate
from customers
where SignupDate>"2023-01-01";

-- how many customers are from mumbai
select count(*)
from customers
where city="mumbai";

select count(city)
from customers
where city ="mumbai";
-- Total quantity sold where order items have a quantity greater than 1
select * from order_items;

select sum(quantity)
from order_items
where Quantity>1;

