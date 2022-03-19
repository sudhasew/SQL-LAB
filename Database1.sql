----------- FROM NORTHWIND -------------

-- (1). Select all the records from the customers table.
select * from customers;

-- (2). Get distinct countries from the customers table.
select distinct country from customers;

-- (3). Get all the records from the table customers where the customer_id starts with “BL”.
select customer_id from customers where customer_id like 'BL%';

-- (4). Get the first 100 records of the orders table.
select * from orders limit 100;

-- (5). Get all customers that live in the postal codes 1010, 3012, 12209, and 05023.
select * from customers where postal_code in ('1010', '3012', '12209', '05023');

-- (6). Get all orders where the ShipRegion is not equal to NULL.
select * from orders where ship_region is not null;

-- (7). Get all customers ordered by the country, then by the city.
select ship_country, ship_city from orders order by ship_country, ship_city;

-- (8). Add a new customer to the customers table. You can use whatever values/
insert into customers 
(customer_id,company_name,contact_name,contact_title,address,city,region,postal_code,country,phone,fax)
values ('ABT2','Own Company','Suvys','Owner','Something Str.0','Self',
'[null]','11010','Nting','101-222-3334','[null]');

-- (9).Update all ship_region to the value 'EuroZone' in the orders table, 
--     where the ship_country is 'France'. 
 update orders set ship_region =  'EuroZone' where ship_country='France';

-- (10). Delete all rows from order_details that have a quantity of 1. 
delete from order_details where quantity=1;

-- (11). Calculate the average, max, and min of the quantity in the order_details table.
select avg(quantity),max(quantity),min(quantity) from order_details;

-- (12). Calculate the average, max, and min of the quantity in the order_details 
--       table, grouped by the order_id.
select order_id, avg(quantity),max(quantity),min(quantity) from order_details group by order_id;

-- (13). Find the customer_id that placed order 10290 (orders table)
select customer_id from orders where order_id = '10290';

-- (14). Do an inner join, left join, right join on orders and customers tables.  
--      (These are three separate queries, one for each type of join.)
inner join customers custs on ords.customer_id = custs.customer_id;
left join customers custs on ords.customer_id = custs.customer_id;
right join customers custs on ords.customer_id = custs.customer_id;

-- (15).Use a join to get the ship_city and ship_country of all the orders 
--      which are associated with an employee who is in London.
select ords.ship_city,ords.ship_country,emplys.city from orders ords 
join employees emplys on ords.employee_id = emplys.employee_id 
where emplys.city='London';

-- (16). Use a join to get the ship_name of all orders that include 
--       a discontinued product. (See orders, order_details, and products. 1 means discontinued.)
-- select * from orders; {{ order_id }}
-- select * from order_details; {{ order_id }}, {{ product_id }}
-- select * from products; {{ product_id }}
-- select discontinued from products where discontinued=1;
select ords.ship_name,ords.order_id,ordtls.order_id,
        ordtls.product_id,prds.product_id,prds.discontinued from orders ords 
	join order_details ordtls 
		on ords.order_id = ordtls.order_id 
	join products prds 
	on ordtls.product_id = prds.product_id where prds.discontinued=1;

-- (17). Get first names of all employees who report to no one.
select first_name,reports_to from employees where reports_to is null;

-- (18). Get first names of all employees who report to 'Andrew'.
select first_name from employees where reports_to =
(select employee_id from employees where first_name='Andrew');