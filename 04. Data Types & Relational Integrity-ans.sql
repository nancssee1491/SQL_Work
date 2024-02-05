-- Assignment:- 04

-- SELECTION COMMANDS:- (FILTERING):- in, like, between
-- 1. Create a Supermart_DB with the tables created from the datasets shared (Customer.csv, Sales.csv and Product.csv files)
create database Supermart_DB;
use Supermart_DB;
select* from customer;
select* from product;
select* from sales;

-- 2. Define the relationship between the tables using constraints/keys.
drop table customer;
drop table product;
drop table sales;

create table customer(Customer_ID text, Customer_Name text, Segment text, Age int, Country text,
City text, State text, Postal_Code int, Region text);
desc customer;
alter table customer modify column Customer_ID VARCHAR(200); 
alter table customer add primary key(Customer_ID);

create table product(Product_ID text, Category text, Sub_Category text, Product_Name text);
desc product;
alter table product modify column Product_ID VARCHAR(200);
alter table product add primary key(Product_ID);

create table sales(Order_Line int, Order_ID text, Order_Date text, Ship_Date text, Ship_Mode text,
Customer_ID VARCHAR(200), Product_ID VARCHAR(200), Sales double, Quantity int, Discount double, Profit double,
foreign key(Customer_ID) references customer(Customer_ID),
foreign key(Product_ID) references product(Product_ID));

-- 3. In the database Supermart _DB, find the following:
-- a. Get the list of all the cities where the region is north or east without any duplicates using IN statement.
select distinct city from customer where Region in('north', 'east');

-- b. Get the list of all orders where the ‘sales’ value is between 100 and 500 using the BETWEEN operator.
select* from sales where sales between 100 and 500; 

-- c. Get the list of customers whose last name contains only 4 characters using LIKE.
select Customer_Name from customer where Customer_Name like '% ____';

-- SELECTION COMMANDS:- ordering
-- 1. Retrieve all orders where the ‘discount’ value is greater than zero ordered in descending order basis ‘discount’ value
select* from (select* from sales order by Discount desc) as ordered_sales where ordered_sales.Discount > 0; 

-- 2. Limit the number of results in the above query to the top 10.
select* from sales where Discount > 0 order by Discount desc limit 10; 

-- Aggregate commands:-
-- 1. Find the sum of all ‘sales’ values.
select sum(Sales) from sales;

-- 2. Find count of the number of customers in the north region with ages between 20 and 30.
select count(*) from customer where Region='north' and Age between 20 and 30;

-- 3. Find the average age of east region customers.
select avg(Age) from customer where Region='east';

-- 4. Find the minimum and maximum aged customers from Philadelphia.
-- The Minimum Aged Customer:
select Customer_Name from customer 
where Age = (select min(Age) from customer where City='Philadelphia') 
and City='Philadelphia';

-- The Maximum Aged Customer:
select Customer_Name from customer 
where Age = (select max(Age) from customer where City='Philadelphia') 
and City='Philadelphia';

-- GROUP BY COMMANDS:-
-- 1. Make a dashboard showing the following figures for each product ID
-- a. Total sales (in $) order by this column in descending 
-- b. Total sales quantity
-- c. The number of orders
-- d. Max Sales value
-- e. Min Sales value
-- f. Average sales value
select Product_ID,
sum(sales) as Total_Sales_In_$, 
sum(Quantity) as Total_Sales_Quantity,
count(*) as The_Number_Of_Orders, 
max(sales) as Max_Sales_Value, 
min(sales) as Min_Sales_Value, 
avg(sales) as Average_Sales_Value
from sales
group by Product_ID
order by Total_Sales_In_$ desc;

-- 2. Get the list of product ID’s where the quantity of product sold is greater than 10
select Product_ID from sales where Quantity > 10;
