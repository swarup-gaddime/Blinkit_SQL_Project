CREATE DATABASE blinkit_db;

USE blinkit_db;

SELECT * FROM blinkit; 

-- data cleaning
UPDATE blinkit
SET Item_fat_content = 
CASE
WHEN Item_fat_content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_fat_content = 'reg' THEN 'Regular'
ELSE Item_fat_content
END;

-- 1)Total Sales
SELECT SUM(Total_sales) AS Total_Sales
FROM blinkit;

-- 2)Average Sales
SELECT ROUND(AVG(Total_sales),2) AS Avg_Sales
FROM blinkit;

-- 3)No. Of Items
SELECT COUNT(*) AS No_Of_Items FROM blinkit;

-- 4)Avg Rating
SELECT ROUND(AVG(Rating),2) AS Avg_Rating
FROM blinkit;

-- 5)Total Sales By Fat Content
SELECT Item_fat_content, ROUND(SUM(Total_sales),2) AS Total_sales
FROM blinkit
GROUP BY Item_fat_content;

-- 6)Total sales by Item Type
SELECT Item_type, ROUND(SUM(Total_sales),2) AS Total_Sales
FROM blinkit
GROUP BY Item_type;

-- 7)Fat content by outlet for total sales
SELECT Outlet_location_type, Item_fat_content, ROUND(SUM(Total_sales),2) AS Total_sales
FROM blinkit
GROUP BY Outlet_location_type, Item_fat_content;

-- 8)Total sales by outlet establishment
SELECT Outlet_establishment_year, ROUND(SUM(Total_sales),2) AS Total_sales
FROM blinkit
GROUP BY Outlet_establishment_year;

-- 9)Percentage of sales by oulet size
SELECT Outlet_size, ROUND(SUM(Total_sales),2) AS Total_Sales, Round((SUM(Total_sales) * 100.0 / SUM(SUM(Total_sales)) OVER()),2) AS Sales_Percentage
FROM blinkit
GROUP BY Outlet_size;

-- 10)Sales by oulet location
SELECT Outlet_location_type, ROUND(SUM(Total_sales),2) AS Total_Sales
FROM blinkit
GROUP BY Outlet_location_type;

-- 11)All metrics by oulet type
SELECT Outlet_type, ROUND(SUM(Total_sales),2) AS Total_Sales, Round((SUM(Total_sales) * 100.0 / SUM(SUM(Total_sales)) OVER()),2) AS Sales_Percentage, ROUND(AVG(Total_sales),2) AS Avg_Sales, COUNT(*) AS No_of_Items, ROUND(AVG(Rating),2) AS Avg_Rating
FROM blinkit
GROUP BY Outlet_type;