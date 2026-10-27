# Olist E-Commerce Data Analysis

## Project Overview

End-to-end analysis of 9 relational tables from Olist's Brazilian E-Commerce dataset. Joined and cleaned 40 attributes to analyze sales performance and operational trends.

## Tech Stack

* **Python:** Pandas, NumPy, and SQLAlchemy for data cleaning, merging, and loading into MySQL
* **SQL:** MySQL for business queries
* **Microsoft Excel:** Pivot Tables, charts, and KPI formulas
* **Power BI:** Interactive dashboards

## 🐍 Python & Pandas Data Pipeline

- **Jupyter Notebook:** [olist sales perfomance.ipynb](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/blob/main/olist%20sales%20perfomance.ipynb)

### Core Data Engineering & Analysis

- **Data Integration:** Merged 8 of the 9 relational Olist tables (all except geolocation) using `pd.merge()` on primary/foreign keys (`order_id`, `customer_id`, `product_id`, `seller_id`, `product_category_name`) into one 40-column master dataset.
- **Aggregations & Grouping:** Used `groupby()` to check missing delivery dates by order status and to count negative reviews by complaint category.

## Data Cleaning & Preprocessing Pipeline

* `# Inspect data structure, non-null counts, and data types: df.info()`
* `# Remove duplicate rows`
* `# Remove extra spaces`
* `# Standardize text and numeric columns`
* `# Fix spelling errors and inconsistent categories`
* `# Fix data types`
* `# Handle invalid values`
* `# Handle missing values`
* `# Create new useful columns (feature engineering)`
* `# Verify categories`
* `# Check final dataset`

* * *

## 🛢️ SQL Data Analysis & Business Queries

- **SQL Script:** [Olist.sql](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/blob/main/Olist.sql)

### Query Capabilities & Business Logic

- **Multi-Table Joins:** Used `JOIN` operations across the customers, orders, order_items, order_reviews, products, sellers, and category translation tables.
- **Advanced Aggregations:** Applied `SUM()`, `COUNT()`, `AVG()`, and `HAVING` to find revenue and average order value by customer state, freight-to-price ratios by category, and order counts by payment type.
- **Conditional Logic:** Used `CASE WHEN` to calculate on-time delivery % by customer state and to group delivered orders into delivery-time bands (0-7, 8-14, 15-21, and over 21 days) to compare average review scores.
- **Date Functions:** Used `DATEDIFF` to measure days early or late against the estimated delivery date, and `DATE_FORMAT` to group revenue by month.
- **CTEs & Window Functions:** Used Common Table Expressions (`WITH`) with `RANK() OVER (PARTITION BY ...)` to find the top 3 sellers by revenue in each state, `LAG()` to calculate month-over-month revenue growth, and `UNION ALL` to find the top 5 and bottom 5 product categories by revenue.
- **Subquery:** Used a subquery to calculate order totals for average order value.

## 📊 Power BI Interactive Dashboards & Analytics

- **Dashboard Overview:** Comprehensive visual analysis tracking sales trends, customer review sentiment, and fulfillment efficiency across Brazilian states.

### Key Power BI Features & Modeling

- **Data Modeling & DAX:** Built custom DAX measures for Total Revenue, Total Orders, Average Order Value (AOV), Total Customers, Average Review Score, Negative Review Ratio, On-Time Delivery %, Average Delivery Days, Repeat Customer Rate, Total Sellers, and Total Payment Transactions.
- **Interactive Filtering & Slicers:** Enabled dynamic cross-filtering by product category, order date, order status, customer state, customer city, payment type, and review score.
- **Executive Visualizations:** Designed custom visual layouts highlighting revenue drivers, geographical fulfillment delays, and customer review distributions.

* * *

## 📈 Excel Analytics & Reporting

- **Excel Folder:** [Browse Excel Files](https://docs.google.com/spreadsheets/d/1YMmdyORxpQl4BuS26a99E7Gy-Sp-BcZS/edit?usp=drive_link&ouid=112088017941688972371&rtpof=true&sd=true)

### Advanced Formulas & Pivot Tables

- **Data Retrieval & Matching:** Applied `XLOOKUP`, `INDEX/MATCH`, and `VLOOKUP` formulas to retrieve values from the master dataset without modifying source data.
- **Aggregations & Summaries:** Built interactive Pivot Tables to summarize revenue by payment type, review score distribution, and delivery days by customer state, and used `SUMIFS`, `COUNTIFS`, and `AVERAGEIFS` formulas to aggregate order volumes and shipping duration metrics.
- **KPI Dashboards:** Created conditional formatting rules and custom charts to highlight key performance metrics and payment channel distributions.

## Key Insights

- Identified top revenue-generating categories across transaction history.
- Evaluated delivery timeline performance against customer review scores.

## Dashboard Screenshots

![Dashboard View 1](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/image/Screenshot%202026-08-20%20105311.png)

![Dashboard View 2](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/image/Screenshot%202026-08-20%20105326.png)

![Dashboard View 3](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/image/Screenshot%202026-08-20%20105348.png)

![Dashboard View 4](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/image/Screenshot%202026-08-20%20105357.png)

![Dashboard View 5](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/image/Screenshot%202026-08-20%20105415.png)

## 📊 Dataset & Schema

The dataset used in this analysis contains the unified and cleaned master dataset. The complete file exceeds GitHub's 25 MB limit and is hosted on Google Drive:

- 🔗 **Google Drive Link:** [Access Full Dataset](https://docs.google.com/spreadsheets/d/1YMmdyORxpQl4BuS26a99E7Gy-Sp-BcZS/edit?usp=sharing&ouid=112088017941688972371&rtpof=true&sd=true)

## 📊 Excel Analysis & Dashboards

- **Excel Folder:** [Browse Excel Files](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/blob/main/excel%20olist)

### KPI Summary & Data Model

Sample from dataset:

![Excel Data Table](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/excel%20olist/Screenshot%202026-08-20%20115557.png)

Finding answers from the dataset with formulas:

![Excel Key Metrics](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/excel%20olist/Screenshot%202026-08-20%20115531.png)

### Revenue & Performance Analytics

![Revenue Breakdown by Payment Type](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/excel%20olist/Screenshot%202026-08-20%20115610.png)

![Review Score Distribution](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/excel%20olist/Screenshot%202026-08-20%20115628.png)

![Delivery Days by State](https://github.com/Aliyan-Kahana/Olist-Sales-Performance-Analysis/raw/main/excel%20olist/Screenshot%202026-08-20%20115839.png)

### Key Metrics

- **Total Rows:** ~113,000
- **Total Columns:** 40
- **Key Attributes:** Orders, Order Items, Customers, Products, Sellers, Payments, Reviews, Category Translation
