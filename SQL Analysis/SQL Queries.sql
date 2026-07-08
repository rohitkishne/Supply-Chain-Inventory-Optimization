-- Query 1 - 7 Day Rolling Average (Demand Forecasting)

WITH daily_sales AS(
	SELECT 
		product_id,
		date,
		SUM(units_sold) as daily_units_sold
	FROM inventory_data
	Group BY product_id, date
)

Select
	product_id,
	date,
	daily_units_sold,
	Round(
		AVG(daily_units_sold) OVER(
			PARTITION BY product_id 
			ORDER BY date
			ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
	,2) as rolling_avg_7day
From daily_sales	
ORDER BY product_id,date;

-- Query 2 - Reorder Point Calculation

WITH daily_sales AS (
    SELECT
        product_id,
        date,
        SUM(units_sold) AS daily_units_sold
    FROM inventory_data
    GROUP BY product_id, date
),
demand_stats AS (
    SELECT
        product_id,
        AVG(daily_units_sold) AS avg_daily_demand,
        STDDEV(daily_units_sold) AS demand_stddev
    FROM daily_sales
    GROUP BY product_id
)

SELECT 
	product_id,
	ROUND(avg_daily_demand*7,0) AS lead_time_demand,
	ROUND((1.65 * demand_stddev * SQRT(7))::numeric,0) AS safety_stock,
	ROUND(((avg_daily_demand*7) + (1.65 * demand_stddev * SQRT(7)))::numeric,0) as reorder_point
	
FROM demand_stats
ORDER BY reorder_point DESC;

-- Query 3 - Stockout Prediction Flag

SELECT
	product_id,
	date,
	inventory_level,
	demand_forecast,
	CASE
		WHEN inventory_level < demand_forecast THEN 'STOCKOUT RISK'
		WHEN inventory_level < (demand_forecast * 1.2) THEN 'LOW STOCK WARNING'
		ELSE 'HEALTHY'
	END
FROM inventory_data
ORDER BY date DESC;

-- Query 4 - ABC Inventory Classification (Pareto Analysis)

WITH product_revenue AS(
	SELECT 
		product_id,
		SUM(units_sold * price) AS total_revenue
	FROM inventory_data
	GROUP BY product_id
),
ranked AS(
	SELECT
		product_id,
		total_revenue,
		SUM(total_revenue) OVER(ORDER BY total_revenue DESC) AS running_total,
		SUM(total_revenue) OVER() AS grand_total
	FROM product_revenue
)

SELECT 
	product_id,
	total_revenue,
	ROUND(100 * running_total/grand_total,2) AS cummulative_pct,
	CASE
		WHEN 100 * running_total/grand_total <= 70 THEN 'A - High Priority'
		WHEN 100 * running_total/grand_total <= 90 THEN 'B - Medium Priority'
		ELSE 'C - Low Priority'
	END AS abc_class
FROM ranked
ORDER BY total_revenue DESC

-- Query 5 -Category Target vs Actual
-- First of ALL create the category_target Table
CREATE TABLE category_target AS
SELECT 
	category,
	(AVG(units_sold) * 1.1) AS target_units
FROM inventory_data
GROUP BY category;

SELECT
	i.category,
	i.product_id,
	i.units_sold,
	ROUND(c.target_units,0),
	CASE
		WHEN i.units_sold < c.target_units THEN 'Below Target'
		ELSE 'On Target'
	END AS target_monitoring
FROM inventory_data i
JOIN category_target c
ON i.category = c.category
ORDER BY i.category;



























