SELECT TOP (1000) [Store]
      ,[Country]
      ,[State]
      ,[City]
      ,[Category]
      ,[Clothing_Type]
      ,[Store_Number]
      ,[Postal_Code]
      ,[Store_Type]
      ,[Store_Open_Date]
      ,[Selling_Area_Size_sq_ft]
      ,[Store_Manager]
      ,[Manager_ID]
      ,[Store_Address]
      ,[Contact_Information]
      ,[Operating_Hours]
      ,[Staff_Count]
      ,[Parking_Availability]
      ,[Security_Features]
      ,[Order_ID]
      ,[Order_Date]
      ,[Month]
      ,[Customer_ID]
      ,[Customer_Name]
      ,[Product_ID]
      ,[Price]
      ,[Quantity]
      ,[Sales_Profit]
  FROM [zudio].[dbo].[Zudio_sales_data]

  -- 1. Get Total Sales and Profit
SELECT 
    SUM(Price * Quantity) AS Total_Sales, 
    SUM(Sales_Profit) AS Total_Profit
FROM [zudio].[dbo].[Zudio_sales_data];

--2. Top 5 Best-Selling Products
SELECT TOP 5
    Product_ID, 
    SUM(Quantity) AS Total_Quantity_Sold
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Product_ID
ORDER BY Total_Quantity_Sold DESC;

--3. Monthly Sales for Zudio
SELECT 
    Month, 
    SUM(Price * Quantity) AS Monthly_Sales
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Month
ORDER BY 
    CASE 
        WHEN Month = 'January' THEN 1
        WHEN Month = 'February' THEN 2
        WHEN Month = 'March' THEN 3
        WHEN Month = 'April' THEN 4
        WHEN Month = 'May' THEN 5
        WHEN Month = 'June' THEN 6
        WHEN Month = 'July' THEN 7
        WHEN Month = 'August' THEN 8
        WHEN Month = 'September' THEN 9
        WHEN Month = 'October' THEN 10
        WHEN Month = 'November' THEN 11
        WHEN Month = 'December' THEN 12
        ELSE 13
    END;

--4 Category-Wise Sales
SELECT 
    Category, 
    SUM(Price * Quantity) AS Total_Sales
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 5 Best Customer (by Total Orders)
SELECT TOP 1
    Customer_ID, 
    Customer_Name, 
    COUNT(Order_ID) AS Total_Orders
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Orders DESC;

-- 6. Daily Sales Trends
SELECT 
    Order_Date, 
    SUM(Price * Quantity) AS Daily_Sales
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Order_Date
ORDER BY Order_Date;

--7. Clothing Type Performance
SELECT 
    Clothing_Type, 
    SUM(Price * Quantity) AS Total_Sales
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Clothing_Type
ORDER BY Total_Sales DESC;

--8  Total Profit by Product
SELECT 
    Product_ID, 
    SUM(Sales_Profit) AS Total_Profit
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Product_ID
ORDER BY Total_Profit DESC;

-- 9. Store Staff and Operational Information
SELECT 
    Store, 
    Staff_Count, 
    Selling_Area_Size_sq_ft, 
    Parking_Availability, 
    Operating_Hours
FROM [zudio].[dbo].[Zudio_sales_data]
WHERE Store = 'Zudio';

-- 10. Customer Purchases and Sales Contribution
SELECT 
    Customer_ID, 
    Customer_Name, 
    SUM(Price * Quantity) AS Total_Sales, 
    SUM(Sales_Profit) AS Total_Profit
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC;

--11. Average Sales Profit
SELECT 
    AVG(Sales_Profit) AS Average_Profit
FROM [zudio].[dbo].[Zudio_sales_data];

--12. Total Quantity Sold
SELECT 
    SUM(Quantity) AS Total_Quantity_Sold
FROM [zudio].[dbo].[Zudio_sales_data];

--13 Count of Orders
SELECT 
    COUNT(Order_ID) AS Total_Orders
FROM [zudio].[dbo].[Zudio_sales_data];

-- 14  Maximum and Minimum Sales Profit
SELECT 
    MAX(Sales_Profit) AS Max_Profit, 
    MIN(Sales_Profit) AS Min_Profit
