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

