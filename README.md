# SQL_retail_sales_-project-1
## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives
1. **Data Cleaning**: Identify and remove any records with missing or null values.
2. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
3. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
```sql
  SELECT * FROM retail_sales
	WHERE 
		sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
		gender IS NULL OR age IS NULL OR category IS NULL OR 
		quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
	--deleting
		DELETE FROM retail_sales
	WHERE 
		sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
		gender IS NULL OR age IS NULL OR category IS NULL OR 
		quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```
### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:
1 all columns for sales made on '2022-11-05'.
```sql
   select * from retailsales
   where sale_date='5/11/2022';
```
2 all transactions where the category is 'Clothing' 
   --and the quantity sold is more than 4 in the month of Nov-2022:
```sql
   --all transactions where the category is 'Clothing' 
   --and the quantity sold is more than 4 in the month of Nov-2022:
   select transactions_id from retailsales
   where category='Clothing' and quantiy >=4 
   and format (cast(sale_date as date),'yyyy-MM')='2022-11'  ;
```

   3-the total sales (total_sale) for each category
   ```sql
   select category ,sum(cast(Total_sale as float)) as "Total_sale"
   from retailsales
   group by category;
   ```
   4-the average age of customers who purchased items from the 'Beauty' category.:
   ```sql
   select avg(cast(age as int)) as from retailsales
   where category ='Beauty';
   ```

   5-all transactions where the total_sale is greater than 1000
   ```sql
	select transactions_id from retailsales 
	where Total_sale>1000;

	the total number of transactions (transaction_id) made by each gender in each category
 
	select gender ,count(transactions_id)as "total number of transactions" from retailsales
	group by gender ;
  
```
``
	6-the average sale for each month. Find out best selling month in each year
 ```sql
			WITH MonthlySales AS (
			SELECT 
				FORMAT(CAST(sale_date AS DATE), 'yyyy') AS sales_year,
				FORMAT(CAST(sale_date AS DATE), 'MM') AS sales_month,
				SUM(Total_sale) AS total_monthly_sales
			FROM retailsales
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
```
 7- top 5 customers based on the highest total sales.
```sql
	select top 5 customer_id, sum(Total_sale) from retailsales
	group by customer_id
	order by sum(Total_sale) desc ;

```
 8-the number of unique customers who purchased items from each category.
```sql
	select category ,count(distinct customer_id) from retailsales
	group by category;
```
`	9-create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17
	with hourly_sale as (
```sql
	select *,case 
				when DATEPART(HOUR, sale_time)<12 then 'Morning'
				when DATEPART(HOUR, sale_time) between 12 and 17 then 'After Noon'
				else 'evening'
				end as shift
	from retailsales
	
	)
	select shift , count(*)as "Number of orders "from hourly_sale
	group by shift

```










