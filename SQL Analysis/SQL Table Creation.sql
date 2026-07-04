-- Create Tables
CREATE TABLE inventory_data ( 
	date DATE, 
	store_id VARCHAR(20), 
	product_id VARCHAR(20), 
	category VARCHAR(50), 
	region VARCHAR(50), 
	inventory_level INT, 
	units_sold INT, 
	Units_Ordered INT,
	demand_forecast NUMERIC, 
	price NUMERIC, 
	discount NUMERIC, 
	weather_condition VARCHAR(30), 
	holiday_promotion INT, 
	competitor_pricing NUMERIC, 
	seasonality VARCHAR(20) 
);

-- Fetch All Data
Select * from inventory_data;