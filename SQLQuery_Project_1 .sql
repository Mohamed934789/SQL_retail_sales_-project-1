-- Data Exploration & Cleaning

	--the total number of records in the dataset.
	select count(*) as "The total number of records " from retail_sales;

	--how many unique customers are in the dataset.
	select count(distinct customer_id) as " Number of customers "from retail_sales;

	--unique product categories in the dataset.
	select distinct category as "the categories " from retail_sales ;

	-- checking and deleting null values from dataset.
	--checking.
		SELECT * FROM retail_sales
	WHERE
		sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
		gender IS NULL OR age IS NULL OR category IS NULL OR
		quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
	-- Rows are reported above for review; this analysis does not delete source records.

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

--Data Analysis & Findings.

   --all columns for sales made on '2022-11-05'.
   select * from retail_sales
   where sale_date='2022-11-05';

   --all transactions where the category is 'Clothing'
   --and the quantity sold is more than 4 in the month of Nov-2022:
   select transactions_id from retail_sales
   where category='Clothing' and quantiy >4
   and format (cast(sale_date as date),'yyyy-MM')='2022-11'  ;

   --the total sales (total_sale) for each category
   select category ,sum(cast(Total_sale as float)) as "Total_sale"
   from retail_sales
   group by category;

   --the average age of customers who purchased items from the 'Beauty' category.:
   select avg(cast(age as float)) as average_age from retail_sales
   where category ='Beauty';

   --all transactions where the total_sale is greater than 1000
	select transactions_id from retail_sales
	where Total_sale>1000;

	--the total number of transactions (transaction_id) made by each gender in each category
	select gender, category, count(transactions_id)as "total number of transactions" from retail_sales
	group by gender, category;

	--Monthly total sales; highest-total month in each year (ties retained)
			WITH MonthlySales AS (
			SELECT
				FORMAT(CAST(sale_date AS DATE), 'yyyy') AS sales_year,
				FORMAT(CAST(sale_date AS DATE), 'MM') AS sales_month,
				SUM(Total_sale) AS total_monthly_sales
			FROM retail_sales
			GROUP BY
				FORMAT(CAST(sale_date AS DATE), 'yyyy'),
				FORMAT(CAST(sale_date AS DATE), 'MM')
		),
		RankedMonths AS (
			SELECT
				sales_year,
				sales_month,
				total_monthly_sales,
				RANK() OVER (
					PARTITION BY sales_year
					ORDER BY total_monthly_sales DESC
				) AS rnk
			FROM MonthlySales
		)
		SELECT
			sales_year,
			sales_month,
			total_monthly_sales
		FROM RankedMonths
		WHERE rnk = 1;

	--top 5 customers based on the highest total sales.
	select top 5 customer_id, sum(Total_sale) from retail_sales
	group by customer_id
	order by sum(Total_sale) desc ;

	--the number of unique customers who purchased items from each category.

	select category ,count(distinct customer_id) from retail_sales
	group by category;

	--create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17
	with hourly_sale as (

	select *,case
				when DATEPART(HOUR, sale_time)<12 then 'Morning'
				when DATEPART(HOUR, sale_time) between 12 and 17 then 'After Noon'
				else 'evening'
				end as shift
	from retail_sales

	)
	select shift , count(*)as "Number of orders "from hourly_sale
	group by shift

---End Query---
