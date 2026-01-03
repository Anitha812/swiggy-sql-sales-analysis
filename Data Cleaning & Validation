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
	
---data validation---
---Null Check
   SELECT
    COUNT(*) FILTER (WHERE state IS NULL)           AS state_nulls,
    COUNT(*) FILTER (WHERE city IS NULL)            AS city_nulls,
    COUNT(*) FILTER (WHERE order_date IS NULL)      AS order_date_nulls,
    COUNT(*) FILTER (WHERE restaurant_name IS NULL) AS restaurant_name_nulls,
    COUNT(*) FILTER (WHERE location IS NULL)        AS location_nulls,
    COUNT(*) FILTER (WHERE category IS NULL)        AS category_nulls,
    COUNT(*) FILTER (WHERE dish_name IS NULL)       AS dish_name_nulls,
    COUNT(*) FILTER (WHERE price_inr IS NULL)       AS price_inr_nulls,
    COUNT(*) FILTER (WHERE rating IS NULL)          AS rating_nulls,
    COUNT(*) FILTER (WHERE rating_count IS NULL)   AS rating_count_nulls
    FROM swiggy;

 ---Blank and Empty Strings 
 SELECT *FROM swiggy
   WHERE order_date is null
   OR state = ''
   OR TRIM(state) = ''
   OR city = ''
   OR TRIM(city) = ''
   OR restaurant_name = ''
   OR TRIM(restaurant_name) = ''
   OR location = ''
   OR TRIM( location) = ''
   OR category= ''
   OR TRIM(category) = ''
   OR dish_name = ''
   OR TRIM(dish_name) = ''
   OR price_inr is null
   OR rating is null
   OR rating_count is null;
   
 ---duplicate detection
   SELECT
    state, city, order_date, restaurant_name, location,
    category, dish_name, price_inr, rating, rating_count,count(*) as cnt
    FROM swiggy
    GROUP BY
    state, city, order_date, restaurant_name, location,
    category, dish_name, price_inr, rating, rating_count
    HAVING COUNT(*) > 1

---delete duplication
   WITH ranked_rows AS (
    SELECT
        ctid,
        ROW_NUMBER() OVER (
        PARTITION BY
        state, city, order_date, restaurant_name,
		location, category, dish_name,
        price_inr, rating, rating_count
        ORDER BY ctid
        ) AS rn FROM swiggy
        )
        delete FROM swiggy
        WHERE ctid IN (SELECT ctid FROM ranked_rows  where rn>1 );
