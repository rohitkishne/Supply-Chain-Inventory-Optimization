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

---

## 📊 Business Insights

### 1. Demand Forecasting via 7-Day Rolling Average
By computing a 7-day rolling average of `units_sold` per product, the analysis reveals short-term demand trends at the product level. Products that show a consistent upward rolling average signal rising demand — meaning inventory replenishment should be proactively triggered before stock depletes. Conversely, a declining rolling average indicates slowing demand, giving buyers the intelligence to avoid over-ordering and excess holding costs.

### 2. Reorder Point Calculation — Data-Driven Replenishment
Using a **7-day lead time**, `avg_daily_demand`, and `STDDEV` of daily sales, the analysis computes a statistically sound **reorder point** for every product:

> **Reorder Point = Lead Time Demand + Safety Stock**
> Safety Stock = 1.65 × σ × √Lead Time (95% service level)

Products sorted by reorder point (descending) immediately surface which SKUs carry the highest replenishment urgency. This eliminates guesswork in procurement planning and ensures high-velocity items never fall below safe operating levels.

### 3. Stockout Risk Prediction — Proactive Inventory Alerts
The stockout flag logic compares real-time `inventory_level` against `demand_forecast` with two alert tiers:
- **`STOCKOUT RISK`** — Inventory is already below forecasted demand; immediate action is required.
- **`LOW STOCK WARNING`** — Inventory is within 20% of forecasted demand; a reorder should be placed urgently.
- **`HEALTHY`** — Stock levels are comfortable relative to demand.

This three-tier system enables operations teams to triage inventory issues by severity, reducing lost sales and service disruptions caused by unexpected stockouts.

### 4. ABC Inventory Classification — Prioritize What Drives Revenue
The **Pareto-based ABC analysis** classifies every product by its cumulative revenue contribution:
| Class | Revenue Contribution | Priority |
|-------|---------------------|----------|
| **A** | Top 0–70% of total revenue | High Priority — tightest controls, frequent reviews |
| **B** | 70–90% of total revenue | Medium Priority — moderate monitoring |
| **C** | 90–100% of total revenue | Low Priority — lean stock, minimal attention |

This directly tells the business where to focus capital and management effort. **Class A products** generate the bulk of revenue and must never stock out. **Class C products** tie up working capital disproportionately and are candidates for reduced safety stock or discontinuation.

### 5. Category Target vs. Actual Performance — Execution Monitoring
By dynamically setting a category-level target as **10% above the average `units_sold`**, the analysis evaluates every product's performance against a data-driven benchmark. Products marked **'Below Target'** in high-priority categories (those with Class A items) represent immediate revenue recovery opportunities. Categories with a high proportion of 'Below Target' products signal underlying issues — whether pricing, discount strategy, supply gaps, or market demand shifts — that need investigation.

---

## ✅ Conclusion

This project demonstrates how SQL can serve as a comprehensive supply chain intelligence engine. By combining **window functions**, **CTEs**, and **statistical aggregations**, five critical inventory management questions are answered from a single dataset:

1. **Where is demand heading?** → Rolling average forecasting
2. **When should we reorder?** → Statistical reorder point calculation
3. **What is at risk of stocking out?** → Real-time stockout prediction flags
4. **Which products deserve the most capital and attention?** → ABC Pareto classification
5. **Is the business hitting its sales targets by category?** → Target vs. actual performance monitoring

Together, these analyses form a **decision-ready supply chain dashboard in SQL** — enabling procurement teams to reduce stockouts, lower excess inventory costs, protect high-revenue SKUs, and hold category performance accountable to measurable targets. The framework is scalable across any number of stores, regions, and product categories present in the `inventory_data` table.
