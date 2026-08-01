--Creating Table
Create table retail_sales(
	transaction_id int primary key,
	sale_data date,
	sale_time time,
	cutomer_id int
	gender varchar(15),
	quantity int,
	price_per_unit float,
	cogs float,
	total_sale float
);

--Data Cleaning
DELETE
FROM RETAIL_SALES
WHERE AGE IS NULL
	OR PRICE_PER_UNIT IS NULL
	OR COGS IS NULL
	OR QUANTITY IS NULL
	OR TOTAL_SALES IS NULL
SELECT *
FROM RETAIL_SALES
	
--Data exploration

--Q1.How many sales we have?
SELECT COUNT(*) AS TOTAL_SALES
FROM RETAIL_SALES

--Q2.How much sales we have?
SELECT SUM(TOTAL_SALES) AS TOTAL_SALES
FROM RETAIL_SALES

--Q3.How many customer we have?
SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS TOTAL_CUSTOMER
FROM RETAIL_SALES
SELECT *
FROM RETAIL_SALES

--Data Analysis and Businees Key Problem
--My Analysis and finding

--Q1.Write a sql query to retrieve all the columns for sales  made on '2022-05-11'
SELECT *
FROM RETAIL_SALES
WHERE SALE_DATA = '2022-05-11'
order by customer_id 

--Q2.Write a sql query to retrieve all the transection where the category is 'Clothing' and the quantity sold is more then the 10 in the month of Nov-2022
SELECT *
FROM RETAIL_SALES
WHERE CATEGORY = 'Clothing'
	AND TO_CHAR(SALE_DATA,'YYYY-MM') = '2022-11'
	AND QUANTITY >= 4
	
--Q3.Write a sql query to calculate the total sales for each category.
SELECT CATEGORY,
	SUM(TOTAL_SALES) AS TOTAL_SALES
FROM RETAIL_SALES
GROUP BY CATEGORY

--Q4.Write a sql query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(AGE),2) AS Average_age
FROM RETAIL_SALES
WHERE CATEGORY = 'Beauty'

--Q5.Write a sql query to find all the transaction where the total_sale is greater than 1000.
SELECT *
FROM RETAIL_SALES
WHERE TOTAL_SALES >= 1000

--Q6.Write a sql query to find the total number of transaction made by each gender in each category.
SELECT CATEGORY,GENDER,
COUNT(TRANSACTION_ID) AS NO_OF_TRANSACTION
FROM RETAIL_SALES
GROUP BY GENDER,CATEGORY
ORDER BY 1

--Q7.Write a sql query to calculate the average sale for each month.Find out best selling month in each year.
SELECT year,month,avg_sale FROM 
(
SELECT EXTRACT(YEAR FROM SALE_DATA) AS YEAR,
	   EXTRACT(MONTH FROM SALE_DATA) AS MONTH,
	   AVG(total_sales) AS avg_sale,
	   RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_data) ORDER BY AVG(total_sales) DESC) as rank FROM retail_sales
GROUP BY 1,2
) as t1 WHERE rank = 1

--Q8.Write a sql query to find the top customer based on the highest total sales.
SELECT CUSTOMER_ID,
	SUM(TOTAL_SALES) AS TOTAL_SALES
FROM RETAIL_SALES
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Q9.Write the sql query to find the number of unique customer who purchased items from each category.
SELECT CATEGORY,
	COUNT(DISTINCT CUSTOMER_ID) as No_Of_Customer
FROM RETAIL_SALES
GROUP BY CATEGORY

--Q10.Write a sql query to create each shift and number of orders (Example Morning <=12,Afternoon Between 12 & 17, Evening >17).
with hourly_sale as(
SELECT *,
	CASE
	WHEN EXTRACT(HOUR FROM SALE_TIME) < 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
END AS SHIFT
FROM RETAIL_SALES)
SELECT SHIFT,
	COUNT(*) AS TOTAL_ORDERS
FROM HOURLY_SALE
GROUP BY SHIFT




	