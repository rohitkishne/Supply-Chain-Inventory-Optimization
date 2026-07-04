# Supply Chain & Inventory Optimization

## Overview
This project focuses on optimizing supply chain and inventory management using SQL. It analyzes retail store inventory data to forecast demand, calculate reorder points, predict stockout risks, classify inventory items based on their revenue contribution (ABC Analysis), and monitor category performance against targets.

## Project Structure
The project is organized into the following directories:
- **`Dataset/`**: Contains the raw dataset used for analysis (`retail_store_inventory.csv`).
- **`SQL Analysis/`**: Contains the SQL scripts for table creation and data analysis.
  - `SQL Table Creation.sql`: Script to set up the `inventory_data` table schema.
  - `SQL Queries.sql`: Contains the analytical SQL queries.

## Data Schema
The `inventory_data` table has the following structure:
- `date` (DATE)
- `store_id` (VARCHAR)
- `product_id` (VARCHAR)
- `category` (VARCHAR)
- `region` (VARCHAR)
- `inventory_level` (INT)
- `units_sold` (INT)
- `Units_Ordered` (INT)
- `demand_forecast` (NUMERIC)
- `price` (NUMERIC)
- `discount` (NUMERIC)
- `weather_condition` (VARCHAR)
- `holiday_promotion` (INT)
- `competitor_pricing` (NUMERIC)
- `seasonality` (VARCHAR)

## Key SQL Analyses
The `SQL Queries.sql` script includes the following advanced analyses:

1. **7-Day Rolling Average (Demand Forecasting)**: 
   Calculates a 7-day rolling average of units sold per product to identify trends and forecast future demand using window functions.

2. **Reorder Point Calculation**: 
   Determines the optimal point to reorder a product based on lead time demand and safety stock, using statistical functions like standard deviation (`STDDEV`).

3. **Stockout Prediction Flag**: 
   Flags products that are at risk of stockouts (`STOCKOUT RISK` or `LOW STOCK WARNING`) by comparing current inventory levels against demand forecasts.

4. **ABC Inventory Classification (Pareto Analysis)**: 
   Classifies products into categories (A, B, C) based on their cumulative revenue contribution, helping prioritize high-value inventory items.

5. **Category Target vs Actual Performance**: 
   Evaluates whether the units sold in a category meet a dynamically calculated target (10% above average units sold), categorizing them as 'On Target' or 'Below Target'.

## Tools Used
- SQL (PostgreSQL dialect functions like `STDDEV`, `SQRT`, `::numeric` are utilized).
- Window Functions
- Common Table Expressions (CTEs)
- Aggregate Functions
