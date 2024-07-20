use supermarket_sales;

SELECT Branch, SUM(Total) AS Total_Sales
FROM data
GROUP BY Branch;

SELECT `Product line`, AVG(Rating) AS Average_Rating
FROM data
GROUP BY `Product line`;

SELECT Payment, SUM(Total) AS Total_Sales
FROM data
GROUP BY Payment;

SELECT City, `Customer type`, SUM(Total) AS Total_Sales
FROM data
GROUP BY City, `Customer type`;

SELECT `Product line`, SUM(Quantity) AS Total_Quantity
FROM data
GROUP BY `Product line`;

SELECT DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month, SUM(Total) AS Total_Sales
FROM data
GROUP BY Month;

SELECT City, AVG(`gross income`) AS Average_Gross_Income
FROM data
GROUP BY City;

SELECT Gender, SUM(Total) AS Total_Sales
FROM data
GROUP BY Gender;

SELECT `Product line`, SUM(Total) AS Total_Sales
FROM data
GROUP BY `Product line`
ORDER BY Total_Sales DESC
LIMIT 5;

SELECT HOUR(STR_TO_DATE(Time, '%H:%i')) AS Hour, SUM(Total) AS Total_Sales
FROM data
GROUP BY Hour;


SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month, 
    SUM(Total) AS Total_Sales, 
    LAG(SUM(Total)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m')) AS Previous_Month_Sales,
    (SUM(Total) - LAG(SUM(Total)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m'))) / LAG(SUM(Total)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m')) * 100 AS Sales_Growth_Percentage
FROM data
GROUP BY Month;

SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month,
    COUNT(DISTINCT CASE WHEN `Customer type` = 'Member' THEN `Invoice ID` END) AS Returning_Customers,
    COUNT(DISTINCT `Invoice ID`) AS Total_Customers,
    COUNT(DISTINCT CASE WHEN `Customer type` = 'Member' THEN `Invoice ID` END) / COUNT(DISTINCT `Invoice ID`) * 100 AS Retention_Rate
FROM data
GROUP BY Month;


SELECT 
    `Customer type`, 
    COUNT(`Invoice ID`) / COUNT(DISTINCT DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m-%d')) AS Avg_Purchase_Frequency
FROM data
GROUP BY `Customer type`;

SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month,
    SUM(Total) AS Total_Sales,
    AVG(SUM(Total)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Rolling_Avg_Sales_3_Months
FROM data
GROUP BY Month;


SELECT 
    AVG((`Unit price` - (SELECT AVG(`Unit price`) FROM data)) * (Rating - (SELECT AVG(Rating) FROM data))) / 
    (STDDEV_SAMP(`Unit price`) * STDDEV_SAMP(Rating)) AS Correlation
FROM data;

SELECT 
    `Invoice ID`, 
    SUM(Total) AS Total_Spend
FROM data
GROUP BY `Invoice ID`
ORDER BY Total_Spend DESC
LIMIT 5;

SELECT 
    CASE
        WHEN HOUR(STR_TO_DATE(Time, '%H:%i')) BETWEEN 0 AND 5 THEN 'Midnight - 6 AM'
        WHEN HOUR(STR_TO_DATE(Time, '%H:%i')) BETWEEN 6 AND 11 THEN '6 AM - Noon'
        WHEN HOUR(STR_TO_DATE(Time, '%H:%i')) BETWEEN 12 AND 17 THEN 'Noon - 6 PM'
        ELSE '6 PM - Midnight'
    END AS Time_Period,
    SUM(Total) AS Total_Sales
FROM data
GROUP BY Time_Period;

SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month,
    Gender,
    SUM(Total) AS Total_Sales
FROM data
GROUP BY Month, Gender
ORDER BY Month, Gender;

