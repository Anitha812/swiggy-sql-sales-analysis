
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

 ---Creating Shemac
 ---Dimention Table
 ---Date Table
   Create table Dim_date(
     date_id int generated always as identity primary key,
	 full_date date,
	 year int,
	 month int,
	 month_name varchar(20),
	 Quater int,
	 day int,
	 week int
   )
   select*from Dim_Date;
    insert into Dim_date(full_date,year,month,month_name,Quater,day,week)
     select distinct 
	 order_date,
	 date_part('year',order_date),
	 date_part('month',order_date),
	 to_char(order_date, 'Month')  ,    
     extract(Quarter FROM order_date),
     date_part('day',order_date),
	 date_part('week',order_date) 
	 from swiggy where order_date is not null;
	   
 ---Dimention_location Table
  Create table Dim_location(
     location_id int generated always as identity primary key,
	  state varchar(100),
	  city varchar(100),
	  location varchar(200)
	  
       )
	   select*from Dim_location;

		insert into Dim_location(state,city,location)
		select distinct
		state,
		city,
		location from swiggy;
	   
---Dimention_restaurant table 
    Create table Dim_restaurant(
      restaurant_id int generated always as identity primary key,
	  restaurant_name varchar(200)
	)   

      insert into Dim_restaurant( restaurant_name)
	  select distinct restaurant_name from swiggy;
	  
	  select*from Dim_restaurant;
	  
---Dimention_category table 
       Create table Dim_category(
      category_id int generated always as identity primary key,
	  category varchar(200)
   )   
     insert into Dim_category(category)
	 select distinct category from swiggy;
	 select*from Dim_category;

	 
---Dimention_dish table 
      Create table Dim_dish(
      dish_id int generated always as identity primary key,
	  dish_name varchar(200)
	)   
   select * from Dim_category;
    insert into Dim_dish(dish_name)
	
	select distinct dish_name from swiggy;
	
    select*from swiggy;
	
---Fact table
   create table fact_swiggy_orders(
    order_id int generated always as identity primary key,
	
	date_id int,
	restaurant_id int,
	location_id int,
    category_id int,
    dish_id int,
	price_inr NUMERIC(10,2) ,
    rating NUMERIC(2,1) ,
    rating_count INT ,

	foreign key(date_id) references Dim_date(date_id),
	foreign key(restaurant_id) references Dim_restaurant(restaurant_id),
	foreign key(location_id) references Dim_location(location_id),
	foreign key(category_id) references Dim_category(category_id),
	foreign key(dish_id) references Dim_dish(dish_id)
	
   );

select*from fact_swiggy_orders;
  
  insert into fact_swiggy_orders(
    date_id ,
	restaurant_id ,
	location_id ,
    category_id ,
    dish_id ,
	price_inr  ,
    rating  ,
    rating_count         
    )
	select
	dd.date_id ,
	dr.restaurant_id ,
	dl.location_id ,
    dc.category_id ,
    dsh.dish_id ,
	s.price_inr  ,
    s.rating  ,
    s.rating_count         
    from swiggy s
	join Dim_date dd 
	on dd.full_date=s.order_date

	join Dim_restaurant dr
	on dr.restaurant_name=s.restaurant_name

	join Dim_location dl
	on dl.state=s.state
	and dl.city=s.city
	and dl.location=s.location

	join Dim_category dc
	on dc.category=s.category

	join Dim_dish dsh
	on dsh.dish_name=s.dish_name

select*from fact_swiggy_orders f
    join Dim_date dd on f.date_id=dd.date_id
    join Dim_restaurant dr on f.restaurant_id=dr.restaurant_id
    join Dim_location dl on f.location_id=dl.location_id
	join Dim_category dc on f.category_id=dc.category_id
	join Dim_dish di on f.dish_id=di.dish_id;
select*from fact_swiggy_orders;

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

---Deep-Dive  Business analysis
---Monthly Trend
   select dd.year,dd.month,dd.month_name ,
    count(*) as Total_monthly_orders from fact_swiggy_orders f
	join Dim_date dd on f.date_id=dd.date_id
	Group by dd.year,dd.month,dd.month_name 
    order by count(*) desc

