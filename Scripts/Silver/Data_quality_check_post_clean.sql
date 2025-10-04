--Silver layer: Quality check 
--TABLE: silver.crm_cust_info

select count(*) ,cst_id 
from silver.crm_cust_info
group by cst_id
having count(*) > 1 OR cst_id is null;

--duplicates check
select * from (
select *,
ROW_NUMBER() OVER ( PARTITION BY cst_id order by cst_create_date desc) as flag
from silver.crm_cust_info where cst_id is not null) t
where flag != 1 ;

-- unwanted spaces check
select cst_firstname from silver.crm_cust_info where cst_firstname != trim(cst_firstname)
select cst_lastname from silver.crm_cust_info where cst_lastname != trim(cst_lastname)
select cst_gndr from silver.crm_cust_info where cst_gndr != trim(cst_gndr) 

--data consistency check and standarization
select distinct(cst_gndr) from silver.crm_cust_info
select * from silver.crm_cust_info -- Contains metadata info -> shows when data was into silver layer 


