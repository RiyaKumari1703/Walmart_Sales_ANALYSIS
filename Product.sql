select * from sales;

---------feature engineering-----------
select time,
(
	CASE 
	  WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
	  WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
	  ELSE 'Evening'
	 END
) AS time_of_date
from sales;
ALTER Table sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
set time_of_day = (
	CASE 
	  WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
	  WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
	  ELSE 'Evening'
	 END
);

-----day name------
select 
   sales_date,
    to_char(sales_date, 'day') as
    day_of_week
from sales;

ALTER table sales ADD COLUMN day_of_week varchar(20);

UPDATE sales 
set day_of_week = (
	to_char(sales_date, 'Day')
);
-----month name-----
select sales_date,
   to_char(sales_date, 'Month') as month
from sales;

ALTER table sales ADD COLUMN month varchar(20);

UPDATE sales
  SET month =(
	to_char(sales_date, 'Month')
  );
--------------------------------------------------------------------------------

--------Generic Question--------
--How many unique cities does the data have?
Select distinct city from sales;

--In which city is each branch?
--1 method:
select city,branch from sales 
  group by branch,city
order by branch asc;
--2 method:
select distinct city,branch
 from sales;

----------------------------------------------------------------------------------

---------Product-----------
--How many unique product line does the data have?
select 
   count(distinct product_line)
from sales;
---what is the most common payment method?
select payment_method, count(payment_method) as count
	from sales
group by payment_method
	order by payment_method desc
	limit 1;
--what is the most selling product line?
Select product_line,count(product_line) as count
	from sales
	group by product_line 
	order by product_line desc
	limit 1;
--what is the total revenue by month?
select month,sum(total)as total_revenue from sales
	group by month
	order by total_revenue desc;
--what month has the largest cogs?
select month, count(cogs) as count_cogs from sales
	group by month
	order by count_cogs desc
	limit 1;
--what product_line has the largest revenue?
select product_line, sum(total) as total_revenue 
from sales
 group by product_line
order by total_revenue desc
limit 1;
--what product_line has the largest VAT?
select * from sales;
select product_line, sum(vat) as total_VAT 
from sales
 group by product_line
order by total_VAT desc
limit 1;
--which branch sold more products than average sold?
select branch, sum(quantity) as sum_quantity 
	from sales
	group by branch
	having sum(quantity) > (select avg(quantity) from sales);
--what is the most common product_line by gender?
select gender,product_line, count(gender) as total_count
from sales
group by product_line,gender
order by total_count desc;
---what is the average rating of each product line?
select product_line, ROUND(AVG(rating),2) as avg_rating
from sales
group by product_line;