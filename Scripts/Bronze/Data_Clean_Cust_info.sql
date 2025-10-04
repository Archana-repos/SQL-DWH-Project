-- Bronze Layer : Cleaning data and loading into silver layer

--Check for duplicates or  nulls in primary key : 
--grouping the primary key based on count and count > 1 / primary key is null -- determine count
--Expectations: No nulls

select count(*) ,cst_id 
from bronze.crm_cust_info
group by cst_id
having count(*) > 1 OR cst_id is null;

--Filter duplicates: Rank based on create date - only retain the latest entry --Row_number()
select * from (
select *,
ROW_NUMBER() OVER ( PARTITION BY cst_id order by cst_create_date desc) as flag
from bronze.crm_cust_info where cst_id is not null) t
where flag = 1 ;

-- filter unwanted spaces
select cst_firstname
from bronze.crm_cust_info
where cst_firstname != trim(cst_firstname)

select cst_lastname
from bronze.crm_cust_info
where cst_lastname != trim(cst_lastname)

select cst_gndr
from bronze.crm_cust_info
where cst_gndr != trim(cst_gndr) -- None