FROM [zudio].[dbo].[Zudio_sales_data];

--15 Average Price of Products
SELECT 
    AVG(Price) AS Average_Product_Price
FROM [zudio].[dbo].[Zudio_sales_data];

-- 16 Total Number of Unique Products
SELECT 
    COUNT(DISTINCT Product_ID) AS Unique_Products
FROM [zudio].[dbo].[Zudio_sales_data];

--17 Total Customers
SELECT 
    COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM [zudio].[dbo].[Zudio_sales_data];

--18 Category-Wise Total Sales
SELECT 
    Category, 
    SUM(Price * Quantity) AS Total_Sales
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Category
ORDER BY Total_Sales DESC;

--19. Month-Wise Total Sales and Average Profit
SELECT 
    Month, 
    SUM(Price * Quantity) AS Total_Sales, 
    AVG(Sales_Profit) AS Average_Profit
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Month
ORDER BY 
    CASE 
        WHEN Month = 'January' THEN 1
        WHEN Month = 'February' THEN 2
        WHEN Month = 'March' THEN 3
        WHEN Month = 'April' THEN 4
        WHEN Month = 'May' THEN 5
        WHEN Month = 'June' THEN 6
        WHEN Month = 'July' THEN 7
        WHEN Month = 'August' THEN 8
        WHEN Month = 'September' THEN 9
        WHEN Month = 'October' THEN 10
        WHEN Month = 'November' THEN 11
        WHEN Month = 'December' THEN 12
     
    END;

-- Subquery 
--1. Products with Sales Greater Than the Average Sales Profit
SELECT 
    Product_ID, 
    SUM(Sales_Profit) AS Total_Profit
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Product_ID
HAVING SUM(Sales_Profit) > (SELECT AVG(Sales_Profit) FROM [zudio].[dbo].[Zudio_sales_data]);

--2 Customers Who Bought More Than the Average Quantity
SELECT 
    Customer_ID, 
    Customer_Name, 
    SUM(Quantity) AS Total_Quantity
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Customer_ID, Customer_Name
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM [zudio].[dbo].[Zudio_sales_data]);

--3. Find the Month with the Highest Total Sales
SELECT 
    Month, 
    SUM(Price * Quantity) AS Monthly_Sales
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Month
HAVING SUM(Price * Quantity) = (
    SELECT MAX(Monthly_Sales)
    FROM (
        SELECT SUM(Price * Quantity) AS Monthly_Sales
        FROM [zudio].[dbo].[Zudio_sales_data]
        GROUP BY Month
    ) AS Subquery
);


-- 4. Find the Store with the Highest Average Sales per Product
SELECT 
    Store, 
    AVG(Price * Quantity) AS Avg_Sales_Per_Product
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Store
HAVING AVG(Price * Quantity) = (
    SELECT MAX(Avg_Sales_Per_Product)
    FROM (
        SELECT AVG(Price * Quantity) AS Avg_Sales_Per_Product
        FROM [zudio].[dbo].[Zudio_sales_data]
        GROUP BY Store
    ) AS Subquery
);

-- 5. Customers Who Bought Products from Multiple Categories
SELECT 
    Customer_ID, 
    Customer_Name
FROM [zudio].[dbo].[Zudio_sales_data]
GROUP BY Customer_ID, Customer_Name
HAVING COUNT(DISTINCT Category) > 1;


--. ROW_NUMBER()
SELECT 
    Order_ID, 
    Customer_ID, 
    Price, 
    ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY Price DESC) AS Row_Num
FROM [zudio].[dbo].[Zudio_sales_data];

--RANK()
SELECT 
    Customer_ID, 
    Sales_Profit, 
    RANK() OVER (ORDER BY Sales_Profit DESC) AS Rank
FROM [zudio].[dbo].[Zudio_sales_data];

-- AVG() (Windowed)
SELECT 
    Order_ID, 
    Customer_ID, 
    Sales_Profit, 
    AVG(Sales_Profit) OVER (PARTITION BY Customer_ID ORDER BY Order_Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Moving_Avg_Sales
FROM [zudio].[dbo].[Zudio_sales_data];

