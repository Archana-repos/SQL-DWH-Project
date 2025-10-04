insert into silver.crm_cust_info 
(cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date)

select 
cst_id,
cst_key,
trim(cst_firstname) as cst_firstname, --ensures Data Consistency & Standarization 
trim(cst_lastname) as cst_lastname,
CASE
WHEN UPPER(trim(cst_marital_status)) = 'M' THEN 'Married' 
WHEN UPPER(trim(cst_marital_status)) = 'S' THEN 'Single'
ELSE 'Not Specified' -- handling missing data
END cst_marital_status, -- Normalise marital status values to readable format
CASE
WHEN UPPER(trim(cst_gndr)) = 'M' THEN 'Male'
WHEN UPPER(trim(cst_gndr)) = 'F' THEN 'Female'
ELSE 'Not Specified'
END cst_gndr, -- Normalise gender values to readable format
cst_create_date
from (
select *,
ROW_NUMBER() OVER ( PARTITION BY cst_id order by cst_create_date desc) as flag
from bronze.crm_cust_info where cst_id is not null )t 
where flag = 1 ; --select most recent record per customer

