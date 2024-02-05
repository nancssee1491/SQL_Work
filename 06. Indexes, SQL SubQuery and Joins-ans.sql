-- Assignments

-- Sub-Queries
-- 1. Get data with all columns of the sales table, and customer name, customer age, product name, and category are in the same result set. (Use join in the subquery, refer to the database and tables from Assignments-05)
use supermart_db;

SELECT 
sales_customer_info.*, sales_product_info.Product_Name, sales_product_info.Category
FROM (select sales.*, product.Product_Name, product.Category 
	from sales 
    left join product 
    on sales.Product_ID = product.Product_ID) AS sales_product_info
LEFT JOIN (select sales.*, customer.Customer_Name, customer.Age 
	from sales 
    left join customer on sales.Customer_ID = customer.Customer_ID) AS sales_customer_info
ON sales_product_info.Product_ID = sales_customer_info.Product_ID;

-- 2. Get data from the sales table, product name, and category in the result set.
select sales.*, product.Product_Name, product.Category
from sales
left join product on sales.Product_ID = product.Product_ID;

-- 3. Without using the join concept create a sub-query by using the customer, product, and sales data.
SELECT 
	sales.*,
	(select Customer_Name from customer where Customer_ID = sales.Customer_ID) AS Customer_Name,
	(select Age from customer where Customer_ID = sales.Customer_ID) AS Age,
	(select Product_Name from product where Product_ID = sales.Product_ID) AS Product_Name,
	(select Category from product where Product_ID = sales.Product_ID) AS Category
FROM sales;

-- Functions: -
-- string functions: -
-- 1. Find the maximum length of characters in the Product name string from the Product table.
select max(CHAR_LENGTH(Product_Name)) from Product;

-- 2. Retrieve product name, sub-category, and category from the Product table and an additional column named “product_details” which contains a concatenated string of product name, sub-category, and category.
select 
Product_Name, Sub_Category, Category, concat(Product_Name,' ',Sub_Category,' ',Category) as product_details 
from product;

-- 3. Analyze the product_id column and take out the three parts composing the product_id in three different columns.
select
substring_index(Product_ID, '-', 1) as Product_ID_1,
SUBSTRING_INDEX(substring_index(Product_ID, '-', 2), '-', -1) as Product_ID_2,
substring_index(Product_ID, '-', -1) as Product_ID_3
from product;

-- 4. List down comma-separated product names where the sub-category is either Chairs or tables.
select group_concat(Product_Name separator ', ') as Product_Name_comma_separated
from product
where Sub_Category in('Chairs', 'tables');

-- Mathematical functions:
-- 1. You are running a lottery for your customers. So, pick a list of 5 lucky customers from the customer table using a random function.
select Customer_Name from customer order by rand() limit 5;

-- 2. Suppose you cannot charge the customer in fraction points. So, for a sales value of 1.63, you will get either 1 (or) 2. In such a scenario, find out.
-- a. Total sales revenue if you are charging the lower integer value of sales always.
select sum(floor(Sales)) from sales;

-- b. Total sales revenue if you are charging the higher integer value of sales always.
select sum(ceil(Sales)) from sales;

-- c. Total sales revenue if you are rounding off the sales always.
select sum(round(sales)) from sales;

-- Date & Time functions: -
-- 1. Find out the current age of “batman” who was born on “April 6, 1939” in Years, months, and days.
select 
datediff(current_date, '1939-04-06') DIV 365 as Years,
datediff(current_date, '1939-04-06') DIV 365 DIV 30 as Months,
datediff(current_date, '1939-04-06') DIV 365 MOD 30 as Days;

-- 2. Analyze and find out the monthly sales of the sub-category ‘chair’. Do you Observe any seasonality in sales of this sub-category.
SELECT 
date_format(str_to_date(Order_Date, '%d-%m-%Y'), '%m') AS Month,
sum(Sales) AS Monthly_Sales
FROM
	(select product.Product_ID, product.Sub_Category, sales.Order_Date, sales.Sales
		from product 
		join sales on product.Product_ID = sales.Product_ID) as product_sales
WHERE Sub_Category='Chairs'
GROUP BY Month
ORDER BY Month ASC;

/*Conclusions In Observation:
-- 1) Yes, seasonality in sales of this sub-category is observed. 
-- 2) Sales are way more better in November and December, probably due to year end festive season such as Christmas.
-- 3) Whereas Jannuary and February are having much less sales when comparing to year end, as the festive season has just ended.*/

-- Joins: - 
-- 1. Run the below query to create the datasets.
-- a. /*Creating sales table for the year 2015*/
-- 		•Create table sales_2015 as select * from sales where ship_date between '2015-01-01' and '2015-12-31';
-- 		•select count(*) from sales_2015; 
-- 		•select count(distinct customer_id) from sales_2015;
create table sales_2015 as 
select* from sales 
where str_to_date(Ship_Date, '%d-%m-%Y') between '2015-01-01' and '2015-12-31';

select count(*) from sales_2015;
select count(distinct Customer_ID) from sales_2015;

-- b. /* Customers with ages between 20 and 60 */
-- 		• create table customer_20_60 as select * from customer where age between 20 and 60;
-- 		• select count (*) from customer_20_60;
create table customer_20_60 as
select* from customer 
where Age between 20 and 60;

select count(*) from customer_20_60;

-- 2. Find the total sales that are done in every state for customer_20_60 and sales_2015 table
-- Hint: Use Joins and Group By command
SELECT State, sum(Sales) AS 2015_State_Total_Sales
FROM(select customer_20_60.Customer_ID, customer_20_60.State, sales_2015.Sales
		from sales_2015
		right join customer_20_60 
		on sales_2015.Customer_ID = customer_20_60.Customer_ID) as 2015_State_Sales
GROUP BY State;

-- 3. Get data containing Product_id, Product name, category, total sales value of that product, and total quantity sold. (Use sales and product tables)
select product.Product_ID, product.Product_Name, product.Category, 
		sum(sales.Sales) as Total_Sales,
		sum(sales.Quantity) as Total_Quantity_Sold
from product
left join sales on product.Product_ID = sales.Product_ID
group by product.Product_ID, product.Product_Name, product.Category;
