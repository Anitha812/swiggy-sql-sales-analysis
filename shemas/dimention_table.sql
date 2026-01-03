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
	
 ---Creating Shemas
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
	
