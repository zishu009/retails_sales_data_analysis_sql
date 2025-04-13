# Retail Sales Data Analysis Project

## Project Overview

This project involves analyzing retail sales data to extract insights related to customer behavior, sales trends, and performance metrics across different categories. The analysis is conducted using SQL queries, focusing on data cleaning, exploration, and detailed business insights.

### Key Objectives:

- Clean and prepare the retail sales data for analysis.
- Perform data exploration to understand key metrics like total sales, unique customers, and categories.
- Conduct in-depth analysis on sales patterns, customer demographics, and category performance.

## Project Files

### 1. **create_table.sql**
This file contains the SQL code to create the `retails_sales` table. The table structure includes columns such as `transactions_id`, `sale_date`, `sale_time`, `customer_id`, `gender`, `age`, `category`, `quantity`, `price_per_unit`, `cogs`, and `total_sale`.

### 2. **load_data.sql**
This file contains the SQL query to load data from a CSV file (`Retail_Sales.csv`) into the `retails_sales` table using the `LOAD DATA INFILE` command. It also handles NULL values to ensure data consistency.

### 3. **data_cleaning.sql**
This file includes SQL queries to identify and clean NULL values in the dataset. It checks for missing values and deletes any rows with essential missing data.

### 4. **data_exploration.sql**
This file contains SQL queries to explore the data, including:
  - Total number of rows
  - Unique customers
  - Unique categories
  - Sample queries for specific dates or conditions

### 5. **data_analysis.sql**
This file contains the SQL queries for deeper analysis, including:
  - Sales trends by date and category
  - Average sales by month
  - Customer segmentation based on total sales
  - Identifying best-selling months and shifts
