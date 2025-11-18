-- Explore All Countries from where our Customers come from
	-- Helps to analyze Geographical Spread 
SELECT DISTINCT country FROM gold.dim_customers

-- Explore All Product Categories "The Major Divisions"
	-- Giving overview of product range 
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1, 2, 3

SELECT DISTINCT category FROM gold.dim_products
SELECT DISTINCT subcategory FROM gold.dim_products
SELECT DISTINCT product_name FROM gold.dim_products