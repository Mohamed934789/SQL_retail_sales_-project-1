-- SQL Server. Import the supplied CSV with explicit date/time types.
-- The original CSV header spells quantity as quantiy; preserve that mapping here.
CREATE TABLE retail_sales (
 transactions_id int, sale_date date, sale_time time, customer_id int,
 gender nvarchar(30), age int, category nvarchar(100), quantiy int,
 price_per_unit decimal(18,2), cogs decimal(18,2), total_sale decimal(18,2)
);
