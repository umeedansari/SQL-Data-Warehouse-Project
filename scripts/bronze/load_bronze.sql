/*===============================================================================
COMMAND: Load Data into Bronze Schema Tables
===============================================================================
Script Purpose:
    This script uses the \COPY command to load data into tables within the 
    'bronze' schema from CSV files. It is configured to skip the first row in 
    the CSV file rather than treating it as a header.
    
    Replace '/path/to/output.csv' with the actual file path on your server 
    containing the data to be loaded.
===============================================================================*/
\COPY bronze.crm_cust_info FROM '/path/to/output.csv' WITH (FORMAT csv, HEADER false);

\COPY bronze.crm_prd_info FROM '/path/to/output.csv' WITH (FORMAT csv, HEADER false);

\COPY bronze.crm_sales_details FROM '/path/to/output.csv' WITH (FORMAT csv, HEADER false);

\COPY bronze.erp_loc_a101 FROM '/path/to/output.csv' WITH (FORMAT csv, HEADER false);

\COPY bronze.erp_cust_az12 FROM '/path/to/output.csv' WITH (FORMAT csv, HEADER false);

\COPY bronze.erp_px_cat_g1v2 FROM '/path/to/output.csv' WITH (FORMAT csv, HEADER false);
