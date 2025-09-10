/*
===================================
Title: Create Database and Schemas
Author: Archana
Version: V1-2025
===================================
Script Purpose:

    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING: Running this script will drop the entire 'DataWarehouse' database if it exists. Run with caution.
    
*/

USE master;
GO

  --drop the database if exists
IF EXISTS (select 1 from sys.databases where name = 'Datawarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Datawarehouse
END;

--create a new database with 3 schemas
CREATE DATABASE DataWarehouse
GO

USE DataWarehouse

GO
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
