/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'dwh' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'dwh' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


-- Drop the 'dwh' database if it exists
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'dwh') THEN
        PERFORM dblink_exec('dbname=postgres', 'DROP DATABASE dwh');
    END IF;
END;
$$;

--create database
create database dwh; 

-- Create schemas
CREATE SCHEMA bronze; -- For raw data
CREATE SCHEMA silver; -- For cleaned data
CREATE SCHEMA gold;   -- For curated data


