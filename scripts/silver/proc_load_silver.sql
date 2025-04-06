/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/


CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    BEGIN TRY
        PRINT 'Inserting data into silver.source_address...';
        TRUNCATE TABLE silver.source_address;
        INSERT INTO silver.source_address(
            address_id,
            Address_Line_1,
            city,
            state_province,
            country_region,
            postal_code,
            row_guid,
            modified_date
        )
        SELECT
            address_id,
            Address_Line_1,
            city,
            state_province,
            country_region,
            postal_code,
            row_guid,
            CAST(modified_date AS DATE)
        FROM bronze.source_address;
        PRINT 'Successfully inserted into silver.source_address.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in silver.source_address: ' + ERROR_MESSAGE();
    END CATCH

    PRINT '===============================================================================================';

    BEGIN TRY
        PRINT 'Inserting data into silver.source_customer...';
        TRUNCATE TABLE silver.source_customer;
        INSERT INTO silver.source_customer(
            customer_id,
            title,
            first_name,
            middle_name,
            last_name,
            suffix,
            company_name,
            sales_person,
            email_address,
            phone,
            password_hash,
            password_salt,
            row_guid,
            modified_date
        )
        SELECT
            customer_id,
            title,
            first_name,
            ISNULL(middle_name, 'N/A'),
            last_name,
            ISNULL(suffix, 'N/A'),
            company_name,
            sales_person,
            email_address,
            phone,
            password_hash,
            password_salt,
            row_guid,
            CAST(modified_date AS DATE)
        FROM bronze.source_customer;
        PRINT 'Successfully inserted into silver.source_customer.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in silver.source_customer: ' + ERROR_MESSAGE();
    END CATCH

    PRINT '===============================================================================================';

    BEGIN TRY
        PRINT 'Inserting data into silver.source_customer_address...';
        TRUNCATE TABLE silver.source_customer_address;
        INSERT INTO silver.source_customer_address(
            customer_id,
            address_id,
            address_type,
            row_guid,
            modified_date
        )
        SELECT
            customer_id,
            address_id,
            address_type,
            row_guid,
            CAST(modified_date AS DATE)
        FROM bronze.source_customer_address;
        PRINT 'Successfully inserted into silver.source_customer_address.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in silver.source_customer_address: ' + ERROR_MESSAGE();
    END CATCH

    PRINT '===============================================================================================';

    BEGIN TRY
        PRINT 'Inserting data into silver.source_product...';
        TRUNCATE TABLE silver.source_product;
        INSERT INTO silver.source_product(
            product_id,
            name_info,
            product_number,
            color,
            standard_cost,
            list_price,
            size,
            weight_info,
            product_category_id,
            product_model_id,
            sell_start_date,
            sell_end_date,
            thumbnail_photo_file_name,
            row_guid,
            modified_date
        )
        SELECT
            product_id,
            name_info,
            product_number,
            ISNULL(color, 'N/A'),
            standard_cost,
            list_price,
            ISNULL(size, 'N/A'),
            ISNULL(weight_info, 'N/A'),
            product_category_id,
            product_model_id,
            sell_start_date,
            CAST(sell_end_date AS DATE),
            thumbnail_photo_file_name,
            row_guid,
            CAST(modified_date AS DATE)
        FROM bronze.source_product;
        PRINT 'Successfully inserted into silver.source_product.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in silver.source_product: ' + ERROR_MESSAGE();
    END CATCH

    PRINT '===============================================================================================';

    BEGIN TRY
        PRINT 'Inserting data into silver.source_product_category...';
        TRUNCATE TABLE silver.source_product_category;
        INSERT INTO silver.source_product_category(
            product_category_id,
            parent_product_category_id,
            name_info,
            row_guid,
            modified_date
        )
        SELECT
            product_category_id,
            ISNULL(parent_product_category_id, 'N/A'),
            name_info,
            row_guid,
            CAST(modified_date AS DATE)
        FROM bronze.source_product_category;
        PRINT 'Successfully inserted into silver.source_product_category.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in silver.source_product_category: ' + ERROR_MESSAGE();
    END CATCH

    PRINT '===============================================================================================';

    BEGIN TRY
        PRINT 'Inserting data into silver.source_product_description...';
        TRUNCATE TABLE silver.source_product_description;
        INSERT INTO silver.source_product_description(
            product_description_id,
            description_info,
            row_guid,
            modified_date
        )
        SELECT
            product_description_id,
            description_info,
            row_guid,
            CAST(modified_date AS DATE)
        FROM bronze.source_product_description;
        PRINT 'Successfully inserted into silver.source_product_description.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in silver.source_product_description: ' + ERROR_MESSAGE();
    END CATCH

    PRINT '===============================================================================================';

    BEGIN TRY
        PRINT 'Inserting data into silver.source_product_model...';
        TRUNCATE TABLE silver.source_product_model;
        INSERT INTO silver.source_product_model(
            product_model_id,
            name_info,
            row_guid,
            modified_date
        )
        SELECT
            product_model_id,
            name_info,
            row_guid,
            CAST(modified_date AS DATE)
        FROM bronze.source_product_model;
        PRINT 'Successfully inserted into silver.source_product_model.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in silver.source_product_model: ' + ERROR_MESSAGE();
    END CATCH

    PRINT '===============================================================================================';

    BEGIN TRY
        PRINT 'Inserting data into silver.source_product_model_product_description...';
        TRUNCATE TABLE silver.source_product_model_product_description;
        INSERT INTO silver.source_product_model_product_description(
            product_model_id,
            product_description_id,
            culture,
            row_guid,
            modified_date
        )
        SELECT
            product_model_id,
            product_description_id,
            CASE
                WHEN culture = 'en' THEN 'English'
                WHEN culture = 'ar' THEN 'Arabic'
                WHEN culture = 'fr' THEN 'French'
                WHEN culture = 'he' THEN 'Hebrew'
                WHEN culture = 'th' THEN 'Thai'
                WHEN culture = 'zh-cht' THEN 'Chinese (Traditional)'
                ELSE culture
            END,
            row_guid,
            CAST(modified_date AS DATE)
        FROM bronze.source_product_model_product_description;
        PRINT 'Successfully inserted into silver.source_product_model_product_description.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in silver.source_product_model_product_description: ' + ERROR_MESSAGE();
    END CATCH

    PRINT '===============================================================================================';
END;
