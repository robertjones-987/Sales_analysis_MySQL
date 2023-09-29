# Sales_analysis_MySQL

# About
This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition.

"In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact." source

# Purposes Of The Project
The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

# About Data
The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition. This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

![image](https://github.com/robertjones-987/Sales_analysis_MySQL/assets/90371462/5a741c08-7cca-444d-8fd2-550724f9187a)


# Analysis List
# Product Analysis
Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

# Sales Analysis
This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

# Customer Analysis
This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

# Approach Used
Data Wrangling: This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.
Build a database
Create table and insert the data.
Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.

Feature Engineering: This will help use generate some new columns from existing ones.

Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.

Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.

Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

Exploratory Data Analysis (EDA): Exploratory data analysis is done to answer the listed questions and aims of this project.

Conclusion:

# Business Questions To Answer
#  Generic Question
1. How many unique cities does this data has?
2. In which city is each branch?
#  Product
1. How many unique product lines does this data has?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month has the largest COGS?
6. What product line has the largest revenue?
7. What is the city with the largest revenue?
8. What product line had the largest VAT?
9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average rating
10. Which branch sold more products than average product sold?
11. What is the most common product line by gender?
What is the average rating of each product line?
