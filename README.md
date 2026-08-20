# Olist E-Commerce Data Analysis

## Project Overview
End-to-end analysis of 9 relational tables from Olist's Brazilian E-Commerce dataset. Joined and cleaned 40 attributes to analyze sales performance and operational trends.

## Tech Stack
## 🐍 Python & Pandas Data Pipeline
- **Jupyter Notebook:** [olist sales perfomance.ipynb](olist%20sales%20perfomance.ipynb)

### Core Data Engineering & Analysis
* **Data Integration:** Merged 9 relational Olist datasets using `pd.merge()` on primary/foreign keys (`order_id`, `customer_id`, `product_id`, `seller_id`).
* **Data Cleaning & Transformation:** Parsed date-time attributes with `pd.to_datetime()`, handled missing values, and created calculated fields for order fulfillment lead times.
* **Aggregations & Grouping:** Utilized `groupby()` and `agg()` to calculate customer lifetime values (CLV), average order value (AOV), and category-level revenues.

---

## 🛢️ SQL Data Analysis & Business Queries
- **SQL Script:** [Olist.sql](Olist.sql)

### Query Capabilities & Business Logic
* **Multi-Table Joins:** Executed multi-level `INNER JOIN` and `LEFT JOIN` operations across customer, order, payment, and seller tables.
* **Advanced Aggregations:** Applied `SUM()`, `COUNT()`, `AVG()`, and `CASE WHEN` logic to segment revenue by payment types and order statuses.
* **CTE & Window Functions:** Used Common Table Expressions (CTEs) alongside date functions (`DATEDIFF`) to evaluate carrier transit performance and calculate regional on-time delivery percentages.
* **Power BI:** Visualizing sales drivers, category insights, and KPI performance.
* **Excel:** Advanced formulas (VLOOKUP, XLOOKUP, INDEX/MATCH), Pivot Tables, and summary reporting

## Key Insights
* Identified top revenue-generating categories across transaction history.
* Evaluated delivery timeline performance against customer review scores.

## Dashboard Screenshots

![Dashboard View 1](image/Screenshot%202026-08-20%20105311.png)

![Dashboard View 2](image/Screenshot%202026-08-20%20105326.png)

![Dashboard View 3](image/Screenshot%202026-08-20%20105348.png)

![Dashboard View 4](image/Screenshot%202026-08-20%20105357.png)

![Dashboard View 5](image/Screenshot%202026-08-20%20105415.png)

## 📊 Dataset & Schema
## 📊 Excel Analysis & Dashboards
- **Excel Folder:** [Browse Excel Files](excel%20olist/)

### KPI Summary & Data Model
sample from dataset
![Excel Data Table](excel%20olist/Screenshot%202026-08-20%20115557.png)
finding answers from dataset with fromulas
![Excel Key Metrics](excel%20olist/Screenshot%202026-08-20%20115531.png)


### Revenue & Performance Analytics
![Revenue Breakdown by Payment Type](excel%20olist/Screenshot%202026-08-20%20115610.png)
![Review Score Distribution](excel%20olist/Screenshot%202026-08-20%20115628.png)
![Delivery Days by State](excel%20olist/Screenshot%202026-08-20%20115839.png)
The dataset used in this analysis contains the unified and cleaned master dataset. The complete file exceeds GitHub's 25 MB limit and is hosted on Google Drive:

* 🔗 **Google Drive Link:** [Access Full Dataset](https://docs.google.com/spreadsheets/d/1YMmdyORxpQl4BuS26a99E7Gy-Sp-BcZS/edit?usp=sharing&ouid=112088017941688972371&rtpof=true&sd=true)

### Key Metrics
* **Total Rows:** ~113,000
* **Total Columns:** 40
* **Key Attributes:** Orders, Customers, Products, Payments, Reviews, Geolocation
