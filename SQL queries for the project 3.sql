USE project3_retail_sales_analysis;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales 
(
	transactions_id	INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,	
    customer_id	INT,
    gender VARCHAR(10),	
    age	INT,
    category VARCHAR(15),	
    quantity INT,	
    price_per_unit FLOAT,	
    cogs FLOAT,	
    total_sale FLOAT
);

select * from retail_sales;

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date LIKE '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND  quantity > 3 
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category
SELECT category, COUNT(*) AS orders, SUM(total_sale) AS total_sales 
FROM retail_sales
GROUP BY category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT category, ROUND(AVG(age),2) AS avg_age_of_customers 
FROM retail_sales
WHERE category = 'Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT transactions_id, category, sale_date, customer_id, total_sale  
FROM retail_sales
WHERE total_sale > '1000'
ORDER BY category, sale_date;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT category, gender, COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT YEAR(sale_date) AS Year, MONTH(sale_date) AS Month, 
AVG(total_sale) AS avg_Sale  
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC; 

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id 
ORDER BY total_sales DESC
LIMIT 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category
SELECT COUNT(DISTINCT customer_id) AS unique_customers, category
FROM retail_sales
GROUP BY category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sales 
AS 
(
	SELECT transactions_id, sale_date, sale_time, category,
		CASE
		WHEN HOUR(sale_time)<12 THEN 'morning'
		WHEN HOUR(sale_time) BETWEEN 12 AND 16 THEN 'afternoon'
		ELSE 'evening'
		END AS shift
	FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;

