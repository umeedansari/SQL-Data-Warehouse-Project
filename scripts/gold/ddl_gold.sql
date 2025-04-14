/*===============================================================================
Script: Create Gold Layer Views
===============================================================================
Script Purpose:
    This script defines views in the 'gold' schema for dimensional tables and 
    a fact table. It transforms and aggregates data from the 'silver' schema 
    to serve analytical and reporting needs.

    - `dim_customers`: Aggregates and normalizes customer-related information.
    - `dim_products`: Provides product-related dimensions with additional 
      category and subcategory details.
    - `fact_sales`: Connects sales transactions with customer and product 
      dimensions for detailed analysis.

===============================================================================*/

/* Create View: Dim Customers */
CREATE OR REPLACE VIEW gold.dim_customers AS 
SELECT 
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_num,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
    la.cntry AS country,
    ci.cst_marital_status AS marital_status,
    CASE 
        WHEN ci.cst_gender != 'N/A' THEN ci.cst_gender
        ELSE COALESCE(ca.gen, 'N/A')
    END AS gender,
    ca.bdate AS birth_date,
    ci.cst_create_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS la
    ON ci.cst_key = la.cid;

/* Create View: Dim Products */
CREATE OR REPLACE VIEW gold.dim_products AS 
SELECT 
    ROW_NUMBER() OVER (ORDER BY p.prd_start_dt, p.prd_key) AS product_key,
    p.prd_id AS product_id,
    p.prd_key AS product_number,
    p.prd_nm AS product_name,
    p.cat_id AS category_id,
    px.cat AS category,
    px.subcat AS subcategory,
    px.maintenance AS maintenance,
    p.prd_cost AS product_cost,
    p.prd_line AS product_line,
    p.prd_start_dt AS product_start_date
FROM silver.crm_prd_info AS p
LEFT JOIN silver.erp_px_cat_g1v2 AS px
    ON px.id = p.cat_id
WHERE p.prd_end_dt IS NULL;

/* Drop View: Fact Sales */
DROP VIEW IF EXISTS gold.fact_sales;

/* Create View: Fact Sales */
CREATE OR REPLACE VIEW gold.fact_sales AS 
SELECT 
    sls_ord_num AS order_number,
    p.product_key,
    c.customer_key,
    sls_order_dt AS order_date,
    sls_ship_dt AS shipping_date,
    sls_due_dt AS due_date,
    sls_sales AS sales,
    sls_quantity AS quantity,
    sls_price AS price
FROM silver.crm_sales_details AS s
LEFT JOIN gold.dim_customers AS c
    ON c.customer_id = s.sls_cust_id
LEFT JOIN gold.dim_products AS p
    ON p.product_number = s.sls_prd_key;
