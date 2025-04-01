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
    
  PRINT 'Inserting data into bronze.source_address...';
  BEGIN TRY
      TRUNCATE TABLE bronze.source_address;
      BULK INSERT bronze.source_address
      FROM 'C:\data\source\address.csv'
      WITH (
          FORMAT = 'CSV',
          FIRSTROW = 2,
          FIELDTERMINATOR = ',',
          FIELDQUOTE = '"',
          TABLOCK
      );
      PRINT 'Successfully inserted data into bronze.source_address.';
  END TRY
  BEGIN CATCH
      PRINT 'Error inserting data into bronze.source_address: ' + ERROR_MESSAGE();
  END CATCH;
  
  PRINT '===============================================================================================';
  
  PRINT 'Inserting data into bronze.source_customer...';
  BEGIN TRY
      TRUNCATE TABLE bronze.source_customer;
      BULK INSERT bronze.source_customer
      FROM 'C:\data\source\customer.csv'
      WITH (  
          FORMAT = 'CSV',
          FIRSTROW = 2,
          FIELDTERMINATOR = ',',
          FIELDQUOTE = '"',
          TABLOCK
      );
      PRINT 'Successfully inserted data into bronze.source_customer.';
  END TRY
  BEGIN CATCH
      PRINT 'Error inserting data into bronze.source_customer: ' + ERROR_MESSAGE();
  END CATCH;
  
  PRINT '===============================================================================================';
  
  PRINT 'Inserting data into bronze.source_customer_address...';
  BEGIN TRY
      TRUNCATE TABLE bronze.source_customer_address;
      BULK INSERT bronze.source_customer_address 
      FROM 'C:\data\source\customer_address.csv' 
      WITH (
          FORMAT = 'CSV',
          FIRSTROW = 2,
          FIELDTERMINATOR = ',',
          FIELDQUOTE = '"',
          TABLOCK
      );
      PRINT 'Successfully inserted data into bronze.source_customer_address.';
  END TRY
  BEGIN CATCH
      PRINT 'Error inserting data into bronze.source_customer_address: ' + ERROR_MESSAGE();
  END CATCH;
  
  PRINT '===============================================================================================';
  
  PRINT 'Inserting data into bronze.source_product_category...';
  BEGIN TRY
      TRUNCATE TABLE bronze.source_product_category;
      BULK INSERT bronze.source_product_category
      FROM 'C:\data\source\product_category.csv' 
      WITH (
          FORMAT = 'CSV',
          FIRSTROW = 2,
          FIELDTERMINATOR = ',',
          FIELDQUOTE = '"',
          TABLOCK
      );
      PRINT 'Successfully inserted data into bronze.source_product_category.';
  END TRY
  BEGIN CATCH
      PRINT 'Error inserting data into bronze.source_product_category: ' + ERROR_MESSAGE();
  END CATCH;
  
  PRINT '===============================================================================================';
  
  PRINT 'Inserting data into bronze.source_product_description...';
  BEGIN TRY
      TRUNCATE TABLE bronze.source_product_description;
      BULK INSERT bronze.source_product_description
      FROM 'C:\data\source\product_description.csv'
      WITH (
          FORMAT = 'CSV',
          FIRSTROW = 2,
          FIELDTERMINATOR = ',',
          FIELDQUOTE = '"',
          TABLOCK
      );
      PRINT 'Successfully inserted data into bronze.source_product_description.';
  END TRY
  BEGIN CATCH
      PRINT 'Error inserting data into bronze.source_product_description: ' + ERROR_MESSAGE();
  END CATCH;
  
  PRINT '===============================================================================================';
  
  PRINT 'Inserting data into bronze.source_product_model...';
  BEGIN TRY
      TRUNCATE TABLE bronze.source_product_model;
      BULK INSERT bronze.source_product_model
      FROM 'C:\data\source\product_model.csv'
      WITH (
          FORMAT = 'CSV',
          FIRSTROW = 2,
          FIELDTERMINATOR = ',',
          FIELDQUOTE = '"',
          TABLOCK
      );
      PRINT 'Successfully inserted data into bronze.source_product_model.';
  END TRY
  BEGIN CATCH
      PRINT 'Error inserting data into bronze.source_product_model: ' + ERROR_MESSAGE();
  END CATCH;
  
  PRINT '===============================================================================================';
  
  PRINT 'Inserting data into bronze.source_product_model_product_description...';
  BEGIN TRY
      TRUNCATE TABLE bronze.source_product_model_product_description;
      BULK INSERT bronze.source_product_model_product_description
      FROM 'C:\data\source\product_model_product_description.csv'
      WITH (
          FORMAT = 'CSV',
          FIRSTROW = 2,
          FIELDTERMINATOR = ',',
          FIELDQUOTE = '"',
          TABLOCK
      );
      PRINT 'Successfully inserted data into bronze.source_product_model_product_description.';
  END TRY
  BEGIN CATCH
      PRINT 'Error inserting data into bronze.source_product_model_product_description: ' + ERROR_MESSAGE();
  END CATCH;
  
  PRINT '===============================================================================================';
END
