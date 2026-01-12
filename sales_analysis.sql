-- =====================================================
-- Online Sales Data Analysis using SQL
-- Author: Md Tawquib
-- =====================================================

USE Project;

-- =====================================================
-- 1. Distinct Product Categories
-- =====================================================
SELECT DISTINCT Product_Category
FROM online_sales_data;


-- =====================================================
-- 2. Most Selling Product Categories (Units Sold)
-- =====================================================
SELECT Product_Category,
       SUM(Units_Sold) AS total_units_sold
FROM online_sales_data
GROUP BY Product_Category
ORDER BY total_units_sold DESC;


-- =====================================================
-- 3. Most Selling Product
-- =====================================================
SELECT Product_Name,
       SUM(Units_Sold) AS total_units_sold
FROM online_sales_data
GROUP BY Product_Name
ORDER BY total_units_sold DESC
LIMIT 1;


-- =====================================================
-- 4. Most Selling Region (by Units Sold)
-- =====================================================
SELECT Region,
       SUM(Units_Sold) AS total_units_sold
FROM online_sales_data
GROUP BY Region
ORDER BY total_units_sold DESC;


-- =====================================================
-- 5. Top 5 Most Selling Products in Each Region
-- =====================================================
SELECT Region, Product_Name, total_units
FROM (
    SELECT Region,
           Product_Name,
           SUM(Units_Sold) AS total_units,
           ROW_NUMBER() OVER (
               PARTITION BY Region
               ORDER BY SUM(Units_Sold) DESC
           ) AS rn
    FROM online_sales_data
    GROUP BY Region, Product_Name
) t
WHERE rn <= 5;


-- =====================================================
-- 6. Most Selling Product in Each Region
-- =====================================================
SELECT Region, Product_Name, total_units
FROM (
    SELECT Region,
           Product_Name,
           SUM(Units_Sold) AS total_units,
           ROW_NUMBER() OVER (
               PARTITION BY Region
               ORDER BY SUM(Units_Sold) DESC
           ) AS rn
    FROM online_sales_data
    GROUP BY Region, Product_Name
) t
WHERE rn = 1;


-- =====================================================
-- 7. Most Selling Date
-- =====================================================
SELECT order_date,
       SUM(Units_Sold) AS total_units_sold
FROM online_sales_data
GROUP BY order_date
ORDER BY total_units_sold DESC
LIMIT 1;


-- =====================================================
-- 8. Most Selling Month
-- =====================================================
SELECT YEAR(order_date) AS year,
       MONTHNAME(order_date) AS month,
       SUM(Units_Sold) AS total_units_sold
FROM online_sales_data
GROUP BY year, MONTH(order_date), MONTHNAME(order_date)
ORDER BY total_units_sold DESC;


-- =====================================================
-- 9. Total Revenue by Product Category
-- =====================================================
SELECT Product_Category,
       SUM(Total_Revenue) AS total_revenue
FROM online_sales_data
GROUP BY Product_Category
ORDER BY total_revenue DESC;


-- =====================================================
-- 10. Most Used Payment Method
-- =====================================================
SELECT Payment_Method,
       COUNT(*) AS usage_count
FROM online_sales_data
GROUP BY Payment_Method
ORDER BY usage_count DESC;


-- =====================================================
-- 11. Total Units Sold and Total Revenue
-- =====================================================
SELECT SUM(Units_Sold) AS total_units_sold,
       SUM(Total_Revenue) AS total_revenue
FROM online_sales_data;
