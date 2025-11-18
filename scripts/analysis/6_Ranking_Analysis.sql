/*
GROUP BY + TOP : 
	is used to create simple ranking 
*/

-- Which 5 Products generate the highest revenue
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
	ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC


-- What are the 5 worst-performing products in terms of sales
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
	ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC


-- Find the Top-10 customers who have generated the highest revenue
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
	ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC


-- Find 3 customers with the fewest orders placed
SELECT TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
	ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_orders ASC




/*
WINDOW FUNCTIONS : 
	For more flexible and complex queries with extra details 
*/

-- Which 5 Products generate the highest revenue
SELECT
	product_name,
	total_revenue,
	rank_products
FROM (
	SELECT
		p.product_name,
		SUM(f.sales_amount) AS total_revenue,
		-- this ROW_NUMBER() is not working in individual but in group data now. Hence, group by is must. 
		ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales AS f
	LEFT JOIN gold.dim_products AS p
		ON f.product_key = p.product_key
	GROUP BY p.product_name
)t
WHERE rank_products <= 5

