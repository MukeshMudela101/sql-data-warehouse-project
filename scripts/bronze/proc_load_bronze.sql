/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME, @start_time DATETIME, @end_time DATETIME;
	SET @batch_start_time = GETDATE();

	BEGIN TRY
		PRINT '=========================================================================='
		PRINT 'LOADING BRONZE LAYER'
		PRINT '=========================================================================='
	

		PRINT '--------------------------------------------------------------------------'
		PRINT 'LOADING CRM Tables'
		PRINT '--------------------------------------------------------------------------'

		-- Table 1 
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Courses\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			DELIMITER = ',',
			TABLOCK			
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------'
		PRINT ''


		-- Table 2
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Courses\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			DELIMITER = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------'
		PRINT ''


		-- Table 3
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Courses\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			DELIMITER = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------'
		PRINT ''



		PRINT '--------------------------------------------------------------------------'
		PRINT 'LOADING ERP Tables'
		PRINT '--------------------------------------------------------------------------'
	

		-- Table 4
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Courses\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'		
		-- .csv filename is not case sensitive for sql-server
		WITH (
			FIRSTROW = 2,
			DELIMITER = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------'
		PRINT ''


		-- Table 5
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into : bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Courses\SQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			DELIMITER = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------'
		PRINT ''

		-- PRINT (1/0); -- Error Message if you want to print 

		-- Table 6
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Courses\SQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			DELIMITER = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------'
		PRINT ''
	END TRY

	BEGIN CATCH
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message : ' + ERROR_MESSAGE();
		PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State : ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '============================================'
	END CATCH
	
	SET @batch_end_time = GETDATE(); 
	PRINT 'Total Batch Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'; 
	PRINT '>> ==============' ;
	PRINT '';
END
GO		-- This solve the problem of recursive printing 

EXEC bronze.load_bronze;
GO


/*
Points to note in FULL_LOAD in Bronze Layer: 

1. Check that the data has not shifted and is in the correct columns (some common mistakes).
2. Quickly delete all rows from a table, resetting it to an empty state.
3. FULL LOAD - emptying table first using TRUNCATE and then using BULK INSERT to fill it.
	It is important process because if changes are made in file, with FULL LOAD, we will always get the 
	latest data.
4. TABLOCK, lock the table during insertion, hence improving performance. 
5. Save frequently used SQL code in stored procedures in database. 

6. Add PRINTS to track execution, debug issues, and understand its flow. 
7. Even after making complete FULL_LOAD procedure. Still you need to make proper PRINT so that execution
	can be seen in better way. 
8. Add TRY. . . CATCH : 
	Ensures error handling, data integrity, and issue logging for easier debugging.
9. TRY . . . CATCH : 
	SQL runs the TRY block, and if it fails, it runs the CATCH block to handle the error.
10. Track ETL Duration : 
	Helps to identify bottlenecks, optimize performance, monitor trends, detect issues. 
	Hence, add that information to output.
11. For fast insertion or insertion in bulk, instead of 'INSERT', 'BULK INSERT' is used. 
*/
