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

   