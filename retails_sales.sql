-- SQL Retails Sales Analysis 
create table retails_sales(
	transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(15),
	age INT,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
);

select * from retails_sales;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Retail_Sales.csv'
INTO TABLE retails_sales 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(transactions_id, sale_date, sale_time, customer_id, gender, @age, category, @quantiy, @price_per_unit, @cogs, @total_sale)
SET
  age = NULLIF(@age, ''),
  quantiy = NULLIF(@quantiy, ''),
  price_per_unit = NULLIF(@price_per_unit, ''),
  cogs = NULLIF(@cogs, ''),
  total_sale = NULLIF(@total_sale, '');

-- fetch the records
select * from retails_sales;

-- total no of rows in my data
select count(*) from retails_sales;

-- Data Cleaning
-- check null values in the data 
SELECT * FROM retails_sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;




-- delete the records
delete from retails_sales
where 
	transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;

-- Data Exploration
-- how many records we have?
select count(*) from retails_sales;

-- how many unique customers
select count(distinct customer_id) from retails_sales;

-- how many unique category
select count(distinct category) from retails_sales;
select distinct category from retails_sales;

-- Data Analysis
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retails_sales
where sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT *
FROM retails_sales
WHERE
    category = 'Clothing'
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND quantiy >= 4;



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category , sum(total_sale) as net_sale, count(*) as total_orders
from retails_sales
group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
    AVG(age) AS average_age
FROM 
    retails_sales
WHERE 
    category = 'Beauty'
    AND age IS NOT NULL;



-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from retails_sales
where total_sale > 1000;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category , gender , count(*) as total_trans
from retails_sales
group by category , gender
order by category;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year, month, avg_sale from
(select 
	extract(YEAR from sale_date) as year,
    extract(MONTH from sale_date) as month,
    avg(total_sale) as avg_sale,
    rank() over(partition by extract(YEAR from sale_date) order by avg(total_sale) desc) as rank_sale
from
	retails_sales
group by 1 , 2
) as t1
where rank_sale = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM 
    retails_sales
GROUP BY 
    customer_id
ORDER BY 
    total_sales DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM 
    retails_sales
GROUP BY 
    category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM 
    retails_sales
GROUP BY 
    shift
ORDER BY
    FIELD(shift, 'Morning', 'Afternoon', 'Evening');






















