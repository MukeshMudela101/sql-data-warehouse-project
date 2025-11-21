/* Segment products into cost ranges and
count how many products fall into each segment. */
	-- CASE WHEN statements are used to create new dimension

WITH product_segments AS (
SELECT 
	product_key,
	product_name,
	cost,
	CASE
		WHEN cost < 100 THEN 'Below 100'
		WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		WHEN cost BETWEEN 501 AND 1000 THEN '501-1000'
		ELSE 'Above 1000'
	END AS cost_range
FROM gold.dim_products
)

SELECT
	cost_range,
	COUNT(*) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;


/* Group customers into three segments based on their spending behavior 
		- VIP: at least 12 months of history and spending more than €5,000.
		- Regular: at least 12 months of history but spending €5,000 or less.
		- New: lifespan less than 12 months.
	And find the total number of customers by each group
*/

WITH customer_sale_details AS (
	SELECT
		c.customer_key,
		SUM(sales_amount) AS total_spending,
		MIN(order_date) AS first_order,
		MAX(order_date) AS last_order,
		DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
	FROM gold.fact_sales AS c
	LEFT JOIN gold.dim_customers AS f
		ON c.customer_key = f.customer_key
	GROUP BY c.customer_key
), 
customer_categorization AS (
SELECT
	customer_key,
	CASE 
		WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
		WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
		ELSE 'New'
	END AS customer_segment
FROM customer_sale_details
) 

SELECT 
	customer_segment,
	COUNT(*) AS total_customers
FROM customer_categorization
GROUP BY customer_segment
ORDER BY total_customers DESC




--SELECT * FROM gold.fact_sales;
--SELECT * FROM gold.dim_customers;