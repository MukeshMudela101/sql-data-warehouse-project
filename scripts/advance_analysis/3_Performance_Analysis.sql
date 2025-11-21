/* Analyze the yearly performance of products by comparing each product's sales to both
its average sales performance and the previous year's sales. */
	-- Thinking logic of this code was tricky for myself

WITH yearly_product_sales AS (
	SELECT
		YEAR(f.order_date) AS order_year,
		p.product_name,
		SUM(f.sales_amount) AS current_sales
	FROM gold.fact_sales AS f
	LEFT JOIN gold.dim_products AS p
		ON p.product_key = f.product_key
	WHERE order_date IS NOT NULL
	GROUP BY YEAR(f.order_date), p.product_name
)

SELECT
	order_year,
	product_name,
	current_sales,
	AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sale,
	(current_sales - AVG(current_sales) OVER(PARTITION BY product_name)) AS diff_avg,
	CASE 
		WHEN (current_sales - AVG(current_sales) OVER(PARTITION BY product_name)) > 0 THEN 'Above Avg'
		WHEN (current_sales - AVG(current_sales) OVER(PARTITION BY product_name)) < 0 THEN 'Below Avg'
		ELSE 'Avg' 
	END AS avg_change,
	-- Year-over-year Analysis
	LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC) AS py_sales,
	(current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC)) AS diff_py,
	CASE 
		WHEN (current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC)) > 0 THEN 'Increase'
		WHEN (current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC)) < 0 THEN 'Decrease'
		ELSE 'No Change' 
	END AS py_change
FROM yearly_product_sales
ORDER BY product_name, order_year

