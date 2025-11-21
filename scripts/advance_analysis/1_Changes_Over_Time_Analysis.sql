-- Analyze Sales Performance Over Time 
-- BY YEAR
SELECT 
	YEAR(order_date) AS order_year,
	SUM(sales_amount) AS sale_by_year,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY order_year ASC

-- BY MONTH
SELECT 
	MONTH(order_date) AS order_month,
	SUM(sales_amount) AS sale_by_month,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY order_month ASC

-- BY YEAR, MONTH
SELECT 
	YEAR(order_date) AS order_year,
	MONTH(order_date) AS order_month,
	SUM(sales_amount) AS sale_by_month,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month ASC

-- BY YEAR, MONTH
SELECT 
	DATETRUNC(MONTH, order_date) AS sale_date,
	SUM(sales_amount) AS sale_by_month,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY sale_date ASC


-- BY YEAR, MONTH (Using FORMAT)
--		Note : FORMAT gives output as STRING not DATE
SELECT 
	FORMAT(order_date, 'yyyy-MM') AS sale_date,
	SUM(sales_amount) AS sale_by_month,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY sale_date ASC


-- BY YEAR, MONTH (Using FORMAT)
--		Note : FORMAT gives output as STRING not DATE
--				Date is sorted incorrectly, by alphabetical order
SELECT 
	FORMAT(order_date, 'yyyy-MMM') AS sale_date,
	SUM(sales_amount) AS sale_by_month,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY sale_date ASC




-- SELECT * FROM gold.fact_sales;
-- SELECT * FROM gold.dim_customers;
-- SELECT * FROM gold.dim_products;