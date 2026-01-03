 CREATE TABLE swiggy (
    state VARCHAR(100),
    city VARCHAR(100) ,
    order_date DATE ,
    restaurant_name VARCHAR(150) NOT NULL,
    location VARCHAR(150),
    category VARCHAR(100),
    dish_name VARCHAR(200) ,
    price_inr NUMERIC(8,2) ,
    rating NUMERIC(2,1) ,
    rating_count INT 
	);
    select*from swiggy;
	
---KPI's
---total order's
   select count(*) as Total_Orders 
   from fact_swiggy_orders;

---Total Revenue
  SELECT 
    ROUND(SUM(price_inr) / 1000000.0, 2) || 'M INR' AS total_revenue
FROM fact_swiggy_orders;

---Average_dish price
  SELECT 
    ROUND(AVG(price_inr), 2) || 'INR' AS avg_dish_price
FROM fact_swiggy_orders;

---Average rating 
  SELECT 
    ROUND(AVG(rating), 2)  AS avg_dish_price
FROM fact_swiggy_orders;