---Quarterly order trends
  select 
  dd.year,
  dd.Quater ,
  count(*) as Quaterly_orders 
  from fact_swiggy_orders f
  join Dim_date dd on f.date_id=dd.date_id
  Group by dd.year,dd.Quater 
  order by count(*) desc
---Year-wise growth
  select 
  dd.year,
  count(*) as yearly_orders 
  from fact_swiggy_orders f
  join Dim_date dd on f.date_id=dd.date_id
  Group by dd.year
  order by count(*) desc

---Day-of-week patterns
  select to_char(dd.full_date,'day') as day_name,
  count(*) as Total_orders
  from fact_swiggy_orders f
  join Dim_date dd on f.date_id=dd.date_id
  Group by to_char(dd.full_date,'day')
  order by count(*) desc
  
---Location-Based Analysis
---Top 10 cities by order volume
   select l.city as Top_10_cities,
   count(*) as Total_orders
   from fact_swiggy_orders f
   join Dim_location l on f.location_id=l.location_id
   Group by l.city 
   order by count(*) desc limit 10 

---Revenue contribution by Top 10 cities
   select l.city ,
   round( sum(f.price_inr) ,2) || ' INR' as Total_Revenue
   from fact_swiggy_orders f
   join Dim_location l on f.location_id=l.location_id
   Group by l.city
   order by round( sum(f.price_inr) ,2)  desc limit 10

---Revenue contribution by Bottum 10 cities
   select l.city ,
   round( sum(f.price_inr) ,2) || ' INR' as Total_Revenue
   from fact_swiggy_orders f
   join Dim_location l on f.location_id=l.location_id
   Group by l.city
   order by round( sum(f.price_inr) ,2)  asc limit 10

---Revenue contribution by states
  select l.state ,
   round( sum(f.price_inr) ,2) || ' INR' as Total_Revenue
   from fact_swiggy_orders f
   join Dim_location l on f.location_id=l.location_id
   Group by l.state
   order by round( sum(f.price_inr) ,2)  desc


---Food Performance
---Top 10 restaurants by orders

    select r.restaurant_name as Top_10_restaurants ,
   count(*) as Total_orders
   from fact_swiggy_orders f
   join Dim_restaurant r on f.restaurant_id=r.restaurant_id
   Group by r.restaurant_name 
   order by count(*) desc limit 10 
   
---Top categories (Indian, Chinese, etc.)
   select c.category as Top_categories,
   count(*) as Total_orders
   from fact_swiggy_orders f
   join Dim_category c on f.category_id=c.category_id
   Group by c.category
   order by Total_orders desc 
   
---Most ordered dishes
   select dsh.dish_name as dish_name,
   count(*) as Total_orders
   from fact_swiggy_orders f
   join Dim_dish dsh on f.dish_id=dsh.dish_id
   Group by dsh.dish_name
   order by Total_orders desc limit 15

---Cuisine performance
   select c.category ,
   count(*) as Total_orders,
   round(avg(rating),2) as avg_rating
   from fact_swiggy_orders f
   join Dim_category c on f.category_id=c.category_id
   Group by c.category
   order by Total_orders desc 

---Customer Spending Insights
---Total order by price range
  SELECT 
    CASE 
        WHEN price_inr < 100 THEN 'Under 100'
        WHEN price_inr BETWEEN 100 AND 199 THEN '100–199'
        WHEN price_inr BETWEEN 200 AND 299 THEN '200–299'
        WHEN price_inr BETWEEN 300 AND 499 THEN '300–499'
        ELSE '500+'
       END AS price_range,
       COUNT(*) AS total_orders
       FROM fact_swiggy_orders
       GROUP BY price_range
       ORDER BY total_orders desc;


---Ratings Analysis

 select rating,
 count(*) as Total_orders
 from  fact_swiggy_orders 
 group by rating
 order by Total_orders  desc

   
