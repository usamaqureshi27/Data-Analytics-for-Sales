Select *
FROM Superstore

--What are total sales and total profits of each year?

SELECT DATEPART(YEAR, Order_Date) AS year
FROM Superstore

ALTER TABLE Superstore
ADD year INT

UPDATE Superstore
SET year = DATEPART(YEAR, Order_Date)

SELECT year, SUM(sales) AS total_sales , SUM(profit) AS total_profit
FROM superstore
GROUP BY year
ORDER BY year ASC


 --2. What are the total profits and total sales per quarter?

SELECT year, 
CASE
WHEN DATEPART(month , Order_Date) IN (1,2,3) THEN 'Q1'
WHEN DATEPART(month , Order_Date) IN (4,5,6) THEN 'Q2'
WHEN DATEPART(month , Order_Date) IN (7,8,9) THEN 'Q3'
ELSE 'Q4'
END AS Quarter
FROM superstore
Order by year

ALTER TABLE Superstore
ADD Quarter Varchar(10)

UPDATE Superstore
SET Quarter = CASE
WHEN DATEPART(month , Order_Date) IN (1,2,3) THEN 'Q1'
WHEN DATEPART(month , Order_Date) IN (4,5,6) THEN 'Q2'
WHEN DATEPART(month , Order_Date) IN (7,8,9) THEN 'Q3'
ELSE 'Q4'
END 

SELECT year, Quarter ,SUM(sales) AS Total_Sales , SUM (profit) as Total_Profit
FROM Superstore
GROUP BY year, Quarter
ORDER BY year, Quarter

--3. What region generates the highest sales and profits ?

SELECT region, SUM(sales) AS total_sales , SUM(profit) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC


SELECT region, ROUND((SUM(profit) / sum(sales)) * 100,2) AS profit_margin
FROM Superstore
GROUP BY region
ORDER BY profit_margin DESC

--4. What state and city brings in the highest sales and profits ?

--States

SELECT TOP 10 State , SUM(sales) AS Total_Sales , SUM (profit) as Total_Profit ,  ROUND((SUM(profit) / sum(sales)) * 100,2) AS profit_margin
FROM Superstore
GROUP BY State
ORDER BY Total_Profit DESC

SELECT TOP 10 State , SUM(sales) AS Total_Sales , SUM (profit) as Total_Profit ,  ROUND((SUM(profit) / sum(sales)) * 100,2) AS profit_margin
FROM Superstore
GROUP BY State
ORDER BY Total_Profit ASC

-- Cities

SELECT TOP 10 City , SUM(sales) AS Total_Sales , SUM (profit) as Total_Profit ,  ROUND((SUM(profit) / sum(sales)) * 100,2) AS profit_margin
FROM Superstore
GROUP BY City
ORDER BY Total_Profit DESC


SELECT TOP 10 City , SUM(sales) AS Total_Sales , SUM (profit) as Total_Profit ,  ROUND((SUM(profit) / sum(sales)) * 100,2) AS profit_margin
FROM Superstore
GROUP BY City
ORDER BY Total_Profit ASC


-- 5. The relationship between discount and sales and the total discount per category

SELECT Discount, AVG(Sales) AS Avg_Sales
FROM superstore
GROUP BY Discount
ORDER BY Discount

SELECT Discount, AVG(Sales) AS Avg_Sales
FROM superstore
GROUP BY Discount
ORDER BY AVG_Sales DESC

SELECT category, MAX(discount) AS total_discount
FROM superstore
GROUP BY category
ORDER BY total_discount DESC

SELECT category, sub_category, MAX(discount) AS total_discount
FROM superstore
GROUP BY category , sub_category
ORDER BY total_discount DESC

-- 6. What category generates the highest sales and profits in each region and state ?

SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM superstore
GROUP BY category
ORDER BY total_profit DESC

SELECT region, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY region, category
ORDER BY total_profit DESC

SELECT state, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY state, category
ORDER BY total_profit DESC

--7. What subcategory generates the highest sales and profits in each region and state ?

SELECT sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC

SELECT region, sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY region, sub_category
ORDER BY total_profit DESC

SELECT state, sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY state, sub_category
ORDER BY total_profit DESC

-- 8. What are the names of the products that are the most and least profitable to us?

SELECT Product_Name, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit DESC


SELECT Product_Name, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit ASC

--9. What segment makes the most of our profits and sales ?

SELECT segment, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY segment
ORDER BY total_profit DESC


-- 10. How many customers do we have in total and how much per region and state?

SELECT COUNT(DISTINCT customer_id) AS Total_Customers
FROM Superstore

SELECT region, COUNT(DISTINCT customer_id) AS Total_Customers
FROM Superstore
GROUP BY region
ORDER BY Total_Customers DESC

SELECT state, COUNT(DISTINCT customer_id) AS Total_Customers
FROM Superstore
GROUP BY state
ORDER BY Total_Customers DESC

SELECT state, COUNT(DISTINCT customer_id) AS Total_Customers
FROM Superstore
GROUP BY state
ORDER BY Total_Customers ASC

-- 11. Customer rewards program

SELECT TOP 15 Customer_ID, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY Customer_ID
ORDER BY total_sales DESC

-- 12. Average shipping time per class and in total

SELECT TOP 1 DATEDIFF (day, order_date, ship_date) AS avg_shipping_time
FROM Superstore


/* ALTER TABLE Superstore
ADD avg_shipping_time INT

UPDATE Superstore
SET avg_shipping_time = DATEDIFF (day, order_date, ship_date)

SELECT ship_mode , avg_shipping_time
FROM Superstore
GROUP BY ship_mode , avg_shipping_time
ORDER BY avg_shipping_time DESC */

SELECT ship_mode , avg(DATEDIFF(day, order_date, ship_date)) AS avg_shipping_time
FROM Superstore
GROUP BY Ship_Mode
ORDER BY avg_shipping_time 
