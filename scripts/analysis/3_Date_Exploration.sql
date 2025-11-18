-- Find the date of the first and last order
-- How many years of sales are available
SELECT 
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_span_yrs
FROM gold.fact_sales

-- Find first and last shiiping_date
SELECT 
	MIN(shipping_date) AS first_shipping_date,
	MAX(shipping_date) AS last_shipping_date,
	DATEDIFF(YEAR, MIN(shipping_date), MAX(shipping_date)) AS shipping_span_yrs
FROM gold.fact_sales

-- Find first and last due_date
SELECT 
	MIN(due_date) AS first_due_date,
	MAX(due_date) AS last_due_date,
	DATEDIFF(MONTH, MIN(due_date), MAX(due_date)) AS due_span_month
FROM gold.fact_sales


-- Find the youngest and oldest customer
SELECT 
	MIN(birthdate) AS oldest_birthdate,
	DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
	MAX(birthdate) AS youngest_birthdate,
	DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers