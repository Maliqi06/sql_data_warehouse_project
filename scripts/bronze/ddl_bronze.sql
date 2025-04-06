/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('bronze.source_address', 'U') IS NOT NULL
    DROP TABLE bronze.source_address;
GO

CREATE TABLE bronze.source_address (
    address_id          INT,
    address_Line_1      NVARCHAR(100),
    address_Line_2      NVARCHAR(100),
    city                NVARCHAR(50),
    state_province      NVARCHAR(50),
    country_region      NVARCHAR(50),
    postal_code         NVARCHAR(50),
    row_guid            NVARCHAR(100),
    modified_date       DATETIME
);
GO 

IF OBJECT_ID('bronze.source_customer', 'U') IS NOT NULL
    DROP TABLE bronze.source_customer;
GO

CREATE TABLE bronze.source_customer (
    customer_id         INT,
    name_style          INT,
    title               NVARCHAR(10),
    first_name          NVARCHAR(50),
    middle_name         NVARCHAR(50),
    last_name           NVARCHAR(50),
    suffix              NVARCHAR(10),
    company_name        NVARCHAR(100),
    sales_person        NVARCHAR(100),
    email_address       NVARCHAR(100),
    phone               NVARCHAR(50),
    password_hash       NVARCHAR(100),
    password_salt       NVARCHAR(10),
    row_guid            NVARCHAR(100),
    modified_date       DATETIME 
);
GO

IF OBJECT_ID('bronze.source_customer_address', 'U') IS NOT NULL
    DROP TABLE bronze.source_customer_address;
GO

CREATE TABLE bronze.source_customer_address (
    customer_id   	INT,
    address_id    	INT,
    address_type  	NVARCHAR(50),
    row_guid      	NVARCHAR(100),
    modified_date 	DATETIME
);
GO

IF OBJECT_ID('bronze.source_product', 'U') IS NOT NULL
    DROP TABLE bronze.source_product;
GO

CREATE TABLE bronze.source_product (
    product_id                  INT,
    name_info                   NVARCHAR(100),
    product_number              NVARCHAR(50),
    color                       NVARCHAR(50),
    standard_cost               DECIMAL(10, 6),
    list_price                  DECIMAL(10, 6),
    size                        NVARCHAR(50),
    weight_info                 NVARCHAR(50),
    product_category_id         NVARCHAR(50),
    product_model_id            NVARCHAR(50),
    sell_start_date             DATETIME,
    sell_end_date               DATETIME,
    discontinued_date           DATETIME,
    thumbnail_photo_file_name   NVARCHAR(100),
    row_guid                    NVARCHAR(100),
    modified_date               DATETIME
);
GO

IF OBJECT_ID('bronze.source_product_category', 'U') IS NOT NULL
    DROP TABLE bronze.source_product_category;
GO

CREATE TABLE bronze.source_product_category (
    product_category_id         INT,
    parent_product_category_id  NVARCHAR(50),
    name_info                   NVARCHAR(50),
    row_guid                    NVARCHAR(100),
    modified_date               DATETIME 
);
GO

IF OBJECT_ID('bronze.source_product_description', 'U') IS NOT NULL
    DROP TABLE bronze.source_product_description;
GO

CREATE TABLE bronze.source_product_description (
    product_description_id   INT,
    description_info         NVARCHAR(MAX),
    row_guid                 NVARCHAR(100),
    modified_date            DATETIME 
);
GO

IF OBJECT_ID('bronze.source_product_model', 'U') IS NOT NULL
    DROP TABLE bronze.source_product_model;
GO

CREATE TABLE bronze.source_product_model (
    product_model_id        INT,
    name_info               NVARCHAR(255),
    catalog_description     NVARCHAR(50),
    row_guid                NVARCHAR(100),
    modified_date           DATETIME
);
GO

IF OBJECT_ID('bronze.source_product_model_product_description', 'U') IS NOT NULL
    DROP TABLE bronze.source_product_model_product_description;
GO
CREATE TABLE bronze.source_product_model_product_description (
    product_model_id   		INT,
    product_description_id      NVARCHAR(255),
    culture                 	NVARCHAR(100),
    row_guid                 	NVARCHAR(100),
    modified_date            	DATETIME
);
GO

IF OBJECT_ID('bronze.source_sales_order_detail', 'U') IS NOT NULL
    DROP TABLE bronze.source_sales_order_detail;
GO

CREATE TABLE bronze.source_sales_order_detail (
    sales_order_id			INT,
    sales_order_detail_id		INT,
    order_qty				INT,
    product_id				INT,
    unit_price				DECIMAL(10, 6),
    unit_price_discount			DECIMAL(10, 6),
    line_total				DECIMAL(10, 6),
    row_guid				NVARCHAR(100),
    modified_date			DATETIME
);
GO 

IF OBJECT_ID('bronze.source_sales_order_header', 'U') IS NOT NULL
    DROP TABLE bronze.source_sales_order_header;
GO

CREATE TABLE bronze.source_sales_order_header (
    	sales_order_id				INT,
    	revision_number				INT,
	order_date				DATETIME,
	due_date				DATETIME,
	ship_date				DATETIME,
	status_info				INT,
	online_order_flag			INT,
	sales_order_number			NVARCHAR(50),
	purchase_order_number			NVARCHAR(50),
	account_number				NVARCHAR(50),
	customer_id				INT,
	ship_to_address_id			INT,
	bill_to_address_id			INT,
	ship_method				NVARCHAR(50),
	credit_card_approval_code		INT,
	sub_total				DECIMAL(15, 9),
	tax_amt		                	DECIMAL(15, 9),
	freight		                	DECIMAL(15, 9),
	total_due		       	        DECIMAL(15, 9),
	comment					NVARCHAR(50),
    	row_guid				NVARCHAR(100),
	modified_date				DATETIME
);
GO 
