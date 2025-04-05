
IF OBJECT_ID('silver.source_address', 'U') IS NOT NULL
    DROP TABLE silver.source_address;
GO

CREATE TABLE silver.source_address (
    address_id          INT,
    address_Line_1      NVARCHAR(100),
    city                NVARCHAR(50),
    state_province      NVARCHAR(50),
    country_region      NVARCHAR(50),
    postal_code         NVARCHAR(50),
    row_guide           NVARCHAR(100),
    modified_date       DATE,
	  dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO 		


IF OBJECT_ID('silver.source_customer', 'U') IS NOT NULL
    DROP TABLE silver.source_customer;
GO

CREATE TABLE silver.source_customer (
    customer_id        INT,
    title		           NVARCHAR(100),
    first_name			   NVARCHAR(50),
    middle_name			   NVARCHAR(50),
    last_name          NVARCHAR(50),
	  suffix				     NVARCHAR(50),
    company_name		   NVARCHAR(50),
    sales_person		   NVARCHAR(50),
    email_address		   NVARCHAR(50),
    phone				       NVARCHAR(50),
    password_hash		   NVARCHAR(50),
    password_salt		   NVARCHAR(50),
	  row_guide          NVARCHAR(100),
    modified_date      DATE,
	  dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO 		


IF OBJECT_ID('silver.source_customer_address', 'U') IS NOT NULL
    DROP TABLE silver.source_customer_address;
GO

CREATE TABLE silver.source_customer_address (
    customer_id		      INT,
    address_id          INT,
    address_type	      NVARCHAR(50),
    row_guid			      NVARCHAR(100),
    modified_date       DATE,
	  dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO 

IF OBJECT_ID('silver.source_product', 'U') IS NOT NULL
    DROP TABLE silver.source_product;
GO

CREATE TABLE silver.source_product (
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
    sell_start_date             DATE,
    sell_end_date               DATE,
    thumbnail_photo_file_name   NVARCHAR(100),
    row_guid                    NVARCHAR(100),
    modified_date               DATE,
	  dwh_create_date	      			DATETIME2 DEFAULT GETDATE()
);
GO 		

IF OBJECT_ID('silver.source_product_category', 'U') IS NOT NULL
    DROP TABLE silver.source_product_category;
GO

CREATE TABLE silver.source_product_category (
    product_category_id           INT,
    parent_product_category_id    NVARCHAR(50),
    name_info                     NVARCHAR(50),
    row_guid					            NVARCHAR(100),
    modified_date				          DATE,
	  dwh_create_date	        			DATETIME2 DEFAULT GETDATE()
);
GO 	

IF OBJECT_ID('silver.source_product_description', 'U') IS NOT NULL
    DROP TABLE silver.source_product_description;
GO

CREATE TABLE silver.source_product_description (
    product_description_id		INT,
    description_info			    NVARCHAR(MAX),
    row_guid					        NVARCHAR(100),
    modified_date				      DATE,
	  dwh_create_date				    DATETIME2 DEFAULT GETDATE()
);
GO 		

IF OBJECT_ID('silver.source_product_model', 'U') IS NOT NULL
    DROP TABLE silver.source_product_model;
GO

CREATE TABLE silver.source_product_model (
    product_model_id        INT,
    name_info               NVARCHAR(255),
    row_guid				        NVARCHAR(100),
    modified_date			      DATE,
	  dwh_create_date			    DATETIME2 DEFAULT GETDATE()
);
GO 		

IF OBJECT_ID('silver.source_product_model_product_description', 'U') IS NOT NULL
    DROP TABLE silver.source_product_model_product_description;
GO

CREATE TABLE silver.source_product_model_product_description (
    product_model_id   			  INT,
    product_description_id    NVARCHAR(255),
    culture                 	NVARCHAR(100),
    row_guid					        NVARCHAR(100),
    modified_date				      DATE,
	  dwh_create_date				    DATETIME2 DEFAULT GETDATE()
);
GO 		


