/*===============================================================================
Script: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This script performs the ETL process to populate the 'silver' schema tables 
    from the 'bronze' schema.
    Actions performed:
    - Truncates the 'silver' tables to ensure no leftover data exists from 
      previous runs.
    - Inserts cleansed and transformed data into 'silver' schema tables.
    - Transforms data formats, normalizes codes to human-readable text, and 
      handles missing or inconsistent data values.
===============================================================================*/

/* Truncate the CRM Customer Info table */
TRUNCATE TABLE silver.crm_cust_info;

-- Insert transformed customer information into the silver layer
INSERT INTO silver.crm_cust_info
SELECT 
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    CASE 
        WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
        WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
        ELSE 'N/A'
    END AS cst_marital_status,
    CASE 
        WHEN UPPER(TRIM(cst_gender)) = 'F' THEN 'Female'
        WHEN UPPER(TRIM(cst_gender)) = 'M' THEN 'Male'
        ELSE 'N/A'
    END AS cst_gender,
    cst_create_date
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flagg
    FROM bronze.crm_cust_info 
    WHERE cst_id IS NOT NULL
) AS c
WHERE flagg = 1;

/* Truncate the Product Info table */
TRUNCATE TABLE silver.crm_prd_info;

-- Insert transformed product information into the silver layer
INSERT INTO silver.crm_prd_info
SELECT 
    prd_id,
    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
    SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
    prd_nm,
    COALESCE(prd_cost, 0) AS prd_cost,
    CASE UPPER(TRIM(prd_line))
        WHEN 'M' THEN 'Mountain'
        WHEN 'R' THEN 'Road'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
        ELSE 'N/A'
    END AS prd_line,
    prd_start_dt :: DATE,
    (LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - INTERVAL '1 day') :: DATE AS prd_end_dt
FROM bronze.crm_prd_info;

/* Truncate the CRM Sales Details table */
TRUNCATE TABLE silver.crm_sales_details;

-- Insert cleansed sales details into the silver layer
INSERT INTO silver.crm_sales_details
SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    CASE 
        WHEN sls_order_dt = '0' OR LENGTH(sls_order_dt::VARCHAR) != 8 THEN NULL
        ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
    END AS sls_order_dt,
    CASE 
        WHEN sls_ship_dt = '0' OR LENGTH(sls_ship_dt::VARCHAR) != 8 THEN NULL
        ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
    END AS sls_ship_dt,
    CASE 
        WHEN sls_due_dt = '0' OR LENGTH(sls_due_dt::VARCHAR) != 8 THEN NULL
        ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
    END AS sls_due_dt,
    CASE
        WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) THEN sls_quantity * ABS(sls_price)
        ELSE sls_sales
    END AS sls_sales,
    sls_quantity,
    CASE
        WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales / NULLIF(sls_quantity, 0)
        ELSE sls_price
    END AS sls_price
FROM bronze.crm_sales_details;

/* Truncate the ERP Customer Table */
TRUNCATE TABLE silver.erp_cust_az12;

-- Insert cleansed customer data into the silver layer
INSERT INTO silver.erp_cust_az12
SELECT 
    CASE 
        WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LENGTH(cid))
        ELSE cid
    END AS cid,
    CASE 
        WHEN bdate > NOW() THEN NULL
        ELSE bdate
    END AS bdate,
    CASE 
        WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
        ELSE 'N/A'
    END AS gen
FROM bronze.erp_cust_az12;

/* Truncate the ERP Location table */
TRUNCATE TABLE silver.erp_loc_a101;

-- Insert transformed location information into the silver layer
INSERT INTO silver.erp_loc_a101
SELECT 
    REPLACE(cid, '-', '') AS cid,
    CASE 
        WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
        WHEN UPPER(TRIM(cntry)) IN ('US', 'USA') THEN 'United States'
        WHEN UPPER(TRIM(cntry)) = '' OR cntry IS NULL THEN 'N/A'
        ELSE TRIM(cntry)
    END AS cntry
FROM bronze.erp_loc_a101;

/* Truncate the ERP PX Category G1V2 table */
TRUNCATE TABLE silver.erp_px_cat_g1v2;

/* Insert transformed data into the silver.erp_px_cat_g1v2 table */
INSERT INTO silver.erp_px_cat_g1v2
SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM bronze.erp_px_cat_g1v2;

