/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.source_address'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    address_id,
    COUNT(*) 
FROM silver.source_address
GROUP BY address_id
HAVING COUNT(*) > 1 OR address_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
    address_Line_1 
FROM silver.source_address
WHERE address_Line_1 != TRIM(address_Line_1);

-- Data Standardization & Consistency
SELECT DISTINCT 
    country_region 
FROM silver.source_address;

-- Identify Out-of-Range Dates
-- Expectation: Modified Date between 2005-06-01 and Today
SELECT DISTINCT 
    modified_date 
FROM silver.source_address
WHERE modified_date > '2005-06-01' 
   OR modified_date > GETDATE();

-- ====================================================================
-- Checking 'silver.source_customer'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    customer_id,
    COUNT(*) 
FROM silver.source_customer
GROUP BY customer_id
HAVING COUNT(*) > 1 OR customer_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
    middle_name 
FROM silver.source_customer
WHERE middle_name != TRIM(middle_name);

-- Check for NULLs or Negative Values in Cost
-- Expectation: No Results
SELECT 
    title 
FROM silver.source_customer
WHERE title IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT 
     middle_name
FROM silver.source_customer;

-- Identify Out-of-Range Dates
-- Expectation: Modified Date between 2005-06-01 and Today
SELECT DISTINCT 
    modified_date 
FROM silver.source_address
WHERE modified_date > '2005-06-01' 
   OR modified_date > GETDATE();

-- ====================================================================
-- Checking 'silver.source_customer_address'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    address_id,
    COUNT(*) 
FROM silver.source_customer_address
GROUP BY address_id
HAVING COUNT(*) > 1 OR address_id IS NULL;

-- Check Data Consistency
-- Expectation: No Results
SELECT DISTINCT 
    address_type 
FROM silver.source_customer_address

-- Identify Out-of-Range Dates
-- Expectation: Modified Date between 2005-06-01 and Today
SELECT DISTINCT 
    modified_date 
FROM silver.source_address
WHERE modified_date > '2005-06-01' 
   OR modified_date > GETDATE();

-- ====================================================================
-- Checking 'silver.source_product'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    product_id,
    COUNT(*) 
FROM silver.source_product
GROUP BY product_id
HAVING COUNT(*) > 1 OR product_id IS NULL;

-- Identify Out-of-Range Dates
-- Expectation: Modified Date between 2005-06-01 and Today
SELECT DISTINCT 
    modified_date 
FROM silver.source_address
WHERE modified_date > '2005-06-01' 
   OR modified_date > GETDATE();

-- Data Standardization & Consistency
SELECT DISTINCT 
    color 
FROM silver.source_product
ORDER BY color;

-- ====================================================================
-- Checking 'silver.source_product_category'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    product_category_id,
    COUNT(*) 
FROM silver.source_product_category
GROUP BY product_category_id
HAVING COUNT(*) > 1 OR product_category_id IS NULL;

-- ====================================================================
-- Checking 'silver.source_product_description'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    product_description_id,
    COUNT(*) 
FROM silver.source_product_description
GROUP BY product_description_id
HAVING COUNT(*) > 1 OR product_description_id IS NULL;
-- ====================================================================
-- Checking 'silver.source_product_model'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    product_model_id,
    COUNT(*) 
FROM silver.source_product_model
GROUP BY product_model_id
HAVING COUNT(*) > 1 OR product_model_id IS NULL;

-- Identify Out-of-Range Dates
-- Expectation: Modified Date between 2005-06-01 and Today
SELECT DISTINCT 
    modified_date 
FROM silver.source_product_model
WHERE modified_date > '2005-06-01' 
   OR modified_date > GETDATE();

-- ====================================================================
-- Checking 'silver.source_product_model_product_description'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    product_description_id,
    COUNT(*) 
FROM silver.source_product_model_product_description
GROUP BY product_description_id
HAVING COUNT(*) > 1 OR product_description_id IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT 
    culture 
FROM silver.source_product_model_product_description
ORDER BY culture;

-- Identify Out-of-Range Dates
-- Expectation: Modified Date between 2005-06-01 and Today
SELECT DISTINCT 
    modified_date 
FROM silver.source_product_model_product_description
WHERE modified_date > '2005-06-01' 
   OR modified_date > GETDATE();

-- ====================================================================
-- Checking 'silver.source_sales_order_detail'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    sales_order_detail_id,
    COUNT(*) 
FROM silver.source_sales_order_detail
GROUP BY sales_order_detail_id
HAVING COUNT(*) > 1 OR sales_order_detail_id IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT 
    order_qty 
FROM silver.source_sales_order_detail
ORDER BY order_qty;

-- Check Data Consistency: Sales = Quantity * Price * (1 - Price Discount)
-- Expectation: No Results
SELECT 
    order_qty,
    unit_price,
    unit_price_discount,
	line_total
FROM silver.source_sales_order_detail
WHERE line_total != order_qty * unit_price * (1 - unit_price_discount)
   OR line_total IS NULL 
   OR unit_price IS NULL 
   OR unit_price_discount IS NULL
   OR order_qty IS NULL
   OR line_total <= 0 
   OR order_qty <= 0 
   OR unit_price <= 0
   OR unit_price_discount < 0
ORDER BY line_total, order_qty, unit_price, unit_price_discount;

-- Identify Out-of-Range Dates
-- Expectation: Modified Date between 2005-06-01 and Today
SELECT DISTINCT 
    modified_date 
FROM silver.source_sales_order_detail
WHERE modified_date > '2005-06-01' 
   OR modified_date > GETDATE();

-- ====================================================================
-- Checking 'silver.source_sales_order_header'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    sales_order_id,
    COUNT(*) 
FROM silver.source_sales_order_header
GROUP BY sales_order_id
HAVING COUNT(*) > 1 OR sales_order_id IS NULL;

SELECT 
    sales_order_number,
    COUNT(*) 
FROM silver.source_sales_order_header
GROUP BY sales_order_number
HAVING COUNT(*) > 1 OR sales_order_number IS NULL;

-- Check for Invalid Date Orders (Order Date > Shipping/Due Dates)
-- Expectation: No Results
SELECT 
    * 
FROM silver.source_sales_order_header
WHERE order_date > ship_date 
   OR order_date > due_date;

-- Check Data Consistency
-- Expectation: No Results
SELECT 
    total_due,
    sub_total,
    tax_amt,
	freight
FROM silver.source_sales_order_header
WHERE total_due != sub_total + tax_amt + freight
   OR total_due IS NULL 
   OR sub_total IS NULL 
   OR tax_amt IS NULL
   OR freight IS NULL
   OR total_due <= 0 
   OR sub_total <= 0 
   OR tax_amt <= 0
   OR freight < 0
ORDER BY total_due, sub_total, tax_amt, freight;

-- Identify Out-of-Range Dates
-- Expectation: Modified Date between 2005-06-01 and Today
SELECT DISTINCT 
    modified_date 
FROM silver.source_sales_order_header
WHERE modified_date > '2005-06-01' 
   OR modified_date > GETDATE();
