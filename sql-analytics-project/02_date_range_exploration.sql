/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATE_PART(),AGE()
===============================================================================
*/

-- Find the first and last order dates, and the range in months
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATE_PART('year', AGE(MIN(order_date), MAX(order_date))) * 12 +
    DATE_PART('month', AGE(MIN(order_date), MAX(order_date))) AS order_range_months
FROM gold.fact_sales;

-- Find the youngest and oldest customer based on birthdate
SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATE_PART('year', AGE(MIN(birthdate))) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    DATE_PART('year', AGE(MAX(birthdate))) AS youngest_age
FROM gold.dim_customers;
