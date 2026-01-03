
# Swiggy Sales Analysis – SQL Project

## Business Objective
Analyze Swiggy food delivery data to uncover insights related to sales performance, customer spending behavior, restaurant performance, and ratings using SQL.

## Data Cleaning & Validation
The raw table `swiggy_data` contains food delivery records across states, cities, restaurants, categories, and dishes.

### Cleaning Steps Performed
- Null checks on critical columns:
  - State, City, Order_Date, Restaurant_Name, Location
  - Category, Dish_Name, Price_INR, Rating, Rating_Count
- Blank / empty string validation
- Duplicate record detection using business-critical columns
- Duplicate removal using `ROW_NUMBER()` while retaining one valid record

## Dimensional Modelling (Star Schema)
A Star Schema was designed to improve analytical performance and reporting efficiency.

### Dimension Tables
- `dim_date` → Year, Month, Quarter, Week
- `dim_location` → State, City, Location
- `dim_restaurant` → Restaurant_Name
- `dim_category` → Cuisine / Category
- `dim_dish` → Dish_Name

### Fact Table
- `fact_swiggy_orders`
  - Measures: Price_INR, Rating, Rating_Count
  - Foreign keys to all dimension tables

## KPIs & Business Analysis
**Basic KPIs:**
-Total Orders
-Total Revenue (INR Million)
-Average Dish Price
-Average Rating
**Deep-Dive Business Analysis:**
-Date-Based Analysis
-Monthly order trends
-Quarterly order trends
-Year-wise growth
-Day-of-week patterns
Location-Based Analysis:
-Top 10 cities by order volume
-Revenue contribution by states
Food Performance:
-Top 10 restaurants by orders
-Top categories (Indian, Chinese, etc.)
Most ordered dishes:
-Cuisine performance → Orders + Avg Rating
-Customer Spending Insights
Buckets of customer spend:
Under 100
100–199
200–299
300–499
500+
With total order distribution across these ranges.
Ratings Analysis:
Distribution of dish ratings from 1–5.


## Tools Used
- SQL (MySQL / PostgreSQL)
