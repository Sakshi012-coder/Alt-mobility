Alt Mobility Data Analysis Project

This project analyzes order, customer, and payment data for Alt Mobility using SQL and Power BI. It focuses on sales trends, customer behavior, payment issues, and customer retention insights.

## Tools Used
- MySQL
- Power BI
- GitHub

## Folder Structure
altmobility-analysis/   ├── analysis_queries.sql # All SQL queries used 
                        ├── visualizations/ # Power BI charts and graphs 
                        ├── summary/ # Summary of findings 
                        └── README.md # Project overview and instructions


## How to Reproduce This Project
1. **Database Setup**  
   - Create the `altmobility` database and two tables: `customer_orders` and `payments` (see `sql_queries/`).

2. **Data Loading**  
   - Import the CSV files into the respective tables using  MySQL Workbench import.

3. **Analysis**  
   - Run the SQL queries in `analysis_queries.sql` to extract insights.

4. **Visualization**  
   - Export the cohort data and use Power BI to create customer retention charts.

## Deliverables
- SQL queries for four major analysis tasks
    (i)order and sales analysis
    (ii)customer analysis
    (iii)payment status analysis
    (iv)order details report
- Power BI for cohort-based retention visualization
- Summary of key findings and recommendations




