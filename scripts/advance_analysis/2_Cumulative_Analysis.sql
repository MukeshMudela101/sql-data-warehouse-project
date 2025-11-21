/* -------------------------------------------
   PURPOSE:
   - Calculate yearly sales and price average
   - Running Total of yearly sales
   - Moving Average of Price
------------------------------------------- */
-- In Cumulative Cases, FRAME like 'ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW' are better than default 'RANGE...' type

SELECT 
	year_date,
	sale_by_year,
	SUM(sale_by_year) OVER(ORDER BY year_date ASC) AS running_total_sales,
	avg_price,
	AVG(avg_price) OVER(ORDER BY year_date ASC) AS moving_avg_price
FROM (
	SELECT
		DATETRUNC(year, order_date) AS year_date,
		SUM(sales_amount) AS sale_by_year,
		AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(year, order_date)
)t


-- Calculate the total sales per month and the running total of sales over 
SELECT 
	month_date,
	sale_by_month,
	SUM(sale_by_month) OVER(ORDER BY month_date ASC) AS running_sale
FROM (
	SELECT
		DATETRUNC(MONTH, order_date) AS month_date,
		SUM(sales_amount) AS sale_by_month
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH, order_date)
)t


-- Calculate the total sales per month and the running total of sales over time
	-- By default frame in Window Fn: RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
			-- (FORMAT() will give error in this case)
	-- Frame I used in Window Fn:	  ROW BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
SELECT 
	month_date,
	sale_by_month,
	--SUM(sale_by_month) OVER(ORDER BY month_date ASC) AS running_sale	
	SUM(sale_by_month) OVER(ORDER BY month_date ASC 
			ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sale
FROM (
	SELECT
		DATETRUNC(MONTH, order_date) AS month_date,
		SUM(sales_amount) AS sale_by_month
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH, order_date)
)t
