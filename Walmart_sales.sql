create database Sales;

use sales;

create table if not exists sales (
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

select * from sales;

-- Feature Engineering --
-- --------------------------------------------------------------------------

-- time_of_day --

-- --------------------------------------------------------------------------

select 
	time,
    (
		case 
			when `time` between "00:00:00" and "12:00:00" then "Morning"
            when `time` between "12:00:00" and "16:00:00" then "Afternoon"
            else "Evening"
		end
    ) as time_of_day
    from sales;
  
  
alter table sales add column time_of_day varchar(20);


update sales set 
	time_of_day = (
		case 
			when `time` between "00:00:00" and "12:00:00" then "Morning"
            when `time` between "12:00:00" and "16:00:00" then "Afternoon"
            else "Evening"
		end
	) ;
    -- ----------------------------------------------------------------------------
    
    
-- ------------------------ Day_name ----------------------------------------------

select 
	date,
    dayname(date) as day_name
    from sales;
    
alter table sales add column day_name varchar(10);

update sales set
	day_name =  dayname(date);
    
-- ---------------- month name ---------------------------------------------------

select 
	date,
		monthname(date) as month_name
	from sales;
    
alter table sales add column month_name varchar(10);

update sales set
	month_name = monthname(date);
    
    
-- ---------------------------------------------------------------------------------
-- ------------------- General Questions -------------------------------------------

-- -- 1.  how many unique cities does this data have?
select
	distinct(city) from sales;

-- -- 2. How many branches we have in each city?

select distinct 
		city, branch
	from sales;
    
    
-- ------------- Product based Questions ---------------------------------------------
-- 1.  how many unique product lines in this data have?
select 
	distinct(product_line) from sales;


-- 2. what is the most common payment method?

select 
	payment,
	count(payment) as cnt 
    from sales 
    group by payment
    order by cnt desc;
    
-- 3. what is the most selling product line?

select product_line, count(product_line) as cnt
 from sales
 group by product_line
 order by cnt desc;
 
 
 -- 4. what is the total revenue by month?
 
 select 
	month_name as month,
    sum(total) as total_revenue
    from sales
    group by month_name
    order by total_revenue desc;
    
    
-- 5. which month has the largest COGS?

select 
	month_name as month,
    sum(cogs) as cogs
    from sales
    group by month_name
    order by cogs desc;
    
-- 6. what product line has the largest revenue?

select 
	month_name as month,
	product_line as product,
    sum(total) as total_revenue
    from sales
    group by product
    order by total_revenue desc;
    
-- 7. which city has the largest revenue?

select 
	city, branch,
    sum(total) as total_revenue
    from sales
    group by city, branch
    order by total_revenue desc;
    
-- 8. what product line has the largest VAT?
select
	product_line,
    avg(tax_pct) as avg_tax
    from sales
    group by product_line
    order by avg_tax desc;
    
-- 9. Fetch each product line and add a column to those product line shows "good","Bad" if good means its greater than avg rating.

alter table sales add column feedback varchar(10);


select 
	product_line as product,rating as avg,
    if(rating > 5 , "Good", "Bad") as avg_sales 
from sales ;

update sales set Feedback = if (
	rating > 5 , "Good", "Bad"
);

select * from sales;

-- 10. which branch sole more products than average product sold?

select
	branch,
    sum(quantity) as qty
    from sales
    group by branch
    having sum(quantity) > (select avg(quantity) from sales);
 
 
-- 11. whatr is the average rating of each product line?
select
	product_line as product,
	round(avg(rating),2) as avg_rating
    from sales
    group by product_line
    order by avg_rating desc;
    
    
-- --------------------------------- Sales ------------------------------------------------
-- 1. Number of sales made in each time of the day and per weekday ------------------------

select 
	time_of_day,
	day_name,
    count(*) as total_sales 
    from sales
    where day_name != "Saturday" and day_name != "Sunday"
    group by day_name
    order by total_sales desc;
    
-- 2. which of the customer type brings the most revenue?

select 
	customer_type, 
    sum(total) as total_revenue
    from sales
    group by customer_type
    order by total_revenue desc;

-- 3. which city has the largest tax percent/ VAT (Value Added Tax)?

-- calculte VAT

select 
	product_line,
    cogs * 0.05 as VAT
    from sales;
    
alter table sales add column VAT varchar(10);

update sales set VAT = round((cogs * 0.05),2);



select 
	city,
    round(avg(VAT),2) as VAT
    from sales
    group by city
    order by VAT desc;
    
-- 4. which customer type pays most of the VAT?

select 
	customer_type,
    round(avg(VAT),2) as VAT
    from sales 
    group by customer_type
    order by VAT desc;
    

-- ------------ Customer Questions -------------------------------------
-- 1. how many Unique Customer type does this Data has?

select 
	distinct(customer_type) 
    from sales; 
    
-- 2. How many unwie payment type this data has?

select
	distinct(payment)
    from sales;
    
-- 3. what is the most customer type we have in this data?
select 
customer_type,
	count(customer_type)
    from sales
    group by customer_type
    order by customer_type desc;


-- 4. which customer type buys most of the products?
select
	customer_type, product_line,
    count(product_line) as product
    from sales
    group by product_line
    order by product desc;
    
-- 5. who is the frequent customers in gender wise?

select
	gender,
    count(*) as gen
    from sales
    group by gender;
    
-- 6. what is the gender distribution in branch wise?

select 
	branch,
    gender,
    count(*) as gender
    from sales 
    where branch = "A"
    group by gender
    order by gender;
    
-- 7.  when time of the day the customers gives most of the rating?

select
	time_of_day,
    avg(rating) as avg_rating
    from sales
    group by time_of_day
    order by avg_rating;

-- 8. Which time of the day do customers give most ratings per branch?

select
	time_of_day,
    avg(rating) as avg_rating
    from sales
    where branch = "A"
    group by time_of_day
    order by avg_rating;

-- 9. Which day for the week has the best avg ratings?

select
	day_name,
    avg(rating) as avg_rating
    from sales
    group by day_name
    order by avg_rating desc;
    
-- 10. Which day of the week has the best average ratings per branch?

select 
	day_name,
    avg(rating) as avg_rating
    from sales
    where branch = "A"
    group by day_name
    order by avg_rating desc;