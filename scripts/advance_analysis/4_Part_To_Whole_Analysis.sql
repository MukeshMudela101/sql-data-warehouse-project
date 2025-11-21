-- Which categories contribute the most to overall sales
	-- Part-To-Whole analysis help to know which product_category of yours is top performer or under-performer in the market
WITH category_wise_sale AS (
	SELECT 
		p.category,
		SUM(sales_amount) AS category_sale
	FROM gold.fact_sales AS f
	LEFT JOIN gold.dim_products AS p
		ON p.product_key = f.product_key
	GROUP BY p.category
)

SELECT 
	category,
	category_sale,
	SUM(category_sale) OVER() AS overall_sale,
	CONCAT(CAST((category_sale * 100.00 / SUM(category_sale) OVER()) AS DECIMAL(10, 2)), '%') AS part_to_whole
FROM category_wise_sale
ORDER BY category_sale DESC
